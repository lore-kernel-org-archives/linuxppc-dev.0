Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yVFVl6cHYzDqwS
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  5 Nov 2017 23:34:07 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id n14so5677032pfh.8
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Nov 2017 04:34:07 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@ozlabs.org>,
 kvm-ppc@vger.kernel.org
Subject: [PATCH] KVM: PPC: Book3S HV: Handle host system reset in guest mode
Date: Sun,  5 Nov 2017 23:33:55 +1100
Message-Id: <20171105123355.3014-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If the host takes a system reset interrupt while a guest is running,
the CPU must exit the guest before processing the host exception
handler.

After this patch, taking a sysrq+x with a CPU running in a guest
gives a trace like this:

   cpu 0x27: Vector: 100 (System Reset) at [c000000fdf5776f0]
       pc: c008000010158b80: kvmppc_run_core+0x16b8/0x1ad0 [kvm_hv]
       lr: c008000010158b80: kvmppc_run_core+0x16b8/0x1ad0 [kvm_hv]
       sp: c000000fdf577850
      msr: 9000000002803033
     current = 0xc000000fdf4b1e00
     paca    = 0xc00000000fd4d680	 softe: 3	 irq_happened: 0x01
       pid   = 6608, comm = qemu-system-ppc
   Linux version 4.14.0-rc7-01489-g47e1893a404a-dirty #26 SMP
   [c000000fdf577a00] c008000010159dd4 kvmppc_vcpu_run_hv+0x3dc/0x12d0 [kvm_hv]
   [c000000fdf577b30] c0080000100a537c kvmppc_vcpu_run+0x44/0x60 [kvm]
   [c000000fdf577b60] c0080000100a1ae0 kvm_arch_vcpu_ioctl_run+0x118/0x310 [kvm]
   [c000000fdf577c00] c008000010093e98 kvm_vcpu_ioctl+0x530/0x7c0 [kvm]
   [c000000fdf577d50] c000000000357bf8 do_vfs_ioctl+0xd8/0x8c0
   [c000000fdf577df0] c000000000358448 SyS_ioctl+0x68/0x100
   [c000000fdf577e30] c00000000000b220 system_call+0x58/0x6c
   --- Exception: c01 (System Call) at 00007fff76868df0
   SP (7fff7069baf0) is in userspace

Fixes: e36d0a2ed5 ("powerpc/powernv: Implement NMI IPI with OPAL_SIGNAL_SYSTEM_RESET")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
--

It has always been possible to sreset the host with direct scom
access, but the patch e36d0a2ed5 has significantly expanded this
functionality so in practice this is a required as a fix for it.

Since RFC:
- Removed the last hunk as sugggested by Paul.
- Re-tested.

Thanks,
Nick
---
 arch/powerpc/include/asm/hw_irq.h    | 1 +
 arch/powerpc/kernel/exceptions-64s.S | 2 ++
 arch/powerpc/kernel/irq.c            | 3 ++-
 arch/powerpc/kvm/book3s_hv.c         | 7 ++++++-
 4 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index 92a3e9a79cb4..a8bbac425ae6 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -40,6 +40,7 @@
 
 #ifndef __ASSEMBLY__
 
+extern void replay_system_reset(void);
 extern void __replay_interrupt(unsigned int vector);
 
 extern void timer_interrupt(struct pt_regs *);
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 651e1a0114ed..bff2ed6e3c3c 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -113,6 +113,7 @@ EXC_VIRT_NONE(0x4000, 0x100)
 	cmpwi	cr3,r10,2 ;						\
 	BRANCH_TO_C000(r10, system_reset_idle_common) ;			\
 1:									\
+	KVMTEST_PR(n) ;							\
 	END_FTR_SECTION_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_206)
 #else
 #define IDLETEST NOTEST
@@ -129,6 +130,7 @@ EXC_REAL_BEGIN(system_reset, 0x100, 0x100)
 
 EXC_REAL_END(system_reset, 0x100, 0x100)
 EXC_VIRT_NONE(0x4100, 0x100)
+TRAMP_KVM(PACA_EXNMI, 0x100)
 
 #ifdef CONFIG_PPC_P7_NAP
 EXC_COMMON_BEGIN(system_reset_idle_common)
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index efbadcbbf694..7e8259106944 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -437,7 +437,7 @@ static const u8 srr1_to_lazyirq[0x10] = {
 	PACA_IRQ_HMI,
 	0, 0, 0, 0, 0 };
 
-static noinline void replay_system_reset(void)
+void replay_system_reset(void)
 {
 	struct pt_regs regs;
 
@@ -447,6 +447,7 @@ static noinline void replay_system_reset(void)
 	system_reset_exception(&regs);
 	get_paca()->in_nmi = 0;
 }
+EXPORT_SYMBOL_GPL(replay_system_reset);
 
 void irq_set_pending_from_srr1(unsigned long srr1)
 {
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 8f34715cfbff..31a362669fea 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -47,6 +47,7 @@
 
 #include <asm/reg.h>
 #include <asm/ppc-opcode.h>
+#include <asm/asm-prototypes.h>
 #include <asm/disassemble.h>
 #include <asm/cputable.h>
 #include <asm/cacheflush.h>
@@ -1089,9 +1090,10 @@ static int kvmppc_handle_exit_hv(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		vcpu->stat.ext_intr_exits++;
 		r = RESUME_GUEST;
 		break;
-	/* HMI is hypervisor interrupt and host has handled it. Resume guest.*/
+	/* SR/HMI/PMI are HV interrupts that host has handled. Resume guest.*/
 	case BOOK3S_INTERRUPT_HMI:
 	case BOOK3S_INTERRUPT_PERFMON:
+	case BOOK3S_INTERRUPT_SYSTEM_RESET:
 		r = RESUME_GUEST;
 		break;
 	case BOOK3S_INTERRUPT_MACHINE_CHECK:
@@ -2604,6 +2606,9 @@ static void set_irq_happened(int trap)
 	case BOOK3S_INTERRUPT_HMI:
 		local_paca->irq_happened |= PACA_IRQ_HMI;
 		break;
+	case BOOK3S_INTERRUPT_SYSTEM_RESET:
+		replay_system_reset();
+		break;
 	}
 }
 
-- 
2.15.0
