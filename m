Return-Path: <linuxppc-dev+bounces-21428-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F378CD5BB1
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 May 2026 11:15:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gN01B2b7Zz2yFY;
	Sat, 23 May 2026 21:15:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779534910;
	cv=none; b=jbBSWeZr7SQ7QfSVwnWohbLDt0Scg8cJkHzfCRZVVwTtVfYbGDIlg/s1JLN6lOj5RGuhb6yZonaV43wLAQom40J+FqsACiv8Kh0NAAGy5eLgDoCqFsP5CjpB7ZV51JvzHLWtNJ8qcaY5JBdf9PXlFPngbwIik8jpCPPVqPkYASt/nvBIioPd4AA2BBS63doZY5LNWYV63sqO7pOL+An4BD92rd5CQkcUVsf79dTG5JTMObIC7kRf7X7LOaYjzH9Irscirh+ZgUeogI7nDZth8shvJFom9ykP2t1aXmEvmaDuG2R7q4qs9XMs4Zwnio++w8VLNNDFO6DgddVK1v8DXw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779534910; c=relaxed/relaxed;
	bh=FQ9oe+X1QrAi8pMjejbPrYtVteMsIofRM/P68r1ErNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g1HWaAeGU3q86hm69rCVI3nuavnbc3TgKG3qQmFSOU8r5TQMPnroNP/9kaOphe/o9BrNyZ70rZ/QSc9K84I8htPj9WE9OjNuSYOFkcu9WfKNwjOz+aSf1gOsTXJAGsI/2PlRvly7e7siKrJFeFZxlEJFZHhH7f5QhOHCuOfFxSYr3/koJsVHJatEpRARGTWmiG9lWFOv13FtjuF8Jw//AItu5bQU0hHd+PZFsud13TMEaZ8A11pTCfb5R46hDysC4m/LJgePwXkt/+9oTb4D5e9CYQCYo2JfaYtgWrftpiZXn7/etJiAp4TNDej4zjVwD0Opbw96gGQNH+pop/P6cA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iU1W8mP+; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42b; helo=mail-pf1-x42b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iU1W8mP+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42b; helo=mail-pf1-x42b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gN01835c3z2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 May 2026 21:15:08 +1000 (AEST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-837b39eb078so5572887b3a.2
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 May 2026 04:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779534906; x=1780139706; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FQ9oe+X1QrAi8pMjejbPrYtVteMsIofRM/P68r1ErNE=;
        b=iU1W8mP+Dt3amAZbBl0NiX/k6H8Ds1B01y1N1CI+bSnU2y3G6I0XR5opap5PciSBi5
         RwWp5NIDwjvOrS+X0PCrlUgDF6uvu4EKbNcr0715IftD+3d8tUSdpFuu/z5tCzAbWXu6
         ZVdy1p3w4bg4UnVddHiwzAkXgWCWhxreP5LS67fT9M0qetzeBtMlxo4IHL7abmrSXcTx
         gVupkrbYehRAcM4gsQacMscrjM/id0OuQJu6QLm0pWNmU3r04IHyASjbd+ItTsV8SECS
         K4PIUejMo7UUIgaHXGN1/OAy8ts80G30uoiEwANRw7otIs00JC6jEr+xO+Su/46V8I+3
         sdxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779534906; x=1780139706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FQ9oe+X1QrAi8pMjejbPrYtVteMsIofRM/P68r1ErNE=;
        b=RMZ7qwXkX6Usf/UelmFo946oKrdZyiY+XCCCHCFtuQsJrbPMC0i8jFt1hXKPZZp2VU
         3uRtODQJShmhg7T8d7CU/M0vR7yPOrUoLieBme1YrF0ll8ehsYH6esb3FVXHsWU7C9A/
         ReSoliO6wrD7ZHZ9Z1wKHBHoPMj0KhRcSYv+hGQTtQnOGU3eQ4gJ/LTWsx45EaCk8PCQ
         Pr+bsnFd3AK81zewZiiWlVBv6ayOmUcqe23Qxe5gGttjKg04+lABmT+xj0ZPgUJTrF+g
         amxi/tfjtptNKOBewwXIs+6vQslewjdQPnVOh1xEEQ/P7/lqSYakY7QVSsi6VUPfFAen
         oqrA==
X-Gm-Message-State: AOJu0YxFQReok+HGgd6VSzxMzFB0iawtzchRyM5ic1k2f/K+xyMGMrqZ
	RBZrBZe0sAx9BuRPGjhcMRlppwc0sYiSj178k1FLKxtYCYuLU3NDHMJF
X-Gm-Gg: Acq92OHCQh2gpsn+gxLYj4fgNV3zqq6jRlty9YR55RwSozdOB+O9GoUHL3vYVmM5CSD
	G7rkw4MreHQQIbylYzcYJXZSt4Qxg2satn/ChKI/TCD1QOSjmB7cynzN59VIV2O/njkAta/ChpD
	z4Nf782swcpwsxoMWQIsOAk8a5ZldMr0Xq90C77Xo3Bj7RY4nwTRT2QZiTPW+ppPfA79MHfJGNH
	tMERUUwz5j0QBq1DK/VeKqw1/zM3EhY8thViqw1FqC+/cVty7Pg5smnWeG4Km75EZdWNoAOT9Oj
	ENx/J7xg1lOnsZOaklE9C0ikPBROHdLxmEK6WiDTaHEVuDWHtOcdZixW4xed54cjicOSyHh5UKZ
	HU+CXjfDTfj/wDK3st2hutDyBf41KgRPL8X0Ng81C6GRpsA4QZ3/LYCsI1XNtbvGHxj7t89JoCs
	CKm83FG+87Ufa6fEs0CQAgbKP63t2PPcrtk6EK+NJ8bXe2bO+8Ag==
X-Received: by 2002:a05:6a00:4196:b0:82f:3ecc:c42f with SMTP id d2e1a72fcca58-8415f65a2a7mr6651228b3a.40.1779534906019;
        Sat, 23 May 2026 04:15:06 -0700 (PDT)
