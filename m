Return-Path: <linuxppc-dev+bounces-22401-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AEC3CD8CB9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jun 2026 12:47:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gb5Cr29P2z2yfD;
	Wed, 10 Jun 2026 22:47:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781095672;
	cv=none; b=Zq+qAK+ls9gEeCHLPJFfp/5JCDT50iPEsDw5+u5bCEKzWwm1LlNmpKL2TQ5TX1IBRg0F0pqWHWf2SnuiJ+1YGefPB4L4EosGaP6T7H8VFajgGwGxgMTAcrAOUypYaeauxYU3P0bEIKjO7bbcQdItuM2+1MOyeTY9SfmrmhG5QpVJ1XROAkLgnvVBi81qstnafRxQwvHJjd0ZAXc2uUtzHiYFEUVWvF1NPfPQ/IeGowBaSyejjsUZMnIyxjk8HxtM8EZHj+8OfCWoXNH+SMMxCGcoRVR0Qmhg4W/etT9r8PRP7LBr6l6yuQuSXGk6T/sQE4p/eNrCiAG7JwnSOSjXwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781095672; c=relaxed/relaxed;
	bh=k0vOlqOnh5jkFuU9tmOA1F8NP87zeNaswUFOalPtmFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lr4qyQlEpwX3OtS4bSTr0HYJ8R5dFsS0CGadoYuVoh9/n7SymZAwPr/+MiX4HRdKJ735el+Y0txXvjZ5w0s6LTha3wyMhYFdPR+K9UZVwu7AZ+eBqgxJ7SbyFE5VUB+kC0PMn6VNNKhQI5v6BbmaarE6DAh96nmyYzbzZ/+NSg731Vu6Svpjj/mL2N2nwsI5pmMQO0Um4RHA4ZGNl4OzWVYMcX6NbG+QZ6wrBZgsY791MtaPcQHSUIImVXsHh6/VokgYxOorRVoT4a+Tg/oml3vFyTnMkvjmtipJQBoa5xhPtik5wspJWePquHcqiM8pXZ1pO7ZbNho2bPaYZNlyZA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JHcrqEsP; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JHcrqEsP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gb5Cq44cMz2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 22:47:51 +1000 (AEST)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-36d98c9b596so4226951a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 05:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781095670; x=1781700470; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k0vOlqOnh5jkFuU9tmOA1F8NP87zeNaswUFOalPtmFY=;
        b=JHcrqEsPPCOlSj5/nWA4hiQYGuvobKAW0f/Nr8lSBn7QuePpZysLRn58aPfMUItWQ1
         js32+rEGCGpUg8jombG8tkJth/23rJY0/KcBOikatcyLrI/vTzzC8DGm/76ujjGu1YLS
         b32qKiex5kw2JoX1hStC8kIuExDcFSZCdb8ICbku1rTDiLjDR72qnR9HrBCI11C/3iwl
         VTTujb9/UL6T6Hrdcmy9wIM1HhFJd0en9nbg90FNkjnt7j6ZUlYsN7EADLdPtW102o5B
         ySgqmsBIDdF2Dt7jwc1EyM9LS+TeE1Ch8nt1ENFG0uB2plyLkeVI6zCU2cpxBC4jGx3X
         EHvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781095670; x=1781700470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k0vOlqOnh5jkFuU9tmOA1F8NP87zeNaswUFOalPtmFY=;
        b=Sphk0teUBxDoYN6/neVNdip4dIe8CkYX1ECIwICYKZcdp6fI7/gM+23w5AiJxR5KTe
         oinr1NXIUd02SEMJca3ZZu97Nub4Zv+nDi8dOHtXwVa+DVmcjw6sxC0b5qeoJjdWf7l/
         Kpnz3MBazbI2zTmTu7zJcKcyWV5mU5tnmmzZuHx1nK48U0R+LdabcNrkctItRYtoQjrw
         2uJF6Elt4KeCR5f2MXNNHyCyfuycNSX30DIFZMIkRvzu3+Bjhv3AFnuUlXE3xa7Wp32g
         uQmmjAygm4+rs2kftNBCsDZj4nkK5QKGQhbKCT/yv/nr0AmAy4+7ff98Dl6duS5fSwX4
         BWwg==
X-Gm-Message-State: AOJu0YynXrvpygZcEqnq41LR9BgkZ01oCU7G9yrZQlTDeb8Y+zPiPHEA
	gv9ZesT/gPvDjonTkx9YOHRSq6+vW/o48AslLbwrQyBBavB+P3FzVNr7
X-Gm-Gg: Acq92OFa2sMR6VP2pLf+d7VAjyP5TL5zPj9AAPrNk6jluPCJukV2OQDI0OW31MPrsOH
	s0xJX+t1WAJw19xIe05Hi6oJIsMkPu4fpJcA2kvl9RFc7rnQOFXvVfhC+rtf8AKiz7R2b/Az+qV
	iNWlTJAnVkYKQpPkQ139CZNoI5bbQrhLuy09F0Wl+SXmyJUcxa5wm0bAgi+TwGO5v7hz3i9dbys
	H0/PCDMTBkbLQX4L5MgLFAmfTEsezLdPkHxVQ84bo8kQO7yGuiVJ8X+L5XfgSBZCSjCx7eLWNUW
	z9vdMWTV44sc+8Cr7wh1lEgfu2VTXj3U7Ecn8R6xgsGjm2wUnZZVdlcmZ2skNd8bFb0VrtLPEOp
	cludBFDMBR+IyoeaFjh4zxE5pfqs29391udy4dsfgbSJKJ4CdcEx5Kby63O7+c95RmqwCKOaCJe
	359ykCJb2E8hXs7xTq1fRnmj1rx48xVhmXBZQCJVtl9SievRfbQUJS/KdWDblYHg==
