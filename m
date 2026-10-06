Return-Path: <linuxppc-dev+bounces-28957-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CDFCCA5FF0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Oct 2026 10:30:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hzXZT3xS5z30TL;
	Tue, 06 Oct 2026 21:30:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::122c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791282609;
	cv=none; b=aKXZu8xdraIXJVCWmc9hCEGZN/bIPDV2mFRetdd5WPZDNkxzpzypEgs1ntiKzrv05KzLHBezBuTn3XVxYe5qhNUAPoJ4mAZ835ueDcnpwN5N3XIjbEUmFleIU/H7I2WVNIDPQUsnSG2QbOKzH4DSLxznrnIeBvFZiLeXWyRVCIRd2L2UfiwFUWEtdE7+7da/yfH5dQsmOn/vzFwEolPPsL5uSwb5xVUO2Trv0DElEvuxfZHFGHvl0pxVQJc6LReDzVJdXp7riEmHNOKwJ1y7iFELfY7L1oMfbRAPNVSxrDkEkTdy0qnJwPovdxPBItgWap8WuZuoZfSOsONjYuVpJA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791282609; c=relaxed/relaxed;
	bh=/VekKKQ4d8NfEXcplZ0vu1EaFf4Kzi+iCXCLSUvN+bU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M+34JyxLqaY9FDATP2ks2GbgBmHY8GQITXxJ5IRDRkRYzruymcBn64Ow/HbmeX+DolHJbMQz7qIGN5h6I6NospkFiLgyFrcY7DL5J8JMcHJcWcuFRUdoW4D/f2OEYfQnrY0SXUCbYR9cHSe6t/Zl9qRw5mVcndwNmT6amP6LtsanODAB0aUQ2OK7HVQu1FwHP09wsa2ECDqk9KjcDvujVxBBa9CkPr91vXYAh/9pxrQ5eoCfrebcPuZn8ppRgAKz+fMqjVTP5M8UFDIGzcetyaNbniFDUJye53WZw3o6wMrIUC3N9TwPDcNhgak8kB81w2Bg97n7Hlyq5ffGhYRLlw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nrCTi7Rc; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::122c; helo=mail-dl1-x122c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nrCTi7Rc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::122c; helo=mail-dl1-x122c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x122c.google.com (mail-dl1-x122c.google.com [IPv6:2607:f8b0:4864:20::122c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hzXZR4CK0z2xwd
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Oct 2026 21:30:07 +1100 (AEDT)
Received: by mail-dl1-x122c.google.com with SMTP id a92af1059eb24-14394530ec6so230527c88.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Oct 2026 03:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791282605; x=1791887405; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/VekKKQ4d8NfEXcplZ0vu1EaFf4Kzi+iCXCLSUvN+bU=;
        b=nrCTi7RcuHrvKqTpsm8vdLnwJVUFktnP+StBXsS+/SB4llx3NPLiWNjmwvAoLFpIiT
         ItRu/D+Ne/9KRp4B2fiDnaNPStaL1Hv8SUdHdVziO7Mkl/DMjsNSiwbe5Y9Cavg8eF5w
         UH+8Jr+Q++e0a9ccEOZccH3yxj1lOUxTd8EIs3Eny3flt2LXYnhFWT7MwVudgYtVG2io
         6zxwE4HKu6bKr0f4DGUUNOA/S9U2XcnAEMpJ0a3qymidizc7t7XrXX5jhCOTSDFZiPeq
         ymUaOwqRZhiQgENvB2ZPmve2FEUfD5ybLIE0aJIxVQU9DXnp+rj4LjPNsM1XElpW5S1S
         Qg+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791282605; x=1791887405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/VekKKQ4d8NfEXcplZ0vu1EaFf4Kzi+iCXCLSUvN+bU=;
        b=F3+4E1GIE1C3NAS17HsW5A/FtHhJ+tDEQWpW5TgTRKfNWjYlp1ytjhqd3Aq5Onu4Ah
         2Cjo5N4YoR5xZUL+LO9wQU2uLan92LyGoFdj8za0OpXWw/Ur60+dP+3HId5DZ/T8pPOS
         v1OjRNeqz2EaoFFLYFny17Q8+D3SaaMUgqUoJzm+XGW6eLR+8n4bgR7kD2YFNUfHP+7a
         49e94goNxqEnse/4lM53cBQ0Gvz6ydbVXrgbxfd72Xnuqbsxy2QkknYSCWhPm/0uah3l
         vG2cpr0FEp1v1OJm6sBeePHynfhAcKXfSvieScOvOgpkuhinGrfiNsxuhN/cipxqfe7Y
         aHTQ==
X-Forwarded-Encrypted: i=1; AKwUvBwmB0VEY4FawtjLUFSdNWLAilEj/meYD6x+VimI/G2SuQ/13sWd2QDE8B5sXFMH1qOhocuPtJf/1dHcdcc=@lists.ozlabs.org
X-Gm-Message-State: AFuF++m1vcdU915wElDR81Pk/09BxhTWYPE9IwientlTzZL2a8jhmasb
	Pv5Ohp1fNCfyNSx6T1XVneFzQnRjBbA9TfwqjlhkPrWgRtMlT8DaacbT
X-Gm-Gg: AYBFou1bbYCstgpvDAjQYppOoiTmvG9XIv8h3z/7ihn2vHcJaZy4YOaevn/AOUL5seH
	DjHIJBdx6pVAETCKI9QJzbMDa4FCiazkgf2L0S0Fr94dtncwLAu4LGc7Clp0xhZhjjjF1JBu69k
	ayxj7jrYmFB10FsVPMm5kWdf8MSFnenDxasCcdAslhR9o8q7a14lc0l9ZK9KqgJE+Ph33nyWAxZ
	A133LI/RRuPXwiQTdg8wiryCoT/SiRIlxmU72ynacd3ycZfli81RPPNYk+Hs1pIXuF7vZQQ7xIt
	gyHFJUP8un0TSh1pMNTMfg9oegrGv45ds5H0oov4TykvZ3iW5MWIczG/kXOxqjSghjq2CBNbHx1
	16TUpK0zaiGDCNpUP3oAU4+yoGV64xHxbiticJiW5NdQ6UEGfGAeQoOWSlvVWX4IcICCqG3a3xR
	0Ksxp51v/rmEmQ83Zj4PfcvZQBO/D52J92rI+QRLxhQKJBi4myXdAe3ygQbVcKvlXcNU6GjkFBp
	XQ7X7r03W7VtZgyb8QIpQ/hCRc7zxWxutNa/dtYBHyQl3/cm1bu1C0gziQ9
X-Received: by 2002:a05:7022:2603:b0:153:3c50:ab85 with SMTP id a92af1059eb24-15ec5e3b05fmr1606837c88.12.1791282604948;
        Tue, 06 Oct 2026 03:30:04 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-351469fa189sm7443970eec.6.2026.10.06.03.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 03:30:03 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: kvm@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	linuxppc-dev@lists.ozlabs.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	Nicholas Piggin <npiggin@gmail.com>,
	Ritesh Harjani <ritesh.list@gmail.com>
Subject: [PATCH v7 4/8] KVM: PPC: selftests: add support for powerpc
Date: Tue,  6 Oct 2026 15:58:38 +0530
Message-Id: <062570e96982a9a1a82e95c7ed0a3458321fd569.1791280439.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1791280439.git.ritesh.list@gmail.com>
References: <cover.1791280439.git.ritesh.list@gmail.com>
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

This patch series also changes the following types as done in other
selftests. These changes are squashed in this main patch as discussed
here [1]:
- Use u64 instead of uint64_t
- Use s64 instead of int64_t
- Use u32 instead of uint32_t
- Use u8 instead of uint8_t
- Replace u64 gpa, u64 gva|vaddr with gpa_t and gva_t
- Adopt to the new page table allocator APIs
- Start the guest at the entry point and not the descriptor in case of
  elfv1

[1]: https://lore.kernel.org/linuxppc-dev/cover.1781093720.git.ritesh.list@gmail.com/
[Rebased to latest mainline tree, "cc" to clobber list, fix the
size calculation in kvm_arch_vm_post_create()]

Co-developed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Link: https://lore.kernel.org/linuxppc-dev/cover.1781093720.git.ritesh.list@gmail.com/
Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 MAINTAINERS                                   |   2 +
 tools/testing/selftests/kvm/Makefile          |   2 +-
 tools/testing/selftests/kvm/Makefile.kvm      |   7 +
 .../testing/selftests/kvm/include/kvm_util.h  |   9 +
 .../selftests/kvm/include/powerpc/hcall.h     |  17 +
 .../kvm/include/powerpc/kvm_util_arch.h       |  22 +
 .../selftests/kvm/include/powerpc/ppc_asm.h   |  32 ++
 .../selftests/kvm/include/powerpc/processor.h |  39 ++
 .../selftests/kvm/include/powerpc/ucall.h     |  21 +
 tools/testing/selftests/kvm/lib/guest_modes.c |  20 +-
 tools/testing/selftests/kvm/lib/kvm_util.c    |   8 +
 .../selftests/kvm/lib/powerpc/handlers.S      |  93 ++++
 .../testing/selftests/kvm/lib/powerpc/hcall.c |  45 ++
 .../selftests/kvm/lib/powerpc/processor.c     | 512 ++++++++++++++++++
 .../testing/selftests/kvm/lib/powerpc/ucall.c |  22 +
 15 files changed, 848 insertions(+), 3 deletions(-)
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
index fc320b373656..35df0c39e991 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14349,6 +14349,8 @@ F:	arch/powerpc/include/asm/kvm*
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
index 96bab7002d39..4b7f6ab0ee54 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -53,6 +53,11 @@ LIBKVM_loongarch += lib/loongarch/processor.c
 LIBKVM_loongarch += lib/loongarch/ucall.c
 LIBKVM_loongarch += lib/loongarch/exception.S
 
+LIBKVM_powerpc += lib/powerpc/handlers.S
+LIBKVM_powerpc += lib/powerpc/processor.c
+LIBKVM_powerpc += lib/powerpc/ucall.c
+LIBKVM_powerpc += lib/powerpc/hcall.c
+
 # Non-compiled test targets
 TEST_PROGS_x86 += x86/nx_huge_pages_test.sh
 
@@ -251,6 +256,8 @@ TEST_GEN_PROGS_loongarch += memslot_perf_test
 TEST_GEN_PROGS_loongarch += set_memory_region_test
 TEST_GEN_PROGS_loongarch += steal_time
 
+TEST_GEN_PROGS_powerpc = $(TEST_GEN_PROGS_COMMON)
+
 SPLIT_TESTS += arch_timer
 SPLIT_TESTS += get-reg-list
 
diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 89b4fc2af751..9df16c8dc82a 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -241,6 +241,9 @@ enum vm_guest_mode {
 	VM_MODE_P41V48_4K,
 	VM_MODE_P41V39_4K,
 
+	VM_MODE_P52V52_4K,	/* For powerpc64 */
+	VM_MODE_P52V52_64K,
+
 	NUM_VM_MODES,
 };
 
@@ -300,6 +303,12 @@ extern enum vm_guest_mode vm_mode_default;
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
index 000000000000..21b2bf9180f1
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
+s64 hcall0(u64 token);
+s64 hcall1(u64 token, u64 arg1);
+s64 hcall2(u64 token, u64 arg1, u64 arg2);
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
index 000000000000..f0ee21a8e2d4
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/powerpc/processor.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * powerpc processor specific defines
+ */
+#ifndef SELFTEST_KVM_PROCESSOR_H
+#define SELFTEST_KVM_PROCESSOR_H
+
+#include <linux/compiler.h>
+#include "ppc_asm.h"
+#include "kvm_util_types.h"
+
+extern unsigned char __interrupts_start[];
+extern unsigned char __interrupts_end[];
+
+struct kvm_vm;
+struct kvm_vcpu;
+
+struct ex_regs {
+	u64	gprs[32];
+	u64	nia;
+	u64	msr;
+	u64	cfar;
+	u64	lr;
+	u64	ctr;
+	u64	xer;
+	u32	cr;
+	u32	trap;
+	gva_t	gva; /* gva of this struct */
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
index 57b653fbd0b1..2be79c240ebf 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -227,6 +227,8 @@ const char *vm_guest_mode_string(u32 i)
 		[VM_MODE_P41V57_4K]	= "PA-bits:41,  VA-bits:57,  4K pages",
 		[VM_MODE_P41V48_4K]	= "PA-bits:41,  VA-bits:48,  4K pages",
 		[VM_MODE_P41V39_4K]	= "PA-bits:41,  VA-bits:39,  4K pages",
+		[VM_MODE_P52V52_4K]	= "PA-bits:52,  VA-bits:52,  4K pages",
+		[VM_MODE_P52V52_64K]	= "PA-bits:52,  VA-bits:52, 64K pages",
 	};
 	_Static_assert(sizeof(strings)/sizeof(char *) == NUM_VM_MODES,
 		       "Missing new mode strings?");
@@ -263,6 +265,8 @@ const struct vm_guest_mode_params vm_guest_mode_params[] = {
 	[VM_MODE_P41V57_4K]	= { 41, 57,  0x1000, 12 },
 	[VM_MODE_P41V48_4K]	= { 41, 48,  0x1000, 12 },
 	[VM_MODE_P41V39_4K]	= { 41, 39,  0x1000, 12 },
+	[VM_MODE_P52V52_4K]	= { 52, 52,  0x1000, 12 },
+	[VM_MODE_P52V52_64K]	= { 52, 52, 0x10000, 16 },
 };
 _Static_assert(sizeof(vm_guest_mode_params)/sizeof(struct vm_guest_mode_params) == NUM_VM_MODES,
 	       "Missing new mode params?");
@@ -383,6 +387,10 @@ struct kvm_vm *____vm_create(struct vm_shape shape)
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
index 000000000000..d5f5282654ee
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
+s64 hcall0(u64 token)
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
+s64 hcall1(u64 token, u64 arg1)
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
+s64 hcall2(u64 token, u64 arg1, u64 arg2)
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
index 000000000000..301455024571
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/powerpc/processor.c
@@ -0,0 +1,512 @@
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
+/*
+ * A radix table must be aligned to its size, and the tables are larger than
+ * the guest base page size for several level/page size combinations.
+ */
+bool kvm_arch_needs_naturally_aligned_page_tables(void)
+{
+	return true;
+}
+
+static void set_proc_table(struct kvm_vm *vm, int pid, u64 dw0, u64 dw1)
+{
+	u64 *proc_table;
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
+	if (vm->mmu.pgd_created)
+		return;
+
+	prtb = vm_alloc_page_table(vm);
+	vm->arch.prtb = prtb;
+
+	pgd_pages = (1UL << (RADIX_PGD_INDEX_SIZE + 3)) >> vm->page_shift;
+	if (!pgd_pages)
+		pgd_pages = 1;
+	pgtb = vm_alloc_page_table_pages(vm, pgd_pages);
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
+
+	vm->mmu.pgd_created = true;
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
+static u64 pt_entry_coverage(struct kvm_vm *vm, int level)
+{
+	u64 size = vm->page_size;
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
+static int pt_idx(struct kvm_vm *vm, gva_t gva, int level, u64 *nls)
+{
+	switch (level) {
+	case 1:
+		if (nls)
+			*nls = 0x9;
+		return (gva >> 39) & 0x1fff;
+	case 2:
+		if (nls)
+			*nls = 0x9;
+		return (gva >> 30) & 0x1ff;
+	case 3:
+		if (vm->mode == VM_MODE_P52V52_4K) {
+			if (nls)
+				*nls = 0x9;
+		} else { /* vm->mode == VM_MODE_P52V52_64K */
+			if (nls)
+				*nls = 0x5;
+		}
+		return (gva >> 21) & 0x1ff;
+	case 4:
+		if (vm->mode == VM_MODE_P52V52_4K)
+			return (gva >> 12) & 0x1ff;
+		else /* vm->mode == VM_MODE_P52V52_64K */
+			return (gva >> 16) & 0x1f;
+	default:
+		TEST_ASSERT(false, "Invalid page table level %d\n", level);
+		return 0;
+	}
+}
+
+static u64 *virt_get_pte(struct kvm_vm *vm, gpa_t pt,
+			  gva_t gva, int level, u64 *nls)
+{
+	int idx = pt_idx(vm, gva, level, nls);
+	u64 *ptep = addr_gpa2hva(vm, pt + idx * 8);
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
+static gpa_t __vm_alloc_pt(struct kvm_vm *vm, u64 pt_shift)
+{
+	gpa_t pt;
+
+	if (pt_shift >= vm->page_shift) {
+		size_t pt_pages = 1ULL << (pt_shift - vm->page_shift);
+
+		pt = vm_alloc_page_table_pages(vm, pt_pages);
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
+		if (!pt_frag_cache->page)
+			pt_frag_cache->page = vm_alloc_page_table(vm);
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
+void virt_arch_pg_map(struct kvm_vm *vm, gva_t gva, gpa_t gpa)
+{
+	gpa_t pt = vm->mmu.pgd;
+	u64 *ptep, pte;
+	int level;
+
+	for (level = 1; level <= 3; level++) {
+		u64 nls;
+		u64 *pdep = virt_get_pte(vm, pt, gva, level, &nls);
+		u64 pde = be64_to_cpu(*pdep);
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
+	u64 *ptep, pte;
+	int level;
+
+	for (level = 1; level <= 3; level++) {
+		u64 nls;
+		u64 *pdep = virt_get_pte(vm, pt, gva, level, &nls);
+		u64 pde = be64_to_cpu(*pdep);
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
+	TEST_ASSERT((pte & PTE_VALID) && (pte & PTE_LEAF),
+		    "PTE not valid at level: %u gva: 0x%lx pte:0x%lx\n",
+		    level, gva, pte);
+
+	return (pte & PTE_PAGE_MASK) + (gva & (vm->page_size - 1));
+}
+
+static void virt_dump_pt(FILE *stream, struct kvm_vm *vm, gpa_t pt,
+			 gva_t va, int level, u8 indent)
+{
+	int size, idx;
+
+	size = 1U << (pt_shift(vm, level) + 3);
+
+	for (idx = 0; idx < size; idx += 8, va += pt_entry_coverage(vm, level)) {
+		u64 *page_table = addr_gpa2hva(vm, pt + idx);
+		u64 pte = be64_to_cpu(*page_table);
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
+void virt_arch_dump(FILE *stream, struct kvm_vm *vm, u8 indent)
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
+/*
+ * Under ELFv1 a function pointer is the address of a descriptor holding the
+ * entry point and the TOC, not the entry point itself.  ELFv2 dropped
+ * descriptors, i.e. the pointer is already the entry point.  Dereference the
+ * descriptor as needed so that the guest starts executing code and not data.
+ */
+static uintptr_t function_entry(void *fn)
+{
+#if defined(_CALL_ELF) && _CALL_ELF == 2
+	return (uintptr_t)fn;
+#else
+	return ((const u64 *)fn)[0];
+#endif
+}
+
+void vcpu_arch_set_entry_point(struct kvm_vcpu *vcpu, void *guest_code)
+{
+	uintptr_t entry = function_entry(guest_code);
+	struct kvm_regs regs;
+
+	vcpu_regs_get(vcpu, &regs);
+	regs.pc = entry;
+	regs.gpr[12] = entry;
+	vcpu_regs_set(vcpu, &regs);
+}
+
+struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, u32 vcpu_id)
+{
+	const size_t stack_size = SZ_64K;
+	gva_t stack_vaddr, ex_regs_vaddr;
+	gpa_t ex_regs_paddr;
+	struct ex_regs *ex_regs;
+	struct kvm_regs regs;
+	struct kvm_vcpu *vcpu;
+	u64 lpcr;
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
+	ex_regs->gva = ex_regs_vaddr;
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
+		regs.gpr[i + 3] = va_arg(ap, u64);
+
+	vcpu_regs_set(vcpu, &regs);
+	va_end(ap);
+}
+
+void vcpu_arch_dump(FILE *stream, struct kvm_vcpu *vcpu, u8 indent)
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
+	/*
+	 * Guest interrupts are taken in real-mode, i.e. the vectors must live
+	 * at gPA 0.  Use the innermost allocator to override the minimum GPA
+	 * that MEM_REGION_DATA would otherwise impose.
+	 */
+	excp_paddr = ____vm_phy_pages_alloc(vm, excp_pages, 0,
+					    vm->memslots[MEM_REGION_DATA],
+					    vm_arch_has_protected_memory(vm),
+					    false);
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


