Return-Path: <linuxppc-dev+bounces-26215-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0040AC61DE8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 05:44:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYHxG3jcqz2yrH;
	Mon, 31 Aug 2026 15:44:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788155058;
	cv=none; b=a7Xlt1R2UfI+NM0sU1VRPLkItUmqjLODMPZgLKr3nhwjhpdEgJWjxOnrwuPAOJQl8wlCMSTeMpb7rOQpUN1RlJF5YU1to84dC933ku9faZlNymKkU126cANueSgWoahkcDPw0ukTs3dyiHaCiYD6zmiyiNkcjArnFgpjwkbpqubxyLJT0RKJdOCce/PvoTv66zVT/M2s9iDikzGa0+xuIVwX6rGPIpgq0mHneHYb4/luBLzUH+0+NLViQiXHM6EuJBRqohixEHa22HTb+rjm/A+ISwclC4YO4qcQRRtPAFnHveJgzBfAUcPU3byGiB/+j+Q4D+1RXQj1GxrI+BYbog==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788155058; c=relaxed/relaxed;
	bh=vC0AdXN9AInSTcYtPsX1sQWcKplWSYNtXUaddP0LnyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D5fbpLfT0AOGzvKeVqEo8XE/PPYtmdfMSibtg12JNfd5+3Gpt/D8cWpWLnQhLRVCXE4Z9iNnHu0I9aYilfjeEOwt0QD6n/rBZ4EmB5xapGaNcwgiWJvqWfX9wGsLXCcmHkmuEyuxdjbmrgf8ZI9lH1t6tnuInZ2M/gCe8rdHzv5BzdaUtati1nJZsdzCKSGS58TROKtjoRMANdaCjmDOa1QD5joKTQEGjcLsEdAycMOf/mSx4IxmpeKcS6FdQeHe0gh4OuYgcyb7CHHcdBRaXypmdK1SKpPRzm+rnZsROIhFB7RPGI/BK/Xtes0fGPK24mOouwXmdY60jDDyTh91Vg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=AgDK4gG1; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=anshuman.khandual@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=AgDK4gG1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=anshuman.khandual@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYHxF3FtSz2yYY
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 15:44:17 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1783419F0;
	Sun, 30 Aug 2026 22:43:42 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1DC573F85F;
	Sun, 30 Aug 2026 22:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788155025; bh=MRpwBQolgZx1ZwHSmSp6+RbqpKwfTCpBNzioH9bhCJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AgDK4gG1pVEjHbGnLFstkXRbQkc6tjZ3ZECUEyq/VeI1J9AzoNicjdQZP4HJ8Kvk4
	 3TXh2zhKUhfWWSAzn8A6D9O2YljapP5Yo/mEFuIROb8kjVzJTM112mGGaKINlQH5eH
	 hNcsn1bxAJ0UwDcOKskNwZcyK6BDzUFItaGQvZxA=
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org
Cc: samuel.holland@sifive.com,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	David Hildenbrand <david@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] loongarch/mm: Stop using pte_ERROR()
Date: Mon, 31 Aug 2026 11:13:25 +0530
Message-ID: <20260831054331.625505-4-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831054331.625505-1-anshuman.khandual@arm.com>
References: <20260831054331.625505-1-anshuman.khandual@arm.com>
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
Content-Transfer-Encoding: 8bit

Directly use pr_err() in __set_fixmap() and drop pte_ERROR() which helps in
eventually dropping pte_ERROR() macro across the tree. In this new printing
__FILE__ and __LINE__ has been dropped because they are always the same and
don't really add any value. The new ptval_to_str() helper is being used for
converting pgtable entry value into a string. The error message itself has
been cleaned up as well.

Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: loongarch@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/loongarch/include/asm/pgtable.h | 2 --
 arch/loongarch/mm/init.c             | 4 +++-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
index a05f6a4928dc..eddd8906b77d 100644
--- a/arch/loongarch/include/asm/pgtable.h
+++ b/arch/loongarch/include/asm/pgtable.h
@@ -135,8 +135,6 @@ struct vm_area_struct;
 #define ptep_get(ptep) READ_ONCE(*(ptep))
 #define pmdp_get(pmdp) READ_ONCE(*(pmdp))
 
-#define pte_ERROR(e) \
-	pr_err("%s:%d: bad pte %016lx.\n", __FILE__, __LINE__, pte_val(e))
 #ifndef __PAGETABLE_PMD_FOLDED
 #define pmd_ERROR(e) \
 	pr_err("%s:%d: bad pmd %016lx.\n", __FILE__, __LINE__, pmd_val(e))
diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
index 4b46c5d30708..f801f7097f03 100644
--- a/arch/loongarch/mm/init.c
+++ b/arch/loongarch/mm/init.c
@@ -197,13 +197,15 @@ void __init __set_fixmap(enum fixed_addresses idx,
 			       phys_addr_t phys, pgprot_t flags)
 {
 	unsigned long addr = __fix_to_virt(idx);
+	char str[PTVAL_STR_MAX];
 	pte_t *ptep;
 
 	BUG_ON(idx <= FIX_HOLE || idx >= __end_of_fixed_addresses);
 
 	ptep = populate_kernel_pte(addr);
 	if (!pte_none(ptep_get(ptep))) {
-		pte_ERROR(*ptep);
+		ptval_to_str(str, pte_val(*ptep));
+		pr_err("unexpected set PTE at %lx in %s: %s\n", addr, __func__, str);
 		return;
 	}
 
-- 
2.43.0


