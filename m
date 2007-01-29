Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DE69ADE239
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 14:17:24 +1100 (EST)
Subject: Re: [RFC/PATCH 0/16] Ops based MSI Implementation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20070128.171309.11624572.davem@davemloft.net>
References: <m1bqkioh6z.fsf@ebiederm.dsl.xmission.com>
	<20070128.155155.51857352.davem@davemloft.net>
	<1170032301.26655.140.camel@localhost.localdomain>
	<20070128.171309.11624572.davem@davemloft.net>
Content-Type: text/plain
Date: Mon, 29 Jan 2007 14:17:02 +1100
Message-Id: <1170040622.26655.187.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: greg@kroah.com, kyle@parisc-linux.org, linuxppc-dev@ozlabs.org,
	brice@myri.com, shaohua.li@intel.com,
	linux-pci@atrey.karlin.mff.cuni.cz, ebiederm@xmission.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> That being said, it looks like the hypervisor calls just setup
> the MSI config inside of the PCI host controller, you still have
> to do the PCI config space writes.  So in this regard it's not
> like RTAS.

Ok, between the spec and your email, I think I sort-of understand it :-)
(damn, the Sun spec is a bit obscure...). 

So basically, from a kernel MSI backend perspective, I think you would
mostly use the "raw" implementation and locally implement your own
vector allocation.

However, your vector space is per-bus (which is good), so you do need to
allocate linux virtual irqs and map them to the actual MSI vectors like
we do on powerpc.

I think Eric's framework would work for you. As long as you don't need
to do something special for MSI-X, which I don't think you do...

Of course, Michael's stuff would work too, though it needs some
additions as you probably need to use config space (or MSI-X MMIO) for
masking & unmasking which we haven't implemented yet.

You are probably better off starting from Eric's stuff with his latest
patches I suppose...

At this point, I feel like Eric and use will not find a common ground,
which leaves us to those options:

 - Just give up and keep our current powerpc hooks at the toplevel. That
is, powerpc does it's own pci_enable_msi/x etc... (we need to fix those
hooks a bit but basically that's the idea). Internally, those go through
function pointers on which the RTAS implementation hooks directly, and
for non-RTAS powerpc archs, those point back to Eric's code which is
useable for these. In addition, I still want to have Eric's two "arch"
callbacks be themselves ops derived from the PCI device but that too can
be done in arch specific ways.

 - Give up in a different way and on powerpc, use Michael's
infrastructure and not use Eric's code at all (that means moving
Michael's stuff back to arch/powerpc which was Greg's original objection
to it).

 - Try to force our stuff in by implementing x86 completely (and Altix)
under Michael's infrastructure and then try to convince
Andrew/Greg/Linus to take it. Fairly unlikely. We do have a somewhat
"gradual" approach to it which consist of having Michael's code at the
toplevel, Eric's code hooked in as if it was a hypervisor, and then
gradually "merge" the raw backend with the x86 code, but it doesn't seem
very sexy (to me neither).

The main problem that I see that prevents us from an approach where
either we fix Michael's code to please Eric or change Eric's code to fit
our needs is that the way Eric code is evolving (based on his latest
patches), it's moving into a direction that is fundamentally unuseable
for our RTAS backend.

So unless Eric agrees to change his mind on that issue, we simply cannot
find a common abstraction. Which means that the only way we'll ever be
able to implement RTAS is by having separate hooks above Eric's code.

Ben.
