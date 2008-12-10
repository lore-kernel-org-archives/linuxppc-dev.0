Return-Path: <tpiepho@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D033CDDE23
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 06:33:19 +1100 (EST)
Date: Wed, 10 Dec 2008 11:33:07 -0800 (PST)
From: Trent Piepho <tpiepho@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC/PATCH 1/2] powerpc: Rework usage of
	_PAGE_COHERENT/NO_CACHE/GUARDED
In-Reply-To: <20081210055136.63D5FDDF5C@ozlabs.org>
Message-ID: <Pine.LNX.4.64.0812101107350.28806@t2.domain.actdsltmp>
References: <20081210055136.63D5FDDF5C@ozlabs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 10 Dec 2008, Benjamin Herrenschmidt wrote:
> This changes the logic so that instead, the PTE now contains
> _PAGE_COHERENT for all normal RAM pages tha have I = 0. The hash
> code clears it if the feature bit is not set.

Why not check the feature bit when the PTE is made and unset _PAGE_COHERENT
at that point?  In fact, could you do something like:

#if defined(CONFIG_SMP) || ....
#define _PAGE_BASE	(_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_COHERENT)
#else
#define _PAGE_BASE	(_PAGE_PRESENT | _PAGE_ACCESSED)
#endif

> I haven't touched at the FSL BookE code yet. It may need to selectively
> clear M in the TLB miss handler ... or not. Depends what the impact of
> M on non-SMP E5xx setup is. I also didn't bother to clear it on 440 because
> it just has no effect (ie, it won't slow things down).

I've been told that setting M on non-SMP will slows things down.  But
couldn't you just change _PAGE_BASE on non-SMP instead of clearning it in
the miss handler?

> 	for_each_pci_dev(pdev) {
> 		for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
> 			struct resource *rp = &pdev->resource[i];
> @@ -422,14 +417,14 @@ pgprot_t pci_phys_mem_access_prot(struct
> 	}
> 	if (found) {
> 		if (found->flags & IORESOURCE_PREFETCH)
> -			prot &= ~_PAGE_GUARDED;
> +			prot = pgprot_noncached_wc(prot);
> 		pci_dev_put(pdev);
> 	}

I have a patch to remove this IORESOURCE_PREFETCH hack.  The current kernel
creates two files, resourceN and resourceN_wc, for prefetchable BARs to
allow the user to choose what mode to use.

Though I want to be able to map PCI resources as cached too.  I'm not sure
what a good way to add that is.  Yet another resource file?  The first
proposal for allowing WC mappings was to add support for ioctl() on sysfs
attributes.  Then one could use ioctl() after opening the resource file to
specify what mode to map it with.  No one liked ioctl(), but clearly the
current method doesn't scale well to all 32 combinations of the WIMGE bits.
