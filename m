Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CCB4167D22
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Nov 2006 20:16:24 +1100 (EST)
Subject: Re: [RFC/PATCH 6/7] MPIC MSI backend
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <3210FBE5-5F22-4759-A728-A98175A435D6@kernel.crashing.org>
References: <20061107072126.C586067CD6@ozlabs.org>
	<93F89F52-7ED9-48F3-AE7A-15CDF5AB8E25@kernel.crashing.org>
	<1162888963.28571.459.camel@localhost.localdomain>
	<3210FBE5-5F22-4759-A728-A98175A435D6@kernel.crashing.org>
Content-Type: text/plain
Date: Tue, 07 Nov 2006 20:16:03 +1100
Message-Id: <1162890963.28571.465.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Greg Kroah-Hartman <greg@kroah.com>, linuxppc-dev@ozlabs.org,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-pci@atrey.karlin.mff.cuni.cz, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > Yes, I will do a cleanup pass on the MPIC code there. I think it  
> > should
> > only program the chip for polarity/sense in startup() and thus can
> > "override" the native LSI setting of that vector when the interrupt is
> > flagged as MSI without actually losing the original information.
> 
> You mean when we (in the future) reserve a range of vectors
> for MSI allocation at MPIC startup?  Sure, that works.

Not only, even with the current code... basically keep the
sense/polarity flags of the LSI intact in the irq_desc, just add the
IRQF_MSI bit to "override" them when we configure the interrupt to be an
MSI. Then, irq_chip->startup() instead of set_irq_type() does the actual
configuration of the MPIC and, seeing the IRQF_MSI flags, does the right
thing.

That way, when restoring the IRQ back to LSI, we just clear IRQF_MSI and
the old sense/polarity settings will still be there in the descriptor
and MPIC will do the right thing on the next startup().

> ["The PCIe slot" == the 16x PCIe slot on PowerMacs here, for
> the record; it isn't connected over a bridge to HT, but is
> directly connected to the CPC945 (U4) chip.]

Yup, the Attu if you prefer :-)

> There are more problems there (with this current code): the LSI
> IRQ will always be #3, which cannot be used as an MSI IRQ;

Are you sure about that ? In this case, we need a special kludge for
now. I though the MSI stuff could override any of the MPIC vectors, but
you might well be right there, it might not work with the U4 internal
ones.

> and the MSI address to use can not be found on a parent HT bridge
> (as there is none, duh).  That last problem makes the patch
> perfectly safe for the CPC945 PCIe port though :-)

Yes, I know :-) We need specific code to discover that a device is
hanging off the Attu instead of HT. I already explained it all to
Michael, it shouldn't be too hard. I even have a card setup to test it,
just didn't have time to do it just yet.

> Can't we just check here?  If not, what's the point of having
> a return code here?  although doing the check in check() might
> be conceptually nicer, sure.

Yes, nicer and avoids going all the way to allocating stuff and then
having to de-allocate.

Ben.
