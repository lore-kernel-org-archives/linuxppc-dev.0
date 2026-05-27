Return-Path: <linuxppc-dev+bounces-21588-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E93ECD5BD5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2026 12:52:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQTxz3lFxz3cQ7;
	Wed, 27 May 2026 22:51:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::630"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779886263;
	cv=none; b=GiZxy00DtQWBhV38E2f4t0eMgu5fN/+dU8JTEk98c+he1Vqv8EXL3c1yFp+ww3k457Psaix7D5G7lnLBIddvDLJ4Jupxd3TRHDT2P2Ey/airyWeOuEfPI1iIjUdTAVUuvZqaKqEmU4EuWDtHzf9gAVkKm9+npEEOL+LXRMhpTR/B8E3Xya0lhs1zaGUhNDjzk40pkoRXgWJMjRtKsTJ+/pu2Fg9d6ngdatBdSI5i/ZdEUCao4iwawBTBM+HNTPv3YA6Wyf4uxzfsWO/liaRHNz+Eq46VbgQyNbpi73bmXGVr7xwDxnI+ITHrfC6t9POOd0Q0jgfl/J8U/AVQ2TQgXg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779886263; c=relaxed/relaxed;
	bh=H/w1Ny+GkWjJd36xIuiCWajcu8GK6fBsl49miGPD7vg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D1CJeUnOz+UN1LZBIw9zECAXD/nrz3qdJWz4gyY26qEoQ1xriGJYBbAAbWBKPavUwrB3bx2xXPENoUCMxszFXSIHsVxSMuoFX1msLCmx6l297jhxPlaR69eJvPqmYKR3sER4Z7IreD5/gUHNzWSTzjmEWtlZxuUVM0MYaREaPRwVPBxZMI91gXl4WkvQpB7PkJycYYek5hWFPdlY5Hp4iutVqwjiFvy/HVQdBUXjL63GYeBWNRibV9WhmjZSY2yuLiy0vDKJO8mn6n+SvKyjZ+DisGcmNLKcPqXMRIv3Xz4sSORW4ZywY/xUbIcAO1dTtyI/+kpCDpilaDRXuLVfFg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jXUxNCpd; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jXUxNCpd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQTxy6T2Nz3cPt
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 22:51:02 +1000 (AEST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-2ba3e3c4f87so121207805ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 05:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779886261; x=1780491061; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/w1Ny+GkWjJd36xIuiCWajcu8GK6fBsl49miGPD7vg=;
        b=jXUxNCpd0qdrojuwYPQ56m/vsLKR+3QUx99At9ENtP1BcM7FpFuljLl8I/7W9vWx+H
         G81itYGl28zhNaDxIz8uRC/MbExd8GGvL9kNxWItgDMAlIlg24onAmQW5eJHj72TMO1P
         +4qBGc8zwZsSTcU5uO/Uq+PSkwQjQPrNHLEA3gKUK9FfUx/ZYBDqSjtOSJ/75FwxZjjS
         gYTgxpVYOy1NelvfsybknraVvSoyjUelu/+cgxrOd4QX0AwgkbleIQXQNZ740Y312k70
         Wx3TwUhzDva2resbTsfgQh9tUJSKgw+7cmvCcRmBLJvJnrHR9PUp7J5mKWg/hymdVl0n
         ZMLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779886261; x=1780491061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H/w1Ny+GkWjJd36xIuiCWajcu8GK6fBsl49miGPD7vg=;
        b=ATn6XvCgSEvCk2F3OujnM0t23Tvy93sEBDEtsW4SJsB+9Xn58RdMUecVP+rf0dkX8/
         cwiIx2HsHXGfn/zfN/UI46QRTd74Hm3kYl9st+Zrizq5PyqRqszFLS8nF9D8DrGrm/nP
         JmAzRdamBROwdENgrERIjn28lGJ5RghMzxPFFMexZQNb04634Bucjv+cnC7LNC0zyExJ
         vboL5cM41jpVksK+wskjP4QVwHxXcackYwOqWFAcsIGV2XNhFTZLdrk3LPnG1k5WtU8i
         /qeBfj7t1cpIpaNHJCEI1f2Nf22InW5IGwdjIT/LPUeAAJEuATqq+e0PevhzLVomI5q6
         0XuA==
X-Gm-Message-State: AOJu0YybcB2+b8tLN6f151pxBiGZZY27Q6kkwUO8rRSU/7OEedKgawL/
	e7A3KyjvrHyxG14GM6WOlVuc4SNkg7F7rstQrtmchkEFKNlvN6ZU/I89
X-Gm-Gg: Acq92OGL7UNBc5QJpb8vijqIT6UwVik4SqExA8OdSXACPuJrTeP7+Xv2iSrsgLXBU4v
	5Aq+rlBJLv4nEeaL5+H2eSaE+00bOE0KWpe/UctfGH8kAJt5bE6ZH9iRLAndfvHnn70G0WWFHGi
	LOJ4BnsaAfc4CNqGmD8qpbLvShzGB6MMuxT/KyrmoZzGeBkQJjE7VR/WAp3dSPorCHMkBTH1kw/
	2OECogMmJXUv/afiMCoMYTpmAc2IwXWjgA5FZEon37OizQU9PCUftdvHAJoOaOBzSNA947b6p4B
	gdT3aLi+1dT46bO3LoGFVt2H4a/1ahvs9hpgg3ItejbKiFwrziwpHCfqixXjc6npdhnB64jTRix
	hLm8lLxNnDleCvuNWJIZSLZRWckcAwmEvdeHRLTncSlTADeipbfzx0cew5Xf1ZzF71NSn3U3esv
	+1aINtCY1aTygWDP+zKeX0Q4o8r0WBw0cUK6j/C78=
X-Received: by 2002:a17:903:2f4f:b0:2b4:5f69:715d with SMTP id d9443c01a7336-2beb05d9d8emr260493225ad.25.1779886261058;
        Wed, 27 May 2026 05:51:01 -0700 (PDT)
Received: from Mac.ibm.com ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58c69a0sm151851185ad.59.2026.05.27.05.50.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 27 May 2026 05:51:00 -0700 (PDT)
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
Subject: [RFC v3 10/10] KVM: PPC: selftests: Replace u64 gpa, u64 gva|vaddr with gpa_t and gva_t
Date: Wed, 27 May 2026 18:19:59 +0530
Message-ID: <bfac43765a97ea184a1bc7e7ab51e322b41401a2.1779885589.git.ritesh.list@gmail.com>
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
2.39.5


