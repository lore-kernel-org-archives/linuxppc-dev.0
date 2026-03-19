Return-Path: <linuxppc-dev+bounces-18436-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD6E41075273
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Mar 2026 08:20:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbzCj1N0Gz2ynT;
	Thu, 19 Mar 2026 19:20:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773908433;
	cv=none; b=eznt4hegaEP8KBc0JukslpQ6mXShZJ0vwGWkmggikfH3eoVRvfmkzaYPZyV+DkV/cxIrAE6EhHqu0FfrsPX2GBMSFLByx+/C1e76zWT06tLWz8YsB5zZxNIGYEpGR468Ggyc//3u4cccrlxbIefCax86CtBe4dYbB52FFJgENyI8iFIjuVmpt6+M4nv711gJil4MeR1c1O2+XBLYmH9WqyqlXSugjtMac7HHLs6gGew7if3OYG8TuTMG9BP43hhUUso1LajOs9d5xtVQ5FvKMPgI+UQQXgqBmgMQZlqKK6AMc8DhpwgSBznl56V6vkMPSG3JDlg9Nj/PrtuG3anRpA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773908433; c=relaxed/relaxed;
	bh=lA6R2iFm4989CJymVljNoKm90cwa7w5F8WADAAuxE+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QIAGVdWjwSQHgD38fwTZyV+UkbqBubDX0O4CdxbHFuKTxf9TjaIuuMXjW9x44aElWaGEa6/oy0Q8skOuK5J+4MKfFFC/D9cwevF5Rxz00OqJztu4hYQbPMmsLTnC/66xQcy2nIOEx376CByJjRPPKHP5uzYfQJKb5ZaRjCI0kyEfqVwecB9XywKJ8Y3qrx38plnDy+5Pom2/qJrtZ6Xff6NK0n6MLO5J1EI0DSUnM/FPRd81kk02hehZdFmR8uDlXe5F95rGuMuAsRR5B7FLDSFMwyCl1SbVoPxeve1ysCG5qpvyIw1IGuRurSxjbcHIO2RElz6736o9PitJrue3dw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Ncs5z7CT; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Ncs5z7CT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fbzCh2ZvCz2xZK
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2026 19:20:32 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 62D5B60126;
	Thu, 19 Mar 2026 08:20:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB51CC19424;
	Thu, 19 Mar 2026 08:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773908429;
	bh=klUwCUSCdgbV1tZfxsphb/dv7F/GAnfibv0j756H5s0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ncs5z7CTqhJIhBNQChRHYmFCx/Gw02cZqph0yX7SmRTDgJm2DLn2WyIwLTWtTffwk
	 FlIgvvlw2O7wMiIl4sIdqv1PPMfQyjp+lEiO6kSyoZuT8mUfKTQ58kd1Xm4OxGQKdT
	 p9pxFkdizBdGPWKy4V3zTtFizqjONEz3nDGPvqv0/GEHaaK8ekD7oZsfIu7ePeci/k
	 AkZs2QIi6CuvEPo3LuCzwztW4AlExyadOcFwBMGWiJ1FQkRF+eqDtaMkeokzzcKOUb
	 dymhmxUCovijWR/aJHZBLNT2MH6nnIGjbCu14vm9SHNCQW3yrPxcgl7Y5pxQ2yt0YG
	 ENQ7VsLW8LzDQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 19 Mar 2026 09:19:40 +0100
Subject: [PATCH 1/2] mm: remove CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-config_migration-v1-1-42270124966f@kernel.org>
References: <20260319-config_migration-v1-0-42270124966f@kernel.org>
In-Reply-To: <20260319-config_migration-v1-0-42270124966f@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
 WANG Xuerui <kernel@xen0n.name>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, 
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
 linux-s390@vger.kernel.org, linux-mm@kvack.org, 
 linux-rt-devel@lists.linux.dev, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.13.0

All architectures that select CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE also
select CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG. So we can just remove
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE.

For CONFIG_MIGRATION, make it depend on CONFIG_MEMORY_HOTREMOVE instead,
and make CONFIG_MEMORY_HOTREMOVE select CONFIG_MIGRATION (just like
CONFIG_CMA and CONFIG_COMPACTION already do).

We'll clean up CONFIG_MIGRATION next.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 arch/arm64/Kconfig     | 1 -
 arch/loongarch/Kconfig | 1 -
 arch/powerpc/Kconfig   | 1 -
 arch/riscv/Kconfig     | 1 -
 arch/s390/Kconfig      | 1 -
 arch/x86/Kconfig       | 1 -
 mm/Kconfig             | 9 +++------
 7 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 38dba5f7e4d2..bcd9f5bc66e2 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -16,7 +16,6 @@ config ARM64
 	select ARCH_BINFMT_ELF_STATE
 	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
 	select ARCH_ENABLE_MEMORY_HOTPLUG
