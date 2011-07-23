Return-Path: <paulus@ozlabs.org>
Date: Sat, 23 Jul 2011 17:41:11 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org,
	Alexander Graf <agraf@suse.de>
Subject: [PATCH 1/3] KVM: PPC: Assemble book3s{,_hv}_rmhandlers.S separately
Message-ID: <20110723074111.GA17927@bloggs.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This makes arch/powerpc/kvm/book3s_rmhandlers.S and
arch/powerpc/kvm/book3s_hv_rmhandlers.S be assembled as
separate compilation units rather than having them #included in
arch/powerpc/kernel/exceptions-64s.S.  We no longer have any
conditional branches between the exception prologs in
exceptions-64s.S and the KVM handlers, so there is no need to
keep their contents close together in the vmlinux image.

In their current location, they are using up part of the limited
space between the first-level interrupt handlers and the firmware
NMI data area at offset 0x7000, and with some kernel configurations
this area will overflow (e.g. allyesconfig), leading to an
"attempt to .org backwards" error when compiling exceptions-64s.S.

Moving them out requires that we add some #includes that the
book3s_{,hv_}rmhandlers.S code was previously getting implicitly
via exceptions-64s.S.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/kernel/exceptions-64s.S    |   10 ----------
 arch/powerpc/kvm/Makefile               |    3 +++
 arch/powerpc/kvm/book3s_hv_rmhandlers.S |    3 +++
 arch/powerpc/kvm/book3s_rmhandlers.S    |    3 +++
 4 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 41b02c7..29ddd8b 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -427,16 +427,6 @@ slb_miss_user_pseries:
 	b	.				/* prevent spec. execution */
 #endif /* __DISABLED__ */
 
-/* KVM's trampoline code needs to be close to the interrupt handlers */
-
-#ifdef CONFIG_KVM_BOOK3S_64_HANDLER
-#ifdef CONFIG_KVM_BOOK3S_PR
-#include "../kvm/book3s_rmhandlers.S"
-#else
-#include "../kvm/book3s_hv_rmhandlers.S"
-#endif
-#endif
-
 	.align	7
 	.globl	__end_interrupts
 __end_interrupts:
diff --git a/arch/powerpc/kvm/Makefile b/arch/powerpc/kvm/Makefile
index 08428e2..e161680 100644
--- a/arch/powerpc/kvm/Makefile
+++ b/arch/powerpc/kvm/Makefile
@@ -49,12 +49,15 @@ kvm-book3s_64-objs-$(CONFIG_KVM_BOOK3S_64_PR) := \
 	book3s_64_mmu_host.o \
 	book3s_64_mmu.o \
 	book3s_32_mmu.o
+kvm-book3s_64-builtin-objs-$(CONFIG_KVM_BOOK3S_64_PR) := \
+	book3s_rmhandlers.o
 
 kvm-book3s_64-objs-$(CONFIG_KVM_BOOK3S_64_HV) := \
 	book3s_hv.o \
 	book3s_hv_interrupts.o \
 	book3s_64_mmu_hv.o
 kvm-book3s_64-builtin-objs-$(CONFIG_KVM_BOOK3S_64_HV) := \
+	book3s_hv_rmhandlers.o \
 	book3s_hv_rm_mmu.o \
 	book3s_64_vio_hv.o \
 	book3s_hv_builtin.o
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 6dd3358..543ee50 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -20,7 +20,10 @@
 #include <asm/ppc_asm.h>
 #include <asm/kvm_asm.h>
 #include <asm/reg.h>
+#include <asm/mmu.h>
 #include <asm/page.h>
+#include <asm/ptrace.h>
+#include <asm/hvcall.h>
 #include <asm/asm-offsets.h>
 #include <asm/exception-64s.h>
 
diff --git a/arch/powerpc/kvm/book3s_rmhandlers.S b/arch/powerpc/kvm/book3s_rmhandlers.S
index c1f877c..5ee66ed 100644
--- a/arch/powerpc/kvm/book3s_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_rmhandlers.S
@@ -20,6 +20,7 @@
 #include <asm/ppc_asm.h>
 #include <asm/kvm_asm.h>
 #include <asm/reg.h>
+#include <asm/mmu.h>
 #include <asm/page.h>
 #include <asm/asm-offsets.h>
 
@@ -39,6 +40,7 @@
 #define MSR_NOIRQ		MSR_KERNEL & ~(MSR_IR | MSR_DR)
 #define FUNC(name) 		GLUE(.,name)
 
+	.globl	kvmppc_skip_interrupt
 kvmppc_skip_interrupt:
 	/*
 	 * Here all GPRs are unchanged from when the interrupt happened
@@ -51,6 +53,7 @@ kvmppc_skip_interrupt:
 	rfid
 	b	.
 
+	.globl	kvmppc_skip_Hinterrupt
 kvmppc_skip_Hinterrupt:
 	/*
 	 * Here all GPRs are unchanged from when the interrupt happened
-- 
1.7.5.4
