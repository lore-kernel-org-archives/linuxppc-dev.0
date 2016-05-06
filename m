Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-x22c.google.com (mail-pa0-x22c.google.com
 [IPv6:2607:f8b0:400e:c03::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r1NQR2gSczDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 May 2016 17:17:33 +1000 (AEST)
Received: by mail-pa0-x22c.google.com with SMTP id r5so45899142pag.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 May 2016 00:17:33 -0700 (PDT)
Subject: Re: [PATCH v9 04/22] powerpc/powernv: Increase PE# capacity
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1462281773-26438-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1462281773-26438-5-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, bhelgaas@google.com,
 robherring2@gmail.com, dja@axtens.net, alistair@popple.id.au
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <2f2282ae-c1dc-1870-4beb-d5e4e8233496@ozlabs.ru>
Date: Fri, 6 May 2016 17:17:25 +1000
MIME-Version: 1.0
In-Reply-To: <1462281773-26438-5-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/03/2016 11:22 PM, Gavin Shan wrote:
> Each PHB maintains an array helping to translate 2-bytes Request
> ID (RID) to PE# with the assumption that PE# takes one byte, meaning
> that we can't have more than 256 PEs. However, pci_dn->pe_number
> already had 4-bytes for the PE#.

Can you possibly have more than 256 PEs? Or exactly 256? What patch in this 
series makes use of it?

I probably asked but do not remember the answer :)

Looks like waste of memory - you only used a small fraction of 
pe_rmap[0x10000] and now the waste is quadrupled.


>
> This extends the PE# capacity for every PHB. After that, the PE number
> is represented by 4-bytes value. Then we can reuse IODA_INVALID_PE to
> check the PE# in phb->pe_rmap[] is valid or not.

Looks like using IODA_INVALID_PE is the only reason for this patch.


>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> Reviewed-by: Daniel Axtens <dja@axtens.net>
> ---
>  arch/powerpc/platforms/powernv/pci-ioda.c | 6 +++++-
>  arch/powerpc/platforms/powernv/pci.h      | 7 ++-----
>  2 files changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index cbd4c0b..cf96cb5 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -768,7 +768,7 @@ static int pnv_ioda_deconfigure_pe(struct pnv_phb *phb, struct pnv_ioda_pe *pe)
>
>  	/* Clear the reverse map */
>  	for (rid = pe->rid; rid < rid_end; rid++)
> -		phb->ioda.pe_rmap[rid] = 0;
> +		phb->ioda.pe_rmap[rid] = IODA_INVALID_PE;
>
>  	/* Release from all parents PELT-V */
>  	while (parent) {
> @@ -3406,6 +3406,10 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>  	if (prop32)
>  		phb->ioda.reserved_pe_idx = be32_to_cpup(prop32);
>
> +	/* Invalidate RID to PE# mapping */
> +	for (segno = 0; segno < ARRAY_SIZE(phb->ioda.pe_rmap); segno++)
> +		phb->ioda.pe_rmap[segno] = IODA_INVALID_PE;
> +
>  	/* Parse 64-bit MMIO range */
>  	pnv_ioda_parse_m64_window(phb);
>
> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
> index 904f60b..80f5326 100644
> --- a/arch/powerpc/platforms/powernv/pci.h
> +++ b/arch/powerpc/platforms/powernv/pci.h
> @@ -156,11 +156,8 @@ struct pnv_phb {
>  		struct list_head	pe_list;
>  		struct mutex            pe_list_mutex;
>
> -		/* Reverse map of PEs, will have to extend if
> -		 * we are to support more than 256 PEs, indexed
> -		 * bus { bus, devfn }
> -		 */
> -		unsigned char		pe_rmap[0x10000];
> +		/* Reverse map of PEs, indexed by {bus, devfn} */
> +		unsigned int		pe_rmap[0x10000];
>
>  		/* TCE cache invalidate registers (physical and
>  		 * remapped)
>


-- 
Alexey