Received: from Mac.ibm.com ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164ac9c77sm5249140b3a.2.2026.05.23.04.15.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 23 May 2026 04:15:05 -0700 (PDT)
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
Subject: [RFC v2 3/5] KVM: PPC: selftests: add support for powerpc
Date: Sat, 23 May 2026 16:44:22 +0530
Message-ID: <6e0c74f1273a4baf652d84820ae83696e77263d9.1779524962.git.ritesh.list@gmail.com>
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

Implement KVM selftests support for powerpc (Book3S-64).

ucalls are implemented with an unsupported PAPR hcall number which will
always cause KVM to exit to userspace.

Virtual memory is implemented for the radix MMU, and only a base page
size is supported (both 4K and 64K).

Guest interrupts are taken in real-mode, so require a page allocated at
gRA 0x0. Interrupt entry is complicated because gVA:gRA is not 1:1
mapped (like the kernel is), so the MMU can not just be switched on and
off.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
[Rebased to latest mainline tree, add "cc" to clobber list and fix the
pagesize calculation in kvm_arch_vm_post_create()]
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 MAINTAINERS                                   |   2 +
 tools/testing/selftests/kvm/Makefile          |   2 +-
 tools/testing/selftests/kvm/Makefile.kvm      |  10 +
 .../testing/selftests/kvm/include/kvm_util.h  |   9 +
 .../selftests/kvm/include/powerpc/hcall.h     |  17 +
 .../kvm/include/powerpc/kvm_util_arch.h       |  22 +
 .../selftests/kvm/include/powerpc/ppc_asm.h   |  32 ++
 .../selftests/kvm/include/powerpc/processor.h |  38 ++
 .../selftests/kvm/include/powerpc/ucall.h     |  21 +
 tools/testing/selftests/kvm/lib/guest_modes.c |  20 +-
 tools/testing/selftests/kvm/lib/kvm_util.c    |   8 +
 .../selftests/kvm/lib/powerpc/handlers.S      |  93 ++++
 .../testing/selftests/kvm/lib/powerpc/hcall.c |  45 ++
 .../selftests/kvm/lib/powerpc/processor.c     | 484 ++++++++++++++++++
 .../testing/selftests/kvm/lib/powerpc/ucall.c |  22 +
 15 files changed, 822 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/powerpc/hcall.h
 create mode 100644 tools/testing/selftests/kvm/include/powerpc/kvm_util_arch.h
 create mode 100644 tools/testing/selftests/kvm/include/powerpc/ppc_asm.h
 create mode 100644 tools/testing/selftests/kvm/include/powerpc/processor.h
 create mode 100644 tools/testing/selftests/kvm/include/powerpc/ucall.h
 create mode 100644 tools/testing/selftests/kvm/lib/powerpc/handlers.S
 create mode 100644 tools/testing/selftests/kvm/lib/powerpc/hcall.c
 create mode 100644 tools/testing/selftests/kvm/lib/powerpc/processor.c
 create mode 100644 tools/testing/selftests/kvm/lib/powerpc/ucall.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f1e5e4258e7b..3c876ea1198e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14118,6 +14118,8 @@ F:	arch/powerpc/include/asm/kvm*
 F:	arch/powerpc/include/uapi/asm/kvm*
 F:	arch/powerpc/kernel/kvm*
 F:	arch/powerpc/kvm/
+F:	tools/testing/selftests/kvm/*/powerpc/
+F:	tools/testing/selftests/kvm/powerpc/
 
 KERNEL VIRTUAL MACHINE FOR RISC-V (KVM/riscv)
 M:	Anup Patel <anup@brainfault.org>
diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index f2b223072b62..03d91f00092f 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -3,7 +3,7 @@ top_srcdir = ../../../..
 include $(top_srcdir)/scripts/subarch.include
 ARCH            ?= $(SUBARCH)
 
-ifeq ($(ARCH),$(filter $(ARCH),arm64 s390 riscv x86 x86_64 loongarch))
+ifeq ($(ARCH),$(filter $(ARCH),arm64 s390 riscv x86 x86_64 loongarch powerpc))
 # Top-level selftests allows ARCH=x86_64 :-(
 ifeq ($(ARCH),x86_64)
 	override ARCH := x86
diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 9118a5a51b89..825bea7f851d 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -52,6 +52,11 @@ LIBKVM_loongarch += lib/loongarch/processor.c
 LIBKVM_loongarch += lib/loongarch/ucall.c
 LIBKVM_loongarch += lib/loongarch/exception.S
 
+LIBKVM_powerpc += lib/powerpc/handlers.S
+LIBKVM_powerpc += lib/powerpc/processor.c
+LIBKVM_powerpc += lib/powerpc/ucall.c
+LIBKVM_powerpc += lib/powerpc/hcall.c
+
 # Non-compiled test targets
 TEST_PROGS_x86 += x86/nx_huge_pages_test.sh
 
@@ -239,6 +244,11 @@ TEST_GEN_PROGS_loongarch += memslot_perf_test
 TEST_GEN_PROGS_loongarch += set_memory_region_test
 TEST_GEN_PROGS_loongarch += steal_time
 
+TEST_GEN_PROGS_powerpc = $(TEST_GEN_PROGS_COMMON)
+TEST_GEN_PROGS_powerpc += access_tracking_perf_test
+TEST_GEN_PROGS_powerpc += dirty_log_perf_test
+TEST_GEN_PROGS_powerpc += hardware_disable_test
+
 SPLIT_TESTS += arch_timer
 SPLIT_TESTS += get-reg-list
 
diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index c515c918c2c9..10f03a182c8b 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -209,6 +209,9 @@ enum vm_guest_mode {
 	VM_MODE_P41V48_4K,
 	VM_MODE_P41V39_4K,
 
+	VM_MODE_P52V52_4K,	/* For powerpc64 */
+	VM_MODE_P52V52_64K,
+
 	NUM_VM_MODES,
 };
 
