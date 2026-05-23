Return-Path: <linuxppc-dev+bounces-21426-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F5ECCD5BB1
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 May 2026 11:15:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gN00v6sHhz3bpJ;
	Sat, 23 May 2026 21:14:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::430"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779534895;
	cv=none; b=fVPa5oJNWwWUXHIyJ/4cO9EGJ056AoJZ9DZ2iYLjaOBNfZ77zbemTpdWV7uUCXnc/o9x1FxGjX7NsLVldbsVcy5xQma7eAZmGbxTIqCXo2ZekhO9ltV6U59ThtRzD9pwoQ7HaKwuqby7Hc+fv4VzpMqw501fbb1b4w6oKsge9BhPYZxYia3dq5X5ThCjj+QQxdBF1ZIUE2b8TEjKEy91MPYvzijQug2l3nh7verp+kOKnx/jtavM2j+TwbGiykEQskk/q/o7LEluRdP8x8AR19YFh7m55l8RulgdvILdUySggv31U9HFHoz0k44KcSiGPMwPhF1bGUyc4lLyEw6obA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779534895; c=relaxed/relaxed;
	bh=oMG8EtROF9Cg3C7hjmtqqGx+u6sXMBdHtk9UvMaumUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IRcmjWgbQWonJvSVIb5kH6aKHJX/RIGytwSiks0xqBkijhPMOOO5Qxs5ZjJNDF1RpMegXbda28u1KvRi1mQat8ThIB1NoKICy7QpbfFR/K6arGcMmBSjubjlflckWXhANAnoOuvduUFilsjBtYOLo8Kpk2xKGFUmhaevACSMLc0unZAa8EfKNSSAbO2LPUHUoff+ZT/mlbWYgbXjpQzyfZ1BT3ddujnNDIwWcFntZsPAGgB4FQj3lzElY75JZR1oFYwRSa4ivHWkyhWSnc3DCpvf6Oirxsfaa4Z2F4aSdqGZPlpXd1mEajLJq6STZrGbkdr3IGBd+FNdp2vBJxyuPA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=s1r0jBt5; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=s1r0jBt5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gN00v25CJz2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 May 2026 21:14:55 +1000 (AEST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-82fbdd60b64so6857200b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 May 2026 04:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779534893; x=1780139693; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oMG8EtROF9Cg3C7hjmtqqGx+u6sXMBdHtk9UvMaumUw=;
        b=s1r0jBt5V+9fWahQpaZ5tWMEMExVsfACem/B9PdSTHb2pdckqIMc9Z2AiCLZzZv57r
         r/swfN5iT8EZz/lIWezH+uRaOxeLc+KnHRR3R2zmq2nxUmCNbJgZQQcVjvF0bAj2AuDb
         O++XK/rqEauAYDmgRQITwt0TQU1SJRpOiGmExdlWL1WwmdbVi3iguSkK1z1I9VYdmq3w
         nrf/9eX8Mf7WL7hyMmkptBr8y/H0mh92y0Lr1B4UHZAPCUasNr8eBHdoyww2RIDEnXSZ
         nzJuJOgio+fOais6gzNcU/7lQU/nFzxUHdfWwXsoOokXNTTQoLHv+lvNpfvtRbaS4FAp
         KmAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779534893; x=1780139693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oMG8EtROF9Cg3C7hjmtqqGx+u6sXMBdHtk9UvMaumUw=;
        b=pJkQ3qEnFXpUhvm2aY8EtK4odg6BQnPDtm075EcaEV2u/RCGAqD3WXnwg4vhDdD1aC
         17H5FqhKFA3E79rG2ExT4BrfjGq8Jdso0Ifo2F30tiAm8sNltHxTmdd5JC1+t6v8LsVB
         JHp25ZSoiA/+pcUrymp/ClwxqBwdVS+rZEdBRLR1C1TdWhN/grm1drQOmuKYEDwegQiQ
         89ABDU4lLVlb38AJxKnreWjyqgVyvaxvf6jVI8umbfLFUw4jURlikuZbkQ5Ixdc2YhHE
         BUsB3/Qb2g7ZEe3xEI8kvwkWmP8n3nN9kJ+nF0bpCN4H2ZCCRpYxsOn2ftg/whaQPm0h
         rKhg==
X-Gm-Message-State: AOJu0Yy2jZObzl71mbDXYcHbdsXcrHRlyKnP0gFBLPY58p13izT8l4tV
	55ghKyo6k0jhsyUZu8NKxnpGQONXPXaYuwQUQWpNepWk3GuzglYGzCTW
X-Gm-Gg: Acq92OEC27s/B3CKDOUI6+Sq+ui8x4Xnh19lq/LWatBSMB5rUfuDBBuZ3g461sEGCdM
	oAj9U7EwsKEobeLoSLzKl0DEo2oiq2Kcdzk+EJep5Cou6IZbx/GKuvuwSkSXDDZE+20iaPlJgNz
	8lNfmK2r3nPtLv2NCvUCAcOppgnEy3UcCW5ANQrBttQBZ86m2uq4CVk5cbKUNFteHkEhKNHaRoR
	1/0FCVLxSGb2WYh8+tMaSZ3hiPj/aSgmGvnKKKCfJtovgKf8lkSP0O/B5HX69Hd8UAgFvbobAqI
	XS9I2tACAcDNigA1WJysLav1CF8MG+hIwZtExz6dMEQl1UKdn5xLw0BGlnOtTCNDH2YgIqKJ/4o
	oiyDoysEJrC+n1QfFByQ8WSRZW7GIfwioxAPAOE4HIh9liPerWRefiPEnUBa1qREdQjUQ9cVyqo
	1bDp0jcjjE4naKVCB52WJTAqKebvD87Y4RoQyZQLU=
X-Received: by 2002:a05:6a00:94fc:b0:82c:6683:b866 with SMTP id d2e1a72fcca58-8415f121b9bmr7424451b3a.4.1779534893432;
        Sat, 23 May 2026 04:14:53 -0700 (PDT)
Received: from Mac.ibm.com ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164ac9c77sm5249140b3a.2.2026.05.23.04.14.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 23 May 2026 04:14:52 -0700 (PDT)
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
Subject: [RFC v2 1/5] KVM: selftests: Move pgd_created check into virt_pgd_alloc
Date: Sat, 23 May 2026 16:44:20 +0530
Message-ID: <d5256bfe85fbb8c7f37ab6090bb08ccfa6a47e7b.1779524962.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1779524962.git.ritesh.list@gmail.com>
References: <cover.1779524962.git.ritesh.list@gmail.com>
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


