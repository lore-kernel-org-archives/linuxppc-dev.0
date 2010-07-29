Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8590FB722B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 29 Jul 2010 22:48:18 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 16/27] KVM: PPC: Generic KVM PV guest support
Date: Thu, 29 Jul 2010 14:47:57 +0200
Message-Id: <1280407688-9815-17-git-send-email-agraf@suse.de>
In-Reply-To: <1280407688-9815-1-git-send-email-agraf@suse.de>
References: <1280407688-9815-1-git-send-email-agraf@suse.de>
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

v2 -> v3:

  - Add hypercall stub
---
 arch/powerpc/kernel/Makefile      |    2 +-
 arch/powerpc/kernel/asm-offsets.c |   15 +++++++++++++++
 arch/powerpc/kernel/kvm.c         |    3 +++
 arch/powerpc/kernel/kvm_emul.S    |   37 +++++++++++++++++++++++++++++++++++++
 arch/powerpc/platforms/Kconfig    |   10 ++++++++++
 5 files changed, 66 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/kernel/kvm_emul.S

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 5ea853d..d8e29b4 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -125,7 +125,7 @@ ifneq ($(CONFIG_XMON)$(CONFIG_KEXEC),)
 obj-y				+= ppc_save_regs.o
 endif
 
-obj-$(CONFIG_KVM_GUEST)		+= kvm.o
+obj-$(CONFIG_KVM_GUEST)		+= kvm.o kvm_emul.o
 
 # Disable GCOV in odd or sensitive code
 GCOV_PROFILE_prom_init.o := n
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
index 4f85505..a5ece71 100644
--- a/arch/powerpc/kernel/kvm.c
+++ b/arch/powerpc/kernel/kvm.c
@@ -30,6 +30,9 @@
 #include <asm/cacheflush.h>
 #include <asm/disassemble.h>
 
+#define KVM_MAGIC_PAGE		(-4096L)
+#define magic_var(x) KVM_MAGIC_PAGE + offsetof(struct kvm_vcpu_arch_shared, x)
+
 unsigned long kvm_hypercall(unsigned long *in,
 			    unsigned long *out,
 			    unsigned long nr)
diff --git a/arch/powerpc/kernel/kvm_emul.S b/arch/powerpc/kernel/kvm_emul.S
new file mode 100644
index 0000000..e0d4183
--- /dev/null
+++ b/arch/powerpc/kernel/kvm_emul.S
@@ -0,0 +1,37 @@
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
+/* Hypercall entry point. Will be patched with device tree instructions. */
+
+.global kvm_hypercall_start
+kvm_hypercall_start:
+	li	r3, -1
+	nop
+	nop
+	nop
+	blr
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
