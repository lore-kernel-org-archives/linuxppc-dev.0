Return-Path: <linuxppc-dev+bounces-20987-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97F96CD343F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 May 2026 16:04:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gHBpz2MKZz2yLG;
	Sat, 16 May 2026 02:04:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::429"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778861083;
	cv=none; b=UneDwruOlelI6tyiKDLfY509X3g8/0VijHz8v4lvyBNn03zApeN1KaBcvYysIfACpmAmfyXoMhUfHdsLwUn5sP8GMwbjijLOfSopnEAS93HmEd9DFldliwdJ8+wyYQ9wc4cUPYznlAUas9VMNUBno5vK4ftxeXZ4mYK560qUm3IWWjGvklxc8RddxMu6jOUs7wqC2GDoG0U4HAIhebr33mNW17CGoJobiv0Qrv2cyDMSfpa5Mv+H9vpBBiSMaAHU8RKWhvpELr1bKKMheib2oRmlA1nytCZ6kveVIvffRttB4SqCYr5VU3FuPcZnYQBsMsb3QSa7jIKjaCOCW+tiyw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778861083; c=relaxed/relaxed;
	bh=tHtM3hln5E0LtkuEKr9m/vG1aJYWfiEmMpXBjaFCM6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ekgc8Vj8lH5hqLilzCa9x7uIj0MPOb3J5i0WDGzOMLdpoTFT4bHzTjO5RSY2oq7EATaU0D/LooR704xeJWIKI/mVNXRu9AsQ6x0rsWKmuFCJMk2WSLWPOpjpKfaoLA2BQlHb5pJ7+EKKLybGH5kEdIBVqM8/2nvp8dDy4g4HbDyLup0jxtBz5FoOkjKmFLx+mq5/avYf2p0K+A41ZOQcY37y5x8N6wdZuc88vkDNMPZw5bzmZXcv9dA4yaPYQ+w/TWM+BX2qQ+sKXkLPQzxxuDJ3iPh5NTW4jmsWFsa7kaVILonu86JFC9ohK6pWTDFLgfkqbKqKAvx7FcOMKw93FQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=o/Kl4MIo; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=o/Kl4MIo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gHBpy4yh2z2xTl
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 May 2026 02:04:42 +1000 (AEST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-83537a80ab6so5753748b3a.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2026 09:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778861081; x=1779465881; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tHtM3hln5E0LtkuEKr9m/vG1aJYWfiEmMpXBjaFCM6o=;
        b=o/Kl4MIoVN15q3If6ZDW0iZgD0jhoJLmnxXqLcK6JSdjxdZ4Pc6QVZnzh63QfOzyCh
         TWOPdCYnvGEYnn3xUz91wLH93DScxyWTBlrtNC1WZF5aIgdiTauwY4BiHmEtXh2MKlVc
         29MF6lvAfaagweeSh0JAMLappPt9ovG35pSSfLsQ7g5gWB8hVfBAKu8IPex3rwdIbpQq
         iwJnkvuBXWW52zILDwEOJErCtCIGoDK5iZyUi5vFQ33ZE/j2Y0DHO3S+QZtMPkFG6wui
         PRcluSSq/sHx5wyb38EZ43wBrJyv1nEq5i2Ai761UiAUSNAl+Gz/lyITX1zlzh4UIhXZ
         eVnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778861081; x=1779465881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tHtM3hln5E0LtkuEKr9m/vG1aJYWfiEmMpXBjaFCM6o=;
        b=HHKDmD1UgtnLFTAkOTDJVe3p3WYYrVJ2I2+1Qj5JSjK07f1HRlp5NxeQEqpaqs1zWJ
         fQbAl8bELHG549p145dKtqoJf/4zuVX5uq1sElZ1yv3GuXGNApEEpIB9bWF12btyQGcL
         6HUF7/98NVE1g4AaK3H1zl9bBFZeH9OFRThvymW1Cp0bCOvngsU/wHV79/P42+3isnV4
         Jk5fXAwupXgwRdlu4W+eNMtYjdgpw5L73aqvZE6tOx5ZDM03Kevxzf1MMB7pE0jhswHd
         GTTC3YJDN0cUJHl46tSSeiiOmhDLtbjP1sTD0p1KVEoQiIzehfT3PMQU2On7DN9NkWgO
         paYA==
X-Gm-Message-State: AOJu0Yzb+J6cg47lTPVCiq3SdQJ8OtjcNXXejHqbeO9w/tR4XQT9MjBW
	FpYMSp7Tyvtv2g26eL7Esz4ZIWp7HVwBI5yP9zCA861PfgIKhf8hHf2W
X-Gm-Gg: Acq92OFRcS2mFF36jxW1CbNB1MSh6P0PpAEkbnH91CUc1g+wW7zMkuOvqR7bSOrqjzM
	DXPUto0bCBZAckZodwtTDv61FPcWwqUYiG4PzYOHrCK/kXrflEMt19XWZ3WldWuxi+w7RcifdF9
	uPzVFi1xp08irwDo1WOk8ksY7ocF1ZuUYZnFIxkgbdiTxEOXrn1qeYnOQ0jouc9tCvQRgTZWeUa
	QoI3Twn/dwYxGEUk6hJ8kMpI9cxknRM0fmaK+YyRdRUhW6jxtXL/8K+T0ov72kL9JTwCJ+NK77T
	H3DJuW2IeTslw6YyddzdAsUtqa36omzjoC/SO5B33B83Xn4l/QQ+k70EkGkHK9AMRfiH8Y2BmTe
	rn/XNipTeoqi0UIu1FWMxWNwZn1IYaKi9uTes6BCSGUxRfWTOUMCmf5U6TbenP1ab0IA0hDV0XZ
	AM/cVFuJ/afoX9CI6Q/82qVwVOUHgCY/neEwl2CMoh6fie6fD7zWXa9tJXhXmMaXl6OH6c3iX3Z
	g==
X-Received: by 2002:a05:6a00:391e:b0:82f:623f:e5b3 with SMTP id d2e1a72fcca58-83f33de9717mr5676947b3a.34.1778861080622;
        Fri, 15 May 2026 09:04:40 -0700 (PDT)
Received: from localhost.localdomain ([171.76.86.174])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19c7c74fsm7920262b3a.49.2026.05.15.09.04.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 15 May 2026 09:04:39 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: kvm@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC 1/4] KVM: selftests: Move pgd_created check into virt_pgd_alloc
Date: Fri, 15 May 2026 21:34:20 +0530
Message-ID: <6e6aea750fb80d4d28dbba97c45f498f2ec06a68.1778857539.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1778857539.git.ritesh.list@gmail.com>
References: <cover.1778857539.git.ritesh.list@gmail.com>
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

