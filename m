Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 61085DDEC2
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Apr 2007 09:17:07 +1000 (EST)
In-Reply-To: <20070419073555.01990DDECB@ozlabs.org>
References: <20070419073555.01990DDECB@ozlabs.org>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <0846c0d8efafe7258075826b9c869fea@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 5/7] Enable MSI mappings for MPIC
Date: Sat, 21 Apr 2007 18:16:55 -0500
To: Michael Ellerman <michael@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, linux-pci <linux-pci@atrey.karlin.mff.cuni.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Apr 19, 2007, Michael Ellerman wrote:
> On some Apple machines the HT MSI mappings are not enabled by 
> firmware, so
> we need to do it by hand.
>

> +#ifdef CONFIG_PCI_MSI
> +static void __init mpic_scan_ht_msi(struct mpic *mpic, u8 __iomem 
> *devbase,
> +				    unsigned int devfn)
> +{
> +	u8 __iomem *base;
> +	u8 pos, flags;
> +	u64 addr = 0;
> +
> +	for (pos = readb(devbase + PCI_CAPABILITY_LIST); pos != 0;
> +	     pos = readb(devbase + pos + PCI_CAP_LIST_NEXT)) {
> +		u8 id = readb(devbase + pos + PCI_CAP_LIST_ID);
> +		if (id == PCI_CAP_ID_HT) {
> +			id = readb(devbase + pos + 3);
> +			if ((id & HT_5BIT_CAP_MASK) == HT_CAPTYPE_MSI_MAPPING)
>

This is just begging to be written in terms of 
pci_bus_find_ht_capability.  Well,
we have pci_bus_find_capability, and pci_find_ht_capability, I'm sure 
we could
create that.   It also means this and the other nearby functions want 
to be
written in terms of a struct pci_bus and config accessors.

milton
