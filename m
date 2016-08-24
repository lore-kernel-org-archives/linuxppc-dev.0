Return-Path: <scott.wood@nxp.com>
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00050.outbound.protection.outlook.com [40.107.0.50])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sKLLF4sRzzDrcd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 07:39:33 +1000 (AEST)
From: Scott Wood <scott.wood@nxp.com>
To: Tillmann Heidsieck <theidsieck@leenox.de>, Scott Wood
 <scottwood@freescale.com>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] powerpc: fsl_pci: fix inbound ATMU entries for
 systems with >4G RAM
Date: Wed, 24 Aug 2016 21:39:27 +0000
Message-ID: <DB5PR0401MB19280DCC626ED0E83EDD0D3791EA0@DB5PR0401MB1928.eurprd04.prod.outlook.com>
References: <20160824194614.4014-1-theidsieck@leenox.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/24/2016 02:48 PM, Tillmann Heidsieck wrote:=0A=
> For systems with >4G of RAM, the current implementation adds a second=0A=
> inbound PCIe window starting at 128G this leaves all memory from 4G to=0A=
> 128G inaccessible to inbound PCIe transactions.=0A=
=0A=
The second inbound window is at 256G, and it maps all of RAM.  Note that=0A=
for accesses in this window, the PCI address is different from the host=0A=
address.=0A=
=0A=
> The according errors can be observed by using the EDAC driver for MPC85XX=
.=0A=
> =0A=
> This patch changes this behaviour by adding the second window starting=0A=
> at 4G. The current implementation still leaves memory beyond 68G=0A=
> unmapped as this would require yet another ATMU entry.=0A=
=0A=
Windows must be size-aligned, as per the description of PEXIWBARn[WBA].=0A=
 This window is illegal.=0A=
=0A=
By trying to identity-map everything you also break the assumption that=0A=
we don't need swiotlb to avoid the PEXCSRBAR region on PCI devices=0A=
capable of generating 64-bit addresses.=0A=
=0A=
> Tested on a T4240 with 12G of RAM and an AMD E6760 PCIe card working with=
=0A=
> the in-tree radeon driver.=0A=
=0A=
I have no problem using an e1000e card on a t4240 with 24 GiB RAM.=0A=
=0A=
Looking at the radeon driver I see that there's a possibility of a dma=0A=
mask that is exactly 40 bits.  I think there's an off-by-one error in=0A=
fsl_pci_dma_set_mask().  If you change "dma_mask >=3D=0A=
DMA_BIT_MASK(MAX_PHYS_ADDR_BITS)" to "dma_mask >=0A=
DMA_BIT_MASK(MAX_PHYS_ADDR_BITS)", does that make radeon work without=0A=
this patch?=0A=
=0A=
=0A=
> Signed-off-by: Tillmann Heidsieck <theidsieck@leenox.de>=0A=
> ---=0A=
>  arch/powerpc/sysdev/fsl_pci.c | 40 ++++++++++++++++++++-----------------=
---=0A=
>  1 file changed, 20 insertions(+), 20 deletions(-)=0A=
> =0A=
> diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.=
c=0A=
> index 0ef9df49f0f2..260983037904 100644=0A=
> --- a/arch/powerpc/sysdev/fsl_pci.c=0A=
> +++ b/arch/powerpc/sysdev/fsl_pci.c=0A=
> @@ -349,17 +349,13 @@ static void setup_pci_atmu(struct pci_controller *h=
ose)=0A=
>  	}=0A=
>  =0A=
>  	sz =3D min(mem, paddr_lo);=0A=
> -	mem_log =3D ilog2(sz);=0A=
> +	mem_log =3D order_base_2(sz);=0A=
>  =0A=
>  	/* PCIe can overmap inbound & outbound since RX & TX are separated */=
=0A=
>  	if (early_find_capability(hose, 0, 0, PCI_CAP_ID_EXP)) {=0A=
> -		/* Size window to exact size if power-of-two or one size up */=0A=
> -		if ((1ull << mem_log) !=3D mem) {=0A=
> -			mem_log++;=0A=
> -			if ((1ull << mem_log) > mem)=0A=
> -				pr_info("%s: Setting PCI inbound window "=0A=
> -					"greater than memory size\n", name);=0A=
> -		}=0A=
> +		if ((1ull << mem_log) > mem)=0A=
> +			pr_info("%s: Setting PCI inbound window greater than memory size\n",=
=0A=
> +				name);=0A=
>  =0A=
>  		piwar |=3D ((mem_log - 1) & PIWAR_SZ_MASK);=0A=
>  =0A=
=0A=
This change is unrelated.=0A=
=0A=
BTW, for some reason your patch is not showing up in Patchwork.=0A=
=0A=
-Scott=0A=
=0A=
