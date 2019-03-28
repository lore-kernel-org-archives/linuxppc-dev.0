Return-Path: <SRS0=U6gC=R7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CBAC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Mar 2019 23:43:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD4902173C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Mar 2019 23:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="GzMezy5b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD4902173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44VhJP40M8zDqJB
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 10:43:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=axtens.net
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=dja@axtens.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.b="GzMezy5b"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44VhGT2PfJzDqLt
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Mar 2019 10:41:34 +1100 (AEDT)
Received: by mail-pl1-x644.google.com with SMTP id cv12so92236plb.9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Mar 2019 16:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version:content-transfer-encoding;
 bh=BVHtxP3yUgOCgsY/NhYMTbBGiBdSCyBIggCpCbKeS/E=;
 b=GzMezy5bBS3P48c3DwOf8xNocddK4qWTadmNFLer4zxoIPRnzMMNUHMGt5Dhu0vnZj
 z0j0q8B2qkATdzkjb/yzrSSo9+on9lr2BpDr0qd/j4zQ3T28b+H1YrMgJcWx461/Lrtk
 wd8HjYG2oryJAMshPYuG9R7JoP+THTyK5Cs24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version:content-transfer-encoding;
 bh=BVHtxP3yUgOCgsY/NhYMTbBGiBdSCyBIggCpCbKeS/E=;
 b=Kwdt2Tj6+s9ikRxauQz8Q+NYz0dyMlp8B0reGMDV6z6S/DXY33u1syNigT1k9HqaeU
 JzUSL32H4lAct8S2VfpiARw+TBEVqoFcGl8MfPyqcgVn2xN9KEvcbB8h+b9POlqExrjF
 eIdOhsJwc24XxH0z4/YrhMD5aWg/s1EDhr3EiPQJ6Kp5QUnQbZ2n0cPbPGM+uPOqc4hs
 Ju9q4gMJKfEGayh8+29NAtWut3mCyFKpgMydhTDIZJGSAovygkdmxlocrFjzwbuIKcP0
 3DZlkqZgxqIbNkIHsPR4tpUK7Nkpy3q3USQr5YU2j3hJbyficqRvV2T9I8aax35ogKcN
 JGzw==
X-Gm-Message-State: APjAAAWmXM1DecOdwUZks7BrLSJFhHge+Oz7U0tSv6gMcVDh47twkgl0
 SyedrK+T9vq8SpCtyPKUGCCcPA==
X-Google-Smtp-Source: APXvYqxIV9dcJgJ2PLWKBHOkXoD4SVsQ8D/71MgXd2rPmUJdRwjw4+oGCMkhlsi9cPfoo21qyDC1WA==
X-Received: by 2002:a17:902:2b8b:: with SMTP id
 l11mr46919385plb.18.1553816490942; 
 Thu, 28 Mar 2019 16:41:30 -0700 (PDT)
Received: from localhost (203-59-138-159.perm.iinet.net.au. [203.59.138.159])
 by smtp.gmail.com with ESMTPSA id
 y68sm318057pgy.67.2019.03.28.16.41.29
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 28 Mar 2019 16:41:29 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [RFC PATCH] powerpc/book3e: KASAN Full support for 64bit
In-Reply-To: <488ecc81-ac72-ec04-380a-bd04d4def39d@c-s.fr>
References: <3401648225001077db54172ee87573b21e1cfa38.1553782837.git.christophe.leroy@c-s.fr>
 <488ecc81-ac72-ec04-380a-bd04d4def39d@c-s.fr>
Date: Fri, 29 Mar 2019 10:41:26 +1100
Message-ID: <87wokiword.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Christophe,

> Daniel,
>
> This patch applies on top of my series.
>
> With this patch, I've managed to enable KASAN without the changes you=20
> proposed on the KASAN core. This allows a full support of KASAN, ie not=20
> limited to KASAN_MINIMAL.
>
> There is still some details to address, but it boots OK on qemu-e500.
>
> Can you have a try and tell me if it works on your side too ?
>
> It will likely fail for modules at the time being as I did nothing about =
it.
>
> Tell me if you continue working on it. I don't plan to spend more time=20
> on it for the time being.

Thanks!! I will have a look - I've been trying to do something on 3s
Radix and was hoping to apply lessons learned from that to the 3e case.
So it may take a little while but I will eventually get back to this.

