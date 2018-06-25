Return-Path: <aik@ozlabs.ru>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41DZxC0mpzzF16W
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2018 13:51:58 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id g3-v6so1067127pfi.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Jun 2018 20:51:58 -0700 (PDT)
Date: Mon, 25 Jun 2018 13:51:48 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: Timothy Pearson <tpearson@raptorengineering.com>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 7/7] powerpc/powernv/pci: Don't use the lower 4G TCEs in
Message-ID: <20180625135148.5c6722a8@aik.ozlabs.ibm.com>
In-Reply-To: <698112983.2569254.1529798098017.JavaMail.zimbra@raptorengineeringinc.com>
References: <698112983.2569254.1529798098017.JavaMail.zimbra@raptorengineeringinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 23 Jun 2018 18:54:58 -0500 (CDT)
Timothy Pearson <tpearson@raptorengineering.com> wrote:

>  pseudo-DMA mode
> 
> Four TCEs are reserved for legacy 32-bit DMA mappings in psuedo DMA
> mode.  Mark these with an invalid address to avoid their use by
> the TCE cache mapper.


Can we still have 32bit DMA in the case when this new DMA is enabled?

Are the TCEs in the actual table marked invalid?

Anyway, this should be merged into the patch introducing
pnv_pci_pseudo_bypass_setup().


> 
> Signed-off-by: Timothy Pearson <tpearson@raptorengineering.com>
> ---
>  arch/powerpc/platforms/powernv/pci-ioda.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index a6097dd323f8..e8a1333f6b3e 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -1783,7 +1783,7 @@ static bool pnv_pci_ioda_pe_single_vendor(struct pnv_ioda_pe *pe)
>  
>  static int pnv_pci_pseudo_bypass_setup(struct pnv_ioda_pe *pe)
>  {
> -	u64 tce_count, table_size, window_size;
> +	u64 i, tce_count, table_size, window_size;
>  	struct pnv_phb *p = pe->phb;
>  	struct page *table_pages;
>  	__be64 *tces;
> @@ -1835,6 +1835,12 @@ static int pnv_pci_pseudo_bypass_setup(struct pnv_ioda_pe *pe)
>  	/* mark the first 4GB as reserved so this can still be used for 32bit */
>  	bitmap_set(pe->tce_bitmap, 0, 1ULL << (32 - p->ioda.max_tce_order));
>  
> +	/* make sure reserved first 4GB TCEs are not used by the mapper
> +	 * set each address to -1, which will never match an incoming request
> +	 */
> +	for (i = 0; i < 4; i++)
> +		pe->tce_tracker[i * 2] = -1;
> +
>  	pe_info(pe, "pseudo-bypass sizes: tracker %d bitmap %d TCEs %lld\n",
>  		tracker_entries, bitmap_size, tce_count);
>  
> -- 
> 2.17.1



--
Alexey