From: Nicholas Piggin <npiggin@gmail.com>

virt_arch_pgd_alloc all do the same test and set of pgd_created. Move
this into common code.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
[Rebased to latest mainline tree]
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 tools/testing/selftests/kvm/include/kvm_util.h        | 5 +++++
 tools/testing/selftests/kvm/lib/arm64/processor.c     | 4 ----
 tools/testing/selftests/kvm/lib/loongarch/processor.c | 4 ----
 tools/testing/selftests/kvm/lib/riscv/processor.c     | 4 ----
 tools/testing/selftests/kvm/lib/s390/processor.c      | 4 ----
 tools/testing/selftests/kvm/lib/x86/processor.c       | 9 +++------
 6 files changed, 8 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 2ecaaa0e9965..3666a8530f31 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -1197,7 +1197,12 @@ void virt_arch_pgd_alloc(struct kvm_vm *vm);
 
 static inline void virt_pgd_alloc(struct kvm_vm *vm)
 {
+	if (vm->mmu.pgd_created)
+		return;
+
 	virt_arch_pgd_alloc(vm);
+
+	vm->mmu.pgd_created = true;
 }
 
 /*
diff --git a/tools/testing/selftests/kvm/lib/arm64/processor.c b/tools/testing/selftests/kvm/lib/arm64/processor.c
index 01325bf4d36f..498fbcb0ea16 100644
--- a/tools/testing/selftests/kvm/lib/arm64/processor.c
+++ b/tools/testing/selftests/kvm/lib/arm64/processor.c
@@ -112,13 +112,9 @@ void virt_arch_pgd_alloc(struct kvm_vm *vm)
 {
 	size_t nr_pages = vm_page_align(vm, ptrs_per_pgd(vm) * 8) / vm->page_size;
 
-	if (vm->mmu.pgd_created)
-		return;
-
 	vm->mmu.pgd = vm_phy_pages_alloc(vm, nr_pages,
 					 KVM_GUEST_PAGE_TABLE_MIN_PADDR,
 					 vm->memslots[MEM_REGION_PT]);
-	vm->mmu.pgd_created = true;
 }
 
 static void _virt_pg_map(struct kvm_vm *vm, gva_t gva, gpa_t gpa,
diff --git a/tools/testing/selftests/kvm/lib/loongarch/processor.c b/tools/testing/selftests/kvm/lib/loongarch/processor.c
index 64d91fb76522..207055db5f5d 100644
--- a/tools/testing/selftests/kvm/lib/loongarch/processor.c
+++ b/tools/testing/selftests/kvm/lib/loongarch/processor.c
@@ -51,9 +51,6 @@ void virt_arch_pgd_alloc(struct kvm_vm *vm)
 	int i;
 	gpa_t child, table;
 
-	if (vm->mmu.pgd_created)
-		return;
-
 	child = table = 0;
 	for (i = 0; i < vm->mmu.pgtable_levels; i++) {
 		invalid_pgtable[i] = child;
@@ -64,7 +61,6 @@ void virt_arch_pgd_alloc(struct kvm_vm *vm)
 		child = table;
 	}
 	vm->mmu.pgd = table;
-	vm->mmu.pgd_created = true;
 }
 
 static int virt_pte_none(u64 *ptep, int level)
diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/testing/selftests/kvm/lib/riscv/processor.c
index ded5429f3448..75a5d4c46001 100644
--- a/tools/testing/selftests/kvm/lib/riscv/processor.c
+++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
@@ -66,13 +66,9 @@ void virt_arch_pgd_alloc(struct kvm_vm *vm)
 {
 	size_t nr_pages = vm_page_align(vm, ptrs_per_pte(vm) * 8) / vm->page_size;
 
-	if (vm->mmu.pgd_created)
-		return;
-
 	vm->mmu.pgd = vm_phy_pages_alloc(vm, nr_pages,
 					 KVM_GUEST_PAGE_TABLE_MIN_PADDR,
 					 vm->memslots[MEM_REGION_PT]);
-	vm->mmu.pgd_created = true;
 }
 
 void virt_arch_pg_map(struct kvm_vm *vm, gva_t gva, gpa_t gpa)
diff --git a/tools/testing/selftests/kvm/lib/s390/processor.c b/tools/testing/selftests/kvm/lib/s390/processor.c
index a9adb3782b35..342b7c92463e 100644
--- a/tools/testing/selftests/kvm/lib/s390/processor.c
+++ b/tools/testing/selftests/kvm/lib/s390/processor.c
@@ -17,16 +17,12 @@ void virt_arch_pgd_alloc(struct kvm_vm *vm)
 	TEST_ASSERT(vm->page_size == PAGE_SIZE, "Unsupported page size: 0x%x",
 		    vm->page_size);
 
-	if (vm->mmu.pgd_created)
-		return;
-
 	gpa = vm_phy_pages_alloc(vm, PAGES_PER_REGION,
 				   KVM_GUEST_PAGE_TABLE_MIN_PADDR,
 				   vm->memslots[MEM_REGION_PT]);
 	memset(addr_gpa2hva(vm, gpa), 0xff, PAGES_PER_REGION * vm->page_size);
 
 	vm->mmu.pgd = gpa;
-	vm->mmu.pgd_created = true;
 }
 
 /*
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index b51467d70f6e..e420afdfbcfb 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -164,12 +164,9 @@ bool kvm_is_tdp_enabled(void)
 static void virt_mmu_init(struct kvm_vm *vm, struct kvm_mmu *mmu,
 			  struct pte_masks *pte_masks)
 {
-	/* If needed, create the top-level page table. */
-	if (!mmu->pgd_created) {
-		mmu->pgd = vm_alloc_page_table(vm);
-		mmu->pgd_created = true;
-		mmu->arch.pte_masks = *pte_masks;
-	}
+	/* Create the top-level page table. */
+	mmu->pgd = vm_alloc_page_table(vm);
+	mmu->arch.pte_masks = *pte_masks;
 
 	TEST_ASSERT(mmu->pgtable_levels == 4 || mmu->pgtable_levels == 5,
 		    "Selftests MMU only supports 4-level and 5-level paging, not %u-level paging",
-- 
2.39.5


