Return-Path: <grundler@lackof.org>
Received: from colo.lackof.org (colo.lackof.org [198.49.126.79])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.lackof.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4244DDE058
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 17:56:24 +1100 (EST)
Date: Thu, 25 Jan 2007 23:56:13 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [RFC/PATCH 0/16] Ops based MSI Implementation
Message-ID: <20070126065613.GB328@colo.lackof.org>
References: <1169714047.65693.647693675533.qpush@cradle>
	<m1wt3awbtf.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <m1wt3awbtf.fsf@ebiederm.dsl.xmission.com>
Cc: Greg Kroah-Hartman <greg@kroah.com>, Kyle McMartin <kyle@parisc-linux.org>,
	linuxppc-dev@ozlabs.org, Brice Goglin <brice@myri.com>,
	shaohua.li@intel.com, linux-pci@atrey.karlin.mff.cuni.cz,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 25, 2007 at 11:18:20PM -0700, Eric W. Biederman wrote:
> You code appears to be nice simple clean and to not support MSI in
> a useful way.  I may be reading too quickly but at the moment your
> infrastructure appears useless if you are on a platform that doesn't
> enforce MSI's get filtered with a legacy interrupt controller.

Hrm?
Isn't the point of MSI to avoid any sort of interrupt controller?

> You don't have MSI-X support (which is the interesting case) and you
> don't have suspend/resume support.

I saw save/restore entry points.
I expected suspend/resume code would use those.
Do you agree (or not)?

> You don't support the MSI mask bit.
> 
> Looking at your msi_ops it does not map to what I am doing on x86.  There
> is the implicit assumption that the msi_message is fixed for the lifetime
> of the msi.  Which is wrong.

Erm...wouldn't changing the message also effectively change which handler
ends up catching the interrupt?
I always understood the addr/msg were a pair that HW would map to a handler.
Can you explain what you mean by "lifetime" and "fixed"?
What event would change the message? system Suspend/resume?

...
> After I get some sleep I will see if I can up with some constructive
> criticism on how we can make things work.

Well, I hope the questions I pose above help lead the discussion in
that direction.

thanks,
grant
