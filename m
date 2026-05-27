Return-Path: <linuxppc-dev+bounces-21580-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF3BECD5BD5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2026 12:50:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQTxG5lSMz2ysb;
	Wed, 27 May 2026 22:50:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779886226;
	cv=none; b=KWCLD02dSMu1Y+ax3mxwxta6e08tpPno8pLD0NWlNh218CbSYDLrxjpbqYiFsAYN524nChuMxEkEmqA7lichOxoc9J5/di3MlF4x1JuCxeMY2thr/1u9DIg6d30/kiXiOAxIlxdDiLd0pTBRAC3GRttbb8CdEfID2lnpc6cAnWmqSNxs244mh/JBZrMlfezPlLiG7jPNNSEoGrJDdc7Z+y97mO6pr+iMaEPnFbqCWqnds4cJJhwtHA/cdV1ud7gSawX2G9QvHTlinNRLfcnS5zlfTSianLhO+ZZnPC7OpEejoqKnr//c+X3Wt7nUIuDjWPlJI33ykb8dkNAugudAMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779886226; c=relaxed/relaxed;
	bh=5yVGhyRSYo0EGvj1O2Xj5DkH81nOVKSw16RhmJnLg/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iJ7It84rjMKfoy/MtxS31PtryfQWSBM0RWrld7uvksIsjQo7u0dbC8TTkxdKQa3/3Qqc0hkA7Vgs1J84Pa5ETGdbtr62IxboO7QkH57HgOGTifEvFCQwCICcnJ28SguKfhKlbk0WC18br2RIb2rBmGcOU5+9eq6PueWnumYA7QY/FVq//urVzvEhkT0KzucPxoS8fjPj/C327rwDYEf+C9qVnHtLf4R1v6Uv28wPEtlJNpah3GMOFRbtxyTHw2hzvkW/1H2y1tQ7Zn9jxGeBC496VX7YcoIH1ADD6d5L6zsqe/jph330lpx0BAnY8S5PJaQkpqkuFwq/c9AhYMwoSw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YNbBWQ3g; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YNbBWQ3g;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQTxD4FD6z2yn2
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 22:50:24 +1000 (AEST)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-3697c35eab7so7098411a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 05:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779886223; x=1780491023; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5yVGhyRSYo0EGvj1O2Xj5DkH81nOVKSw16RhmJnLg/M=;
        b=YNbBWQ3gIS+R3Py02XKLknSWrnKxEUvXDMOAk6mRWt7dL2wNCQT+MlkHgoEp2f8N/v
         6AsYPWWei7x98/9WQnXEDMSEMSeO1E9AXoa3JBcHDG/wVKYIQfiYVAGYHv7twq+4Eu+a
         eHfACbM/etkEll7NoV399yr8+H4g9IXAfZLsdm/5GIZUCbQTYS9KvQb7aet3ww2I7KUc
         KeJK1XTh+5q4OR/V/T0mXzanHc7iFbieq3hsgSwk7xrC6ZE0ynhiNHGAFUDay+0RZH2Y
         8m6JuB3KAJCeRUH6Tg8wpTpwT2iTMjic/TLqME91QsN0SfxaM7ZIvfDFmMm2swYtuzaj
         ra9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779886223; x=1780491023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5yVGhyRSYo0EGvj1O2Xj5DkH81nOVKSw16RhmJnLg/M=;
        b=hn7CKwoXDCGevAJgA26fE4CNy7BL1Og3L5XhRGnw5l/CdWtEKfESS+/yUljMyGLR5q
         EMtPBU2VW9nrmgyq5dxnJqjKsuV25YGw4gkdpxoglWJuFgtKQjYc2QASQiOmojwFJ9B+
         MD7n8f3f94dnK6UzNwzfTwGq1uNeGtzVT3EMdm9t8zAZvxqK0iJSSGkfCYQQ3B2UXDf6
         qCNVfWkp9SoJm6ACF1cw9Qv3mfft/Bu7uK419jKTp/MCMJIhm+FgAJX5/E2zZPZ5oU+y
         /BmEu9Pwg02VuOR0JQJ3nScZLtT7MicYYrBfXuSJRnyYJDd/y8+mOYq+80tNR2sg+8hY
         6cbQ==
X-Gm-Message-State: AOJu0YwyHRKbQ3JFeC4CIC3zWhUaTWBezn22rVylW125dZIEcVNNr/k0
	uYLlDeoQn1oMLdftS8/0ISYYa0yWw2vCbTmE7IfTdexMF0H4p/Er+YBM
X-Gm-Gg: Acq92OGoxcgbT2Mp1qq70LZc1U+3Iap+YL9YNlynceL+Q6aG8HXy7GjLuEbLXQED8PE
	VTvTTc3Q0Vks9vUi0PaoMJvZoCEKAd9ORr3b0VXEhCjBJwIco2h5anfSCz8IlOBJ3/AkG7xWa3+
	+bF3FP95j5PA0+IpviGa4iPFj/Vgo+hRkDbLQnPg6yHc/Et5maFHFfJgnlntgcX5PF0Ur07vBzN
	iLQbNvvnn6tf7KlVOYfdUBELbIYeLk/wMSDxM//JQRucOxDRvJGNvyaNLEycRIkfbgLeXXQe0eT
	xqQPpdqLKc8H7FMbK+Swi2JxXhmrWzgS3YlLUjrLm/TvZULaz4QT5xjO2SjCJqj/E9j8Y/xaeNl
	MkMy3onwp6EqleXKd5f9QW1UkZSJHxCtSav8V9PWx6fgDs6C3y5stKxb8K0ZZqidLocDRSzC0DV
	ToStpbcfe04zmzneCY24QQfw2vuJhqPycgjzchtJPkBPqYjwluRw==
X-Received: by 2002:a17:903:11c6:b0:2bd:3bfd:7512 with SMTP id d9443c01a7336-2beb065b6edmr251222955ad.29.1779886222267;
        Wed, 27 May 2026 05:50:22 -0700 (PDT)
Received: from Mac.ibm.com ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58c69a0sm151851185ad.59.2026.05.27.05.50.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 27 May 2026 05:50:21 -0700 (PDT)
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
Subject: [RFC v3 02/10] KVM: selftests: Add aligned guest physical page allocator
Date: Wed, 27 May 2026 18:19:51 +0530
Message-ID: <e9fdbd834a05cbf1113080bb73b36cc1d9766f4a.1779885589.git.ritesh.list@gmail.com>
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
2.39.5


