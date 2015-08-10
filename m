Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f46.google.com (mail-pa0-f46.google.com
 [209.85.220.46])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8A2871A03BD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2015 19:53:10 +1000 (AEST)
Received: by pacgr6 with SMTP id gr6so23720433pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2015 02:53:09 -0700 (PDT)
Subject: Re: [PATCH v6 12/42] powerpc/powernv: Increase PE# capacity
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1438834307-26960-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1438834307-26960-13-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, bhelgaas@google.com,
 grant.likely@linaro.org, robherring2@gmail.com, panto@antoniou-consulting.com
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <55C8747E.9090908@ozlabs.ru>
Date: Mon, 10 Aug 2015 19:53:02 +1000
MIME-Version: 1.0
In-Reply-To: <1438834307-26960-13-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/06/2015 02:11 PM, Gavin Shan wrote:
> Each PHB maintains an array helping to translate RID (Request
> ID) to PE# with the assumption that PE# takes 8 bits, indicating
> that we can't have more than 256 PEs. However, pci_dn->pe_number
> already had 4-bytes for the PE#.
>
> The patch extends the PE# capacity so that each of them will be
> 4-bytes long. Then we can use IODA_INVALID_PE to check one entry
> in phb->pe_rmap[] is valid or not.
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>   arch/powerpc/platforms/powernv/pci-ioda.c | 8 ++++++--
>   arch/powerpc/platforms/powernv/pci.h      | 7 +++----
>   2 files changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 57ba8fd..3094c61 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -786,7 +786,7 @@ static int pnv_ioda_deconfigure_pe(struct pnv_phb *phb, struct pnv_ioda_pe *pe)
>
>   	/* Clear the reverse map */
>   	for (rid = pe->rid; rid < rid_end; rid++)
> -		phb->ioda.pe_rmap[rid] = 0;
> +		phb->ioda.pe_rmap[rid] = IODA_INVALID_PE;
>
>   	/* Release from all parents PELT-V */
>   	while (parent) {
> @@ -3134,7 +3134,7 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>   	unsigned long size, pemap_off;
>   	const __be64 *prop64;
>   	const __be32 *prop32;
> -	int len;
> +	int len, i;
>   	u64 phb_id;
>   	void *aux;
>   	long rc;
> @@ -3201,6 +3201,10 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>   	if (prop32)
>   		phb->ioda.reserved_pe = be32_to_cpup(prop32);
>
> +	/* Invalidate RID to PE# mapping */
> +	for (i = 0; i < ARRAY_SIZE(phb->ioda.pe_rmap); ++i)
> +		phb->ioda.pe_rmap[i] = IODA_INVALID_PE;
> +
>   	/* Parse 64-bit MMIO range */
>   	pnv_ioda_parse_m64_window(phb);
>
> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
> index 1dc9578..6f8568e 100644
> --- a/arch/powerpc/platforms/powernv/pci.h
> +++ b/arch/powerpc/platforms/powernv/pci.h
> @@ -175,11 +175,10 @@ struct pnv_phb {
>   			struct list_head	pe_list;
>   			struct mutex            pe_list_mutex;
>
> -			/* Reverse map of PEs, will have to extend if
> -			 * we are to support more than 256 PEs, indexed
> -			 * bus { bus, devfn }
> +			/* Reverse map of PEs, indexed by
> +			 * { bus, devfn }
>   			 */
> -			unsigned char		pe_rmap[0x10000];
> +			int			pe_rmap[0x10000];


256k seems to be waste when only tiny fraction of it will ever be used. 
Using include/linux/hashtable.h makes sense here, and if you use a 
hashtable, you won't have to initialize anything with IODA_INVALID_PE.


>
>   			/* 32-bit TCE tables allocation */
>   			unsigned long		dma32_segcount;
>


-- 
Alexey
