Return-Path: <ebiederm@xmission.com>
Received: from ebiederm.dsl.xmission.com (ebiederm.dsl.xmission.com
	[166.70.28.69])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 51413DE083
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 18:16:15 +1100 (EST)
From: ebiederm@xmission.com (Eric W. Biederman)
To: Grant Grundler <grundler@parisc-linux.org>
Subject: Re: [RFC/PATCH 0/16] Ops based MSI Implementation
References: <1169714047.65693.647693675533.qpush@cradle>
	<m1wt3awbtf.fsf@ebiederm.dsl.xmission.com>
	<20070126065613.GB328@colo.lackof.org>
Date: Fri, 26 Jan 2007 00:15:40 -0700
In-Reply-To: <20070126065613.GB328@colo.lackof.org> (Grant Grundler's message
	of "Thu, 25 Jan 2007 23:56:13 -0700")
Message-ID: <m18xfqw95v.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

Grant Grundler <grundler@parisc-linux.org> writes:

> On Thu, Jan 25, 2007 at 11:18:20PM -0700, Eric W. Biederman wrote:
>> You code appears to be nice simple clean and to not support MSI in
>> a useful way.  I may be reading too quickly but at the moment your
>> infrastructure appears useless if you are on a platform that doesn't
>> enforce MSI's get filtered with a legacy interrupt controller.
>
> Hrm?
> Isn't the point of MSI to avoid any sort of interrupt controller?

That is how the supported platforms were designed.  But something needs
to translate a pci message to a cpu interrupt and on PPC apparently
they implemented this in their interrupt controller.

To be fair there are also ioapic on x86 which can do this as well
they just haven't been sufficiently interesting to support.

The interesting case will be when there is the equivalent of an
iommu for msi interrupts (and quite possibly it will be the iommu)
that filters iommu for hardware isolation purposes.

>> You don't have MSI-X support (which is the interesting case) and you
>> don't have suspend/resume support.
>
> I saw save/restore entry points.
> I expected suspend/resume code would use those.
> Do you agree (or not)?

Mostly for that bit I was relying on the documented part that said
they don't work yet.

>> You don't support the MSI mask bit.
>> 
>> Looking at your msi_ops it does not map to what I am doing on x86.  There
>> is the implicit assumption that the msi_message is fixed for the lifetime
>> of the msi.  Which is wrong.
>
> Erm...wouldn't changing the message also effectively change which handler
> ends up catching the interrupt?
> I always understood the addr/msg were a pair that HW would map to a handler.
> Can you explain what you mean by "lifetime" and "fixed"?
> What event would change the message? system Suspend/resume?

Suspend/resume and irq migration.  Currently the architecture code pushes
what it thinks best at the controller, instead of the pull model in
Micheal Ellerman's patch.

> ...
>> After I get some sleep I will see if I can up with some constructive
>> criticism on how we can make things work.
>
> Well, I hope the questions I pose above help lead the discussion in
> that direction.

We will see.  My current observation seems to be that problems that are
currently solved and the problems that Michael needed to solve to support
ppc are almost disjoint.  Making it a challenge to understand what the
other architecture is doing.

Eric
