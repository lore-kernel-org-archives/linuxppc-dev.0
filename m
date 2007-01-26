Return-Path: <grundler@lackof.org>
Received: from colo.lackof.org (colo.lackof.org [198.49.126.79])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.lackof.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C1EEADE094
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 18:48:43 +1100 (EST)
Date: Fri, 26 Jan 2007 00:48:33 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [RFC/PATCH 0/16] Ops based MSI Implementation
Message-ID: <20070126074833.GF328@colo.lackof.org>
References: <1169714047.65693.647693675533.qpush@cradle>
	<m1wt3awbtf.fsf@ebiederm.dsl.xmission.com>
	<20070126065613.GB328@colo.lackof.org>
	<m18xfqw95v.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <m18xfqw95v.fsf@ebiederm.dsl.xmission.com>
Cc: Grant Grundler <grundler@parisc-linux.org>,
	Greg Kroah-Hartman <greg@kroah.com>,
	Kyle McMartin <kyle@parisc-linux.org>, linuxppc-dev@ozlabs.org,
	Brice Goglin <brice@myri.com>, shaohua.li@intel.com,
	linux-pci@atrey.karlin.mff.cuni.cz, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jan 26, 2007 at 12:15:40AM -0700, Eric W. Biederman wrote:
> > Isn't the point of MSI to avoid any sort of interrupt controller?
> 
> That is how the supported platforms were designed.  But something needs
> to translate a pci message to a cpu interrupt and on PPC apparently
> they implemented this in their interrupt controller.
> 
> To be fair there are also ioapic on x86 which can do this as well
> they just haven't been sufficiently interesting to support.

Sorry, I'm not understanding your point...it's past my bedtime now
and maybe tomorrow it will make more sense.

I get the impression you are confusing Local-APIC with IO-APIC.
The former catches MSI's on behalf of the CPU and
the latter generates the equivalent of MSI's for IRQ lines.
Any CPU that can support MSI's has either a Local-APIC or it's equivalent.
(e.g. parisc or alpha)

> 
> The interesting case will be when there is the equivalent of an
> iommu for msi interrupts (and quite possibly it will be the iommu)
> that filters iommu for hardware isolation purposes.

IOMMU might give us better control over devices can write as long
as it's always used and not bypassed (e.g. ZX1 chipset).
Also, not all IOMMU can direct MSI transactions to a CPU.
I thought some IOMMU implementation can only deal with cacheline
sized transactions and I never had the impression MSI filled out
a full cacheline. Anyway, I expect the "Virtual Machine Monitor"
will own the IOMMU and expect that's the case in the IBM machines (RTAS
boxen).

> >> You don't have MSI-X support (which is the interesting case) and you
> >> don't have suspend/resume support.
> >
> > I saw save/restore entry points.
> > I expected suspend/resume code would use those.
> > Do you agree (or not)?
> 
> Mostly for that bit I was relying on the documented part that said
> they don't work yet.

ok.

> 
> >> You don't support the MSI mask bit.
> >> 
> >> Looking at your msi_ops it does not map to what I am doing on x86.  There
> >> is the implicit assumption that the msi_message is fixed for the lifetime
> >> of the msi.  Which is wrong.
> >
> > Erm...wouldn't changing the message also effectively change which handler
> > ends up catching the interrupt?
> > I always understood the addr/msg were a pair that HW would map to a handler.
> > Can you explain what you mean by "lifetime" and "fixed"?
> > What event would change the message? system Suspend/resume?
> 
> Suspend/resume and irq migration.

Hrm ok. IRQ migration shouldn't surprise anyone.
I expect the "virq" (linux IRQ #) would hide the values changing
in a Suspend/resume event. If the code isn't doing that for platforms
that support suspend/resume, then I agree it's broken.

> Currently the architecture code pushes
> what it thinks best at the controller, instead of the pull model in
> Micheal Ellerman's patch.

I need to look at the code more to get this. thanks for the observation.

thanks,
grant

> 
> > ...
> >> After I get some sleep I will see if I can up with some constructive
> >> criticism on how we can make things work.
> >
> > Well, I hope the questions I pose above help lead the discussion in
> > that direction.
> 
> We will see.  My current observation seems to be that problems that are
> currently solved and the problems that Michael needed to solve to support
> ppc are almost disjoint.  Making it a challenge to understand what the
> other architecture is doing.
> 
> Eric
