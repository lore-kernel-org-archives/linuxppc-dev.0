Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D5C41DE362
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Jan 2007 07:58:05 +1100 (EST)
Subject: Re: [RFC/PATCH 0/16] Ops based MSI Implementation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Grundler <grundler@parisc-linux.org>
In-Reply-To: <20070126065613.GB328@colo.lackof.org>
References: <1169714047.65693.647693675533.qpush@cradle>
	<m1wt3awbtf.fsf@ebiederm.dsl.xmission.com>
	<20070126065613.GB328@colo.lackof.org>
Content-Type: text/plain
Date: Sat, 27 Jan 2007 07:57:53 +1100
Message-Id: <1169845073.24996.129.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Greg Kroah-Hartman <greg@kroah.com>, Kyle McMartin <kyle@parisc-linux.org>,
	linuxppc-dev@ozlabs.org, Brice Goglin <brice@myri.com>,
	shaohua.li@intel.com, linux-pci@atrey.karlin.mff.cuni.cz,
	"David S. Miller" <davem@davemloft.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-01-25 at 23:56 -0700, Grant Grundler wrote:
> On Thu, Jan 25, 2007 at 11:18:20PM -0700, Eric W. Biederman wrote:
> > You code appears to be nice simple clean and to not support MSI in
> > a useful way.  I may be reading too quickly but at the moment your
> > infrastructure appears useless if you are on a platform that doesn't
> > enforce MSI's get filtered with a legacy interrupt controller.
> 
> Hrm?
> Isn't the point of MSI to avoid any sort of interrupt controller?

Depends how it's implemented :-) In cases like powerpc where the
processor only has a single interrupt line, you need an interrupt
controller anyway.

> > You don't have MSI-X support (which is the interesting case) and you
> > don't have suspend/resume support.
> 
> I saw save/restore entry points.
> I expected suspend/resume code would use those.
> Do you agree (or not)?

MSI-X should be coming soon, I actually though Michael had that sorted
out already, I'll check with him.

Suspend resume should just hook to the backend.

> > You don't support the MSI mask bit.
> > 
> > Looking at your msi_ops it does not map to what I am doing on x86.  There
> > is the implicit assumption that the msi_message is fixed for the lifetime
> > of the msi.  Which is wrong.

The mask bit is not necessary when hooking onto an existing PIC,
however, we should provide a set of mask/unmask for use by the backend
using the mask bit, I agree there.

> Erm...wouldn't changing the message also effectively change which handler
> ends up catching the interrupt?
> I always understood the addr/msg were a pair that HW would map to a handler.
> Can you explain what you mean by "lifetime" and "fixed"?
> What event would change the message? system Suspend/resume?

Intel, in it's great wisdom, defined some bits of the message to have a
special meaning (in addition to the message address being used as a cpu
mask of destinations). I suppose there are cases where they want to
change things in there, not too sure though. I don't see anything that
can't be done by the backend though.

> ...
> > After I get some sleep I will see if I can up with some constructive
> > criticism on how we can make things work.
> 
> Well, I hope the questions I pose above help lead the discussion in
> that direction.

Well, our basic model of alloc/enable/disable/free should map pretty
much anything, and then we provide "raw" functions for the backend to
use rather than re-implement them.

If your backend needs something not provided by those (like mask/unmask
using the mask bit(s)), then either add it to the backend itself or add
new "generic" functions for optional use by the backend.

Ben.
