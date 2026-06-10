Return-Path: <linuxppc-dev+bounces-22405-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCDC2CD8CB9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jun 2026 12:48:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gb5DJ3y2lz3bwR;
	Wed, 10 Jun 2026 22:48:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1036"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781095696;
	cv=none; b=Jv9V/vV9Af0jO4t+wfNBO7PyZLH+vmSLJGC5A2C0Bwve2jQnqrvpiTxCNAjzkG5XDNE+i1GPt9O/cKE/gAduHh/IDtKNgB7lqY/utIl1FQFNVlVp0nHUOTpC/Nx1uOBJloCKCSa387hG47ErPqL4BEHpP5Hy49U40itGmWxLrGMy3u5kHyRjJjtMhL7Cw9qWkVn5YPASVaPHrfj40erTUh000etHNNAAZOb7ilposJ2BfhH3sf4MdoZJ9nGalErWzYdPmjPXYp7W3BxaCTIqCFQz+tFwye+NSmFTW9eF5wC6TxAuJIiNsZnDlfwEnIt4DNc1lM/h89EZpfFzZit30Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781095696; c=relaxed/relaxed;
	bh=nqa48U7Zo36zEODVSIgL4W0ts+Mysp9P11byxscZfNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OjcrFT3uxA04BjHPbrsSvu5KJzkk2J15hBhcHuYOXQJKmQpWthT798DLorl5LC1wwyqNhpADutNaTlgn3LONHj5fUYI/JFhPw/xpRPQAcmDb53o0ru31X21HvhGnITdePayS4l+2p3mSPHEc6NlaeDucw92h0DhAaHVccqc2nC5hP8Qa7ji6nbY/N/ZqfkBn2LeK7UeSHzVYCwxF9jiJjiuM4raw5cqD7JsfAI5XVtZ1cxLrrGGAhy8dM8Xv2vWdvHsqShgjECh8PpClRzFbGI/O+bZF/r6ZmnjcLw0//TbLD4jPE3K92DrNApiUy7l/Ez1RsjJcBMasgDbTmgTa/g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ACPD1/On; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ACPD1/On;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gb5DH5Wfnz3bpm
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 22:48:15 +1000 (AEST)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-36dac5d5da0so3510053a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 05:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781095694; x=1781700494; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nqa48U7Zo36zEODVSIgL4W0ts+Mysp9P11byxscZfNU=;
        b=ACPD1/Onb4ribYvTLpL7eZSBy8kiBu2reVkgCLpQvknNgqMY06T2fU9fBSCc0nbzsU
         nNHRbg+7cPT9aaSiOBmiMPMClpyBXX1fgqk9kMqtM48FOSS+vo/vsFd9CC55+cVa17Fq
         YA8c6kzPgtyQtJbbbeyCOkIkagadm+vhf8CM497fAFRzZ5mT3q5GBefhKtqa9JHCZTav
         ozndBH2sKDLJLdB+N38wWVhiVLLK//CT1h4rJK+9EyLupu8wEYZpiVxRDfslGykVzjeq
         fzRlZRdq5YVcRSUSTEuclqk4O/x4wvnJLh2Vjlorm4QTa+DxjfN0Qaa+5pgNBiKvEIz8
         6A/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781095694; x=1781700494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nqa48U7Zo36zEODVSIgL4W0ts+Mysp9P11byxscZfNU=;
        b=H9QjPozpbDozlSZK7eCQ0Zx9u6F01aLeOz7KVf+4QfSPjRJybGT2QVAH6jmmenQoPI
         HnIO4HGnDbuv3dRFZNYqylNVpohsGD+bTk/1fGytccet9N3XNZj86DJhSIGZFK+y4NgA
         Okfe+1vZVMwPihDZadO5HFsuD+c85Tb+S72zTiny00u2Y/WgbtcbGCvOiO/TKVdfqYwf
         L5KBgnGlDmFIeZYngw43P7mLb7xGyBBs6fa9MF7OabspgkbKav+PY93rjaXJvRIvS/QJ
         oWfihU3q9AF2nKziq8W2sZcXgOy6ZFYJzYLJtObhv7tA9vlwa1Wk++M2jHgMzYYuLbDg
         MGEg==
X-Gm-Message-State: AOJu0Yxc0Tsh4Mf3g2oObCsVZ2/ebY/gViiYrbRcqV1O+Ab/TK9sdZs0
	OBzFXyTseSzhpZz9Px92ca1aBNbB4ag4V979J1ZW29gt8nKUzmQjbGLk
X-Gm-Gg: Acq92OHaF08v+HsMI6nznKJIQxqLTenMazKeHyYQ4nJHg2Ra4GBw+ACTlccy5/6UpW2
	rMs+lvAexrs7xHdyQEqjmlzUPHikoFmOPpTNNjwavJOthSQFYc9SqpKSEUn/2CKM5k4Uf0e8BRD
	zelZIDaor2IPwE+G4N9A/qtyD53unFAVuRiDgqgRM+KI4sUQS+TASZLp3ktvbbgagk9wXp1XiST
	CcKKS+Ts69gYgEvZkwBFEA5Pvq5LCx3vO572Av+FoEib3u+ihvopPeymaiMekp3FwrN3IH3AJNj
	ONcTqIQcBorOILKf2OF1Jww/gcv8QoYgBtqrcDeZhGW01nlSzrzmPu+3GrjRk5Hgli22BahRIZ+
	SH62tNcW2TgkJwtTnlhBzwQBEPliFEkq6CIJKIVWSYy5QlFBKsHutSQYPbCtTfOI4o1vwhhQrbl
	k2c6NO6x5xXvbr0BE/QbriYYNRW1vX/wllVRVIX0RiA6zFcQrNpthtQPxgX/mu4g==
X-Received: by 2002:a17:90b:2706:b0:36b:ad81:c134 with SMTP id 98e67ed59e1d1-370ee928d34mr26496639a91.10.1781095693483;
        Wed, 10 Jun 2026 05:48:13 -0700 (PDT)
Received: from localhost.localdomain ([171.76.83.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37624b83589sm3783554a91.16.2026.06.10.05.48.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 10 Jun 2026 05:48:12 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: kvm@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Sean Christopherson <seanjc@google.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v3 RESEND 06/10] KVM: PPC: selftests: Use u64 instead of uint64_t
Date: Wed, 10 Jun 2026 18:17:22 +0530
Message-ID: <a09b26fcaceb79693b38af9c6ece9a8a9a4b93a9.1781093720.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1781093720.git.ritesh.list@gmail.com>
References: <cover.1781093720.git.ritesh.list@gmail.com>
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
2.50.1 (Apple Git-155)


