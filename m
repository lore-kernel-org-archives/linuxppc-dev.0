Return-Path: <linuxppc-dev+bounces-22400-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A9D7CD8CB2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jun 2026 12:47:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gb5Cl25pMz3bqM;
	Wed, 10 Jun 2026 22:47:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1031"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781095667;
	cv=none; b=DcPuq/CfFq+kB6gSWW9lAG7K6JX8tQ1QvkWcCBDDD2RfCLCxhVAOsHBy2y10YC2m8VRYLmYzLiSqGNQtcHZDzjzqThUR+QTlvOfYfI0bVQYVdSqq4kObqec3ys4j2+aPowAYyjb3MNkYMXueKddLJuHXjsBJQlJpX1FL/Zjsp8i4/CsZhD2bIh1jszyJB9RKR5KnNS+0IAwsAYXq+6s/9qycAUeOmiQVEguaUPREnaqD3xAphankN5U+6h7vKj9jz+JesQznTS2X+c0Qjz4ewPBoiHWG7Le+pXNQg7OdrxtRjrJkiHN1dbbRmmMpL9HKLZFXpg0pE+cw6hYu3svE0A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781095667; c=relaxed/relaxed;
	bh=t1g5wHVLikCWLgdTTQWpgtkBPvcVl9HkkR1GjckPL4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cfUexZR3Dcdd0JZYpfNH5vhCioUh4FP8NzSvK0nPakwkjDkjgZx5fI2PD7Bq2Eeak4clEGIsF8jE/ZQl43mIsOJ/WWhpipL+oJXZDiLqbRB5iUZY4PrniZuevGwllBP6DUTyel66K3lsof0shJEncG+OByJXAeKgGUe+APlv7266shUg4tQrrUxoQseDaURdj5js9LaeLe6y91/J1CaAn/zmgxtUUQD1EZUrmvLVlpfyIovcKw/naJ2C/jocU3bALdw8CB2Y91/WJsWve8Wt7tTB5wHjeNfZ9vNlwgAd3FhEQcb4V8IuPixcgYl6q9wddPgJypkUC/rIm2rqKIsNhQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VNzsMMAc; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VNzsMMAc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gb5Cj70Dzz2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 22:47:45 +1000 (AEST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-36bb3551f6eso5938487a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 05:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781095664; x=1781700464; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t1g5wHVLikCWLgdTTQWpgtkBPvcVl9HkkR1GjckPL4Q=;
        b=VNzsMMAcZDh8O2BLTVSc0LcPG75MlUXAdh/YpBfDfs2JXSRGperOAvdURacCca0vJ/
         GGlWhoQVGA9N7gpt/w1eQgFQBHC58sDElZoIXHx7FsFr+gxdv1lGHqgoDgsITL/KJohY
         zhg4IGa5NvJjl2e2sWLoQDfYojL6zTnSikbhUMvxZTgncRKYGeE1JzHdmj02rM4PWqRy
         UhDm+UIBCFTmF/qRlgkUJPDsizVwL/TQ4kr8+y5yRJ6am36+yTtxTIHaT+ImlC0BXOIi
         AvLsYunLXX9tj/J+eoKl0EC64t+kiiHbQ+Hn0Pe+T4caIcZyCODP4ihzN+JPfPLjqMu/
         vskw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781095664; x=1781700464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t1g5wHVLikCWLgdTTQWpgtkBPvcVl9HkkR1GjckPL4Q=;
        b=NhPfcMSOT5qFxfBFggp8mKL/fnGzLAH85Uzj0RxhcnIhz9sEWDkpI1stB0hm8NN+y3
         yHsw1adBqSZ4KkX4YR3pVvDeVZTByNqQgP2oofnvWwgmdoKe/LlJgOSrSTe0ekCviGqH
         oApdszTe2pfeQXfP5B0PWVCme5h/11LYdOt3O+Not272KStFru91hNj92R8UtuXgkcJL
         OldGZZoDMIjoK2Fh7ag9x53QshByddUvzCkVQtk4cvweAh/qapq0UYgcyUlCFFK0zWpR
         x73ceongpMtumgR78pye3BFrtgVV6IGWQ1qCjmhpd356IcWZLh2zv8r6a1YrM+QhQNOu
         Xr1A==
X-Gm-Message-State: AOJu0YzpKctM36/bw99jzt/CiLehxNhkW0Eg6V0CGjMO+r4K4/c+M8Ja
	LOHIJCBHrNKpaAUF2fQcRxxyTQqCMzJYEfTwe9vFMfQmy1O4GQF7rnPz
X-Gm-Gg: Acq92OGxeOSEoAmqpZtFuaO88mIWm2DnF8C4ExpvOABeqci6XOD9Z29hOi8OlvDxGly
	ynZogSNYCBHZyN66nN+WFvF79qU2Iv7okr7dYeYy7l7QhXdY+r1ipNjJ0a4HBl2LM6nrh85BezA
	w7fPC0/OVJMBu1ZR/Nw9EXhtU6Nw5SPTp+xy57d3vCuvYSAro5o6B5tA1yTWEGmBRfpYBqDeg/u
	+ehqwg8jWK/7RQ1QUEh5pkwI3XEByxZ/PKoCW4BNIuk23bGPBY07S1dPjlix+mVrcQzwxaZPlH0
	U1IsLCx/vnfvZzBXhm5pkR5w0bSBi9qu0HjBWUhPe3xzBK57RCkjkaPjx9Qp0AoMKQU0+CL2z/E
	vii8msuKZPFxj7lSV0EkCTyOx0OKtcbYoSTxdaFKj5gwo8TtiGIsaBAkQdFYkaKHz0eOWfjD5mR
	a+UpGPUUb08BZ8l96dwZma0aphjpQLwrCoAk3labxZc3n3WIcVEyc5q48OdXWKNg==
X-Received: by 2002:a17:90b:3d44:b0:368:7c0f:ebf7 with SMTP id 98e67ed59e1d1-370f0095b8amr26453338a91.16.1781095663927;
        Wed, 10 Jun 2026 05:47:43 -0700 (PDT)
Received: from localhost.localdomain ([171.76.83.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37624b83589sm3783554a91.16.2026.06.10.05.47.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 10 Jun 2026 05:47:43 -0700 (PDT)
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
	Nicholas Piggin <npiggin@gmail.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v3 RESEND 01/10] KVM: selftests: Move pgd_created check into virt_pgd_alloc
Date: Wed, 10 Jun 2026 18:17:17 +0530
Message-ID: <ece1d2a3bdfa13666b608ce3d65cc166dd7a08e7.1781093720.git.ritesh.list@gmail.com>
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
2.50.1 (Apple Git-155)


