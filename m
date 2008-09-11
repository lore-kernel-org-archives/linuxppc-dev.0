Return-Path: <prodyuth@gmail.com>
Received: from mail-gx0-f21.google.com (mail-gx0-f21.google.com
	[209.85.217.21]) by ozlabs.org (Postfix) with ESMTP id 8A27CDDF23
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Sep 2008 04:39:40 +1000 (EST)
Received: by gxk14 with SMTP id 14so16777390gxk.9
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Sep 2008 11:38:53 -0700 (PDT)
Message-ID: <49c0ff980809111138xc2b8fadj79f1a1340a3dad0c@mail.gmail.com>
Date: Thu, 11 Sep 2008 11:38:52 -0700
From: "prodyut hazarika" <prodyuth@gmail.com>
To: "Ilya Yanok" <yanok@emcraft.com>
Subject: Re: [PATCH] powerpc: add support for PAGE_SIZEs greater than 4KB for
In-Reply-To: <48C96349.1040903@emcraft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
References: <1221083587-8091-1-git-send-email-yanok@emcraft.com>
	<1221083587-8091-2-git-send-email-yanok@emcraft.com>
	<49c0ff980809110957h4b7b85d4ie39dbb27d1edbe39@mail.gmail.com>
	<48C96349.1040903@emcraft.com>
Cc: linuxppc-dev@ozlabs.org, wd@denx.de, dzu@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>
> I think you missed first '-' on the first line.
>
I was not too careful :-)


>> I think these 44x specific defines should go to asm/mmu-44x.h since I
>>
>
> Agreed.
>
It would be great to have user-friendly names.
Also moving to the mmu-4xx specific header files hides the changes to 4xx files.


>> For 256KB page size, I cannot understand why PTE_SHIFT is 11. Since
>> each PTE entry is 8 byte, PTE_SHIFT should have been 15. But then
>> there would be no bits in the Effective address for the 1st level
>> PGDIR offset. On what basis PTE_SHIFT of 11 is chosen? This overflow
>> problem happens only for 256KB page size.
>>
>
> I think Yuri has commented on this already.
>
Thanks.

In file arch/powerpc/mm/pgtable_32.c, we have:

#ifdef CONFIG_PTE_64BIT
/* 44x uses an 8kB pgdir because it has 8-byte Linux PTEs. */
#define PGDIR_ORDER     1
#else
#define PGDIR_ORDER     0
#endif
pgd_t *pgd_alloc(struct mm_struct *mm)
{
        pgd_t *ret;

        ret = (pgd_t *)__get_free_pages(GFP_KERNEL|__GFP_ZERO, PGDIR_ORDER);
        return ret;
}

Thus, we allocate 2 pages for 44x processors for PGD. This is needed
only for 4K page.
We are anyway not using the whole 64K or 256K page for the PGD. So
there is no point to waste an additional 64K or 256KB page

Change this to:
#ifdef CONFIG_PTE_64BIT
#if (PAGE_SHIFT == 12)
/* 44x uses an 8kB pgdir because it has 8-byte Linux PTEs. */
#define PGDIR_ORDER     1
#else
#define PGDIR_ORDER     0
#endif
#else
#define PGDIR_ORDER     0
#endif
