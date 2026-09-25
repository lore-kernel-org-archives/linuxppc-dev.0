Return-Path: <linuxppc-dev+bounces-28242-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F15F6C98321
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Sep 2026 20:13:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hs22Q1jRtz30hg;
	Sat, 26 Sep 2026 06:13:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790367198;
	cv=none; b=M5NEFyZamY68PNcY9hnAPl4L1y+c5JMqrS2Oz4jhxQrbz7Ycs1LcVv4Z9iFymjTkDM3SjTjhVSC8QYeck6zeD6/ci3wQ5t8s7rtWmS/vcO25tGH5UzJLXXiYtR5Lut0O44UcAVMjoGzaOOe2f5ZAghdbxI6rSFrMAE/FI3fyKa+bMkrIVfzz28bSp/UZNsKTwUAAuE/BmQf8dNYeOtzQw99YkA4bNwn8zTuBODRgHYH2npDT8xDRi/1cTSs0X0IogjUr6oCX6XDEouyoHWK59pSV/qVreL+2bOxSCdJ8Pz0yxEFloVxYbyDUSyq39xCks+yMCj0Pfl2NyVHxRLiV+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790367198; c=relaxed/relaxed;
	bh=mPVNWiLAFF1iezEhxPcol440WBp7n3/37lnVTerEjFg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=meWtSaN9alygkZOdk8sPiuH5AA9o7oSrl+MysPGJ5wUwmEsBCu+aFVT45h3UvoHZeKE7S4/J1w+o74BmVp0kJtgZx+eajWuU9/151KId1W3kk/k1yzHKAI+CP1M5xbgOsX7QcjP9dqqCXrFJdfFW2g2TnDDZXyjIUW8LPf7IQIxRThFZGYKqjGjbpixnMUbr6hXDYDkS9+qLYnTieU8JSkDNHZ5jHR91kBDnFmY5DS8qy1sM1AnrOqxuysUtbreJe3IwV4qYN/oHBTi099hU0EoPhdOBCkmHZLgpAE7Kfr1ypA2fELaEJdJj+5XoKNcxUnmwKVtRHd/0oDURG1+/4Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QryC7Ar+; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QryC7Ar+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hs22P2Wlhz30WJ
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Sep 2026 06:13:17 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id ADB39429E3;
	Fri, 25 Sep 2026 20:13:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 012541F00893;
	Fri, 25 Sep 2026 20:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790367195;
	bh=mPVNWiLAFF1iezEhxPcol440WBp7n3/37lnVTerEjFg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=QryC7Ar+FcRdX3s6hKIofOc9HRRTUt5TEhNwyJo3ZGeLHjOekVPBVj/xkBBVB5rv+
	 YdtP+kmUyWrpbfEdxVjiQrL2SQcAdWSqGyvJTgjJI6alanD+Smv0JIX6gGNeBI/iP3
	 8n7uVG+YAlOI1RLvK1YrYQmw1zlaaGGvCUABQp1zUBPPMxFCoBzBXj0ZwobZHIK++9
	 BqCRqG+DP2c3/tDpavbFJ2PJuclqfdIY95e4gRSTmhtzw/3XUJvyhmk1jVQVK4wyoZ
	 q9h9dbvuhx1IZcR0Qb4OsZrBkCJG2ufQnV7azOj35g3Z455zka33vu5MMRCQ03cJJA
	 wx7/PBgfD69ww==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Fri, 25 Sep 2026 21:09:44 +0100