@@ -268,6 +271,12 @@ extern enum vm_guest_mode vm_mode_default;
 #define MIN_PAGE_SHIFT			12U
 #define ptes_per_page(page_size)	((page_size) / 8)
 
+#elif defined(__powerpc64__)
+
+#define VM_MODE_DEFAULT			vm_mode_default
+#define MIN_PAGE_SHIFT			12U
+#define ptes_per_page(page_size)	((page_size) / 8)
+
 #endif
 
 #define VM_SHAPE_DEFAULT	VM_SHAPE(VM_MODE_DEFAULT)
diff --git a/tools/testing/selftests/kvm/include/powerpc/hcall.h b/tools/testing/selftests/kvm/include/powerpc/hcall.h
new file mode 100644
index 000000000000..4028baa6c5d8
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/powerpc/hcall.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * powerpc hcall defines
+ */
+#ifndef SELFTEST_KVM_HCALL_H
+#define SELFTEST_KVM_HCALL_H
+
+#include <linux/compiler.h>
+
+/* Ucalls use unimplemented PAPR hcall 0 which exits KVM */
+#define H_UCALL	0
+
+int64_t hcall0(uint64_t token);
+int64_t hcall1(uint64_t token, uint64_t arg1);
+int64_t hcall2(uint64_t token, uint64_t arg1, uint64_t arg2);
+
+#endif
diff --git a/tools/testing/selftests/kvm/include/powerpc/kvm_util_arch.h b/tools/testing/selftests/kvm/include/powerpc/kvm_util_arch.h
new file mode 100644
index 000000000000..5d45c25cd299
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/powerpc/kvm_util_arch.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef SELFTEST_KVM_UTIL_ARCH_H
+#define SELFTEST_KVM_UTIL_ARCH_H
+
+#include <stdint.h>
+
+#include "kvm_util_types.h"
+
+struct kvm_mmu_arch {};
+
+/* Page table fragment cache for guest page tables < page size */
+struct vm_pt_frag_cache {
+	gpa_t page;
+	size_t page_nr_used;
+};
+
+struct kvm_vm_arch {
+	gpa_t prtb; /* process table */
+	struct vm_pt_frag_cache pt_frag_cache[2]; /* 256B and 4KB PT caches */
+};
+
+#endif  /* SELFTEST_KVM_UTIL_ARCH_H */
diff --git a/tools/testing/selftests/kvm/include/powerpc/ppc_asm.h b/tools/testing/selftests/kvm/include/powerpc/ppc_asm.h
new file mode 100644
index 000000000000..b9df64659792
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/powerpc/ppc_asm.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * powerpc asm specific defines
+ */
+#ifndef SELFTEST_KVM_PPC_ASM_H
+#define SELFTEST_KVM_PPC_ASM_H
+
+#define STACK_FRAME_MIN_SIZE	112 /* Could be 32 on ELFv2 */
+#define STACK_REDZONE_SIZE	512
+
+#define INT_FRAME_SIZE		(STACK_FRAME_MIN_SIZE + STACK_REDZONE_SIZE)
+
+#define SPR_SRR0	0x01a
+#define SPR_SRR1	0x01b
+#define SPR_CFAR	0x01c
+
+#define MSR_SF		0x8000000000000000ULL
+#define MSR_HV		0x1000000000000000ULL
+#define MSR_VEC		0x0000000002000000ULL
+#define MSR_VSX		0x0000000000800000ULL
+#define MSR_EE		0x0000000000008000ULL
+#define MSR_PR		0x0000000000004000ULL
+#define MSR_FP		0x0000000000002000ULL
+#define MSR_ME		0x0000000000001000ULL
+#define MSR_IR		0x0000000000000020ULL
+#define MSR_DR		0x0000000000000010ULL
+#define MSR_RI		0x0000000000000002ULL
+#define MSR_LE		0x0000000000000001ULL
+
+#define LPCR_ILE	0x0000000002000000ULL
+
+#endif
diff --git a/tools/testing/selftests/kvm/include/powerpc/processor.h b/tools/testing/selftests/kvm/include/powerpc/processor.h
new file mode 100644
index 000000000000..cb75b77c33bb
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/powerpc/processor.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * powerpc processor specific defines
+ */
+#ifndef SELFTEST_KVM_PROCESSOR_H
+#define SELFTEST_KVM_PROCESSOR_H
+
+#include <linux/compiler.h>
+#include "ppc_asm.h"
+
+extern unsigned char __interrupts_start[];
+extern unsigned char __interrupts_end[];
+
+struct kvm_vm;
+struct kvm_vcpu;
+
+struct ex_regs {
+	uint64_t	gprs[32];
+	uint64_t	nia;
+	uint64_t	msr;
+	uint64_t	cfar;
+	uint64_t	lr;
+	uint64_t	ctr;
+	uint64_t	xer;
+	uint32_t	cr;
+	uint32_t	trap;
+	uint64_t	vaddr; /* vaddr of this struct */
+};
+
+void vm_install_exception_handler(struct kvm_vm *vm, int vector,
+			void (*handler)(struct ex_regs *));
+
+static inline void cpu_relax(void)
+{
+	asm volatile("" ::: "memory");
+}
+
+#endif
diff --git a/tools/testing/selftests/kvm/include/powerpc/ucall.h b/tools/testing/selftests/kvm/include/powerpc/ucall.h
new file mode 100644
index 000000000000..e0dbe91e8848
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/powerpc/ucall.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef SELFTEST_KVM_UCALL_H
+#define SELFTEST_KVM_UCALL_H
+
+#include "hcall.h"
+
+#define UCALL_EXIT_REASON	KVM_EXIT_PAPR_HCALL
+
+#define UCALL_R4_UCALL	0x5715 /* regular ucall, r5 contains ucall pointer */
+#define UCALL_R4_SIMPLE	0x0000 /* simple exit usable by asm with no ucall data */
+
+static inline void ucall_arch_init(struct kvm_vm *vm, gpa_t mmio_gpa)
+{
+}
+
+static inline void ucall_arch_do_ucall(gva_t uc)
+{
+	hcall2(H_UCALL, UCALL_R4_UCALL, (uintptr_t)(uc));
+}
+
+#endif
diff --git a/tools/testing/selftests/kvm/lib/guest_modes.c b/tools/testing/selftests/kvm/lib/guest_modes.c
index 7a96c43b5704..439766fad693 100644
--- a/tools/testing/selftests/kvm/lib/guest_modes.c
+++ b/tools/testing/selftests/kvm/lib/guest_modes.c
@@ -4,16 +4,20 @@
  */
 #include "guest_modes.h"
 
