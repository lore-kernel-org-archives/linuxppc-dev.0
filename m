Return-Path: <linuxppc-dev+bounces-17168-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B785FEFD216
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Feb 2026 09:34:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fLTtz0Y0Vz3dXj;
	Wed, 25 Feb 2026 20:34:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::532"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772012059;
	cv=none; b=FNoeumEQsQ8dAexPoQpFe+2ZcgshWaV+ZOuaaJr9ds816io145AB0j4bUdhDjswte9baip7Js5LMerxN6ApYBYbqdPMpphgFg9EtA+mIypecAgcyPEvmQ1G1u3APNAKhoUgChH+BW7/lZxxvTuqI2jOGbjDv9IrJ4d76ZScbXZOX5b1mZ99Wam+kRJQpaa28tS+vKnaQNC4K+lq7b/HBBCQtDP3xP/atNGNXM/SpIRi7ecNsT5Gx+FDWlxsabOZmyvdHogqntdO2iJrWyJbe25Ds2MGZ8o+qBVi1xQ0FMqLh5GChrG56URO5pHJUzsm+201J+Qm5lTcJ6SFHhGNYew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772012059; c=relaxed/relaxed;
	bh=JxnsaOQZey5wMq56BxN2EdEuMBW71mGq+RSuzcss/8M=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=e91VK4YJEHwJdmiwYKqTUDcunP0k9z+48zz6FSf5UJFvsXvaR6WTvBASd9PV8pzsG8JGYS251i2mOkzlkEkU8EfYX9NeDTwvPmKtmOhl/e5gN+eetVO4B2MqbvrugRqWk2uCxDGsN01uTJ3kZjn0bhcHh6CYypHNG1VhT4hxPw6nRGspSilFfTorfXH84k3MAS86jLrQeQZFDwyTV+l7OH9/3El0aAa4wxv+AmdaEOkGIko+C847dm9JRcufGv8nAgLKjTjZnjfyZ/kVIV0iJRVwQlXNqpvkzXWS9lIleKM3oYNP7XtWkrDnzNyG/HoH0ONtKCx3Ev3Nw4dU/mE+pQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=NuHqsKMf; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::532; helo=mail-pg1-x532.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=NuHqsKMf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::532; helo=mail-pg1-x532.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fLTtx70CNz3dXW
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Feb 2026 20:34:17 +1100 (AEDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-c6e266a3572so2257012a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Feb 2026 01:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772012054; x=1772616854; darn=lists.ozlabs.org;
        h=mime-version:references:message-id:date:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=JxnsaOQZey5wMq56BxN2EdEuMBW71mGq+RSuzcss/8M=;
        b=NuHqsKMf4r7gix9rohHLHZ0ieWcPQAuw2yNc/ix56e7XN0SngwcMftA3Ye5jF8WgQH
         EbYkoUr+SytmTLs1/Rraw6vgCmRjbd8frgw9XptakbY7rSEg+4Sf7hGTQGDnNe73XGWW
         7S+Sb1bBeMVdpVdb93OTNAsDgbL1reBrzIKRmmeBsf03tcOVG4DxRmHQHRiCy2qh3eeH
         u+si4y2UvAB9uCqBjlEnTIhMGR2Pb5GhpeYeBUhibW6q3Y7hC+sWGgfSCPS9jIYFv44C
         gO3/nH/FVKMvGWk8CM06mSCx+GXdS1CppF0vFr3EnZ8s5g2bUehwbh1UhymSz3Vn4Uyt
         KKzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772012054; x=1772616854;
        h=mime-version:references:message-id:date:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JxnsaOQZey5wMq56BxN2EdEuMBW71mGq+RSuzcss/8M=;
        b=rg5ihkFfEwtpIQfa/fWyOb8VhDiz6/8hTgcxneKIz6Ot4otxeOsxsNomOywPS0yLlF
         ileEU3zla3RAos04eIIemdxgGRMD+JkCZHo8hv94YqfZAC4ewUHaJpFeUdwO+xhtvwcT
         GfFvnMKyMtFF7i0OSLk4TqGLPFouJP2yvf9K8poaoDkg98N75tvMQD9Es528t6atYlLx
         7b81G/yd6mu1bLqrrxL+oENbUHgP1IsqpJUUQk5v3Q8TU/o6mRmrZb65KZkbhRzcG1Sk
         CXgdQ8sfiQIUg7kAcE1//UoSFf95Eb9R/czdqX6CJw0/um7uaoZbPkszPw3zIm/k6JGV
         JqbA==
X-Forwarded-Encrypted: i=1; AJvYcCXrFwRqFlbn83ISs35yPXsTZDBaFs8sz+533vqvnFXZ8h9oJZXN2FGDzY0oEZx4qlgQAv1ZNL8u705FJuk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzwB+uFRO0YVCUwKeopNw2+3OOqqxqGuusDYlLatmWxJXuvvXAg
	nBvBpFFVP8HuY3TNRqqA9WX3YvmKKCDBBeXPe6dedagB4EGUdXcwREdZ
X-Gm-Gg: ATEYQzz30I5s1WZn6V9KjEPvXix4eD0fuUyVaMvEoJLzHC3LCtNs25jIRsrT15KYGrQ
	H3iQnlzq9b1WKX6rsi5MepvBG4a9mGITHhbJ+mF6fqd3YJlWn28hWT8Q3wyroQknx/9tXRYZnGg
	lCzWiFI56Rnr8ZP1lFYDvh4gP7z//JRSavyn2H/DV9hW8IM5arOHPUKgLzpJRvX4cxLRh/IgHkr
	wBjULXDVJERykzjWyb+hSEF8anIbcNUUOhn4jjQJazOxhhrXHHh4RBHufDphSV20QtJsy9iIzew
	L1DuWJbt1T4oi79o5Kl0XbBlUNnfGMJTMH9aHUaj3y10Vwe8HDHNM6YmDOEY61u6B0AJ7ymckHy
	EXSdqZH9qBFDKwOI/7qsBnpFR+1W+CyMau9CApfA9nS2yHBlaT6zjl4+Ifjff+61j3L+TjUjV7D
	yUYjoLrWX9ZZbNA8yKAw==
X-Received: by 2002:a17:90b:3dcc:b0:340:c60b:f362 with SMTP id 98e67ed59e1d1-358ae7c6ca9mr13087754a91.6.1772012054135;
        Wed, 25 Feb 2026 01:34:14 -0800 (PST)
Received: from dw-tp ([203.81.242.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3590188126esm2256635a91.6.2026.02.25.01.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 01:34:13 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Alex Shi <alexs@kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Andreas Larsson <andreas@gaisler.com>, Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@kernel.org>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	"David S. Miller" <davem@davemloft.net>, Dave Hansen <dave.hansen@linux.intel.com>, 
	David Hildenbrand <david@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Guo Ren <guoren@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Johannes Berg <johannes@sipsolutions.net>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Jonathan Corbet <corbet@lwn.net>, 
	Klara Modin <klarasmodin@gmail.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Magnus Lindholm <linmag7@gmail.com>, 
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>, Michal Simek <monstr@monstr.eu>, 
	Mike Rapoport <rppt@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Richard Weinberger <richard@nod.at>, 
	Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>, 
	Suren Baghdasaryan <surenb@google.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Vasily Gorbik <gor@linux.ibm.com>, Vineet Gupta <vgupta@kernel.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>, x86@kernel.org, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-cxl@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-um@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	loongarch@lists.linux.dev, sparclinux@vger.kernel.org
Subject: Re: [PATCH v3 24/29] arch, mm: consolidate initialization of SPARSE memory model
In-Reply-To: <20260111082105.290734-25-rppt@kernel.org>
Date: Wed, 25 Feb 2026 09:00:35 +0530
Message-ID: <87tsv5h544.ritesh.list@gmail.com>
References: <20260111082105.290734-1-rppt@kernel.org> <20260111082105.290734-25-rppt@kernel.org>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Mike Rapoport <rppt@kernel.org> writes:

> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> Every architecture calls sparse_init() during setup_arch() although the
> data structures created by sparse_init() are not used until the
> initialization of the core MM.
>
> Beside the code duplication, calling sparse_init() from architecture
> specific code causes ordering differences of vmemmap and HVO initialization
> on different architectures.
>
> Move the call to sparse_init() from architecture specific code to
> free_area_init() to ensure that vmemmap and HVO initialization order is
> always the same.
>

Hello Mike,

[    0.000000][    T0] ------------[ cut here ]------------
[    0.000000][    T0] WARNING: arch/powerpc/include/asm/io.h:879 at virt_to_phys+0x44/0x1b8, CPU#0: swapper/0
[    0.000000][    T0] Modules linked in:
[    0.000000][    T0] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.19.0-12139-gc57b1c00145a #31 PREEMPT
[    0.000000][    T0] Hardware name: IBM pSeries (emulated by qemu) POWER10 (architected) 0x801200 0xf000006 of:SLOF,git-ee03ae pSeries
[    0.000000][    T0] NIP:  c000000000601584 LR: c000000004075de4 CTR: c000000000601548
[    0.000000][    T0] REGS: c000000004d1f870 TRAP: 0700   Not tainted  (6.19.0-12139-gc57b1c00145a)
[    0.000000][    T0] MSR:  8000000000021033 <SF,ME,IR,DR,RI,LE>  CR: 48022448  XER: 20040000
[    0.000000][    T0] CFAR: c0000000006016c4 IRQMASK: 1
[    0.000000][    T0] GPR00: c000000004075dd4 c000000004d1fb10 c00000000304bb00 c000000180000000
[    0.000000][    T0] GPR04: 0000000000000009 0000000000000009 c000000004ec94a0 0000000000000000
[    0.000000][    T0] GPR08: 0000000000018000 0000000000000001 c000000004921280 0000000048022448
[    0.000000][    T0] GPR12: c000000000601548 c000000004fe0000 0000000000000004 0000000000000004
[    0.000000][    T0] GPR16: 000000000287fb08 0000000000000060 0000000000000002 0000000002831750
[    0.000000][    T0] GPR20: 0000000002831778 fffffffffffffffd c000000004d78050 00000000051cbb00
[    0.000000][    T0] GPR24: 0000000005a40008 c000000000000000 c000000000400000 0000000000000100
[    0.000000][    T0] GPR28: c000000004d78050 0000000000000000 c000000004ecd4a8 0000000000000001
[    0.000000][    T0] NIP [c000000000601584] virt_to_phys+0x44/0x1b8
[    0.000000][    T0] LR [c000000004075de4] alloc_bootmem+0x144/0x1a8
[    0.000000][    T0] Call Trace:
[    0.000000][    T0] [c000000004d1fb50] [c000000004075dd4] alloc_bootmem+0x134/0x1a8
[    0.000000][    T0] [c000000004d1fba0] [c000000004075fac] __alloc_bootmem_huge_page+0x164/0x230
[    0.000000][    T0] [c000000004d1fbe0] [c000000004030bc4] alloc_bootmem_huge_page+0x44/0x138
[    0.000000][    T0] [c000000004d1fc10] [c000000004076e48] hugetlb_hstate_alloc_pages+0x350/0x5ac
[    0.000000][    T0] [c000000004d1fd30] [c0000000040782f0] hugetlb_bootmem_alloc+0x15c/0x19c
[    0.000000][    T0] [c000000004d1fd70] [c00000000406d7b4] mm_core_init_early+0x7c/0xdf4
[    0.000000][    T0] [c000000004d1ff30] [c000000004011d84] start_kernel+0xac/0xc58
[    0.000000][    T0] [c000000004d1ffe0] [c00000000000e99c] start_here_common+0x1c/0x20
[    0.000000][    T0] Code: 6129ffff 792907c6 6529ffff 6129ffff 7c234840 40810018 3d2201e8 3929a7a8 e9290000 7c291840 41810044 3be00001 <0b1f0000> 3d20bfff 6129ffff 792907c6


I think this is happening because, now in mm_core_early_init(), the
order of initialization between hugetlb_bootmem_alloc() and
free_area_init() is reversed. Since free_area_init() -> sparse_init()
is responsible for setting SECTIONS and vmemmap area. 

Then in alloc_bootmem() (from hugetlb_bootmem_alloc() path), it uses virt_to_phys(m)...

			/*
			 * For pre-HVO to work correctly, pages need to be on
			 * the list for the node they were actually allocated
			 * from. That node may be different in the case of
			 * fallback by memblock_alloc_try_nid_raw. So,
			 * extract the actual node first.
			 */
			if (m)
				listnode = early_pfn_to_nid(PHYS_PFN(virt_to_phys(m)));


... virt_to_phys on powerpc uses:

static inline unsigned long virt_to_phys(const volatile void * address)
{
	WARN_ON(IS_ENABLED(CONFIG_DEBUG_VIRTUAL) && !virt_addr_valid(address));

	return __pa((unsigned long)address);
}

#define virt_addr_valid(vaddr)	({					\
	unsigned long _addr = (unsigned long)vaddr;			\
	_addr >= PAGE_OFFSET && _addr < (unsigned long)high_memory &&	\
	pfn_valid(virt_to_pfn((void *)_addr));				\
})


I think the above warning in dmesg gets printed from above WARN_ON, i.e.
because pfn_valid() is false, since we haven't done sparse_init() yet.

So, what I wanted to check was - do you think instead of virt_to_phys(), we
could directly use __pa() here() in mm/hugetlb.c, since these are
memblock alloc addresses? i.e.: 

// alloc_bootmem():
-   listnode = early_pfn_to_nid(PHYS_PFN(virt_to_phys(m)));
+   listnode = early_pfn_to_nid(PHYS_PFN(__pa(m)));

// __alloc_bootmem_huge_page():
-   memblock_reserved_mark_noinit(virt_to_phys((void *)m + PAGE_SIZE),
+   memblock_reserved_mark_noinit(__pa((void *)m + PAGE_SIZE),


Thoughts?

-ritesh