X-Received: by 2002:a17:90b:2f85:b0:368:147f:bd2b with SMTP id 98e67ed59e1d1-370f0e488f3mr28109280a91.23.1781095669630;
        Wed, 10 Jun 2026 05:47:49 -0700 (PDT)
Received: from localhost.localdomain ([171.76.83.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37624b83589sm3783554a91.16.2026.06.10.05.47.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 10 Jun 2026 05:47:48 -0700 (PDT)
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
Subject: [PATCH v3 RESEND 02/10] KVM: selftests: Add aligned guest physical page allocator
Date: Wed, 10 Jun 2026 18:17:18 +0530
Message-ID: <df86b5ccdbdafc3509d9538bd5e6796737bab2db.1781093720.git.ritesh.list@gmail.com>
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

powerpc will require this to allocate MMU tables in guest memory that
are larger than guest base page size.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
[Rebased to latest mainline tree]
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 .../testing/selftests/kvm/include/kvm_util.h  | 20 +++++++++--
 tools/testing/selftests/kvm/lib/kvm_util.c    | 33 +++++++++----------
 2 files changed, 33 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 3666a8530f31..c515c918c2c9 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -991,8 +991,8 @@ void kvm_gsi_routing_write(struct kvm_vm *vm, struct kvm_irq_routing *routing);
 const char *exit_reason_str(unsigned int exit_reason);
 
 gpa_t vm_phy_page_alloc(struct kvm_vm *vm, gpa_t min_gpa, u32 memslot);
-gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t num, gpa_t min_gpa,
-			   u32 memslot, bool protected);
+gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t num, size_t align,
+			   gpa_t min_gpa, u32 memslot, bool protected);
 gpa_t vm_alloc_page_table(struct kvm_vm *vm);
 
 static inline gpa_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
@@ -1003,10 +1003,24 @@ static inline gpa_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
 	 * protected memory, as the majority of memory for such VMs is
 	 * protected, i.e. using shared memory is effectively opt-in.
 	 */
-	return __vm_phy_pages_alloc(vm, num, min_gpa, memslot,
+	return __vm_phy_pages_alloc(vm, num, 1, min_gpa, memslot,
 				    vm_arch_has_protected_memory(vm));
 }
 
+static inline gpa_t vm_phy_pages_alloc_align(struct kvm_vm *vm, size_t num,
+					     size_t align, gpa_t min_gpa,
+					     u32 memslot)
+{
+	/*
+	 * By default, allocate memory as protected for VMs that support
+	 * protected memory, as the majority of memory for such VMs is
+	 * protected, i.e. using shared memory is effectively opt-in.
+	 */
+	return __vm_phy_pages_alloc(vm, num, align, min_gpa, memslot,
+				    vm_arch_has_protected_memory(vm));
+}
+
+
 /*
  * ____vm_create() does KVM_CREATE_VM and little else.  __vm_create() also
  * loads the test binary into guest memory and creates an IRQ chip (x86 only).
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index e08967ef7b7b..ac7215824203 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1442,7 +1442,7 @@ static gva_t ____vm_alloc(struct kvm_vm *vm, size_t sz, gva_t min_gva,
 	u64 pages = (sz >> vm->page_shift) + ((sz % vm->page_size) != 0);
 
 	virt_pgd_alloc(vm);
-	gpa_t gpa = __vm_phy_pages_alloc(vm, pages,
+	gpa_t gpa = __vm_phy_pages_alloc(vm, pages, 1,
 					   KVM_UTIL_MIN_PFN * vm->page_size,
 					   vm->memslots[type], protected);
 
@@ -2021,7 +2021,7 @@ const char *exit_reason_str(unsigned int exit_reason)
  * and their base address is returned. A TEST_ASSERT failure occurs if
  * not enough pages are available at or above min_gpa.
  */
-gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
+gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t num, size_t align,
 			   gpa_t min_gpa, u32 memslot,
 			   bool protected)
 {
@@ -2039,23 +2039,22 @@ gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
 	TEST_ASSERT(!protected || region->protected_phy_pages,
 		    "Region doesn't support protected memory");
 
-	base = pg = min_gpa >> vm->page_shift;
-	do {
-		for (; pg < base + num; ++pg) {
-			if (!sparsebit_is_set(region->unused_phy_pages, pg)) {
-				base = pg = sparsebit_next_set(region->unused_phy_pages, pg);
-				break;
+	base = min_gpa >> vm->page_shift;
+again:
+	base = (base + align - 1) & ~(align - 1);
+	for (pg = base; pg < base + num; ++pg) {
+		if (!sparsebit_is_set(region->unused_phy_pages, pg)) {
+			base = sparsebit_next_set(region->unused_phy_pages, pg);
+			if (!base) {
+				fprintf(stderr, "No guest physical page available, "
+					"min_gpa: 0x%lx page_size: 0x%x memslot: %u\n",
+					min_gpa, vm->page_size, memslot);
+				fputs("---- vm dump ----\n", stderr);
+				vm_dump(stderr, vm, 2);
+				abort();
 			}
+			goto again;
 		}
-	} while (pg && pg != base + num);
-
-	if (pg == 0) {
-		fprintf(stderr, "No guest physical page available, "
-			"min_gpa: 0x%lx page_size: 0x%x memslot: %u\n",
-			min_gpa, vm->page_size, memslot);
-		fputs("---- vm dump ----\n", stderr);
-		vm_dump(stderr, vm, 2);
-		abort();
 	}
 
 	for (pg = base; pg < base + num; ++pg) {
-- 
2.50.1 (Apple Git-155)


