Return-Path: <aik@ozlabs.ru>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41DZpw4s7BzF16W
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2018 13:46:31 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id i7-v6so5461059pgp.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Jun 2018 20:46:31 -0700 (PDT)
Date: Mon, 25 Jun 2018 13:46:18 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: Timothy Pearson <tpearson@raptorengineering.com>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 4/7] powerpc/powernv/pci: Safety fixes for pseudobypass TCE
Message-ID: <20180625134618.4ba3b4a9@aik.ozlabs.ibm.com>
In-Reply-To: <955790001.2569251.1529798034743.JavaMail.zimbra@raptorengineeringinc.com>
References: <955790001.2569251.1529798034743.JavaMail.zimbra@raptorengineeringinc.com>
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

On Sat, 23 Jun 2018 18:53:54 -0500 (CDT)
Timothy Pearson <tpearson@raptorengineering.com> wrote:

>  allocation
> 
> Signed-off-by: Russell Currey <ruscur@russell.cc>
> ---
>  arch/powerpc/platforms/powernv/pci-dma.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/pci-dma.c b/arch/powerpc/platforms/powernv/pci-dma.c
> index 1d5409be343e..237940a2a052 100644
> --- a/arch/powerpc/platforms/powernv/pci-dma.c
> +++ b/arch/powerpc/platforms/powernv/pci-dma.c
> @@ -29,8 +29,9 @@ static int dma_pseudo_bypass_select_tce(struct pnv_ioda_pe *pe, phys_addr_t addr
>  {
>  	int tce;
>  	__be64 old, new;
> +	unsigned long flags;
>  
> -	;
> +	spin_lock_irqsave(&pe->tce_alloc_lock, flags);


No commit log and this actually should be merged into the patch
introducing spin_lock(&pe->tce_alloc_lock).


>  	tce = bitmap_find_next_zero_area(pe->tce_bitmap,
>  					 pe->tce_count,
>  					 0,
> @@ -40,9 +41,10 @@ static int dma_pseudo_bypass_select_tce(struct pnv_ioda_pe *pe, phys_addr_t addr
>  	old = pe->tces[tce];
>  	new = cpu_to_be64(addr | TCE_PCI_READ | TCE_PCI_WRITE);
>  	pe->tces[tce] = new;
> +	mb();
>  	pe_info(pe, "allocating TCE %i 0x%016llx (old 0x%016llx)\n",
>  		tce, new, old);
> -	spin_unlock(&pe->tce_alloc_lock);
> +	spin_unlock_irqrestore(&pe->tce_alloc_lock, flags);
>  
>  	return tce;
>  }
> -- 
> 2.17.1



--
Alexey
