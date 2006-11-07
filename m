Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net
	[151.189.21.43])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 072B667D1F
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Nov 2006 19:27:54 +1100 (EST)
In-Reply-To: <20061107072126.C586067CD6@ozlabs.org>
References: <20061107072126.C586067CD6@ozlabs.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <93F89F52-7ED9-48F3-AE7A-15CDF5AB8E25@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC/PATCH 6/7] MPIC MSI backend
Date: Tue, 7 Nov 2006 09:27:35 +0100
To: Michael Ellerman <michael@ellerman.id.au>
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

Looks lovely, thanks Michael!

> +static unsigned int find_ht_msi_capability(struct pci_dev *pdev)
> +{
> +	u8 subcap;
> +	unsigned int pos = pci_find_capability(pdev, PCI_CAP_ID_HT);
> +
> +	while (pos) {
> +		pci_read_config_byte(pdev, pos + HT_SUBCAP_OFFSET, &subcap);
> +		if (subcap == HT_CAPTYPE_MSI_MAPPING)
> +			return pos;
> +		pos = pci_find_next_capability(pdev, pos, PCI_CAP_ID_HT);
> +	}
> +
> +	return 0;
> +}

It would be nice to have a generic find_ht_capability(pdev, type).

> +static void msi_mpic_free(struct pci_dev *pdev, int num,
> +			struct msix_entry *entries, int type)
> +{
> +	/* We borrowed the LSI irq, so don't unmap it! */
> +	return;
> +}
> +
> +static int msi_mpic_alloc(struct pci_dev *pdev, int num,
> +			struct msix_entry *entries, int type)
> +{
> +	/* For now we reuse the assigned LSI, this is a hack. */
> +	set_irq_type(pdev->irq, IRQ_TYPE_EDGE_RISING);
> +	entries[0].vector = pdev->irq;
> +
> +	return 0;
> +}

If msi_mpic_alloc() changes the sense/polarity, msi_mpic_free()
should set it back.  This doesn't actually matter on CPC925/945,
as LSI interrupts are rising edge as well (on the MPIC); maybe
the sense/polarity should be configurable per MPIC controller
somewhere (or just mark the code as "FIXME: only correct for
some MPICs").

> ++static int msi_mpic_setup_msi_msg(struct pci_dev *pdev,
> +		struct msix_entry *entry, struct msi_msg *msg, int type)
> +{
> +	u64 addr;
> +
> +	addr = find_ht_magic_addr(pdev);
> +	msg->address_lo = addr & 0xFFFFFFFF;
> +	msg->address_hi = addr >> 32;

You don't seem the check whether the "magic address" is outside
of 32-bit range and the device can do 32-bit only?


Segher
