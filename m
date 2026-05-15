Return-Path: <linuxppc-dev+bounces-20988-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2682CD343F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 May 2026 16:04:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gHBq42vcnz2ySN;
	Sat, 16 May 2026 02:04:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::434"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778861088;
	cv=none; b=i1mX7etFvbesjJNUIjJzmj9JxtHj4LhdhytINKSGXIuPgslqN8Zd27797P/HMbeOZYhH+oQf8iCKdrpp+tbjxLT+hHqJvVCoF+rbUSj3/YmSwqV0JjTQwBbEKcjzhwQqtBl8Jw+7gpDroWykX6sUsSSTdyLfM/ab7p2kaHbBD+7rH+CGBF3V+VabL+vu7jc1e4OfHiChbqrWxQTE8lxKh3LQxiHE4uWfJY2+4bRIAF9a5dz18IwtvoKVWGIQ89Z+lj7O0cnEvhgh4tVR7hrxkUMV1WeFbDH5E3slzz5h7FMuD0g5j00MA5X+qaXZRXWxqgOCCBOWcr8L13sl3Czz0g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778861088; c=relaxed/relaxed;
	bh=dYv7n7MNQFWGtdjlWPVxo0rnA4k4aMTlnbBv8oYiho8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wt1Ptj3OGC2TziFyPG2a4JF0atMN5uCKqckj7bd5FQoPHuemMKzM5+uOMlTYTGoR4HzRE4iwYFlK1uydnxAES0VsBsBlFdrhpW7yGxHMepnEVXDT5f1mN1/DeBMEWbL+giNHEHucW4ca1A08et+01Sro4Rw/A9zuxS6ASPG+ducOVmvYfGP2Feqv25TVvU1LOxwzwc1nDkY2X/qyfvfuvA1PIo5oCJEQqkkQttC2gVLbAkSLIJ/5CkQfm9w2j/BRXxnPBZUCq9KEtv7DHAa9n7m1Uzc836VEsTwQerEjsny6lh8BGvigrfr5OwKgPdENmLLVMNaYUPQYrl9gFe2MDQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pjytWddu; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::434; helo=mail-pf1-x434.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pjytWddu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::434; helo=mail-pf1-x434.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gHBq35VWbz2xTl
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 May 2026 02:04:47 +1000 (AEST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-82faf871346so7032684b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2026 09:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778861086; x=1779465886; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dYv7n7MNQFWGtdjlWPVxo0rnA4k4aMTlnbBv8oYiho8=;
        b=pjytWdduhJJBlaSdJTDOjhB51M2onCANa8YAgESj1jlrrDhZFVhL2USmqXimSXmxRw
         yirYUrTVYUPdcAHri4A0BmVLDXwMsTRXPAq/awTQVREChLwTaQlQx91XrdYXLYLip4Jd
         kNjRiulEsajaI9wLtni3ea57vjX+y1f8Ip8oL83eHLcdomH0f/c2PQlU456lBaAF0s5Z
         GJR6jUfc4kLcsFcgdA3e8L3WD+nJnPdNVIqco1vIuchABbMcXCo857G8zqfYNxqiR97I
         D3/2zJNcmGa0X5/InyLQsPm6wM/VYIs7udUwOUWJDy1WIWwDxWj6RVMqjFJk51g8ND1g
         OuDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778861086; x=1779465886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dYv7n7MNQFWGtdjlWPVxo0rnA4k4aMTlnbBv8oYiho8=;
        b=GVw+3S4f0vZkNtj6gn/dBGt3O8A6Ir4xGNAkzLWCfqZXzefHH2LLxwj2uxI8tMpiM3
         CAFIcF8/UulS05OFocbWB0e0GbNJ6GxF6xyOlbyL2EvT0hmVEHlDaDXfEvTmQ5/1aBde
         te8CiLmBv4/rVNPUolOB+uGPoNWaLqghSyMx1szXbWzHrVgJd4nDCLccxio+Q4/fM4PI
         l6zVva3PSo/L0bv+gcKsP6J0hRtLs6ZlVH853WdIZu7+jhuRUfVhwoyChky6lb9o3fU6
         Izw9GVz1lqdlyahN0S6ghdjNoviQH/GZRA2bRPyg/hn7aJjMNtjZgpkn/EqCw/Q8fy7/
         C96g==
X-Gm-Message-State: AOJu0Yxdf2mPZZIq8NuHKb7yYLzDoYouPx0nw+tNNQnLvybWsFMBwVYe
	hDFiqPSYbbekBA/WTeBpEHHYeV2SpyktFW5D1oswMv1CFjMZzPUfGiN9
X-Gm-Gg: Acq92OHhLXSWLo75itcWhiWFVuHzg8xZP5rZ8/cWpHsIUQ32NK2sGPYg7rt4mHmJpHK
	ClmK8Pllz3zy8UccuTGJ+GmZWQ+j4rPyMEIFIeOEa3cdJnQmMxTPubLy/+U1q8Y6V0XL+W4l652
	HQl0yBp9yKbyttnAbY271MKpfnQm16KzC261OHhr/OYydPQg7k6kJI58XgGuDbcqgL2EuYlc9Kn
	dH8cL5MBrb3hy4/CWfLrzLTblj2SV1xsMJGwI1y9O//Q2PRi+FOT6H8dL4FCLn7drv5W4qZ7jQw
	XZig9EPWe5nag1rV6w4d6WGZQUjaSE5fTmkSpwvSna5dCfEEbNOrz2fzyRgDq4EbaAO+MmCX1YA
	jpDRtp6FictYPCBtd+ja+TBLsPVQLas0q+9IO2nQvCwWCyVnG+G5y8nkO+SC1AU9pNT4dn2ZmgW
	2KSrs3COxP4ORFNK3sxNaP4MLe7Xc2LRFy72pIWVePWHECIAKdG1PX
X-Received: by 2002:a05:6a00:1902:b0:834:ea1a:4b25 with SMTP id d2e1a72fcca58-83f33b2e0c9mr5587593b3a.12.1778861085597;
        Fri, 15 May 2026 09:04:45 -0700 (PDT)
Received: from localhost.localdomain ([171.76.86.174])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19c7c74fsm7920262b3a.49.2026.05.15.09.04.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 15 May 2026 09:04:43 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: kvm@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC 2/4] KVM: selftests: Add aligned guest physical page allocator
Date: Fri, 15 May 2026 21:34:21 +0530
Message-ID: <b7977803c6aa382c30db739bfc00e17893eef861.1778857539.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1778857539.git.ritesh.list@gmail.com>
References: <cover.1778857539.git.ritesh.list@gmail.com>
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


