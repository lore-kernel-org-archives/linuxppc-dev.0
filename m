Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4323BDE1B1
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Sep 2008 04:36:29 +1000 (EST)
Date: Thu, 11 Sep 2008 22:15:07 +0400
From: Yuri Tikhonov <yur@emcraft.com>
Message-ID: <1715327082.20080911221507@emcraft.com>
To: "prodyut hazarika" <prodyuth@gmail.com>
Subject: Re[2]: [PATCH] powerpc: add support for PAGE_SIZEs greater than 4KB
	for
In-Reply-To: <49c0ff980809110957h4b7b85d4ie39dbb27d1edbe39@mail.gmail.com>
References: <1221083587-8091-1-git-send-email-yanok@emcraft.com>
	<1221083587-8091-2-git-send-email-yanok@emcraft.com>
	<49c0ff980809110957h4b7b85d4ie39dbb27d1edbe39@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Cc: linuxppc-dev@ozlabs.org, dzu@denx.de, wd@denx.de,
	Ilya Yanok <yanok@emcraft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=0D=0AHello,

On Thursday, September 11, 2008 you wrote:

> I was planning to post a similar patch. Good that you already posted
> it :-) I will try to finish off similar patch for 40x processors.

>>
>> +choice
>> +       prompt "Page size"
>> +       depends on 44x && PPC32
>> +       default PPC32_4K_PAGES
>> +       help
>> +         The PAGE_SIZE definition. Increasing the page size may
>> +         improve the system performance in some dedicated cases.
>> +         If unsure, set it to 4 KB.
>> +
> You should mention an example of dedicated cases (eg. RAID).

ACK.

> I think this help should mention that for page size 256KB, you will
> need to have a special version of binutils, since the ELF standard
> mentions page sizes only upto 64KB.

 Right. We use ELDK-4.2 for compiling applications to be run on 256K
PAGE_SIZE kernel. This toolchain includes necessary changes for
ELF_MAXPAGESIZE in binutils/bfd/elf32-ppc.c.

>> -#ifdef CONFIG_PPC_64K_PAGES
>> +#if defined(CONFIG_PPC32_256K_PAGES)
>> +#define PAGE_SHIFT             18
>> +#elif defined(CONFIG_PPC32_64K_PAGES) || defined(CONFIG_PPC_64K_PAGES)
>>  #define PAGE_SHIFT             16
>> +#elif defined(CONFIG_PPC32_16K_PAGES)
>> +#define PAGE_SHIFT             14
>>  #else
>>  #define PAGE_SHIFT             12
>>  #endif

> Why should the new defines be inside CONFIG_PPC_64K_PAGES? The
> definition CONFIG_PPC_64K_PAGES is repeated.

 We decided to introduce new CONFIG_PPC32_64K_PAGES option to
distinguish using 64K pages on PPC32 and PPC64, so PAGE_SHIFT will be
defined as 16 when the CONFIG_PPC_64K_PAGES option is set on some PPC64
platform, and as 16 when the CONFIG_PPC32_64K_PAGES option is set on
some ppc44x PPC32 platform.

> Shouldn't these defines be like this:
> #if defined(CONFIG_PPC32_256K_PAGES)
> #define PAGE_SHIFT             18
> #elif defined(CONFIG_PPC32_64K_PAGES) || defined(CONFIG_PPC_64K_PAGES)
> #define PAGE_SHIFT             16
> #elif defined(CONFIG_PPC32_16K_PAGES)
> #define PAGE_SHIFT             14
> #else
> #define PAGE_SHIFT             12
> #endif

 Admittedly, I don't see the difference between your version and
Ilya's one. Am I missing something ?

>> +#elif (PAGE_SHIFT =3D=3D 14)
>> +/*
>> + * PAGE_SIZE  16K
>> + * PAGE_SHIFT 14
>> + * PTE_SHIFT  11
>> + * PMD_SHIFT  25
>> + */
>> +#define PPC44x_TLBE_SIZE       PPC44x_TLB_16K
>> +#define PPC44x_PGD_OFF_SH      9  /*(32 - PMD_SHIFT + 2)*/
>> +#define PPC44x_PGD_OFF_M1      23 /*(PMD_SHIFT - 2)*/
>> +#define PPC44x_PTE_ADD_SH      21 /*32 - PMD_SHIFT + PTE_SHIFT + 3*/
>> +#define PPC44x_PTE_ADD_M1      18 /*32 - 3 - PTE_SHIFT*/
>> +#define PPC44x_RPN_M2          17 /*31 - PAGE_SHIFT*/

> Please change PPC44x_PGD_OFF_SH to PPC44x_PGD_OFF_SHIFT. SH sounds
> very confusing. I don't like the MI and M2 names too. Change
> PPC44x_RPN_M2 to PPC44x_RPN_MASK. Change M1 to MASK in
> PPC44x_PGD_OFF_M1 and PPC44x_PTE_ADD_M1 .
> Is there no way a define like
> #define PPC44x_PGD_OFF_SH      (32 - PMD_SHIFT + 2)
> be used in assembly file. If yes, we can avoid repeating the defines.

> I think these 44x specific defines should go to asm/mmu-44x.h since I
> am planning to post a patch for 40x. For those processors, the defines
> below will changes as:
> #define PPC44x_PTE_ADD_SH      (32 - PMD_SHIFT + PTE_SHIFT + 2)
> #define PPC44x_PTE_ADD_M1      (32 - 2 - PTE_SHIFT)
> Since these defines are not generic, they should be put in the mmu
> specific header file rather than adding a new header file. When 40x
> processors are supported, the corresponding defines can go to
> include/asm/mmu-40x.h

>> +#elif (PAGE_SHIFT =3D=3D 18)
>> +/*
>> + * PAGE_SIZE  256K
>> + * PAGE_SHIFT 18
>> + * PTE_SHIFT  11
>> + * PMD_SHIFT  29
>> + */
>> +#define PPC44x_TLBE_SIZE       PPC44x_TLB_256K
>> +#define PPC44x_PGD_OFF_SH      5  /*(32 - PMD_SHIFT + 2)*/
>> +#define PPC44x_PGD_OFF_M1      27 /*(PMD_SHIFT - 2)*/
>> +#define PPC44x_PTE_ADD_SH      17 /*32 - PMD_SHIFT + PTE_SHIFT + 3*/
>> +#define PPC44x_PTE_ADD_M1      18 /*32 - 3 - PTE_SHIFT*/
>> +#define PPC44x_RPN_M2          13 /*31 - PAGE_SHIFT*/

> For 256KB page size, I cannot understand why PTE_SHIFT is 11. Since
> each PTE entry is 8 byte, PTE_SHIFT should have been 15. But then
> there would be no bits in the Effective address for the 1st level
> PGDIR offset. On what basis PTE_SHIFT of 11 is chosen? This overflow
> problem happens only for 256KB page size.

 We should use smaller PTE area in address to free some bits for PGDIR
part. I guess the only impact this approach has is ineffective usage
of memory pages allocated for PTE tables, since having PTE_SHIFT of 11
we use only 1/16 of pages with PTEs.

 Regards, Yuri

 --
 Yuri Tikhonov, Senior Software Engineer
 Emcraft Systems, www.emcraft.com
