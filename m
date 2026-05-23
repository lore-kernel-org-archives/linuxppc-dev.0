Return-Path: <linuxppc-dev+bounces-21427-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3537ACD5BAC
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 May 2026 11:15:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gN0130JMWz2y81;
	Sat, 23 May 2026 21:15:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::434"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779534903;
	cv=none; b=Hn5ek8kS+v9nZq6jXNHstPiSy1CghX6KSX8qcglLYDBvvoNJS1DKegNevBq8FlM2WLY2UF0LgGGjF1uIu25i25j6dlStBZHEADfcNhpaGILBtSkn43dvt9nWj8H+oMD4WoeH9HbA85UEgff3R45i1aV9bTYKsvdKiMveMgbxad6Mwh19UCZpXzMe6E9DM3RHmEABuZwDhuGmUfQ8tK1ZyaivtfT6QDW6ouhc0kih5KBp+YGv4a/jB/VbuQHDTm/AHhf8YUhdEhp6dq7i+hrfJyI2spfRzqBHd1P1oDrUaHcM6Amo8encAktftjWNKcZDnrqzD9G9pivWKXHCUKU0BA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779534903; c=relaxed/relaxed;
	bh=dYv7n7MNQFWGtdjlWPVxo0rnA4k4aMTlnbBv8oYiho8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bX4AKRsUnKm8b21YooNlgctLQ5lUBVzh+Q51+cXu86q9Y43DgBaQGg/tqprNAkGwW0D8xDJ6qJa3ptU1EwEkVMkmrJBdIte3PqmZ971sYUcn8uxwIn7zZbQ0nBDnX6gZLIJ6GRmvr6SyqLQLLsVi9H5XFBI5wRV8VbnjKQ+UV6GoxCAsWvKZjuvJP/1gpti5GotXXPD3wBkI8NOnBQuoN0RS2lyg7jw9Sdym0/ct9LZFRymoBjjEB7RKtDIa8VZ7f5JJd1cpEtiQuG3dh3fohGHzOpmWQScoWmqSF2ZiOjHuqD5mHgfdnFIdAd31pOs/TZp9Xd/w0OoqRGQYKSAlBg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lHiUskNC; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::434; helo=mail-pf1-x434.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lHiUskNC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::434; helo=mail-pf1-x434.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gN0121Q29z2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 May 2026 21:15:01 +1000 (AEST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-836ed29d1e5so3651719b3a.2
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 May 2026 04:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779534900; x=1780139700; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dYv7n7MNQFWGtdjlWPVxo0rnA4k4aMTlnbBv8oYiho8=;
        b=lHiUskNCNPc6ryLAOXum5mEUEWaEaWksAEkC+z57W2Bx2xYoqENjXin3VwmJ6rAjwn
         ECevY8RUfir8H8kYCrf4qJM0jJ8E576KzdrlWlREPUc5iVlUGHEW8cfxikRf5QYOdv7Q
         9EJ6jI0JkMGQQdBRRc/VgPX8DszJuyBZknF214NO4kuE7ZNb9dFsfFz3c/xwXWrMV5WU
         fW5T6P7I4OOryQkeJ6g0d0tJYirQwwHbWz3v5Lsl5W23LGKcq3PkW3GKV17wAYP+Z4HZ
         eyL3nIwG/T6Ww6J7jZHYEQ5ycFy7lilygISVSAm5nsvsyC+Z4d5qol1HyWIxYYno6ITw
         JnYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779534900; x=1780139700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dYv7n7MNQFWGtdjlWPVxo0rnA4k4aMTlnbBv8oYiho8=;
        b=BICukYd4qJk6OxQZX6agloG21GbWuJHaJVa3V5svAHsthWDh53s3Zx55hqoZYY7gW5
         55BG1b0+YxcQpIYvtOOFp8p5OAK11AqMK6wTDq+ILtZNM5vOyG62RdxV/Cag9F9p8u6e
         0COkuJf3OhQFBWT+WfxlDEHkkR2Quw7/n7VzCuG7A7W4wlSouLy2qbyoHOwakaIthgJ8
         XDH6FL+tTL6ZkltomglhzeCsJWgZNAe6oqYmh8K+klQ/qfT8sJNckYzY7KICWGye7ioe
         gn5V7zZ7veEt9XuWXF/IKiY+7qY8A1GO6ko8nsXForNtbZB/2MyxfgfTT9qajD6QtvP0
         OlDQ==
X-Gm-Message-State: AOJu0Yz6qeeXYkoDMqNTqfWwYXfvm79qbvVZps1Tvai/VgCj5IfJGMDO
	OijBJZXNcAR6pMKmLP8tE6+lEQ6JexOC6XS4IprdepEPzXvKnG3i0PAs
X-Gm-Gg: Acq92OGA7AbwGhwPfBnDbX2JP317LrZrQo4Y+deM0ITxzBgFQ/khG7sQQaBS12ER/Ng
	05K+KHoeU/y5gnOf9QOb7jVjm0iWxmgpv2uEXX1aOcmSdt+nWSh385VAHmgUvd8jowmGqB6h3j1
	RBeTc2ytFfhpNtZOJEQTYNBQB6DGd2RwTmON/XY+fxtePjGuMq7B0SoXt5oQaooQMY/aQgnlOJg
	0PeeX8o+cQNUY4wNtwsDI25OC/tzCLXLeTbVy8+Ca8k9HCNICDBugW+Rn2OrRkE7xcQBkb3aQxb
	j9xbJxOQHL60yYxNDifeGAC6eJvZEcQjrmzXuhZgzD1O/PWgYx9L6eFg7OchKUDZ2/nkltfh6SK
	GBUnqvY8CJBvefg/uejBbWo2TVIqR32M0QInI7qCov3o6m0dds99O1qQNCOiWnv1in0bhDADbQE
	wy6ysLFJzM1Frkqwe3hrmcHyX9xZ0PPC0ImG4zf/k=
X-Received: by 2002:a05:6a00:1c8a:b0:82f:4f67:1ff6 with SMTP id d2e1a72fcca58-8415f2dca4cmr7587485b3a.4.1779534899815;
        Sat, 23 May 2026 04:14:59 -0700 (PDT)
Received: from Mac.ibm.com ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164ac9c77sm5249140b3a.2.2026.05.23.04.14.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 23 May 2026 04:14:59 -0700 (PDT)
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
Subject: [RFC v2 2/5] KVM: selftests: Add aligned guest physical page allocator
Date: Sat, 23 May 2026 16:44:21 +0530
Message-ID: <0fcea77119a6f4e0554f8bc0b258a54c2fe9d49f.1779524962.git.ritesh.list@gmail.com>
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
index 2a76eca7029d..cdb004c9ba56 100644
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


