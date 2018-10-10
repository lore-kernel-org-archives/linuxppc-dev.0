Return-Path: <SRS0=lRG+=MW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D99EC43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 05:17:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C762321479
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 05:17:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C762321479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42VMm06RdLzF0wf
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 16:17:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42VMgt4L6DzF09n
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 16:13:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 42VMgt3f79z9sC7; Wed, 10 Oct 2018 16:13:30 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 42VMgt2zJhz9sB7; Wed, 10 Oct 2018 16:13:30 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/4] powerpc: Add -Werror at arch/powerpc level
Date: Wed, 10 Oct 2018 16:13:06 +1100
Message-Id: <20181010051308.25422-2-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181010051308.25422-1-mpe@ellerman.id.au>
References: <20181010051308.25422-1-mpe@ellerman.id.au>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: maddy@linux.ibm.com, keescook@chromium.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Back when I added -Werror in commit ba55bd74360e ("powerpc: Add
configurable -Werror for arch/powerpc") I did it by adding it to most
of the arch Makefiles.

At the time we excluded math-emu, because apparently it didn't build
cleanly. But that seems to have been fixed somewhere in the interim.

So move the -Werror addition to the top-level of the arch, this saves
us from repeating it in every Makefile and means we won't forget to
add it to any new sub-dirs.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/Kbuild                | 2 ++
 arch/powerpc/kernel/Makefile       | 2 --
 arch/powerpc/kernel/trace/Makefile | 2 --
 arch/powerpc/kvm/Makefile          | 2 --
 arch/powerpc/lib/Makefile          | 2 --
 arch/powerpc/mm/Makefile           | 2 --
 arch/powerpc/oprofile/Makefile     | 1 -
 arch/powerpc/perf/Makefile         | 1 -
 arch/powerpc/platforms/Makefile    | 2 --
 arch/powerpc/sysdev/Makefile       | 3 ---
 arch/powerpc/sysdev/xics/Makefile  | 1 -
 arch/powerpc/sysdev/xive/Makefile  | 1 -
 arch/powerpc/xmon/Makefile         | 2 --
 13 files changed, 2 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/Kbuild b/arch/powerpc/Kbuild
index 690a498da050..1625a06802ca 100644
--- a/arch/powerpc/Kbuild
+++ b/arch/powerpc/Kbuild
@@ -1,3 +1,5 @@
+subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
+
 obj-y += kernel/
 obj-y += mm/
 obj-y += lib/
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 85ffa488dfb5..006e391814ed 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -5,8 +5,6 @@
 
 CFLAGS_ptrace.o		+= -DUTS_MACHINE='"$(UTS_MACHINE)"'
 
-subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
-
 ifdef CONFIG_PPC64
 CFLAGS_prom_init.o	+= $(NO_MINIMAL_TOC)
 endif
diff --git a/arch/powerpc/kernel/trace/Makefile b/arch/powerpc/kernel/trace/Makefile
index d868ba42032f..b1725ad3e13d 100644
--- a/arch/powerpc/kernel/trace/Makefile
+++ b/arch/powerpc/kernel/trace/Makefile
@@ -3,8 +3,6 @@
 # Makefile for the powerpc trace subsystem
 #
 
-subdir-ccflags-$(CONFIG_PPC_WERROR)	:= -Werror
-
 ifdef CONFIG_FUNCTION_TRACER
 # do not trace tracer code
 CFLAGS_REMOVE_ftrace.o = $(CC_FLAGS_FTRACE)
diff --git a/arch/powerpc/kvm/Makefile b/arch/powerpc/kvm/Makefile
index f872c04bb5b1..e9d579921a96 100644
--- a/arch/powerpc/kvm/Makefile
+++ b/arch/powerpc/kvm/Makefile
@@ -3,8 +3,6 @@
 # Makefile for Kernel-based Virtual Machine module
 #
 
-subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
-
 ccflags-y := -Ivirt/kvm -Iarch/powerpc/kvm
 KVM := ../../../virt/kvm
 
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index 670286808928..703afa1808ed 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -3,8 +3,6 @@
 # Makefile for ppc-specific library files..
 #
 
-subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
-
 ccflags-$(CONFIG_PPC64)	:= $(NO_MINIMAL_TOC)
 
 CFLAGS_REMOVE_code-patching.o = $(CC_FLAGS_FTRACE)
diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index cdf6a9960046..90e103ab44fb 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -3,8 +3,6 @@
 # Makefile for the linux ppc-specific parts of the memory manager.
 #
 
-subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
-
 ccflags-$(CONFIG_PPC64)	:= $(NO_MINIMAL_TOC)
 
 obj-y				:= fault.o mem.o pgtable.o mmap.o \
diff --git a/arch/powerpc/oprofile/Makefile b/arch/powerpc/oprofile/Makefile
index 7a7834c39f64..8d26d7416481 100644
--- a/arch/powerpc/oprofile/Makefile
+++ b/arch/powerpc/oprofile/Makefile
@@ -1,5 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
 
 ccflags-$(CONFIG_PPC64)	:= $(NO_MINIMAL_TOC)
 
diff --git a/arch/powerpc/perf/Makefile b/arch/powerpc/perf/Makefile
index 82986d2acd9b..ab26df5bacb9 100644
--- a/arch/powerpc/perf/Makefile
+++ b/arch/powerpc/perf/Makefile
@@ -1,5 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
 
 obj-$(CONFIG_PERF_EVENTS)	+= callchain.o perf_regs.o
 
diff --git a/arch/powerpc/platforms/Makefile b/arch/powerpc/platforms/Makefile
index e46bb7ea710f..143d4417f6cc 100644
--- a/arch/powerpc/platforms/Makefile
+++ b/arch/powerpc/platforms/Makefile
@@ -1,7 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
-subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
-
 obj-$(CONFIG_FSL_ULI1575)	+= fsl_uli1575.o
 
 obj-$(CONFIG_PPC_PMAC)		+= powermac/
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index f730539074c4..2caa4defdfb6 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -1,5 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
 
 ccflags-$(CONFIG_PPC64)		:= $(NO_MINIMAL_TOC)
 
@@ -56,8 +55,6 @@ obj-$(CONFIG_PPC_SCOM)		+= scom.o
 
 obj-$(CONFIG_PPC_EARLY_DEBUG_MEMCONS)	+= udbg_memcons.o
 
-subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
-
 obj-$(CONFIG_PPC_XICS)		+= xics/
 obj-$(CONFIG_PPC_XIVE)		+= xive/
 
diff --git a/arch/powerpc/sysdev/xics/Makefile b/arch/powerpc/sysdev/xics/Makefile
index 5d438d92472b..ba1e3117b1c0 100644
--- a/arch/powerpc/sysdev/xics/Makefile
+++ b/arch/powerpc/sysdev/xics/Makefile
@@ -1,5 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
 
 obj-y				+= xics-common.o
 obj-$(CONFIG_PPC_ICP_NATIVE)	+= icp-native.o
diff --git a/arch/powerpc/sysdev/xive/Makefile b/arch/powerpc/sysdev/xive/Makefile
index 536d6e5706e3..dea2abc23f4d 100644
--- a/arch/powerpc/sysdev/xive/Makefile
+++ b/arch/powerpc/sysdev/xive/Makefile
@@ -1,4 +1,3 @@
-subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
 
 obj-y				+= common.o
 obj-$(CONFIG_PPC_XIVE_NATIVE)	+= native.o
diff --git a/arch/powerpc/xmon/Makefile b/arch/powerpc/xmon/Makefile
index 93cc1f1b8b61..ab5f66affb06 100644
--- a/arch/powerpc/xmon/Makefile
+++ b/arch/powerpc/xmon/Makefile
@@ -1,8 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for xmon
 
-subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
-
 GCOV_PROFILE := n
 UBSAN_SANITIZE := n
 
-- 
2.17.1

