Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id B1F93DDF43
	for <linuxppc-dev@ozlabs.org>; Fri,  9 May 2008 06:51:45 +1000 (EST)
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 08 May 2008 22:45:02 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Message-ID: <20080508204502.189970@gmx.net>
MIME-Version: 1.0
Subject: Patch [Port fixmap from x86 and use for kmap_atomic] breaks
	dma_noncoherent.c
To: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

The commit "[POWERPC] Port fixmap from x86 and use for kmap_atomic" breaks
dma-noncoherent.c, if highmem is enabled.

> --- a/arch/powerpc/mm/pgtable_32.c
> +++ b/arch/powerpc/mm/pgtable_32.c
> @@ -387,3 +388,25 @@ void kernel_map_pages(struct page *page, int numpages, int enable)
>         change_page_attr(page, numpages, enable ? PAGE_KERNEL : __pgprot(0));
>  }
>  #endif /* CONFIG_DEBUG_PAGEALLOC */
> +
> +static int fixmaps;
> +unsigned long FIXADDR_TOP = 0xfffff000;
> +EXPORT_SYMBOL(FIXADDR_TOP);
> +
The address defined for FIXADDR_TOP seems to conflict with the address
defined by CONSISTENT_START (default 0xff100000). It triggers the
BUG_ON(!pte_none(*pte)) statement in __dma_alloc_coherent().

regards,

Gerhard

-- 
GMX startet ShortView.de. Hier findest Du Leute mit Deinen Interessen!
Jetzt dabei sein: http://www.shortview.de/?mc=sv_ext_mf@gmx
