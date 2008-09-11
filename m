Return-Path: <prodyuth@gmail.com>
Received: from mail-gx0-f21.google.com (mail-gx0-f21.google.com
	[209.85.217.21]) by ozlabs.org (Postfix) with ESMTP id F0BDDDE03F
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Sep 2008 02:57:53 +1000 (EST)
Received: by gxk14 with SMTP id 14so16508491gxk.9
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Sep 2008 09:57:52 -0700 (PDT)
Message-ID: <49c0ff980809110957h4b7b85d4ie39dbb27d1edbe39@mail.gmail.com>
Date: Thu, 11 Sep 2008 09:57:50 -0700
From: "prodyut hazarika" <prodyuth@gmail.com>
To: "Ilya Yanok" <yanok@emcraft.com>
Subject: Re: [PATCH] powerpc: add support for PAGE_SIZEs greater than 4KB for
In-Reply-To: <1221083587-8091-2-git-send-email-yanok@emcraft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
References: <1221083587-8091-1-git-send-email-yanok@emcraft.com>
	<1221083587-8091-2-git-send-email-yanok@emcraft.com>
Cc: linuxppc-dev@ozlabs.org, wd@denx.de, dzu@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I was planning to post a similar patch. Good that you already posted
it :-) I will try to finish off similar patch for 40x processors.

>
> +choice
> +       prompt "Page size"
> +       depends on 44x && PPC32
> +       default PPC32_4K_PAGES
> +       help
> +         The PAGE_SIZE definition. Increasing the page size may
> +         improve the system performance in some dedicated cases.
> +         If unsure, set it to 4 KB.
> +
You should mention an example of dedicated cases (eg. RAID).
I think this help should mention that for page size 256KB, you will
need to have a special version of binutils, since the ELF standard
mentions page sizes only upto 64KB.

> -#ifdef CONFIG_PPC_64K_PAGES
> +#if defined(CONFIG_PPC32_256K_PAGES)
> +#define PAGE_SHIFT             18
> +#elif defined(CONFIG_PPC32_64K_PAGES) || defined(CONFIG_PPC_64K_PAGES)
>  #define PAGE_SHIFT             16
> +#elif defined(CONFIG_PPC32_16K_PAGES)
> +#define PAGE_SHIFT             14
>  #else
>  #define PAGE_SHIFT             12
>  #endif

Why should the new defines be inside CONFIG_PPC_64K_PAGES? The
definition CONFIG_PPC_64K_PAGES is repeated.
Shouldn't these defines be like this:
#if defined(CONFIG_PPC32_256K_PAGES)
#define PAGE_SHIFT             18
#elif defined(CONFIG_PPC32_64K_PAGES) || defined(CONFIG_PPC_64K_PAGES)
#define PAGE_SHIFT             16
#elif defined(CONFIG_PPC32_16K_PAGES)
#define PAGE_SHIFT             14
#else
#define PAGE_SHIFT             12
#endif

> +#elif (PAGE_SHIFT == 14)
> +/*
> + * PAGE_SIZE  16K
> + * PAGE_SHIFT 14
> + * PTE_SHIFT  11
> + * PMD_SHIFT  25
> + */
> +#define PPC44x_TLBE_SIZE       PPC44x_TLB_16K
> +#define PPC44x_PGD_OFF_SH      9  /*(32 - PMD_SHIFT + 2)*/
> +#define PPC44x_PGD_OFF_M1      23 /*(PMD_SHIFT - 2)*/
> +#define PPC44x_PTE_ADD_SH      21 /*32 - PMD_SHIFT + PTE_SHIFT + 3*/
> +#define PPC44x_PTE_ADD_M1      18 /*32 - 3 - PTE_SHIFT*/
> +#define PPC44x_RPN_M2          17 /*31 - PAGE_SHIFT*/

Please change PPC44x_PGD_OFF_SH to PPC44x_PGD_OFF_SHIFT. SH sounds
very confusing. I don't like the MI and M2 names too. Change
PPC44x_RPN_M2 to PPC44x_RPN_MASK. Change M1 to MASK in
PPC44x_PGD_OFF_M1 and PPC44x_PTE_ADD_M1 .
Is there no way a define like
#define PPC44x_PGD_OFF_SH      (32 - PMD_SHIFT + 2)
be used in assembly file. If yes, we can avoid repeating the defines.

I think these 44x specific defines should go to asm/mmu-44x.h since I
am planning to post a patch for 40x. For those processors, the defines
below will changes as:
#define PPC44x_PTE_ADD_SH      (32 - PMD_SHIFT + PTE_SHIFT + 2)
#define PPC44x_PTE_ADD_M1      (32 - 2 - PTE_SHIFT)
Since these defines are not generic, they should be put in the mmu
specific header file rather than adding a new header file. When 40x
processors are supported, the corresponding defines can go to
include/asm/mmu-40x.h

> +#elif (PAGE_SHIFT == 18)
> +/*
> + * PAGE_SIZE  256K
> + * PAGE_SHIFT 18
> + * PTE_SHIFT  11
> + * PMD_SHIFT  29
> + */
> +#define PPC44x_TLBE_SIZE       PPC44x_TLB_256K
> +#define PPC44x_PGD_OFF_SH      5  /*(32 - PMD_SHIFT + 2)*/
> +#define PPC44x_PGD_OFF_M1      27 /*(PMD_SHIFT - 2)*/
> +#define PPC44x_PTE_ADD_SH      17 /*32 - PMD_SHIFT + PTE_SHIFT + 3*/
> +#define PPC44x_PTE_ADD_M1      18 /*32 - 3 - PTE_SHIFT*/
> +#define PPC44x_RPN_M2          13 /*31 - PAGE_SHIFT*/

For 256KB page size, I cannot understand why PTE_SHIFT is 11. Since
each PTE entry is 8 byte, PTE_SHIFT should have been 15. But then
there would be no bits in the Effective address for the 1st level
PGDIR offset. On what basis PTE_SHIFT of 11 is chosen? This overflow
problem happens only for 256KB page size.
