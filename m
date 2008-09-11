Return-Path: <yanok@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 83875DE023
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Sep 2008 08:44:58 +1000 (EST)
Message-ID: <48C99F42.80909@emcraft.com>
Date: Fri, 12 Sep 2008 02:44:18 +0400
From: Ilya Yanok <yanok@emcraft.com>
MIME-Version: 1.0
To: prodyut hazarika <prodyuth@gmail.com>
Subject: Re: [PATCH] powerpc: add support for PAGE_SIZEs greater than 4KB for
References: <1221083587-8091-1-git-send-email-yanok@emcraft.com>	
	<1221083587-8091-2-git-send-email-yanok@emcraft.com>	
	<49c0ff980809110957h4b7b85d4ie39dbb27d1edbe39@mail.gmail.com>	
	<48C96349.1040903@emcraft.com>
	<49c0ff980809111138xc2b8fadj79f1a1340a3dad0c@mail.gmail.com>
In-Reply-To: <49c0ff980809111138xc2b8fadj79f1a1340a3dad0c@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, wd@denx.de, dzu@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

prodyut hazarika wrote:
> In file arch/powerpc/mm/pgtable_32.c, we have:
>
> #ifdef CONFIG_PTE_64BIT
> /* 44x uses an 8kB pgdir because it has 8-byte Linux PTEs. */
> #define PGDIR_ORDER     1
> #else
> #define PGDIR_ORDER     0
> #endif
> pgd_t *pgd_alloc(struct mm_struct *mm)
> {
>         pgd_t *ret;
>
>         ret = (pgd_t *)__get_free_pages(GFP_KERNEL|__GFP_ZERO, PGDIR_ORDER);
>         return ret;
> }
>
> Thus, we allocate 2 pages for 44x processors for PGD. This is needed
> only for 4K page.
> We are anyway not using the whole 64K or 256K page for the PGD. So
> there is no point to waste an additional 64K or 256KB page
>   

Ok. Not sure I'm right but I think 16K case doesn't need second page 
too. (PGDIR_SHIFT=25, so sizeof(pgd_t)<<(32-PGDIR_SHIFT) < 16KB)

> Change this to:
> #ifdef CONFIG_PTE_64BIT
> #if (PAGE_SHIFT == 12)
>   

I think #ifdef CONFIG_PTE_64BIT is a little bit confusing here...  
Actually PGDIR_ORDER  should be something like max(32 + 2 - PGDIR_SHIFT 
- PAGE_SHIFT, 0)

> /* 44x uses an 8kB pgdir because it has 8-byte Linux PTEs. */
> #define PGDIR_ORDER     1
> #else
> #define PGDIR_ORDER     0
> #endif
> #else
> #define PGDIR_ORDER     0
> #endif
>   

Yuri, any comments?

Regards, Ilya.
