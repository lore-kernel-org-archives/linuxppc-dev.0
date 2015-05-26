Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A03921A0E48
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2015 15:10:26 +1000 (AEST)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/perf: Fix book3s kernel to userspace backtraces
Date: Tue, 26 May 2015 15:10:24 +1000
Message-Id: <1432617024-11352-1-git-send-email-anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When we take a PMU exception or a software event we call
perf_read_regs(). This overloads regs->result with a boolean that
describes if we should use the sampled instruction address register
(SIAR) or the regs.

If the exception is in kernel, we start with the kernel regs and
backtrace through the kernel stack. At this point we switch to the
userspace regs and backtrace the user stack with perf_callchain_user().

Unfortunately these regs have not got the perf_read_regs() treatment,
so regs->result could be anything. If it is non zero,
perf_instruction_pointer() decides to use the SIAR, and we get issues
like this:

0.11%  qemu-system-ppc  [kernel.kallsyms]        [k] _raw_spin_lock_irqsave
       |
       ---_raw_spin_lock_irqsave
          |
          |--52.35%-- 0
          |          |
          |          |--46.39%-- __hrtimer_start_range_ns
          |          |          kvmppc_run_core
          |          |          kvmppc_vcpu_run_hv
          |          |          kvmppc_vcpu_run
          |          |          kvm_arch_vcpu_ioctl_run
          |          |          kvm_vcpu_ioctl
          |          |          do_vfs_ioctl
          |          |          sys_ioctl
          |          |          system_call
          |          |          |
          |          |          |--67.08%-- _raw_spin_lock_irqsave <--- hi mum
          |          |          |          |
          |          |          |           --100.00%-- 0x7e714
          |          |          |                     0x7e714

Notice the bogus _raw_spin_irqsave when we transition from kernel
(system_call) to userspace (0x7e714). We inserted what was in the SIAR.

Add a check in regs_use_siar() to check that the regs in question
are from a PMU exception. With this fix the backtrace makes sense:

     0.47%  qemu-system-ppc  [kernel.vmlinux]         [k] _raw_spin_lock_irqsave
            |
            ---_raw_spin_lock_irqsave
               |
               |--53.83%-- 0
               |          |
               |          |--44.73%-- hrtimer_try_to_cancel
               |          |          kvmppc_start_thread
               |          |          kvmppc_run_core
               |          |          kvmppc_vcpu_run_hv
               |          |          kvmppc_vcpu_run
               |          |          kvm_arch_vcpu_ioctl_run
               |          |          kvm_vcpu_ioctl
               |          |          do_vfs_ioctl
               |          |          sys_ioctl
               |          |          system_call
               |          |          __ioctl
               |          |          0x7e714
               |          |          0x7e714

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/perf/core-book3s.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 12b6384..42a3725 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -131,7 +131,10 @@ static void pmao_restore_workaround(bool ebb) { }
 
 static bool regs_use_siar(struct pt_regs *regs)
 {
-	return !!regs->result;
+	if ((TRAP(regs) == 0xf00) && regs->result)
+		return true;
+
+	return false;
 }
 
 /*
-- 
2.1.4
