Return-Path: <linuxppc-dev+bounces-22409-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C839CD8CB9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jun 2026 12:48:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gb5Dk4NTlz3brD;
	Wed, 10 Jun 2026 22:48:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1031"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781095718;
	cv=none; b=PdEElmXlTO/60VnwhKZ4fReBfhWpLuFFRHIzDGTfYKwW1Al2ZNHgeMngvJU4kTNJSiu9kME7ufHWDSM3xZNDBB0B3zauJWRkGw4xw6ixKi8yf8a5fYbbWfopgwmoShLwpP/VaBwNEe6VcHRvdLoeFAS3lY/IlRO6UzcO2mgL9gQukFZVXbjiol6aXPkxW+M/KbFAOm7H3vPxkNnF6o/8xyLFrNa2hMkHw3PfeZTCSSKz5Gji2xRl8Mi3q63ZzH7TWiUb6D+oB1oKkvcR/Eyv5hXmkKFiygacz+n+luUAFiGX5apMeo4gwvK4e1VLTme/oAPACWaCYBX7cmRCtMRkWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781095718; c=relaxed/relaxed;
	bh=z9BiimjFi0aXMRD8saAolcJy9dKWyzjah+ENtioga50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j9PoI8cLuA9yzdoBS2pLi4e9ySJoduLHOhd8+diWKdQUooa3D+SbzMKdb+tPBCeF9F1nGl/3+PQHs5+trE5kNPEnlhOJYO/LW2Z9TonEN5TYqC3Zlhg4PerDITqzHrMzrlhACmm1J22YH7N/Ro+gC/sKJROFd6D/kZH0sXD+oANqLWNWgtCC+nuiSYFkJP3PP9yIpwKrw6LYv8U6y+dI+oUO9e0ZQSc1Is1tOiBws3EIeGJ1bCxAgQWaNUgKp3MMxU6GspR35svy+snRuWGLLB4iT0UWDjZizlUY0CfU4/T/WeFhi3Kk8M0+atWie11afES3BAx3EnrNX4c5SsfJXQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RcK/YE1I; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RcK/YE1I;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gb5Dj6J81z3bpm
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 22:48:37 +1000 (AEST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-36d630c0e35so7248694a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 05:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781095716; x=1781700516; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9BiimjFi0aXMRD8saAolcJy9dKWyzjah+ENtioga50=;
        b=RcK/YE1Idb3iY408i7mlZuV+oE9qcMm0Bf5D8xEbNiDybfOLlDocwokeKTJdE3XJP7
         fr0Xf6oWmjhoST8ZJc46Vk1dhryzZxiXn36Ueul0IfnRkYXa+UtbPpsCxfHAwNLj8dY+
         K32gDCLsxYna3+tXLgICyX8z4GEwLRNVDYOQMGrIN+ESpM8Mz832vPQy01LEN7Z2bFKu
         58xb8GiqGJAy7xdNaUqvfCER1wobOfAjkovlShmf9AG9kPddXCxpac+o4+QcyzS3TtBB
         MRK52hder2EPMOJBLIrAzSBx/i+fhSOAmKgfaYP+UNCvTRykxdMAcgO3ft4UCkjJBWDM
         oy6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781095716; x=1781700516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z9BiimjFi0aXMRD8saAolcJy9dKWyzjah+ENtioga50=;
        b=pB5EkLwf5ggzh5jQqtWBxBU0/3f/fUWyHTj60QJxc8zRx88IST8BZFs6j9pKliWwJ6
         viXsYCo6MREeCrkTsXvAlto/cIeh0cZ12FO9IADLnctLR/osS5JA7TvQx2pIBo/fc2sR
         hN/V5INhxc30a4EQljj1fRoxSwHOF/zDTOeRzXogAzESQvs/XlgWHUWiTSSDu4YliM2C
         P9CwXsy6QAN2t6dSMSdN0+Tul2/opFbL4i2P7gdRPs+JttBiV5+ugZGeL2mGX0+42OdR
         4C/zWO2aLRAV5ijG9P9KzCkChafdhCiVzZvHsCzAcLTWsrD/cuk+5zHWIn8QoCDO7NqB
         +nAg==
X-Gm-Message-State: AOJu0YyGT2r3zPgd4neBlmK4xEhl8nThN4Psnekk2AN5xFxYmtAO6RjJ
	2ZmMnQqYB5YsH8bPvPdb0Qd/Kq5OElzrDgGhYNBogxSPd4yjosGsGhnd
X-Gm-Gg: Acq92OEU4sFZVqzUeMe97z++9qbYzZ+VGi2LvTvV5u+Mjyqu48n4RS9vQ15WLDxvhCK
	SGNT1C49GewVnUIOGZreMWU1bEVm8vU0HC8xd2UTCFGNPEQwBJdysxj4aO7s5l/oR36ymgEvwhs
	lPgipi5axAMRo+fDfl98ljyy+lwL9WtWq2Mp2AaqPpbJqVvy9mEIMcb+FjV8tC/YZL/fOgpdsVf
	0ska7QGuMVdyzxBcI3X4G89LKSUIflT0BcByVboBF9HxxQpBCnNezqmH0/ULgek2Pc2d9//+R+Z
	Qqu5vacYH0k7BWriLoDJ97NDe3Ez6J3cNvw7+qTQp5K5e5oBBSsyeo2SE488TB6bGQ7BtvqJTvF
	zu6JKyV4u7/OnK2WADZhjubaaxXkHvpCDYUE99ztKnyZ0WSOHDAX8gwd39yXBrGUmmuYelFf/9m
	4smqBY+ahtPBBIF/mQ0yJe+0YqObr93af6bqClDHc+WNsb2coH7zKXQWjZNB8QC6Vf1NZ5T0ec
X-Received: by 2002:a17:90b:1350:b0:366:4782:1379 with SMTP id 98e67ed59e1d1-370f0f459d1mr26153514a91.24.1781095716002;
        Wed, 10 Jun 2026 05:48:36 -0700 (PDT)
Received: from localhost.localdomain ([171.76.83.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37624b83589sm3783554a91.16.2026.06.10.05.48.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 10 Jun 2026 05:48:35 -0700 (PDT)
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
Subject: [PATCH v3 RESEND 10/10] KVM: PPC: selftests: Replace u64 gpa, u64 gva|vaddr with gpa_t and gva_t
Date: Wed, 10 Jun 2026 18:17:26 +0530
Message-ID: <2acdd4984130cc5b66ab6cdbdb8bdfee193838c2.1781093720.git.ritesh.list@gmail.com>
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

commit df079910f9814 ("KVM: selftests: Replace "u64 gpa" with "gpa_t" throughout")
commit 014dfb7b9bf3f ("KVM: selftests: Replace "vaddr" with "gva" throughout")

Similar to above 2 commits, this patch makes the relevant changes to
powerpc kvm selftests code to make use of gpa_t and gva_t types instead
of u64 throughout the code.

No functional change intended.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 .../selftests/kvm/include/powerpc/processor.h |  3 ++-
 .../selftests/kvm/lib/powerpc/processor.c     | 20 +++++++++----------
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/powerpc/processor.h b/tools/testing/selftests/kvm/include/powerpc/processor.h
index 95ec3debc83c..f0ee21a8e2d4 100644
--- a/tools/testing/selftests/kvm/include/powerpc/processor.h
+++ b/tools/testing/selftests/kvm/include/powerpc/processor.h
@@ -7,6 +7,7 @@
 
 #include <linux/compiler.h>
 #include "ppc_asm.h"
+#include "kvm_util_types.h"
 
 extern unsigned char __interrupts_start[];
 extern unsigned char __interrupts_end[];
@@ -24,7 +25,7 @@ struct ex_regs {
 	u64	xer;
 	u32	cr;
 	u32	trap;
-	u64	vaddr; /* vaddr of this struct */
+	gva_t	gva; /* gva of this struct */
 };
 
 void vm_install_exception_handler(struct kvm_vm *vm, int vector,
diff --git a/tools/testing/selftests/kvm/lib/powerpc/processor.c b/tools/testing/selftests/kvm/lib/powerpc/processor.c
index 2c1e95c8aa9c..009a0859ba05 100644
--- a/tools/testing/selftests/kvm/lib/powerpc/processor.c
+++ b/tools/testing/selftests/kvm/lib/powerpc/processor.c
@@ -97,17 +97,17 @@ static u64 pt_entry_coverage(struct kvm_vm *vm, int level)
 	return size;
 }
 
-static int pt_idx(struct kvm_vm *vm, u64 vaddr, int level, u64 *nls)
+static int pt_idx(struct kvm_vm *vm, gva_t gva, int level, u64 *nls)
 {
 	switch (level) {
 	case 1:
 		if (nls)
 			*nls = 0x9;
-		return (vaddr >> 39) & 0x1fff;
+		return (gva >> 39) & 0x1fff;
 	case 2:
 		if (nls)
 			*nls = 0x9;
-		return (vaddr >> 30) & 0x1ff;
+		return (gva >> 30) & 0x1ff;
 	case 3:
 		if (vm->mode == VM_MODE_P52V52_4K) {
 			if (nls)
@@ -116,12 +116,12 @@ static int pt_idx(struct kvm_vm *vm, u64 vaddr, int level, u64 *nls)
 			if (nls)
 				*nls = 0x5;
 		}
-		return (vaddr >> 21) & 0x1ff;
+		return (gva >> 21) & 0x1ff;
 	case 4:
 		if (vm->mode == VM_MODE_P52V52_4K)
-			return (vaddr >> 12) & 0x1ff;
+			return (gva >> 12) & 0x1ff;
 		else /* vm->mode == VM_MODE_P52V52_64K */
-			return (vaddr >> 16) & 0x1f;
+			return (gva >> 16) & 0x1f;
 	default:
 		TEST_ASSERT(false, "Invalid page table level %d\n", level);
 		return 0;
@@ -129,9 +129,9 @@ static int pt_idx(struct kvm_vm *vm, u64 vaddr, int level, u64 *nls)
 }
 
 static u64 *virt_get_pte(struct kvm_vm *vm, gpa_t pt,
-			  u64 vaddr, int level, u64 *nls)
+			  gva_t gva, int level, u64 *nls)
 {
-	int idx = pt_idx(vm, vaddr, level, nls);
+	int idx = pt_idx(vm, gva, level, nls);
 	u64 *ptep = addr_gpa2hva(vm, pt + idx * 8);
 
 	return ptep;
@@ -189,7 +189,7 @@ static gpa_t __vm_alloc_pt(struct kvm_vm *vm, u64 pt_shift)
 	return pt;
 }
 
-void virt_arch_pg_map(struct kvm_vm *vm, u64 gva, u64 gpa)
+void virt_arch_pg_map(struct kvm_vm *vm, gva_t gva, gpa_t gpa)
 {
 	gpa_t pt = vm->mmu.pgd;
 	u64 *ptep, pte;
@@ -331,7 +331,7 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, u32 vcpu_id)
 				       MEM_REGION_DATA);
 	ex_regs_paddr = addr_gva2gpa(vm, ex_regs_vaddr);
 	ex_regs = addr_gpa2hva(vm, ex_regs_paddr);
-	ex_regs->vaddr = ex_regs_vaddr;
+	ex_regs->gva = ex_regs_vaddr;
 
 	vcpu = __vm_vcpu_add(vm, vcpu_id);
 
-- 
2.50.1 (Apple Git-155)


