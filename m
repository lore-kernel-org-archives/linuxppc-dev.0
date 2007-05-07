Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CA197DDE48
	for <linuxppc-dev@ozlabs.org>; Mon,  7 May 2007 18:24:46 +1000 (EST)
Date: Mon, 7 May 2007 10:24:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: Re: powerpc: Remove use of 4level-fixup.h for ppc32
Message-ID: <20070507082441.GA2795@lst.de>
References: <20070507053527.GB24464@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070507053527.GB24464@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 07, 2007 at 03:35:27PM +1000, David Gibson wrote:
> ===================================================================
> --- working-2.6.orig/include/asm-powerpc/page.h	2007-05-07 14:24:21.000000000 +1000
> +++ working-2.6/include/asm-powerpc/page.h	2007-05-07 15:30:04.000000000 +1000
> @@ -121,9 +121,11 @@ typedef struct { pte_t pte; } real_pte_t
>  #endif
>  
>  /* PMD level */
> +#ifdef CONFIG_PPC64
>  typedef struct { unsigned long pmd; } pmd_t;
>  #define pmd_val(x)	((x).pmd)
>  #define __pmd(x)	((pmd_t) { (x) })
> +#endif
>  
>  /* PUD level exusts only on 4k pages */
>  #if defined(CONFIG_PPC64) && !defined(CONFIG_PPC_64K_PAGES)
> @@ -159,9 +161,11 @@ typedef unsigned long real_pte_t;
>  #endif
>  
>  
> +#if defined (CONFIG_PPC64)
>  typedef unsigned long pmd_t;
>  #define pmd_val(x)	(x)
>  #define __pmd(x)	(x)
> +#endif

This should be one bit CONFIG_PPC64 block with a nested !CONFIG_PPC_64K_PAGES
block inbetween.

>  
>  #if defined(CONFIG_PPC64) && !defined(CONFIG_PPC_64K_PAGES)
>  typedef unsigned long pud_t;

also extending down here.  Unfortunately the page.h you patch seems
to be different already from the one in current mainline so I don't
have the full picture at hand, but it would be nice to only have
a few ifdef blocks in the header.

Except for that little nitpick the patch looks good.
