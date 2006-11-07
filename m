Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 485C567D47
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Nov 2006 19:43:02 +1100 (EST)
Subject: Re: [RFC/PATCH 6/7] MPIC MSI backend
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <93F89F52-7ED9-48F3-AE7A-15CDF5AB8E25@kernel.crashing.org>
References: <20061107072126.C586067CD6@ozlabs.org>
	<93F89F52-7ED9-48F3-AE7A-15CDF5AB8E25@kernel.crashing.org>
Content-Type: text/plain
Date: Tue, 07 Nov 2006 19:42:43 +1100
Message-Id: <1162888963.28571.459.camel@localhost.localdomain>
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


> It would be nice to have a generic find_ht_capability(pdev, type).

Agreed, though I prefer the naming to be ht_find_capability().

> If msi_mpic_alloc() changes the sense/polarity, msi_mpic_free()
> should set it back.  This doesn't actually matter on CPC925/945,
> as LSI interrupts are rising edge as well (on the MPIC); maybe
> the sense/polarity should be configurable per MPIC controller
> somewhere (or just mark the code as "FIXME: only correct for
> some MPICs").

Yes, I will do a cleanup pass on the MPIC code there. I think it should
only program the chip for polarity/sense in startup() and thus can
"override" the native LSI setting of that vector when the interrupt is
flagged as MSI without actually losing the original information.

Right now, as you noticed, it's a non-issue for MSIs coming off HT, as
both HT interrupts and MSIs are programmed to be edge in the MPIC
itself, however, this is not ok with interrupts from the PCIe slot fow
which, according to the device-tree on my Quad G5, the LSI is level low.

Something else I'd like to do is add a generic IRQF_MSI purely for the
sake of displaying "MSI" instead of "Edge" in /proc/interrupts :-)
Though it might be useful for some backends to track what interrupts
have been configured as MSI too.
  
> > ++static int msi_mpic_setup_msi_msg(struct pci_dev *pdev,
> > +		struct msix_entry *entry, struct msi_msg *msg, int type)
> > +{
> > +	u64 addr;
> > +
> > +	addr = find_ht_magic_addr(pdev);
> > +	msg->address_lo = addr & 0xFFFFFFFF;
> > +	msg->address_hi = addr >> 32;
> 
> You don't seem the check whether the "magic address" is outside
> of 32-bit range and the device can do 32-bit only?

Good point. It happens not to be on our chipset / firmware but we should
probably check in the check() callback. If it's the case, then we refuse
to enable MSI for that device.

Cheers,
Ben.