-#if defined(__aarch64__) || defined(__riscv)
+#if defined(__aarch64__) || defined(__riscv) || defined(__powerpc64__)
 #include "processor.h"
 enum vm_guest_mode vm_mode_default;
 #endif
 
+#if defined(__powerpc64__)
+#include <unistd.h>
+#endif
+
 struct guest_mode guest_modes[NUM_VM_MODES];
 
 void guest_modes_append_default(void)
 {
-#if !defined(__aarch64__) && !defined(__riscv)
+#if !defined(__aarch64__) && !defined(__riscv) && !defined(__powerpc64__)
 	guest_mode_append(VM_MODE_DEFAULT, true);
 #endif
 
@@ -108,6 +112,18 @@ void guest_modes_append_default(void)
 		TEST_ASSERT(vm_mode_default != NUM_VM_MODES, "No supported mode!");
 	}
 #endif
+#ifdef __powerpc64__
+	{
+		TEST_REQUIRE(kvm_has_cap(KVM_CAP_PPC_MMU_RADIX));
+		/* Radix guest EA and RA are 52-bit on POWER9 and POWER10 */
+		if (sysconf(_SC_PAGESIZE) == 4096)
+			vm_mode_default = VM_MODE_P52V52_4K;
+		else
+			vm_mode_default = VM_MODE_P52V52_64K;
+		guest_mode_append(VM_MODE_P52V52_4K, true);
+		guest_mode_append(VM_MODE_P52V52_64K, true);
+	}
+#endif
 }
 
 void for_each_guest_mode(void (*func)(enum vm_guest_mode, void *), void *arg)
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index cdb004c9ba56..0dc67c1502cf 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -218,6 +218,8 @@ const char *vm_guest_mode_string(u32 i)
 		[VM_MODE_P41V57_4K]	= "PA-bits:41,  VA-bits:57,  4K pages",
 		[VM_MODE_P41V48_4K]	= "PA-bits:41,  VA-bits:48,  4K pages",
 		[VM_MODE_P41V39_4K]	= "PA-bits:41,  VA-bits:39,  4K pages",
+		[VM_MODE_P52V52_4K]	= "PA-bits:52,  VA-bits:52,  4K pages",
+		[VM_MODE_P52V52_64K]	= "PA-bits:52,  VA-bits:52, 64K pages",
 	};
 	_Static_assert(sizeof(strings)/sizeof(char *) == NUM_VM_MODES,
 		       "Missing new mode strings?");
@@ -254,6 +256,8 @@ const struct vm_guest_mode_params vm_guest_mode_params[] = {
 	[VM_MODE_P41V57_4K]	= { 41, 57,  0x1000, 12 },
 	[VM_MODE_P41V48_4K]	= { 41, 48,  0x1000, 12 },
 	[VM_MODE_P41V39_4K]	= { 41, 39,  0x1000, 12 },
+	[VM_MODE_P52V52_4K]	= { 52, 52,  0x1000, 12 },
+	[VM_MODE_P52V52_64K]	= { 52, 52, 0x10000, 16 },
 };
 _Static_assert(sizeof(vm_guest_mode_params)/sizeof(struct vm_guest_mode_params) == NUM_VM_MODES,
 	       "Missing new mode params?");
@@ -371,6 +375,10 @@ struct kvm_vm *____vm_create(struct vm_shape shape)
 	case VM_MODE_P41V39_4K:
 		vm->mmu.pgtable_levels = 3;
 		break;
+	case VM_MODE_P52V52_4K:
+	case VM_MODE_P52V52_64K:
+		vm->mmu.pgtable_levels = 4;
+		break;
 	default:
 		TEST_FAIL("Unknown guest mode: 0x%x", vm->mode);
 	}