Subject: [PATCH v5 09/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for
 m68k-motorola
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
Message-Id: <20260925-rcu-pagetable-freeing-v5-9-31e91065fea4@kernel.org>
References: <20260925-rcu-pagetable-freeing-v5-0-31e91065fea4@kernel.org>
In-Reply-To: <20260925-rcu-pagetable-freeing-v5-0-31e91065fea4@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Guo Ren <guoren@kernel.org>, Brian Cain <bcain@kernel.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Dinh Nguyen <dinguyen@kernel.org>, 
 Simon Schuster <schuster.simon@siemens-energy.com>, 
 Jonas Bonn <jonas@southpole.se>, 
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, 
 Stafford Horne <shorne@gmail.com>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Russell King <linux@armlinux.org.uk>, Vineet Gupta <vgupta@kernel.org>, 
 Michal Simek <monstr@monstr.eu>, Chris Zankel <chris@zankel.net>, 
 Max Filippov <jcmvbkbc@gmail.com>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Matt Turner <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Mark Rutland <mark.rutland@arm.com>, Huacai Chen <chenhuacai@kernel.org>, 
 WANG Xuerui <kernel@xen0n.name>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Arnd Bergmann <arnd@arndb.de>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
 linux-m68k@lists.linux-m68k.org, linux-openrisc@vger.kernel.org, 
 linux-sh@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-snps-arc@lists.infradead.org, 
 linux-arch@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-alpha@vger.kernel.org, loongarch@lists.linux.dev, 
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
 linux-um@lists.infradead.org, Hugh Dickins <hughd@google.com>, 
 Qi Zheng <qi.zheng@linux.dev>, linux-doc@vger.kernel.org, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=9617; i=ljs@kernel.org;
 h=from:subject:message-id; bh=mgUH6O2ZCJzOVqiKD7sFhXEYE2JvxJj9LkI8E7czbME=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLK2XWVnbFzn+Ektppx515vVfy7deu3MEVEU3togrht+3
 DHhaLNrRykLgxgXg6yYIsvzL+L7g0TC5nVe8HeDmcPKBDKEgYtTACbC2crIsPnnNettT0t19LgZ
 o+/M2jBTzbT9joGIxScGwReRaveEPzL8T7o286a81j5bnm7Z0h7xe12PLm3uDuN+LPjc+nHP3N9
 G3AA=
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

sun3 and coldfire are already supported, however motorola requires a little
more care.

Here, custom table removal logic is required, so
CONFIG_HAVE_ARCH_TLB_REMOVE_TABLE is enabled for m68k-motorola.

Firstly as part of this change, the page table level must be communicated
to the underlying __tlb_remove_table() implementation.

Take advantage of the fact that page tables are aligned by more than enough
to permit setting TABLE_PTE or TABLE_PMD in the low bits of the pointer,
and store this there.

Then update __pte_free_tlb() and __pmd_free_tlb() to pass this through,
then have __tlb_remove_table() decode this and pass it to
free_pointer_table().

The page table freeing is performed via call_rcu(), so free_pointer_table()
now will be invoked from softirq context, and as such may be re-entrant.

Introduce a spinlock to handle this and hold it over the time a given
ptable entry is being referenced in both get_pointer_table() and
free_pointer_table().

As softirq is the only asynchronous context in which the lock is taken, it
suffices to disable bottom halves while holding it.

In order to make things a little easier in this respect, separate out the
logic for adding a new ptable entry into add_pointer_table() and only hold
the lock during ptable entry insertion in this case.

Note that original list_add_tail(new, dp) added new prior to dp, which is
ptable_list[type].next, i.e. after ptable_list[type].

The equivalent therefore is list_add(new, &ptable_list[type]), which adds
new after ptable_list[type], only without needing to make reference to dp.

Note that, as m68k-motorola specifies CONFIG_HAVE_ARCH_TLB_REMOVE_TABLE, it
does not enable CONFIG_PT_RECLAIM. This isn't meaningfully impactful.

With this applied, all of m68k implements CONFIG_MMU_GATHER_RCU_TABLE_FREE.

This forms part of an overall effort to switch every architecture to this
mode.

Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Acked-by: Lance Yang <lance.yang@linux.dev>
Tested-by: Lance Yang <lance.yang@linux.dev>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 arch/m68k/Kconfig                        |   3 +-
 arch/m68k/include/asm/motorola_pgalloc.h |   9 +--
 arch/m68k/mm/motorola.c                  | 119 ++++++++++++++++++++-----------
 3 files changed, 84 insertions(+), 47 deletions(-)

diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 6b8ec67c86fd..fa5d39549da9 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -29,6 +29,7 @@ config M68K
 	select HAVE_ARCH_LIBGCC_H
 	select HAVE_ARCH_SECCOMP
 	select HAVE_ARCH_SECCOMP_FILTER
+	select HAVE_ARCH_TLB_REMOVE_TABLE if MMU_MOTOROLA
 	select HAVE_ASM_MODVERSIONS
 	select HAVE_DEBUG_BUGVERBOSE
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS if !CPU_HAS_NO_UNALIGNED
@@ -36,7 +37,7 @@ config M68K
 	select HAVE_MOD_ARCH_SPECIFIC
 	select HAVE_UID16
 	select MMU_GATHER_NO_RANGE if MMU
-	select MMU_GATHER_RCU_TABLE_FREE if MMU && (SUN3 || COLDFIRE)
+	select MMU_GATHER_RCU_TABLE_FREE if MMU
 	select MODULES_USE_ELF_REL
 	select MODULES_USE_ELF_RELA
 	select NO_DMA if !MMU && !COLDFIRE
diff --git a/arch/m68k/include/asm/motorola_pgalloc.h b/arch/m68k/include/asm/motorola_pgalloc.h
index 1091fb0affbe..dcde40e8b5c6 100644
--- a/arch/m68k/include/asm/motorola_pgalloc.h
+++ b/arch/m68k/include/asm/motorola_pgalloc.h
@@ -17,6 +17,7 @@ enum m68k_table_types {
 extern void init_pointer_table(void *table, int type);
 extern void *get_pointer_table(struct mm_struct *mm, int type);
 extern int free_pointer_table(void *table, int type);
+extern void __tlb_remove_table(void *table);
 
 /*
  * Allocate and free page tables. The xxx_kernel() versions are
@@ -47,7 +48,7 @@ static inline void pte_free(struct mm_struct *mm, pgtable_t pgtable)
 static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pgtable,
 				  unsigned long address)
 {
-	free_pointer_table(pgtable, TABLE_PTE);
+	tlb_remove_table(tlb, (void *)((unsigned long)pgtable | TABLE_PTE));
 }
 
 
@@ -61,10 +62,10 @@ static inline int pmd_free(struct mm_struct *mm, pmd_t *pmd)
 	return free_pointer_table(pmd, TABLE_PMD);
 }
 
-static inline int __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
-				 unsigned long address)
+static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
+				  unsigned long address)
 {
-	return free_pointer_table(pmd, TABLE_PMD);
+	tlb_remove_table(tlb, (void *)((unsigned long)pmd | TABLE_PMD));
 }
 
 
diff --git a/arch/m68k/mm/motorola.c b/arch/m68k/mm/motorola.c
index b30aa69a73a6..f3efa0d13963 100644
--- a/arch/m68k/mm/motorola.c
+++ b/arch/m68k/mm/motorola.c
@@ -20,6 +20,7 @@
 #include <linux/init.h>
 #include <linux/memblock.h>
 #include <linux/gfp.h>
+#include <linux/cleanup.h>
 
 #include <asm/setup.h>
 #include <linux/uaccess.h>
@@ -103,6 +104,8 @@ static struct list_head ptable_list[3] = {
 	LIST_HEAD_INIT(ptable_list[2]),
 };
 
+static DEFINE_SPINLOCK(ptable_lock);
+
 #define PD_PTABLE(ptdesc) ((ptable_desc *)&(virt_to_ptdesc((void *)(ptdesc))->pt_list))
 #define PD_PTDESC(ptable) (list_entry(ptable, struct ptdesc, pt_list))
 #define PD_MARKBITS(dp) (*(unsigned int *)&PD_PTDESC(dp)->pt_index)
@@ -139,52 +142,65 @@ void __init init_pointer_table(void *table, int type)
 	return;
 }
 
-void *get_pointer_table(struct mm_struct *mm, int type)
+/*
+ * For a pointer table for a user process address space, a
+ * table is taken from a ptdesc allocated for the purpose.  Each
+ * ptdesc can hold 8 pointer tables.  The ptdesc is remapped in
+ * virtual address space to be noncacheable.
+ */
+static void *add_pointer_table(struct mm_struct *mm, int type)
 {
-	ptable_desc *dp = ptable_list[type].next;
-	unsigned int mask = list_empty(&ptable_list[type]) ? 0 : PD_MARKBITS(dp);
-	unsigned int tmp, off;
+	struct ptdesc *ptdesc;
+	ptable_desc *new;
+	void *pt_addr;
 
-	/*
-	 * For a pointer table for a user process address space, a
-	 * table is taken from a ptdesc allocated for the purpose.  Each
-	 * ptdesc can hold 8 pointer tables.  The ptdesc is remapped in
-	 * virtual address space to be noncacheable.
-	 */
-	if (mask == 0) {
-		struct ptdesc *ptdesc;
-		ptable_desc *new;
-		void *pt_addr;
-
-		ptdesc = pagetable_alloc(GFP_KERNEL | __GFP_ZERO, 0);
-		if (!ptdesc)
-			return NULL;
-
-		pt_addr = ptdesc_address(ptdesc);
-
-		switch (type) {
-		case TABLE_PTE:
-			/*
-			 * m68k doesn't have SPLIT_PTE_PTLOCKS for not having
-			 * SMP.
-			 */
-			pagetable_pte_ctor(mm, ptdesc);
-			break;
-		case TABLE_PMD:
-			pagetable_pmd_ctor(mm, ptdesc);
-			break;
-		case TABLE_PGD:
-			pagetable_pgd_ctor(ptdesc);
-			break;
-		}
+	ptdesc = pagetable_alloc(GFP_KERNEL | __GFP_ZERO, 0);
+	if (!ptdesc)
+		return NULL;
+
+	pt_addr = ptdesc_address(ptdesc);
+
+	switch (type) {
+	case TABLE_PTE:
+		/*
+		 * m68k doesn't have SPLIT_PTE_PTLOCKS for not having
+		 * SMP.
+		 */
+		pagetable_pte_ctor(mm, ptdesc);
+		break;
+	case TABLE_PMD:
+		pagetable_pmd_ctor(mm, ptdesc);
+		break;
+	case TABLE_PGD:
+		pagetable_pgd_ctor(ptdesc);
+		break;
+	}
+
+	mmu_page_ctor(pt_addr);
+
+	new = PD_PTABLE(pt_addr);
 
-		mmu_page_ctor(pt_addr);
+	PD_MARKBITS(new) = ptable_mask(type) - 1;
+	scoped_guard(spinlock_bh, &ptable_lock)
+		list_add(new, &ptable_list[type]);
 
-		new = PD_PTABLE(pt_addr);
-		PD_MARKBITS(new) = ptable_mask(type) - 1;
-		list_add_tail(new, dp);
+	return (pmd_t *)pt_addr;
+}
+
+void *get_pointer_table(struct mm_struct *mm, int type)
+{
+	unsigned int tmp, off;
+	unsigned long mask;
+	ptable_desc *dp;
+	void *ret;
 
-		return (pmd_t *)pt_addr;
+	spin_lock_bh(&ptable_lock);
+	dp = ptable_list[type].next;
+	mask = list_empty(&ptable_list[type]) ? 0 : PD_MARKBITS(dp);
+
+	if (mask == 0) {
+		spin_unlock_bh(&ptable_lock);
+		return add_pointer_table(mm, type);
 	}
 
 	for (tmp = 1, off = 0; (mask & tmp) == 0; tmp <<= 1, off += ptable_size(type))
@@ -194,7 +210,10 @@ void *get_pointer_table(struct mm_struct *mm, int type)
 		/* move to end of list */
 		list_move_tail(dp, &ptable_list[type]);
 	}
-	return ptdesc_address(PD_PTDESC(dp)) + off;
+
+	ret = ptdesc_address(PD_PTDESC(dp)) + off;
+	spin_unlock_bh(&ptable_lock);
+	return ret;
 }
 
 int free_pointer_table(void *table, int type)
@@ -204,6 +223,8 @@ int free_pointer_table(void *table, int type)
 	unsigned long pt_addr = ptable & PAGE_MASK;
 	unsigned int mask = 1U << ((ptable - pt_addr)/ptable_size(type));
 
+	spin_lock_bh(&ptable_lock);
+
 	dp = PD_PTABLE(pt_addr);
 	if (PD_MARKBITS (dp) & mask)
 		panic ("table already free!");
@@ -213,6 +234,8 @@ int free_pointer_table(void *table, int type)
 	if (PD_MARKBITS(dp) == ptable_mask(type)) {
 		/* all tables in ptdesc are free, free ptdesc */
 		list_del(dp);
+		spin_unlock_bh(&ptable_lock);
+
 		mmu_page_dtor((void *)pt_addr);
 		pagetable_dtor_free(virt_to_ptdesc((void *)pt_addr));
 		return 1;
@@ -223,9 +246,21 @@ int free_pointer_table(void *table, int type)
 		 */
 		list_move(dp, &ptable_list[type]);
 	}
+
+	spin_unlock_bh(&ptable_lock);
 	return 0;
 }
 
+void __tlb_remove_table(void *table)
+{
+	/* The bottom 2 bits are used to encode page table type. */
+	const unsigned long encoded = (unsigned long)table;
+	void *addr = (void *)(encoded & ~3UL);
+	const int type = encoded & 3;
+
+	free_pointer_table(addr, type);
+}
+
 /* size of memory already mapped in head.S */
 extern __initdata unsigned long m68k_init_mapped_size;
 

-- 
2.55.0