-	select ARCH_ENABLE_MEMORY_HOTREMOVE
 	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
 	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
 	select ARCH_HAS_CACHE_LINE_SIZE
diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index d211c6572b0a..dbf65ad512f1 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -12,7 +12,6 @@ config LOONGARCH
 	select ARCH_NEEDS_DEFER_KASAN
 	select ARCH_DISABLE_KASAN_INLINE
 	select ARCH_ENABLE_MEMORY_HOTPLUG
-	select ARCH_ENABLE_MEMORY_HOTREMOVE
 	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
 	select ARCH_HAS_ACPI_TABLE_UPGRADE	if ACPI
 	select ARCH_HAS_CPU_FINALIZE_INIT
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index ad7a2fe63a2a..9f3417b75b2b 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -126,7 +126,6 @@ config PPC
 	select ARCH_DISABLE_KASAN_INLINE	if PPC_RADIX_MMU
 	select ARCH_DMA_DEFAULT_COHERENT	if !NOT_COHERENT_CACHE
 	select ARCH_ENABLE_MEMORY_HOTPLUG
-	select ARCH_ENABLE_MEMORY_HOTREMOVE
 	select ARCH_HAS_COPY_MC			if PPC64
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DEBUG_VIRTUAL
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 90c531e6abf5..61a9d8d3ea64 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -21,7 +21,6 @@ config RISCV
 	select ARCH_DMA_DEFAULT_COHERENT
 	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
 	select ARCH_ENABLE_MEMORY_HOTPLUG if SPARSEMEM_VMEMMAP
-	select ARCH_ENABLE_MEMORY_HOTREMOVE if MEMORY_HOTPLUG
 	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
 	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
 	select ARCH_HAS_BINFMT_FLAT
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index edc927d9e85a..d01800962d84 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -85,7 +85,6 @@ config S390
 	select ARCH_32BIT_USTAT_F_TINODE
 	select ARCH_CORRECT_STACKTRACE_ON_KRETPROBE
 	select ARCH_ENABLE_MEMORY_HOTPLUG if SPARSEMEM
-	select ARCH_ENABLE_MEMORY_HOTREMOVE
 	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
 	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
 	select ARCH_HAS_CC_CAN_LINK
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index e2df1b147184..c290fe363f27 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -69,7 +69,6 @@ config X86
 	select ARCH_CORRECT_STACKTRACE_ON_KRETPROBE
 	select ARCH_ENABLE_HUGEPAGE_MIGRATION if X86_64 && HUGETLB_PAGE && MIGRATION
 	select ARCH_ENABLE_MEMORY_HOTPLUG if X86_64
-	select ARCH_ENABLE_MEMORY_HOTREMOVE if MEMORY_HOTPLUG
 	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if (PGTABLE_LEVELS > 2) && (X86_64 || X86_PAE)
 	select ARCH_ENABLE_THP_MIGRATION if X86_64 && TRANSPARENT_HUGEPAGE
 	select ARCH_HAS_ACPI_TABLE_UPGRADE	if ACPI
diff --git a/mm/Kconfig b/mm/Kconfig
index c012944938a7..b2e21d873d3f 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -465,9 +465,6 @@ config HAVE_BOOTMEM_INFO_NODE
 config ARCH_ENABLE_MEMORY_HOTPLUG
 	bool
 
-config ARCH_ENABLE_MEMORY_HOTREMOVE
-	bool
-
 # eventually, we can have this option just 'select SPARSEMEM'
 menuconfig MEMORY_HOTPLUG
 	bool "Memory hotplug"
@@ -540,8 +537,8 @@ endchoice
 config MEMORY_HOTREMOVE
 	bool "Allow for memory hot remove"
 	select HAVE_BOOTMEM_INFO_NODE if (X86_64 || PPC64)
-	depends on MEMORY_HOTPLUG && ARCH_ENABLE_MEMORY_HOTREMOVE
-	depends on MIGRATION
+	depends on MEMORY_HOTPLUG
+	select MIGRATION
 
 config MHP_MEMMAP_ON_MEMORY
 	def_bool y
@@ -636,7 +633,7 @@ config PAGE_REPORTING
 config MIGRATION
 	bool "Page migration"
 	default y
-	depends on (NUMA || ARCH_ENABLE_MEMORY_HOTREMOVE || COMPACTION || CMA) && MMU
+	depends on (NUMA || MEMORY_HOTREMOVE || COMPACTION || CMA) && MMU
 	help
 	  Allows the migration of the physical location of pages of processes
 	  while the virtual addresses are not changed. This is useful in

-- 
2.43.0


