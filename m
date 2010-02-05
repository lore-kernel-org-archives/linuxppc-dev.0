Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 271ECB7D21
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  6 Feb 2010 07:57:53 +1100 (EST)
Subject: Re: [PATCH 4/4] Fix iMac iSight PCI bridge setup
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@gmail.com>
In-Reply-To: <20100205135546.GJ12001@hansolo.jdub.homelinux.org>
References: <20100205133552.GF12001@hansolo.jdub.homelinux.org>
	<20100205135546.GJ12001@hansolo.jdub.homelinux.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 06 Feb 2010 07:57:46 +1100
Message-ID: <1265403466.8287.218.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-02-05 at 08:55 -0500, Josh Boyer wrote:
> This works around the PCIe bridge setup on the iMac iSight boxen.

Is this still needed ? I though I had fixed the root cause (incorrect
setup of the bridge) a while back...

Cheers,
Ben.

> ---
> 
> --- linux/arch/powerpc/platforms/powermac/pci.c~	2008-03-22 19:08:07.000000000 +0000
> +++ linux/arch/powerpc/platforms/powermac/pci.c	2008-03-23 09:10:46.000000000 +0000
> @@ -1271,6 +1271,12 @@ void pmac_pci_fixup_pciata(struct pci_de
>  	}
>  }
>  DECLARE_PCI_FIXUP_EARLY(PCI_ANY_ID, PCI_ANY_ID, pmac_pci_fixup_pciata);
> +#else /* CONFIG_PPC64 */
> +static void __devinit imac_transparent_bridge(struct pci_dev *dev)
> +{
> +	dev->transparent = 1;
> +}
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_APPLE, 0x005b, imac_transparent_bridge);
>  #endif /* CONFIG_PPC32 */
>  
>  /*
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
