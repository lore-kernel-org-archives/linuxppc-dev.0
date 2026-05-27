Return-Path: <linuxppc-dev+bounces-21579-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C833CD5BD0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2026 12:50:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQTx86sRJz2ybQ;
	Wed, 27 May 2026 22:50:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::634"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779886220;
	cv=none; b=ltv+Gm01cZsgBdJ59L/XFVLplLiEYmycgvYGeFWvCnMIRQJwczoegvWthwyKpi8dSrvq82hOJB+b7jXRmBS7gcaDubaLofSaGxtFLHe2RZMbTx45NJKVmFNz/rQfQwukr8FlhZaphDRkryi+oHnDZ0mhpm9UZq1s4Kd4ye94OeNO00T2MtAnbApcwNNQW7VlQJE2CSXBB92fUf1DoAORadsaKViw4hS8qCpfgBfuf03+kGRTcL4Y5FHYIbVM/by6qhRw9T49u8d8PfkFFY1xhjLrxxfIZiYdvkF9kS/In8aFiAuEf4JqNtofE/taPTtlQpsxqoWzDG0yoRx5hLqzsA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779886220; c=relaxed/relaxed;
	bh=oMG8EtROF9Cg3C7hjmtqqGx+u6sXMBdHtk9UvMaumUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KdPe8Tem/W5HEZnWnyrEK2j95EhvN2LWX9k3hmDQnNoziKcYJdPj2iyU5tB+eaEiWw8CfyvBZbPhEcyjXC5Ya60LnbTUyGppysIk3GN0Slw/qQwrcKxeI/tV3wTpxkWMgu+LoHqLksxcannHKivetXtbF5gLr3R2t6X/LEw3DIeoVggFWYMYqUPgVkO88kDwYY/bCVxoThOJjxt0HugFAwPQUrwadZ/xtqTkMNhG+0wweTf48XnVvaoqi7wWQSpY4G9IiuvfQBTJvHUlTlR8FVa7acSX9ul++1RSvISiTUSjnMD7zCVo6roLi93mebjNiVYBHxSaQBRVkb56kNP0ZA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sTE+yIPi; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sTE+yIPi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQTx75ghHz2yn2
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 22:50:19 +1000 (AEST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2bc85eda6b6so59215395ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 05:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779886217; x=1780491017; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oMG8EtROF9Cg3C7hjmtqqGx+u6sXMBdHtk9UvMaumUw=;
        b=sTE+yIPiFfUNDtt14LDwpsOItXGCXzd3S/CL7DlG78kAIs/6QI8AQaBKn3exYRonri
         Xd868M9T2/WeW5oO+RMxfClaPFJeP5QSZSvGKy1Z5+I8Zwefov1uwNzcswwtnbobmt+i
         /UcXggj5WJLy+LMdyq7qOvMe/TURTKuLO6DZLKA2b8kNW/RI18vE1+VQu3iWpDVxYQb9
         FGSARX3Yg292Tak9026u3OCiLtc3ctBbz0c8xkr95dVYLRLxPe9pwNotfmmfilzMEZji
         aY6omahx9c7zhEZGUhc52gzmFNvWoM4y6in04BlbkK1EVPCsON4VmKhMWzptUZ+y6sWO
         Q6bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779886217; x=1780491017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oMG8EtROF9Cg3C7hjmtqqGx+u6sXMBdHtk9UvMaumUw=;
        b=Xsi/bw1UTNt27nB005ARLukEJd6IMnB0rOPZxv0I11oqI39N7pdTHa9KRpja2x8fpn
         UitE9WZC1h/+RKrN1SWMRmG/zAfp1mOLNYckzn8A6MOUo1Oz6lp1odUTf55UM908TAkz
         Hu4f3iA6U97lqfIvV3lup7c7F4K4CedX4dA0CmCmdXlwZNy+A+q4ZA2sePT6ZR65jIKK
         NOGYYnTrxzzuagrNTXZ1qSMfLB4TkX229qXAmy88/qMSLBLBYnE8v2IDx7Y3tn5MpDKx
         AlCF80RPQCEqwhiO+8wT4BrNCH0XUjylQFdzTjYiuVZBUgdv4VwXEzKpGljTcWa/+T7A
         SqPw==
X-Gm-Message-State: AOJu0YxCSBhdfhbxWfEJiQ/iNXqEQjWOrlc88kHcIg2gWnVe6yj9sUiU
	FdjFcTUa7HkXgdlfYYQ8SziHC4iVP1Ttx5ZKRvJ1kc0IBuzjjxP0Wsci
X-Gm-Gg: Acq92OFYuU1GmwC/uqZGEY6UnjToR1FTWphMILjtfG7lnWl1H151v1PZsOvcZJSgOgZ
	IKFyRD06ajTdl3vw9tFdS0a0wACk7ifVq9buDyC0yuOhEhiW302+pGFTxtLc3ouDwM+gIV2Ts3h
	XGKAbFrgDuCN5NsE1Xk3kXgnRElarztKBdcFvMyAHa0xQ3ExkTzdN8K0JhB2gGpO6GNWVSembPb
	J+ge8WbZCZRc7kE9iOkNyZtgnn8LWLQdfZXhL6Vrg4o2Wq0jRd5n4YzKqMbRfNr8ut/njUxrkYf
	gRPmX96d2jxaLsynqQDztKyuRKvtrCU4kwkDRi/eom3R/lu9i1VjEMYfs5HE5k9GxF+72AzxJch
	AsLDc3s1VEbTqHTPUGAabh7sUFqPLSukhHhBmSXCKQQoFa51qAoHPzIoKpq5G8vKeficYWNCIaj
	dzeoa9iClh4HktqnoDI2bwjZgME1g0ENLYhvzDvdE=
X-Received: by 2002:a17:903:390d:b0:2b4:5e0f:c239 with SMTP id d9443c01a7336-2beb03776bcmr229042615ad.10.1779886217442;
        Wed, 27 May 2026 05:50:17 -0700 (PDT)
Received: from Mac.ibm.com ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58c69a0sm151851185ad.59.2026.05.27.05.50.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 27 May 2026 05:50:16 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: kvm@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Misbah Anjum N <misanjum@linux.ibm.com>,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC v3 01/10] KVM: selftests: Move pgd_created check into virt_pgd_alloc
Date: Wed, 27 May 2026 18:19:50 +0530
Message-ID: <ce1d35a37541702914e4a89052b6f1dd049045ba.1779885589.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1779885589.git.ritesh.list@gmail.com>
References: <cover.1779885589.git.ritesh.list@gmail.com>
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

virt_arch_pgd_alloc all do the same test and set pgd_created. Move
this into common code -
except for x86's virt_arch_pgd_alloc() -> virt_mmu_init() - because this
can also be called from it's tdp_mmu_init() call for setting up it's
stage-2 mmu.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
[Rebased to latest mainline tree and removed x86 case]
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 tools/testing/selftests/kvm/include/kvm_util.h        | 5 +++++
 tools/testing/selftests/kvm/lib/arm64/processor.c     | 4 ----
 tools/testing/selftests/kvm/lib/loongarch/processor.c | 4 ----
 tools/testing/selftests/kvm/lib/riscv/processor.c     | 4 ----
 tools/testing/selftests/kvm/lib/s390/processor.c      | 4 ----
 5 files changed, 5 insertions(+), 16 deletions(-)

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
-- 
2.39.5


