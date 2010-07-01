Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 93D73B70A1
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  1 Jul 2010 20:43:07 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 17/27] KVM: PPC: Generic KVM PV guest support
Date: Thu,  1 Jul 2010 12:42:52 +0200
Message-Id: <1277980982-12433-18-git-send-email-agraf@suse.de>
In-Reply-To: <1277980982-12433-1-git-send-email-agraf@suse.de>
References: <1277980982-12433-1-git-send-email-agraf@suse.de>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We have all the hypervisor pieces in place now, but the guest parts are still
missing.

This patch implements basic awareness of KVM when running Linux as guest. It
doesn't do anything with it yet though.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kernel/Makefile      |    2 ++
 arch/powerpc/kernel/asm-offsets.c |   15 +++++++++++++++
 arch/powerpc/kernel/kvm.c         |   34 ++++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/kvm_emul.S    |   27 +++++++++++++++++++++++++++
 arch/powerpc/platforms/Kconfig    |   10 ++++++++++
 5 files changed, 88 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/kernel/kvm.c
 create mode 100644 arch/powerpc/kernel/kvm_emul.S

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 58d0572..2d7eb9e 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -125,6 +125,8 @@ ifneq ($(CONFIG_XMON)$(CONFIG_KEXEC),)
 obj-y				+= ppc_save_regs.o
 endif
 
+obj-$(CONFIG_KVM_GUEST) += kvm.o kvm_emul.o
+
 # Disable GCOV in odd or sensitive code
 GCOV_PROFILE_prom_init.o := n
 GCOV_PROFILE_ftrace.o := n
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index a55d47e..e3e740b 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -465,6 +465,21 @@ int main(void)
 	DEFINE(VCPU_FAULT_ESR, offsetof(struct kvm_vcpu, arch.fault_esr));
 #endif /* CONFIG_PPC_BOOK3S */
 #endif
+
+#ifdef CONFIG_KVM_GUEST
+	DEFINE(KVM_MAGIC_SCRATCH1, offsetof(struct kvm_vcpu_arch_shared,
+					    scratch1));
+	DEFINE(KVM_MAGIC_SCRATCH2, offsetof(struct kvm_vcpu_arch_shared,
+					    scratch2));
+	DEFINE(KVM_MAGIC_SCRATCH3, offsetof(struct kvm_vcpu_arch_shared,
+					    scratch3));
+	DEFINE(KVM_MAGIC_INT, offsetof(struct kvm_vcpu_arch_shared,
+				       int_pending));
+	DEFINE(KVM_MAGIC_MSR, offsetof(struct kvm_vcpu_arch_shared, msr));
+	DEFINE(KVM_MAGIC_CRITICAL, offsetof(struct kvm_vcpu_arch_shared,
+					    critical));
+#endif
+
 #ifdef CONFIG_44x
 	DEFINE(PGD_T_LOG2, PGD_T_LOG2);
 	DEFINE(PTE_T_LOG2, PTE_T_LOG2);
diff --git a/arch/powerpc/kernel/kvm.c b/arch/powerpc/kernel/kvm.c
new file mode 100644
index 0000000..2d8dd73
--- /dev/null
+++ b/arch/powerpc/kernel/kvm.c
@@ -0,0 +1,34 @@
+/*
+ * Copyright (C) 2010 SUSE Linux Products GmbH. All rights reserved.
+ *
+ * Authors:
+ *     Alexander Graf <agraf@suse.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ */
+
+#include <linux/kvm_host.h>
+#include <linux/init.h>
+#include <linux/kvm_para.h>
+#include <linux/slab.h>
+
+#include <asm/reg.h>
+#include <asm/kvm_ppc.h>
+#include <asm/sections.h>
+#include <asm/cacheflush.h>
+#include <asm/disassemble.h>
+
+#define KVM_MAGIC_PAGE		(-4096L)
+#define magic_var(x) KVM_MAGIC_PAGE + offsetof(struct kvm_vcpu_arch_shared, x)
+
diff --git a/arch/powerpc/kernel/kvm_emul.S b/arch/powerpc/kernel/kvm_emul.S
new file mode 100644
index 0000000..c7b9fc9
--- /dev/null
+++ b/arch/powerpc/kernel/kvm_emul.S
@@ -0,0 +1,27 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ *
+ * Copyright SUSE Linux Products GmbH 2010
+ *
+ * Authors: Alexander Graf <agraf@suse.de>
+ */
+
+#include <asm/ppc_asm.h>
+#include <asm/kvm_asm.h>
+#include <asm/reg.h>
+#include <asm/page.h>
+#include <asm/asm-offsets.h>
+
+#define KVM_MAGIC_PAGE		(-4096)
+
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index d1663db..1744349 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -21,6 +21,16 @@ source "arch/powerpc/platforms/44x/Kconfig"
 source "arch/powerpc/platforms/40x/Kconfig"
 source "arch/powerpc/platforms/amigaone/Kconfig"
 
+config KVM_GUEST
+	bool "KVM Guest support"
+	default y
+	---help---
+	  This option enables various optimizations for running under the KVM
+	  hypervisor. Overhead for the kernel when not running inside KVM should
+	  be minimal.
+
+	  In case of doubt, say Y
+
 config PPC_NATIVE
 	bool
 	depends on 6xx || PPC64
-- 
1.6.0.2
