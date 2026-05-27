Return-Path: <linuxppc-dev+bounces-21584-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11DBFCD5BD5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2026 12:51:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQTxc2krsz30GV;
	Wed, 27 May 2026 22:50:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779886244;
	cv=none; b=FCtK4YixACbhfWVcUk5LJ4Y9dfCNRkgd3Pzt6XB7m2/82cs0e0l6rZFHewN3qVkGG2u+HLqS93wUw54KMjsl8JYDbfsSXLhwB0Y61jRC4yknirF7XNM+s5LFuSdRYAW+c4JE18fuqNurlUExE5j5cBwS8htb7gs6rwgNB4W64aI6q/OrsEbR0GBiDxodcJ1kexGQ7kNQ7kX0G5v3RcE361qyRESHuSOMv5bvD6qwRW+IbdeqE86RZcn/b9D0R6Fc5U3haTbUlzLGrS1c1VMXegvo24U2EK9X8CK25C+9JaTVJm9Xqzw4iJbRd1y8ynizKUpAQ+nC8WUP3lEGYFrdNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779886244; c=relaxed/relaxed;
	bh=V4S58wFnVNRvnxdkAeXXsrXJzD1QYgOVb+aOndCv6B0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gc3U1SWcVC8kq5RULwUZ+qdFXtc0EEQjwoZZqqR9jO+ekxQsdpNy4VNMW9wGyX3t9i7PVXCXFu/3xUz7FitYBs3HNiZwbD2d0YnhFSMke7RIMtrwjJRAAIzUlhWYnCHHtAn7+tu8i0Ervn33SY9LhVfaGWxb5RNsycs9Tm35qx98Vs2fcFePKMQqNdzdU+75ldM5fu7ysirNYSVxFNo5UxABWV/VsBsaMCMc1OM8Xis2TwdBpLvoAcMaMz74ArAZLZQg1Id1wmRGnuEILROY/5oeo+2MucOnlhxSydeJeWCPtOZoqR0O1Jn8Jp6EiLLe5chR6SYA6hVCXynfHC9ZLA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=El25xi+R; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=El25xi+R;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQTxb2CN6z2yvY
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 22:50:43 +1000 (AEST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-2bea7176c72so49202285ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 05:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779886241; x=1780491041; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V4S58wFnVNRvnxdkAeXXsrXJzD1QYgOVb+aOndCv6B0=;
        b=El25xi+RQDSP1I7wMK/QbpnQmZalT7tPairL5XXODpCq7Psy498ixYY9fw6jq98XkE
         S9tLaBiMewxR8xDEd53U6YGgSA48VyHdpyKlf2SFSuQv6I8tkoMp4GgvBa1ictjomH6G
         n0zhtkcZwQNhOg295ghcmXNexYlczxJdiOjxG/ABlvV/xwOhHg/JWYm3uTOVy1Cc1L8G
         Wkalm4tgHHx3tlpnTDEFrPexFzRXU+IL4GdrQP23grKOy7QyOez2LasZD92ziJ+868lG
         +4dz5Fenrh85us7+rbP7YT85Y49GNMldORbRqeD5XOxJ06rfejDbECoHg5LnK8KeDQc2
         lSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779886241; x=1780491041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V4S58wFnVNRvnxdkAeXXsrXJzD1QYgOVb+aOndCv6B0=;
        b=SEQj7lze9VJz92rhXAPqTwE51xmQo1k4/BKNPsHMdSQIWlJwVV73YK/aS/rdFcwBPi
         MIsVCTNJyVCjBMDOpqz3hgYGIuCsGcDrVVcVknf2tGZrXIqwcAUIVvrSD1SifTmlpJ7C
         TTy1Wvf6fbgVyix4aIDiE55TUScRdTVwr+JnygjoWSwqubE2TEsj57SngGwswHxGBTtq
         XEVD8An2nDmJJdfNSiCE538zUUSarDMmzc4swehDk4+SVVB/2Og9D7QdN5dN8UF2WqBD
         CsQK7qBXzL9e9l75Kg5NQ2hCwrTfnd4o79p1kXNGsUdmZzNcINu55+E/9JDly1I7djwX
         sRig==
X-Gm-Message-State: AOJu0YypOiYXUgyGRg0YDd5A4j+j11P8ppP7nbBLq7ssBbwRqrqaFVpP
	EJSZ5u1dZ7hcVHLPRjVwCu3s5cQH9zOdyWNxOJrRjER6v7P3oF7qcmlw
X-Gm-Gg: Acq92OEhSErcTH8RjwM2wsIPVLSq8JS3KoJebA6jy1j8kHlFQv3FThH2wDeAAAf/7Pc
	pGc56/p0TY66j6MPfHO6JJ4ARhqgYh0FGe30dsZTEJF89myoPHzUVbiyuqXWtXo+dpLj/hiWIWW
	nb2+Xevv77nAFVo/EltoPwmwXT9HbaHJahj6I+vmnlmRqEKNtbmQupn4zxS4OtMFc9iLf0pkVYY
	YCdfI8tLPXqaHvzQ9FABdJBQ0toENO1GLgrBr50LOLxeLZRR+GCiSOtR6cbdyPKsu6J73lbR8Eb
	hFtq+UbqXOzY/UyHtcNA3cV47hKci9IKMec/svxcAXoeWGfmrJJsA8oWv48lgPTOlAsfr0etYMM
	EkhfsXcSUd4YWficeDjwQi+/zT3qDghSTR/LKcfcIOraBsyyFoWwdxjWk+WbCyfQXMXX8CeJVaI
	ASKJmLWhG0ifmhZHnqfqsTSLGa8Pf9kKPTSPF4GIiGSEu0LmsFWA==
X-Received: by 2002:a17:903:19e8:b0:2b2:539b:d2b1 with SMTP id d9443c01a7336-2beb0628a12mr256281175ad.16.1779886241233;
        Wed, 27 May 2026 05:50:41 -0700 (PDT)
Received: from Mac.ibm.com ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58c69a0sm151851185ad.59.2026.05.27.05.50.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 27 May 2026 05:50:40 -0700 (PDT)
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
Subject: [RFC v3 06/10] KVM: PPC: selftests: Use u64 instead of uint64_t
Date: Wed, 27 May 2026 18:19:55 +0530
Message-ID: <0132c8045f8d2718b155eab52e659d9b0a80aefe.1779885589.git.ritesh.list@gmail.com>
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

commit 26f8453288d4c ("KVM: selftests: Use u64 instead of uint64_t")
made this change from uint64_t -> u64 for all other kvm selftests.

Do the same for powerpc as well. No functional changes expected.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 .../selftests/kvm/include/powerpc/hcall.h     |  6 +--
 .../selftests/kvm/include/powerpc/processor.h | 16 +++----
 .../testing/selftests/kvm/lib/powerpc/hcall.c |  6 +--
 .../selftests/kvm/lib/powerpc/processor.c     | 44 +++++++++----------
 4 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/powerpc/hcall.h b/tools/testing/selftests/kvm/include/powerpc/hcall.h
index 4028baa6c5d8..f923b3f5e233 100644
--- a/tools/testing/selftests/kvm/include/powerpc/hcall.h
+++ b/tools/testing/selftests/kvm/include/powerpc/hcall.h
@@ -10,8 +10,8 @@
 /* Ucalls use unimplemented PAPR hcall 0 which exits KVM */
 #define H_UCALL	0
 
-int64_t hcall0(uint64_t token);
-int64_t hcall1(uint64_t token, uint64_t arg1);
-int64_t hcall2(uint64_t token, uint64_t arg1, uint64_t arg2);
+int64_t hcall0(u64 token);
+int64_t hcall1(u64 token, u64 arg1);
+int64_t hcall2(u64 token, u64 arg1, u64 arg2);
 
 #endif
diff --git a/tools/testing/selftests/kvm/include/powerpc/processor.h b/tools/testing/selftests/kvm/include/powerpc/processor.h
index cb75b77c33bb..cbbe390ae244 100644
--- a/tools/testing/selftests/kvm/include/powerpc/processor.h
+++ b/tools/testing/selftests/kvm/include/powerpc/processor.h
@@ -15,16 +15,16 @@ struct kvm_vm;
 struct kvm_vcpu;
 
 struct ex_regs {
-	uint64_t	gprs[32];
-	uint64_t	nia;
-	uint64_t	msr;
-	uint64_t	cfar;
-	uint64_t	lr;
-	uint64_t	ctr;
-	uint64_t	xer;
+	u64	gprs[32];
+	u64	nia;
+	u64	msr;
+	u64	cfar;
+	u64	lr;
+	u64	ctr;
+	u64	xer;
 	uint32_t	cr;
 	uint32_t	trap;
-	uint64_t	vaddr; /* vaddr of this struct */
+	u64	vaddr; /* vaddr of this struct */
 };
 
 void vm_install_exception_handler(struct kvm_vm *vm, int vector,
diff --git a/tools/testing/selftests/kvm/lib/powerpc/hcall.c b/tools/testing/selftests/kvm/lib/powerpc/hcall.c
index efb4318252be..cd10022572a5 100644
--- a/tools/testing/selftests/kvm/lib/powerpc/hcall.c
+++ b/tools/testing/selftests/kvm/lib/powerpc/hcall.c
@@ -5,7 +5,7 @@
 #include "kvm_util.h"
 #include "hcall.h"
 
-int64_t hcall0(uint64_t token)
+int64_t hcall0(u64 token)
 {
 	register uintptr_t r3 asm ("r3") = token;
 
@@ -17,7 +17,7 @@ int64_t hcall0(uint64_t token)
 	return r3;
 }
 
-int64_t hcall1(uint64_t token, uint64_t arg1)
+int64_t hcall1(u64 token, u64 arg1)
 {
 	register uintptr_t r3 asm ("r3") = token;
 	register uintptr_t r4 asm ("r4") = arg1;
@@ -30,7 +30,7 @@ int64_t hcall1(uint64_t token, uint64_t arg1)
 	return r3;
 }
 
-int64_t hcall2(uint64_t token, uint64_t arg1, uint64_t arg2)
+int64_t hcall2(u64 token, u64 arg1, u64 arg2)
 {
 	register uintptr_t r3 asm ("r3") = token;
 	register uintptr_t r4 asm ("r4") = arg1;
diff --git a/tools/testing/selftests/kvm/lib/powerpc/processor.c b/tools/testing/selftests/kvm/lib/powerpc/processor.c
index 9846ec26a32a..ac5c3421ec81 100644
--- a/tools/testing/selftests/kvm/lib/powerpc/processor.c
+++ b/tools/testing/selftests/kvm/lib/powerpc/processor.c
@@ -14,9 +14,9 @@
 #define RADIX_TREE_SIZE ((0x2UL << 61) | (0x5UL << 5)) /* 52-bits */
 #define RADIX_PGD_INDEX_SIZE 13
 
-static void set_proc_table(struct kvm_vm *vm, int pid, uint64_t dw0, uint64_t dw1)
+static void set_proc_table(struct kvm_vm *vm, int pid, u64 dw0, u64 dw1)
 {
-	uint64_t *proc_table;
+	u64 *proc_table;
 
 	proc_table = addr_gpa2hva(vm, vm->arch.prtb);
 	proc_table[pid * 2 + 0] = cpu_to_be64(dw0);
@@ -81,9 +81,9 @@ static int pt_shift(struct kvm_vm *vm, int level)
 	}
 }
 
-static uint64_t pt_entry_coverage(struct kvm_vm *vm, int level)
+static u64 pt_entry_coverage(struct kvm_vm *vm, int level)
 {
-	uint64_t size = vm->page_size;
+	u64 size = vm->page_size;
 
 	if (level == 4)
 		return size;
@@ -97,7 +97,7 @@ static uint64_t pt_entry_coverage(struct kvm_vm *vm, int level)
 	return size;
 }
 
-static int pt_idx(struct kvm_vm *vm, uint64_t vaddr, int level, uint64_t *nls)
+static int pt_idx(struct kvm_vm *vm, u64 vaddr, int level, u64 *nls)
 {
 	switch (level) {
 	case 1:
@@ -128,11 +128,11 @@ static int pt_idx(struct kvm_vm *vm, uint64_t vaddr, int level, uint64_t *nls)
 	}
 }
 
-static uint64_t *virt_get_pte(struct kvm_vm *vm, gpa_t pt,
-			  uint64_t vaddr, int level, uint64_t *nls)
+static u64 *virt_get_pte(struct kvm_vm *vm, gpa_t pt,
+			  u64 vaddr, int level, u64 *nls)
 {
 	int idx = pt_idx(vm, vaddr, level, nls);
-	uint64_t *ptep = addr_gpa2hva(vm, pt + idx * 8);
+	u64 *ptep = addr_gpa2hva(vm, pt + idx * 8);
 
 	return ptep;
 }
@@ -151,7 +151,7 @@ static uint64_t *virt_get_pte(struct kvm_vm *vm, gpa_t pt,
 #define PDE_NLS		0x0000000000000011ull
 #define PDE_PT_MASK	0x0fffffffffffff00ull
 
-static gpa_t __vm_alloc_pt(struct kvm_vm *vm, uint64_t pt_shift)
+static gpa_t __vm_alloc_pt(struct kvm_vm *vm, u64 pt_shift)
 {
 	gpa_t pt;
 
@@ -189,16 +189,16 @@ static gpa_t __vm_alloc_pt(struct kvm_vm *vm, uint64_t pt_shift)
 	return pt;
 }
 
-void virt_arch_pg_map(struct kvm_vm *vm, uint64_t gva, uint64_t gpa)
+void virt_arch_pg_map(struct kvm_vm *vm, u64 gva, u64 gpa)
 {
 	gpa_t pt = vm->mmu.pgd;
-	uint64_t *ptep, pte;
+	u64 *ptep, pte;
 	int level;
 
 	for (level = 1; level <= 3; level++) {
-		uint64_t nls;
-		uint64_t *pdep = virt_get_pte(vm, pt, gva, level, &nls);
-		uint64_t pde = be64_to_cpu(*pdep);
+		u64 nls;
+		u64 *pdep = virt_get_pte(vm, pt, gva, level, &nls);
+		u64 pde = be64_to_cpu(*pdep);
 
 		if (pde) {
 			TEST_ASSERT((pde & PDE_VALID) && !(pde & PTE_LEAF),
@@ -227,13 +227,13 @@ void virt_arch_pg_map(struct kvm_vm *vm, uint64_t gva, uint64_t gpa)
 gpa_t addr_arch_gva2gpa(struct kvm_vm *vm, gva_t gva)
 {
 	gpa_t pt = vm->mmu.pgd;
-	uint64_t *ptep, pte;
+	u64 *ptep, pte;
 	int level;
 
 	for (level = 1; level <= 3; level++) {
-		uint64_t nls;
-		uint64_t *pdep = virt_get_pte(vm, pt, gva, level, &nls);
-		uint64_t pde = be64_to_cpu(*pdep);
+		u64 nls;
+		u64 *pdep = virt_get_pte(vm, pt, gva, level, &nls);
+		u64 pde = be64_to_cpu(*pdep);
 
 		TEST_ASSERT((pde & PDE_VALID) && !(pde & PTE_LEAF),
 			"PDE not present at level: %u gva: 0x%lx pde:0x%lx\n",
@@ -263,8 +263,8 @@ static void virt_dump_pt(FILE *stream, struct kvm_vm *vm, gpa_t pt,
 	size = 1U << (pt_shift(vm, level) + 3);
 
 	for (idx = 0; idx < size; idx += 8, va += pt_entry_coverage(vm, level)) {
-		uint64_t *page_table = addr_gpa2hva(vm, pt + idx);
-		uint64_t pte = be64_to_cpu(*page_table);
+		u64 *page_table = addr_gpa2hva(vm, pt + idx);
+		u64 pte = be64_to_cpu(*page_table);
 
 		if (!(pte & PTE_VALID))
 			continue;
@@ -320,7 +320,7 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
 	struct ex_regs *ex_regs;
 	struct kvm_regs regs;
 	struct kvm_vcpu *vcpu;
-	uint64_t lpcr;
+	u64 lpcr;
 
 	stack_vaddr = __vm_alloc(vm, stack_size,
 				       DEFAULT_GUEST_STACK_VADDR_MIN,
@@ -374,7 +374,7 @@ void vcpu_args_set(struct kvm_vcpu *vcpu, unsigned int num, ...)
 	vcpu_regs_get(vcpu, &regs);
 
 	for (i = 0; i < num; i++)
-		regs.gpr[i + 3] = va_arg(ap, uint64_t);
+		regs.gpr[i + 3] = va_arg(ap, u64);
 
 	vcpu_regs_set(vcpu, &regs);
 	va_end(ap);
-- 
2.39.5