diff --git a/tools/testing/selftests/kvm/lib/powerpc/handlers.S b/tools/testing/selftests/kvm/lib/powerpc/handlers.S
new file mode 100644
index 000000000000..b860f6a520a1
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/powerpc/handlers.S
@@ -0,0 +1,93 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <ppc_asm.h>
+
+.macro INTERRUPT vec
+. = __interrupts_start + \vec
+	std	%r0,(0*8)(%r13)
+	std	%r3,(3*8)(%r13)
+	mfspr	%r0,SPR_CFAR
+	li	%r3,\vec
+	b	handle_interrupt
+.endm
+
+.balign 0x1000
+.global __interrupts_start
+__interrupts_start:
+INTERRUPT 0x100
+INTERRUPT 0x200
+INTERRUPT 0x300
+INTERRUPT 0x380
+INTERRUPT 0x400
+INTERRUPT 0x480
+INTERRUPT 0x500
+INTERRUPT 0x600
+INTERRUPT 0x700
+INTERRUPT 0x800
+INTERRUPT 0x900
+INTERRUPT 0xa00
+INTERRUPT 0xc00
+INTERRUPT 0xd00
+INTERRUPT 0xf00
+INTERRUPT 0xf20
+INTERRUPT 0xf40
+INTERRUPT 0xf60
+
+virt_handle_interrupt:
+	stdu	%r1,-INT_FRAME_SIZE(%r1)
+	mr	%r3,%r31
+	bl	route_interrupt
+	ld	%r4,(32*8)(%r31) /* NIA */
+	ld	%r5,(33*8)(%r31) /* MSR */
+	ld	%r6,(35*8)(%r31) /* LR */
+	ld	%r7,(36*8)(%r31) /* CTR */
+	ld	%r8,(37*8)(%r31) /* XER */
+	lwz	%r9,(38*8)(%r31) /* CR */
+	mtspr	SPR_SRR0,%r4
+	mtspr	SPR_SRR1,%r5
+	mtlr	%r6
+	mtctr	%r7
+	mtxer	%r8
+	mtcr	%r9
+reg=4
+	ld	%r0,(0*8)(%r31)
+	ld	%r3,(3*8)(%r31)
+.rept 28
+	ld	reg,(reg*8)(%r31)
+	reg=reg+1
+.endr
+	addi	%r1,%r1,INT_FRAME_SIZE
+	rfid
+
+virt_handle_interrupt_p:
+	.llong virt_handle_interrupt
+
+handle_interrupt:
+reg=4
+.rept 28
+	std	reg,(reg*8)(%r13)
+	reg=reg+1
+.endr
+	mfspr	%r4,SPR_SRR0
+	mfspr	%r5,SPR_SRR1
+	mflr	%r6
+	mfctr	%r7
+	mfxer	%r8
+	mfcr	%r9
+	std	%r4,(32*8)(%r13) /* NIA */
+	std	%r5,(33*8)(%r13) /* MSR */
+	std	%r0,(34*8)(%r13) /* CFAR */
+	std	%r6,(35*8)(%r13) /* LR */
+	std	%r7,(36*8)(%r13) /* CTR */
+	std	%r8,(37*8)(%r13) /* XER */
+	stw	%r9,(38*8 + 0)(%r13) /* CR */
+	stw	%r3,(38*8 + 4)(%r13) /* TRAP */
+
+	ld	%r31,(39*8)(%r13) /* vaddr */
+	ld	%r4,virt_handle_interrupt_p - __interrupts_start(0)
+	mtspr	SPR_SRR0,%r4
+	/* Reuse SRR1 */
+
+	rfid
+.global __interrupts_end
+__interrupts_end:
diff --git a/tools/testing/selftests/kvm/lib/powerpc/hcall.c b/tools/testing/selftests/kvm/lib/powerpc/hcall.c
new file mode 100644
index 000000000000..efb4318252be
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/powerpc/hcall.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PAPR (pseries) hcall support.
+ */
+#include "kvm_util.h"
+#include "hcall.h"
+
+int64_t hcall0(uint64_t token)
+{
+	register uintptr_t r3 asm ("r3") = token;
+
+	asm volatile("sc 1" : "+r"(r3) :
+			    : "r0", "r4", "r5", "r6", "r7", "r8", "r9",
+			      "r10", "r11", "r12", "ctr", "xer",
+			      "cc", "memory");
+
+	return r3;
+}
+
+int64_t hcall1(uint64_t token, uint64_t arg1)
+{
+	register uintptr_t r3 asm ("r3") = token;
+	register uintptr_t r4 asm ("r4") = arg1;
+
+	asm volatile("sc 1" : "+r"(r3), "+r"(r4) :
+			    : "r0", "r5", "r6", "r7", "r8", "r9",
+			      "r10", "r11", "r12", "ctr", "xer",
+			      "cc", "memory");
+
+	return r3;
+}
+
+int64_t hcall2(uint64_t token, uint64_t arg1, uint64_t arg2)
+{
+	register uintptr_t r3 asm ("r3") = token;
+	register uintptr_t r4 asm ("r4") = arg1;
+	register uintptr_t r5 asm ("r5") = arg2;
+
+	asm volatile("sc 1" : "+r"(r3), "+r"(r4), "+r"(r5) :
+			    : "r0", "r6", "r7", "r8", "r9",
+			      "r10", "r11", "r12", "ctr", "xer",
+			      "cc", "memory");
+
+	return r3;
+}
diff --git a/tools/testing/selftests/kvm/lib/powerpc/processor.c b/tools/testing/selftests/kvm/lib/powerpc/processor.c
new file mode 100644
index 000000000000..310c67a00b95
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/powerpc/processor.c
@@ -0,0 +1,484 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * KVM selftest powerpc library code - CPU-related functions (page tables...)
+ */
+
+#include <linux/sizes.h>
+
+#include "processor.h"
+#include "kvm_util.h"
+#include "ucall_common.h"
+#include "guest_modes.h"
+#include "hcall.h"
+
+#define RADIX_TREE_SIZE ((0x2UL << 61) | (0x5UL << 5)) /* 52-bits */
+#define RADIX_PGD_INDEX_SIZE 13
+
+static void set_proc_table(struct kvm_vm *vm, int pid, uint64_t dw0, uint64_t dw1)
+{
+	uint64_t *proc_table;
+
+	proc_table = addr_gpa2hva(vm, vm->arch.prtb);
+	proc_table[pid * 2 + 0] = cpu_to_be64(dw0);
+	proc_table[pid * 2 + 1] = cpu_to_be64(dw1);
+}
+
+static void set_radix_proc_table(struct kvm_vm *vm, int pid, gpa_t pgd)
+{
+	set_proc_table(vm, pid, pgd | RADIX_TREE_SIZE | RADIX_PGD_INDEX_SIZE, 0);
+}
+
+void virt_arch_pgd_alloc(struct kvm_vm *vm)
+{
+	struct kvm_ppc_mmuv3_cfg mmu_cfg;
+	gpa_t prtb, pgtb;
+	size_t pgd_pages;
+
+	TEST_ASSERT((vm->mode == VM_MODE_P52V52_4K) ||
+		    (vm->mode == VM_MODE_P52V52_64K),
+		    "Unsupported guest mode, mode: 0x%x", vm->mode);
+
+	prtb = vm_phy_page_alloc(vm, KVM_GUEST_PAGE_TABLE_MIN_PADDR,
+				 vm->memslots[MEM_REGION_PT]);
+	vm->arch.prtb = prtb;
+
+	pgd_pages = (1UL << (RADIX_PGD_INDEX_SIZE + 3)) >> vm->page_shift;
+	if (!pgd_pages)
+		pgd_pages = 1;
+	pgtb = vm_phy_pages_alloc_align(vm, pgd_pages, pgd_pages,
+					KVM_GUEST_PAGE_TABLE_MIN_PADDR,
+					vm->memslots[MEM_REGION_PT]);
+	vm->mmu.pgd = pgtb;
+
+	/* Set the base page directory in the proc table */
+	set_radix_proc_table(vm, 0, pgtb);
+
+	if (vm->mode == VM_MODE_P52V52_4K)
+		mmu_cfg.process_table = prtb | 0x8000000000000000UL | 0x0; /* 4K size */
+	else /* vm->mode == VM_MODE_P52V52_64K */
+		mmu_cfg.process_table = prtb | 0x8000000000000000UL | 0x4; /* 64K size */
+	mmu_cfg.flags = KVM_PPC_MMUV3_RADIX | KVM_PPC_MMUV3_GTSE;
+
+	vm_ioctl(vm, KVM_PPC_CONFIGURE_V3_MMU, &mmu_cfg);
+}
+
+static int pt_shift(struct kvm_vm *vm, int level)
+{
+	switch (level) {
+	case 1:
+		return 13;
+	case 2:
+	case 3:
+		return 9;
+	case 4:
+		if (vm->mode == VM_MODE_P52V52_4K)
+			return 9;
+		else /* vm->mode == VM_MODE_P52V52_64K */
+			return 5;
+	default:
+		TEST_ASSERT(false, "Invalid page table level %d\n", level);
+		return 0;
+	}
+}
+
+static uint64_t pt_entry_coverage(struct kvm_vm *vm, int level)
+{
+	uint64_t size = vm->page_size;
+
+	if (level == 4)
+		return size;
+	size <<= pt_shift(vm, 4);
+	if (level == 3)
+		return size;
+	size <<= pt_shift(vm, 3);
+	if (level == 2)
+		return size;
+	size <<= pt_shift(vm, 2);
+	return size;
+}
+
+static int pt_idx(struct kvm_vm *vm, uint64_t vaddr, int level, uint64_t *nls)
+{
+	switch (level) {
+	case 1:
+		if (nls)
+			*nls = 0x9;
+		return (vaddr >> 39) & 0x1fff;
+	case 2:
+		if (nls)
+			*nls = 0x9;
+		return (vaddr >> 30) & 0x1ff;
+	case 3:
+		if (vm->mode == VM_MODE_P52V52_4K) {
+			if (nls)
+				*nls = 0x9;
+		} else { /* vm->mode == VM_MODE_P52V52_64K */
+			if (nls)
+				*nls = 0x5;
+		}
+		return (vaddr >> 21) & 0x1ff;
+	case 4:
+		if (vm->mode == VM_MODE_P52V52_4K)
+			return (vaddr >> 12) & 0x1ff;
+		else /* vm->mode == VM_MODE_P52V52_64K */
+			return (vaddr >> 16) & 0x1f;
+	default:
+		TEST_ASSERT(false, "Invalid page table level %d\n", level);
+		return 0;
+	}
+}
+
+static uint64_t *virt_get_pte(struct kvm_vm *vm, gpa_t pt,
+			  uint64_t vaddr, int level, uint64_t *nls)
+{
+	int idx = pt_idx(vm, vaddr, level, nls);
+	uint64_t *ptep = addr_gpa2hva(vm, pt + idx * 8);
+
+	return ptep;
+}
+
+#define PTE_VALID	0x8000000000000000ull
+#define PTE_LEAF	0x4000000000000000ull
+#define PTE_REFERENCED	0x0000000000000100ull
+#define PTE_CHANGED	0x0000000000000080ull
+#define PTE_PRIV	0x0000000000000008ull
+#define PTE_READ	0x0000000000000004ull
+#define PTE_RW		0x0000000000000002ull
+#define PTE_EXEC	0x0000000000000001ull
+#define PTE_PAGE_MASK	0x01fffffffffff000ull
+
+#define PDE_VALID	PTE_VALID
+#define PDE_NLS		0x0000000000000011ull
+#define PDE_PT_MASK	0x0fffffffffffff00ull
+
+static gpa_t __vm_alloc_pt(struct kvm_vm *vm, uint64_t pt_shift)
+{
+	gpa_t pt;
+
+	if (pt_shift >= vm->page_shift) {
+		size_t pt_pages = 1ULL << (pt_shift - vm->page_shift);
+
+		pt = vm_phy_pages_alloc_align(vm, pt_pages, pt_pages,
+					KVM_GUEST_PAGE_TABLE_MIN_PADDR,
+					vm->memslots[MEM_REGION_PT]);
+	} else {
+		struct vm_pt_frag_cache *pt_frag_cache;
+
+		if (pt_shift == 8) {
+			pt_frag_cache = &vm->arch.pt_frag_cache[0];
+		} else if (pt_shift == 12) {
+			pt_frag_cache = &vm->arch.pt_frag_cache[1];
+		} else {
+			TEST_ASSERT(0, "Invalid pt_shift:%lu\n", pt_shift);
+			return 0;
+		}
+
+		if (!pt_frag_cache->page) {
+			pt_frag_cache->page = vm_phy_pages_alloc_align(vm, 1, 1,
+						KVM_GUEST_PAGE_TABLE_MIN_PADDR,
+						vm->memslots[MEM_REGION_PT]);
+		}
+		pt = pt_frag_cache->page + pt_frag_cache->page_nr_used;
+		pt_frag_cache->page_nr_used += (1 << pt_shift);
+		if (pt_frag_cache->page_nr_used == vm->page_size) {
+			pt_frag_cache->page = 0;
+			pt_frag_cache->page_nr_used = 0;
+		}
+	}
+
+	return pt;
+}
+
+void virt_arch_pg_map(struct kvm_vm *vm, uint64_t gva, uint64_t gpa)
+{
+	gpa_t pt = vm->mmu.pgd;
+	uint64_t *ptep, pte;
+	int level;
+
+	for (level = 1; level <= 3; level++) {
+		uint64_t nls;
+		uint64_t *pdep = virt_get_pte(vm, pt, gva, level, &nls);
+		uint64_t pde = be64_to_cpu(*pdep);
+
+		if (pde) {
+			TEST_ASSERT((pde & PDE_VALID) && !(pde & PTE_LEAF),
+				    "Invalid PDE at level: %u gva: 0x%lx pde:0x%lx\n",
+				    level, gva, pde);
+			pt = pde & PDE_PT_MASK;
+			continue;
+		}
+
+		pt = __vm_alloc_pt(vm, nls + 3);
+		pde = PDE_VALID | nls | pt;
+		*pdep = cpu_to_be64(pde);
+	}
+
+	ptep = virt_get_pte(vm, pt, gva, level, NULL);
+	pte = be64_to_cpu(*ptep);
+
+	TEST_ASSERT(!pte, "PTE already present at level: %u gva: 0x%lx pte:0x%lx\n",
+		    level, gva, pte);
+
+	pte = PTE_VALID | PTE_LEAF | PTE_REFERENCED | PTE_CHANGED | PTE_PRIV |
+	      PTE_READ | PTE_RW | PTE_EXEC | (gpa & PTE_PAGE_MASK);
+	*ptep = cpu_to_be64(pte);
+}
+
+gpa_t addr_arch_gva2gpa(struct kvm_vm *vm, gva_t gva)
+{
+	gpa_t pt = vm->mmu.pgd;
+	uint64_t *ptep, pte;
+	int level;
+
+	for (level = 1; level <= 3; level++) {
+		uint64_t nls;
+		uint64_t *pdep = virt_get_pte(vm, pt, gva, level, &nls);
+		uint64_t pde = be64_to_cpu(*pdep);
+
+		TEST_ASSERT((pde & PDE_VALID) && !(pde & PTE_LEAF),
+			"PDE not present at level: %u gva: 0x%lx pde:0x%lx\n",
+			level, gva, pde);
+		pt = pde & PDE_PT_MASK;
+	}
+
+	ptep = virt_get_pte(vm, pt, gva, level, NULL);
+	pte = be64_to_cpu(*ptep);
+
+	TEST_ASSERT(pte,
+		"PTE not present at level: %u gva: 0x%lx pte:0x%lx\n",
+		level, gva, pte);
+
+	TEST_ASSERT((pte & PTE_VALID) && (pte & PTE_LEAF) &&
+		    (pte & PTE_READ) && (pte & PTE_RW) && (pte & PTE_EXEC),
+		    "PTE not valid at level: %u gva: 0x%lx pte:0x%lx\n",
+		    level, gva, pte);
+
+	return (pte & PTE_PAGE_MASK) + (gva & (vm->page_size - 1));
+}
+
+static void virt_dump_pt(FILE *stream, struct kvm_vm *vm, gpa_t pt,
+			 gva_t va, int level, uint8_t indent)
+{
+	int size, idx;
+
+	size = 1U << (pt_shift(vm, level) + 3);
+
+	for (idx = 0; idx < size; idx += 8, va += pt_entry_coverage(vm, level)) {
+		uint64_t *page_table = addr_gpa2hva(vm, pt + idx);
+		uint64_t pte = be64_to_cpu(*page_table);
+
+		if (!(pte & PTE_VALID))
+			continue;
+
+		if (pte & PTE_LEAF) {
+			fprintf(stream,
+				"%*s PTE[%d] gVA:0x%016lx -> gRA:0x%016llx\n",
+				indent, "", idx / 8, va, pte & PTE_PAGE_MASK);
+		} else {
+			fprintf(stream, "%*sPDE%d[%d] gVA:0x%016lx\n",
+				indent, "", level, idx / 8, va);
+			virt_dump_pt(stream, vm, pte & PDE_PT_MASK, va,
+				     level + 1, indent + 2);
+		}
+	}
+
+}
+
+void virt_arch_dump(FILE *stream, struct kvm_vm *vm, uint8_t indent)
+{
+	gpa_t pt = vm->mmu.pgd;
+
+	if (!vm->mmu.pgd_created)
+		return;
+
+	virt_dump_pt(stream, vm, pt, 0, 1, indent);
+}
+
+static unsigned long get_r2(void)
+{
+	unsigned long r2;
+
+	asm("mr %0,%%r2" : "=r"(r2));
+
+	return r2;
+}
+
+void vcpu_arch_set_entry_point(struct kvm_vcpu *vcpu, void *guest_code)
+{
+	struct kvm_regs regs;
+
+	vcpu_regs_get(vcpu, &regs);
+	regs.pc = (uintptr_t)guest_code;
+	regs.gpr[12] = (uintptr_t)guest_code;
+	vcpu_regs_set(vcpu, &regs);
+}
+
+struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
+{
+	const size_t stack_size = SZ_64K;
+	gva_t stack_vaddr, ex_regs_vaddr;
+	gpa_t ex_regs_paddr;
+	struct ex_regs *ex_regs;
+	struct kvm_regs regs;
+	struct kvm_vcpu *vcpu;
+	uint64_t lpcr;
+
+	stack_vaddr = __vm_alloc(vm, stack_size,
+				       DEFAULT_GUEST_STACK_VADDR_MIN,
+				       MEM_REGION_DATA);
+
+	ex_regs_vaddr = __vm_alloc(vm, stack_size,
+				       DEFAULT_GUEST_STACK_VADDR_MIN,
+				       MEM_REGION_DATA);
+	ex_regs_paddr = addr_gva2gpa(vm, ex_regs_vaddr);
+	ex_regs = addr_gpa2hva(vm, ex_regs_paddr);
+	ex_regs->vaddr = ex_regs_vaddr;
+
+	vcpu = __vm_vcpu_add(vm, vcpu_id);
+
+	vcpu_enable_cap(vcpu, KVM_CAP_PPC_PAPR, 1);
+
+	/* Setup guest registers */
+	vcpu_regs_get(vcpu, &regs);
+	lpcr = vcpu_get_reg(vcpu, KVM_REG_PPC_LPCR_64);
+
+	regs.gpr[1] = stack_vaddr + stack_size - 256;
+	regs.gpr[2] = (uintptr_t)get_r2();
+	regs.gpr[13] = (uintptr_t)ex_regs_paddr;
+
+	regs.msr = MSR_SF | MSR_VEC | MSR_VSX | MSR_FP |
+		   MSR_ME | MSR_IR | MSR_DR | MSR_RI;
+
+	if (BYTE_ORDER == LITTLE_ENDIAN) {
+		regs.msr |= MSR_LE;
+		lpcr |= LPCR_ILE;
+	} else {
+		lpcr &= ~LPCR_ILE;
+	}
+
+	vcpu_regs_set(vcpu, &regs);
+	vcpu_set_reg(vcpu, KVM_REG_PPC_LPCR_64, lpcr);
+
+	return vcpu;
+}
+
+void vcpu_args_set(struct kvm_vcpu *vcpu, unsigned int num, ...)
+{
+	va_list ap;
+	struct kvm_regs regs;
+	int i;
+
+	TEST_ASSERT(num >= 1 && num <= 5, "Unsupported number of args: %u\n",
+		    num);
+
+	va_start(ap, num);
+	vcpu_regs_get(vcpu, &regs);
+
+	for (i = 0; i < num; i++)
+		regs.gpr[i + 3] = va_arg(ap, uint64_t);
+
+	vcpu_regs_set(vcpu, &regs);
+	va_end(ap);
+}
+
+void vcpu_arch_dump(FILE *stream, struct kvm_vcpu *vcpu, uint8_t indent)
+{
+	struct kvm_regs regs;
+
+	vcpu_regs_get(vcpu, &regs);
+
+	fprintf(stream, "%*sNIA: 0x%016llx  MSR: 0x%016llx\n",
+			indent, "", regs.pc, regs.msr);
+	fprintf(stream, "%*sLR:  0x%016llx  CTR :0x%016llx\n",
+			indent, "", regs.lr, regs.ctr);
+	fprintf(stream, "%*sCR:  0x%08llx          XER :0x%016llx\n",
+			indent, "", regs.cr, regs.xer);
+}
+
+void kvm_arch_vm_post_create(struct kvm_vm *vm, unsigned int nr_vcpus)
+{
+	size_t excp_size = __interrupts_end - __interrupts_start;
+	size_t excp_pages = (excp_size + vm->page_size - 1) / vm->page_size;
+	gpa_t excp_paddr;
+	void *mem;
+
+	excp_paddr = vm_phy_pages_alloc(vm, excp_pages, 0,
+					vm->memslots[MEM_REGION_DATA]);
+
+	TEST_ASSERT(excp_paddr == 0,
+		    "Interrupt vectors not allocated at gPA address 0: (0x%lx)",
+		    excp_paddr);
+
+	mem = addr_gpa2hva(vm, excp_paddr);
+	memcpy(mem, __interrupts_start, excp_size);
+}
+
+void assert_on_unhandled_exception(struct kvm_vcpu *vcpu)
+{
+	struct ucall uc;
+
+	if (get_ucall(vcpu, &uc) == UCALL_UNHANDLED) {
+		gpa_t ex_regs_paddr;
+		struct ex_regs *ex_regs;
+		struct kvm_regs regs;
+
+		vcpu_regs_get(vcpu, &regs);
+		ex_regs_paddr = (gpa_t)regs.gpr[13];
+		ex_regs = addr_gpa2hva(vcpu->vm, ex_regs_paddr);
+
+		TEST_FAIL("Unexpected interrupt in guest NIA:0x%016lx MSR:0x%016lx TRAP:0x%04x",
+			  ex_regs->nia, ex_regs->msr, ex_regs->trap);
+	}
+}
+
+struct handler {
+	void (*fn)(struct ex_regs *regs);
+	int trap;
+};
+
+#define NR_HANDLERS	10
+static struct handler handlers[NR_HANDLERS];
+
+void route_interrupt(struct ex_regs *regs)
+{
+	int i;
+
+	for (i = 0; i < NR_HANDLERS; i++) {
+		if (handlers[i].trap == regs->trap) {
+			handlers[i].fn(regs);
+			return;
+		}
+	}
+
+	ucall(UCALL_UNHANDLED, 0);
+}
+
+void vm_install_exception_handler(struct kvm_vm *vm, int trap,
+			       void (*fn)(struct ex_regs *))
+{
+	int i;
+
+	for (i = 0; i < NR_HANDLERS; i++) {
+		if (!handlers[i].trap || handlers[i].trap == trap) {
+			if (fn == NULL)
+				trap = 0; /* Clear handler */
+			handlers[i].trap = trap;
+			handlers[i].fn = fn;
+			sync_global_to_guest(vm, handlers[i]);
+			return;
+		}
+	}
+
+	TEST_FAIL("Out of exception handlers");
+}
+
+void kvm_selftest_arch_init(void)
+{
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_PPC_MMU_RADIX));
+
+	/*
+	 * powerpc default mode is set by host page size and not static,
+	 * so start by computing that early.
+	 */
+	guest_modes_append_default();
+}
diff --git a/tools/testing/selftests/kvm/lib/powerpc/ucall.c b/tools/testing/selftests/kvm/lib/powerpc/ucall.c
new file mode 100644
index 000000000000..3481a7a0b850
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/powerpc/ucall.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ucall support. A ucall is a "hypercall to host userspace".
+ */
+#include "kvm_util.h"
+#include "ucall_common.h"
+#include "hcall.h"
+
+void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu)
+{
+	struct kvm_run *run = vcpu->run;
+
+	if (run->exit_reason == UCALL_EXIT_REASON &&
+	    run->papr_hcall.nr == H_UCALL) {
+		struct kvm_regs regs;
+
+		vcpu_regs_get(vcpu, &regs);
+		if (regs.gpr[4] == UCALL_R4_UCALL)
+			return (void *)regs.gpr[5];
+	}
+	return NULL;
+}
-- 
2.39.5