Regards,
Daniel
>
> Like I did on PPC32, it would be good to create an early_64.c file and=20
> move into it the few functions from setup_64.c and paca.c that are=20
> called before feature_fixups are done, in order to not disable KASAN on=20
> the entire paca.c and setup_64.c
>
> I guess we could reduce a bit the size of the IOREMAP_AREA and put KASAN=
=20
> on top of it instead of using VMEMMAP space, allthough I don't have a=20
> clean view of how it would cooperate with VMEMMMAP if we keep it enabled.
>
> I've not been able to identify what is the largest size of the linear=20
> mapping (ie the 0xc000000000000000 region).
>
> Christophe
>
> Le 28/03/2019 =C3=A0 15:21, Christophe Leroy a =C3=A9crit=C2=A0:
>> The KASAN shadow area is mapped into vmemmap space:
>> 0x8000 0400 0000 0000 to 0x8000 0600 0000 0000.
>> For this vmemmap has to be disabled.
>>=20
>> Cc: Daniel Axtens <dja@axtens.net>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>   arch/powerpc/Kconfig                  |   1 +
>>   arch/powerpc/Kconfig.debug            |   3 +-
>>   arch/powerpc/include/asm/kasan.h      |  11 +++
>>   arch/powerpc/kernel/Makefile          |   2 +
>>   arch/powerpc/kernel/head_64.S         |   3 +
>>   arch/powerpc/kernel/setup_64.c        |  20 +++---
>>   arch/powerpc/mm/kasan/Makefile        |   1 +
>>   arch/powerpc/mm/kasan/kasan_init_64.c | 129 ++++++++++++++++++++++++++=
++++++++
>>   8 files changed, 159 insertions(+), 11 deletions(-)
>>   create mode 100644 arch/powerpc/mm/kasan/kasan_init_64.c
>>=20
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index 1a2fb50126b2..e0b7c45e4dc7 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -174,6 +174,7 @@ config PPC
>>   	select HAVE_ARCH_AUDITSYSCALL
>>   	select HAVE_ARCH_JUMP_LABEL
>>   	select HAVE_ARCH_KASAN			if PPC32
>> +	select HAVE_ARCH_KASAN			if PPC_BOOK3E_64 && !SPARSEMEM_VMEMMAP
>>   	select HAVE_ARCH_KGDB
>>   	select HAVE_ARCH_MMAP_RND_BITS
>>   	select HAVE_ARCH_MMAP_RND_COMPAT_BITS	if COMPAT
>> diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
>> index 61febbbdd02b..b4140dd6b4e4 100644
>> --- a/arch/powerpc/Kconfig.debug
>> +++ b/arch/powerpc/Kconfig.debug
>> @@ -370,4 +370,5 @@ config PPC_FAST_ENDIAN_SWITCH
>>   config KASAN_SHADOW_OFFSET
>>   	hex
>>   	depends on KASAN
>> -	default 0xe0000000
>> +	default 0xe0000000 if PPC32
>> +	default 0x6800040000000000 if PPC64
>> diff --git a/arch/powerpc/include/asm/kasan.h b/arch/powerpc/include/asm=
/kasan.h
>> index 296e51c2f066..756b3d58f921 100644
>> --- a/arch/powerpc/include/asm/kasan.h
>> +++ b/arch/powerpc/include/asm/kasan.h
>> @@ -23,10 +23,21 @@
>>=20=20=20
>>   #define KASAN_SHADOW_OFFSET	ASM_CONST(CONFIG_KASAN_SHADOW_OFFSET)
>>=20=20=20
>> +#ifdef CONFIG_PPC32
>>   #define KASAN_SHADOW_END	0UL
>>=20=20=20
>>   #define KASAN_SHADOW_SIZE	(KASAN_SHADOW_END - KASAN_SHADOW_START)
>>=20=20=20
>> +#else
>> +
>> +#include <asm/pgtable.h>
>> +
>> +#define KASAN_SHADOW_SIZE	(KERN_VIRT_SIZE >> KASAN_SHADOW_SCALE_SHIFT)
>> +
>> +#define KASAN_SHADOW_END	(KASAN_SHADOW_START + KASAN_SHADOW_SIZE)
>> +
>> +#endif /* CONFIG_PPC32 */
>> +
>>   #ifdef CONFIG_KASAN
>>   void kasan_early_init(void);
>>   void kasan_mmu_init(void);
>> diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
>> index 0ea6c4aa3a20..7f232c06f11d 100644
>> --- a/arch/powerpc/kernel/Makefile
>> +++ b/arch/powerpc/kernel/Makefile
>> @@ -35,6 +35,8 @@ KASAN_SANITIZE_early_32.o :=3D n
>>   KASAN_SANITIZE_cputable.o :=3D n
>>   KASAN_SANITIZE_prom_init.o :=3D n
>>   KASAN_SANITIZE_btext.o :=3D n
>> +KASAN_SANITIZE_paca.o :=3D n
>> +KASAN_SANITIZE_setup_64.o :=3D n
>>=20=20=20
>>   ifdef CONFIG_KASAN
>>   CFLAGS_early_32.o +=3D -DDISABLE_BRANCH_PROFILING
>> diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64=
.S
>> index 3fad8d499767..80fbd8024fb2 100644
>> --- a/arch/powerpc/kernel/head_64.S
>> +++ b/arch/powerpc/kernel/head_64.S
>> @@ -966,6 +966,9 @@ start_here_multiplatform:
>>   	 * and SLB setup before we turn on relocation.
>>   	 */
>>=20=20=20
>> +#ifdef CONFIG_KASAN
>> +	bl	kasan_early_init
>> +#endif
>>   	/* Restore parameters passed from prom_init/kexec */
>>   	mr	r3,r31
>>   	bl	early_setup		/* also sets r13 and SPRG_PACA */
>> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_=
64.c
>> index ba404dd9ce1d..d2bf860dd966 100644
>> --- a/arch/powerpc/kernel/setup_64.c
>> +++ b/arch/powerpc/kernel/setup_64.c
>> @@ -311,6 +311,16 @@ void __init early_setup(unsigned long dt_ptr)
>>    	DBG(" -> early_setup(), dt_ptr: 0x%lx\n", dt_ptr);
>>=20=20=20
>>   	/*
>> +	 * Configure exception handlers. This include setting up trampolines
>> +	 * if needed, setting exception endian mode, etc...
>> +	 */
>> +	configure_exceptions();
>> +
>> +	/* Apply all the dynamic patching */
>> +	apply_feature_fixups();
>> +	setup_feature_keys();
>> +
>> +	/*
>>   	 * Do early initialization using the flattened device
>>   	 * tree, such as retrieving the physical memory map or
>>   	 * calculating/retrieving the hash table size.
>> @@ -325,16 +335,6 @@ void __init early_setup(unsigned long dt_ptr)
>>   	setup_paca(paca_ptrs[boot_cpuid]);
>>   	fixup_boot_paca();
>>=20=20=20
>> -	/*
>> -	 * Configure exception handlers. This include setting up trampolines
>> -	 * if needed, setting exception endian mode, etc...
>> -	 */
>> -	configure_exceptions();
>> -
>> -	/* Apply all the dynamic patching */
>> -	apply_feature_fixups();
>> -	setup_feature_keys();
>> -
>>   	/* Initialize the hash table or TLB handling */
>>   	early_init_mmu();
>>=20=20=20
>> diff --git a/arch/powerpc/mm/kasan/Makefile b/arch/powerpc/mm/kasan/Make=
file
>> index 6577897673dd..0bfbe3892808 100644
>> --- a/arch/powerpc/mm/kasan/Makefile
>> +++ b/arch/powerpc/mm/kasan/Makefile
>> @@ -3,3 +3,4 @@
>>   KASAN_SANITIZE :=3D n
>>=20=20=20
>>   obj-$(CONFIG_PPC32)           +=3D kasan_init_32.o
>> +obj-$(CONFIG_PPC64)	+=3D kasan_init_64.o
>> diff --git a/arch/powerpc/mm/kasan/kasan_init_64.c b/arch/powerpc/mm/kas=
an/kasan_init_64.c
>> new file mode 100644
>> index 000000000000..7fd71b8e883b
>> --- /dev/null
>> +++ b/arch/powerpc/mm/kasan/kasan_init_64.c
>> @@ -0,0 +1,129 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#define DISABLE_BRANCH_PROFILING
>> +
>> +#include <linux/kasan.h>
>> +#include <linux/printk.h>
>> +#include <linux/memblock.h>
>> +#include <linux/sched/task.h>
>> +#include <asm/pgalloc.h>
>> +
>> +static void __init kasan_populate_pte(pte_t *ptep, pgprot_t prot)
>> +{
>> +	unsigned long va =3D (unsigned long)kasan_early_shadow_page;
>> +	phys_addr_t pa =3D __pa(kasan_early_shadow_page);
>> +	int i;
>> +
>> +	for (i =3D 0; i < PTRS_PER_PTE; i++, ptep++)
>> +		__set_pte_at(&init_mm, va, ptep, pfn_pte(PHYS_PFN(pa), prot), 0);
>> +}
>> +
>> +static void __init kasan_populate_pmd(pmd_t *pmdp)
>> +{
>> +	int i;
>> +
>> +	for (i =3D 0; i < PTRS_PER_PMD; i++)
>> +		pmd_populate_kernel(&init_mm, pmdp + i, kasan_early_shadow_pte);
>> +}
>> +
>> +static void __init kasan_populate_pud(pud_t *pudp)
>> +{
>> +	int i;
>> +
>> +	for (i =3D 0; i < PTRS_PER_PUD; i++)
>> +		pud_populate(&init_mm, pudp + i, kasan_early_shadow_pmd);
>> +}
>> +
>> +static void __init *kasan_alloc_pgtable(unsigned long size)
>> +{
>> +	void *ptr =3D memblock_alloc_try_nid(size, size, MEMBLOCK_LOW_LIMIT,
>> +					   __pa(MAX_DMA_ADDRESS), NUMA_NO_NODE);
>> +
>> +	if (!ptr)
>> +		panic("%s: Failed to allocate %lu bytes align=3D0x%lx max_addr=3D%lx\=
n",
>> +		      __func__, size, size, __pa(MAX_DMA_ADDRESS));
>> +
>> +	return ptr;
>> +}
>> +
>> +static int __init kasan_map_page(unsigned long va, unsigned long pa, pg=
prot_t prot)
>> +{
>> +	pgd_t *pgdp =3D pgd_offset_k(va);
>> +	pud_t *pudp;
>> +	pmd_t *pmdp;
>> +	pte_t *ptep;
>> +
>> +	if (pgd_none(*pgdp) || (void *)pgd_page_vaddr(*pgdp) =3D=3D kasan_earl=
y_shadow_pud) {
>> +		pudp =3D kasan_alloc_pgtable(PUD_TABLE_SIZE);
>> +		kasan_populate_pud(pudp);
>> +		pgd_populate(&init_mm, pgdp, pudp);
>> +	}
>> +	pudp =3D pud_offset(pgdp, va);
>> +	if (pud_none(*pudp) || (void *)pud_page_vaddr(*pudp) =3D=3D kasan_earl=
y_shadow_pmd) {
>> +		pmdp =3D kasan_alloc_pgtable(PMD_TABLE_SIZE);
>> +		kasan_populate_pmd(pmdp);
>> +		pud_populate(&init_mm, pudp, pmdp);
>> +	}
>> +	pmdp =3D pmd_offset(pudp, va);
>> +	if (!pmd_present(*pmdp) || (void *)pmd_page_vaddr(*pmdp) =3D=3D kasan_=
early_shadow_pte) {
>> +		ptep =3D kasan_alloc_pgtable(PTE_TABLE_SIZE);
>> +		kasan_populate_pte(ptep, PAGE_KERNEL);
>> +		pmd_populate_kernel(&init_mm, pmdp, ptep);
>> +	}
>> +	ptep =3D pte_offset_kernel(pmdp, va);
>> +
>> +	__set_pte_at(&init_mm, va, ptep, pfn_pte(pa >> PAGE_SHIFT, prot), 0);
>> +
>> +	return 0;
>> +}
>> +
>> +static void __init kasan_init_region(struct memblock_region *reg)
>> +{
>> +	void *start =3D __va(reg->base);
>> +	void *end =3D __va(reg->base + reg->size);
>> +	unsigned long k_start, k_end, k_cur;
>> +
>> +	if (start >=3D end)
>> +		return;
>> +
>> +	k_start =3D (unsigned long)kasan_mem_to_shadow(start);
>> +	k_end =3D (unsigned long)kasan_mem_to_shadow(end);
>> +
>> +	for (k_cur =3D k_start; k_cur < k_end; k_cur +=3D PAGE_SIZE) {
>> +		void *va =3D memblock_alloc(PAGE_SIZE, PAGE_SIZE);
>> +
>> +		kasan_map_page(k_cur, __pa(va), PAGE_KERNEL);
>> +	}
>> +	flush_tlb_kernel_range(k_start, k_end);
>> +}
>> +
>> +void __init kasan_init(void)
>> +{
>> +	struct memblock_region *reg;
>> +
>> +	for_each_memblock(memory, reg)
>> +		kasan_init_region(reg);
>> +
>> +	/* It's too early to use clear_page() ! */
>> +	memset(kasan_early_shadow_page, 0, sizeof(kasan_early_shadow_page));
>> +
>> +	/* Enable error messages */
>> +	init_task.kasan_depth =3D 0;
>> +	pr_info("KASAN init done\n");
>> +}
>> +
>> +/* The early shadow maps everything to a single page of zeroes */
>> +asmlinkage void __init kasan_early_init(void)
>> +{
>> +	unsigned long addr =3D KASAN_SHADOW_START;
>> +	unsigned long end =3D KASAN_SHADOW_END;
>> +	pgd_t *pgdp =3D pgd_offset_k(addr);
>> +
>> +	kasan_populate_pte(kasan_early_shadow_pte, PAGE_KERNEL);
>> +	kasan_populate_pmd(kasan_early_shadow_pmd);
>> +	kasan_populate_pud(kasan_early_shadow_pud);
>> +
>> +	do {
>> +		pgd_populate(&init_mm, pgdp, kasan_early_shadow_pud);
>> +	} while (pgdp++, addr =3D pgd_addr_end(addr, end), addr !=3D end);
>> +}
>>=20
