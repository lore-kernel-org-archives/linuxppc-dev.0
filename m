Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 96E361A03DF
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Mar 2016 15:27:04 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: bsingharora@gmail.com, duwe@lst.de, <linux-kernel@vger.kernel.org>,
 rostedt@goodmis.org, kamalesh@linux.vnet.ibm.com, pmladek@suse.com,
 jeyu@redhat.com, jkosina@suse.cz, live-patching@vger.kernel.org,
 mbenes@suse.cz
Subject: [PATCH v3 8/8] powerpc/ftrace: Add Kconfig & Make glue for
 mprofile-kernel
Date: Thu,  3 Mar 2016 15:27:00 +1100
Message-Id: <1456979220-10931-8-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1456979220-10931-1-git-send-email-mpe@ellerman.id.au>
References: <1456979220-10931-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Torsten Duwe <duwe@lst.de>

Firstly we add logic to Kconfig to allow a user to choose if they want
mprofile-kernel. This has to be user-selectable because only some
current toolchains support it. If we enabled it unconditionally we would
prevent some users from building the kernel entirely.

Arguably it would be nice if we could detect if mprofile-kernel was
available, and use it then. However that would violate the principle of
least surprise because a user having choosen options such as live
patching, would then see them quietly disabled at build time.

We also make the user selectable option negative, ie. it disables when
selected, so that allyesconfig continues to build on old toolchains.

Once we've decided we do want to use mprofile-kernel, we then add a
script which checks it actually works. That is because there are
versions of gcc that accept the flag but don't generate correct code.

Due to the way kconfig works, we can't error out when we detect a
non-working toolchain. If we did a user would never be able to modify
their config and run oldconfig - because the check would block oldconfig
from running. Instead we emit a warning and add a bogus flag to CFLAGS
so that the build will fail.

Signed-off-by: Torsten Duwe <duwe@suse.de>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/Kconfig                              | 19 +++++++++++++++++++
 arch/powerpc/Makefile                             | 15 +++++++++++++++
 arch/powerpc/scripts/gcc-check-mprofile-kernel.sh | 23 +++++++++++++++++++++++
 3 files changed, 57 insertions(+)
 create mode 100755 arch/powerpc/scripts/gcc-check-mprofile-kernel.sh

v3: MPROFILE_KERNEL needs to also depend on PPC64 && LITTLE_ENDIAN,
    otherwise it incorrectly appears on 32 bit builds.
v2: Rework to prevent breaking the build by default for users with
    unsupported toolchains.
    Warn rather than erroring so that users can run oldconfig.

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 9faa18c4f3f7..df415370f891 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -94,6 +94,7 @@ config PPC
 	select OF_RESERVED_MEM
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_DYNAMIC_FTRACE
+	select HAVE_DYNAMIC_FTRACE_WITH_REGS if MPROFILE_KERNEL
 	select HAVE_FUNCTION_TRACER
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select SYSCTL_EXCEPTION_TRACE
@@ -373,6 +374,24 @@ config PPC_TRANSACTIONAL_MEM
        ---help---
          Support user-mode Transactional Memory on POWERPC.
 
+config DISABLE_MPROFILE_KERNEL
+	bool "Disable use of mprofile-kernel for kernel tracing"
+	depends on PPC64 && CPU_LITTLE_ENDIAN
+	default y
+	help
+	  Selecting this options disables use of the mprofile-kernel ABI for
+	  kernel tracing. That will cause options such as live patching
+	  (CONFIG_LIVEPATCH) which depend on CONFIG_DYNAMIC_FTRACE_WITH_REGS to
+	  be disabled also.
+
+	  If you have a toolchain which supports mprofile-kernel, then you can
+	  enable this. Otherwise leave it disabled. If you're not sure, say
+	  "N".
+
+config MPROFILE_KERNEL
+	depends on PPC64 && CPU_LITTLE_ENDIAN
+	def_bool !DISABLE_MPROFILE_KERNEL
+
 config IOMMU_HELPER
 	def_bool PPC64
 
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 96efd8213c1c..f4e49a4153cb 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -133,6 +133,21 @@ else
 CFLAGS-$(CONFIG_GENERIC_CPU) += -mcpu=powerpc64
 endif
 
+ifdef CONFIG_MPROFILE_KERNEL
+    ifeq ($(shell $(srctree)/arch/powerpc/scripts/gcc-check-mprofile-kernel.sh $(CC) -I$(srctree)/include -D__KERNEL__),OK)
+        CC_FLAGS_FTRACE := -pg -mprofile-kernel
+        KBUILD_CPPFLAGS += -DCC_USING_MPROFILE_KERNEL
+    else
+        # If the user asked for mprofile-kernel but the toolchain doesn't
+        # support it, emit a warning and deliberately break the build later
+        # with mprofile-kernel-not-supported. We would prefer to make this an
+        # error right here, but then the user would never be able to run
+        # oldconfig to change their configuration.
+        $(warning Compiler does not support mprofile-kernel, set CONFIG_DISABLE_MPROFILE_KERNEL)
+        CC_FLAGS_FTRACE := -mprofile-kernel-not-supported
+    endif
+endif
+
 CFLAGS-$(CONFIG_CELL_CPU) += $(call cc-option,-mcpu=cell)
 CFLAGS-$(CONFIG_POWER4_CPU) += $(call cc-option,-mcpu=power4)
 CFLAGS-$(CONFIG_POWER5_CPU) += $(call cc-option,-mcpu=power5)
diff --git a/arch/powerpc/scripts/gcc-check-mprofile-kernel.sh b/arch/powerpc/scripts/gcc-check-mprofile-kernel.sh
new file mode 100755
index 000000000000..c658d8cf760b
--- /dev/null
+++ b/arch/powerpc/scripts/gcc-check-mprofile-kernel.sh
@@ -0,0 +1,23 @@
+#!/bin/bash
+
+set -e
+set -o pipefail
+
+# To debug, uncomment the following line
+# set -x
+
+# Test whether the compile option -mprofile-kernel exists and generates
+# profiling code (ie. a call to _mcount()).
+echo "int func() { return 0; }" | \
+    $* -S -x c -O2 -p -mprofile-kernel - -o - 2> /dev/null | \
+    grep -q "_mcount"
+
+# Test whether the notrace attribute correctly suppresses calls to _mcount().
+
+echo -e "#include <linux/compiler.h>\nnotrace int func() { return 0; }" | \
+    $* -S -x c -O2 -p -mprofile-kernel - -o - 2> /dev/null | \
+    grep -q "_mcount" && \
+    exit 1
+
+echo "OK"
+exit 0
-- 
2.5.0
