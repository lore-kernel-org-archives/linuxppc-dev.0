Return-Path: <aik@ozlabs.ru>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41DZtR4TymzF16W
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2018 13:49:35 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id w8-v6so5455326pgp.7
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Jun 2018 20:49:35 -0700 (PDT)
Date: Mon, 25 Jun 2018 13:49:25 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: Timothy Pearson <tpearson@raptorengineering.com>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 6/7] powerpc/powernv/pci: Invalidate TCE cache after DMA
 map
Message-ID: <20180625134925.1371d933@aik.ozlabs.ibm.com>
In-Reply-To: <1298010887.2569253.1529798076885.JavaMail.zimbra@raptorengineeringinc.com>
References: <1298010887.2569253.1529798076885.JavaMail.zimbra@raptorengineeringinc.com>
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

On Sat, 23 Jun 2018 18:54:36 -0500 (CDT)
Timothy Pearson <tpearson@raptorengineering.com> wrote:

>  setup
> 
> Per the IODA2, TCEs must be invalidated after their settings
> have been changed.  Invalidate the cache after the address
> is changed during TCE allocation when using pseudo DMA.
> 
> Signed-off-by: Timothy Pearson <tpearson@raptorengineering.com>
> ---
>  arch/powerpc/platforms/powernv/pci-dma.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/pci-dma.c b/arch/powerpc/platforms/powernv/pci-dma.c
> index 237940a2a052..060dbc168401 100644
> --- a/arch/powerpc/platforms/powernv/pci-dma.c
> +++ b/arch/powerpc/platforms/powernv/pci-dma.c
> @@ -42,8 +42,7 @@ static int dma_pseudo_bypass_select_tce(struct pnv_ioda_pe *pe, phys_addr_t addr
>  	new = cpu_to_be64(addr | TCE_PCI_READ | TCE_PCI_WRITE);
>  	pe->tces[tce] = new;
>  	mb();
> -	pe_info(pe, "allocating TCE %i 0x%016llx (old 0x%016llx)\n",
> -		tce, new, old);
> +	pnv_pci_ioda2_tce_invalidate_pe(pe);

This should be merged into "powerpc/powernv: DMA operations for
discontiguous" and "[PATCH 5/7] powerpc/powernv/pci: Export" should be
first in the series.


>  	spin_unlock_irqrestore(&pe->tce_alloc_lock, flags);
>  
>  	return tce;
> -- 
> 2.17.1



--
Alexey
