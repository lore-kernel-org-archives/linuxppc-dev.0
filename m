Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8D496DDE23
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jul 2008 11:01:18 +1000 (EST)
Subject: Re: [patch] powerpc: implement pte_special for 64K pages
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nick Piggin <npiggin@suse.de>
In-Reply-To: <20080717104426.GA25083@wotan.suse.de>
References: <20080717104426.GA25083@wotan.suse.de>
Content-Type: text/plain
Date: Mon, 21 Jul 2008 10:57:55 +1000
Message-Id: <1216601875.11027.59.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-07-17 at 12:44 +0200, Nick Piggin wrote:
> This can be folded into powerpc-implement-pte_special.patch
> 
> --
> Ben has now freed up a pte bit on 64k pages. Use it for special pte bit.
> 
> Signed-off-by: Nick Piggin <npiggin@suse.de>
> ---

Ack.

Andrew, will you merge this or do you want me to ?

Cheers,
Ben.

> Index: linux-2.6/include/asm-powerpc/pgtable-64k.h
> ===================================================================
> --- linux-2.6.orig/include/asm-powerpc/pgtable-64k.h	2008-07-17 18:53:03.000000000 +1000
> +++ linux-2.6/include/asm-powerpc/pgtable-64k.h	2008-07-17 20:30:06.000000000 +1000
> @@ -70,11 +70,12 @@
>  #define PGDIR_MASK	(~(PGDIR_SIZE-1))
>  
>  /* Additional PTE bits (don't change without checking asm in hash_low.S) */
> +#define __HAVE_ARCH_PTE_SPECIAL
> +#define _PAGE_SPECIAL	0x00000400 /* software: special page */
>  #define _PAGE_HPTE_SUB	0x0ffff000 /* combo only: sub pages HPTE bits */
>  #define _PAGE_HPTE_SUB0	0x08000000 /* combo only: first sub page */
>  #define _PAGE_COMBO	0x10000000 /* this is a combo 4k page */
>  #define _PAGE_4K_PFN	0x20000000 /* PFN is for a single 4k page */
> -#define _PAGE_SPECIAL	0x0	   /* don't have enough room for this yet */
>  
>  /* For 64K page, we don't have a separate _PAGE_HASHPTE bit. Instead,
>   * we set that to be the whole sub-bits mask. The C code will only
