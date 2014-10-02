Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2B1201A0BB6
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Oct 2014 11:57:30 +1000 (EST)
In-Reply-To: <1412073306-13812-7-git-send-email-mikey@neuling.org>
To: Michael Neuling <mikey@neuling.org>, greg@kroah.com, arnd@arndb.de,
 benh@kernel.crashing.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2 06/17] powerpc/powernv: Split out set MSI IRQ chip code
Message-Id: <20141002015729.D379414016B@ozlabs.org>
Date: Thu,  2 Oct 2014 11:57:29 +1000 (EST)
Cc: cbe-oss-dev@lists.ozlabs.org, mikey@neuling.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, imunsie@au.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, jk@ozlabs.org,
 anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-30-09 at 10:34:55 UTC, Michael Neuling wrote:
> From: Ian Munsie <imunsie@au1.ibm.com>
> 
> Some of the MSI IRQ code in pnv_pci_ioda_msi_setup() is generically useful so
> split it out.
> 
> This will be used by some of the cxl PCIe code later.
> 
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index df241b1..329164f 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -1306,14 +1306,36 @@ static void pnv_ioda2_msi_eoi(struct irq_data *d)
>  	icp_native_eoi(d);
>  }
>  
> +
> +static void set_msi_irq_chip(struct pnv_phb *phb, unsigned int virq)
> +{
> +	struct irq_data *idata;
> +	struct irq_chip *ichip;
> +
> +	if (phb->type != PNV_PHB_IODA2)
> +		return;
> +
> +	/*
> +	 * Change the IRQ chip for the MSI interrupts on PHB3.
> +	 * The corresponding IRQ chip should be populated for
> +	 * the first time.

Seeing as you're moving this comment can you clarify the wording.


cheers
