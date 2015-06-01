Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 218131A0673
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Jun 2015 20:45:13 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: Anton Blanchard <anton@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Laurentiu.Tudor@freescale.com
Subject: [PATCH v2] powerpc/perf: Fix book3s kernel to userspace backtraces
Date: Mon,  1 Jun 2015 20:45:07 +1000
Message-Id: <1433155507-7822-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anton Blanchard <anton@samba.org>

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

Cc: stable@vger.kernel.org
Signed-off-by: Anton Blanchard <anton@samba.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---

v2: Return the result directly rather than if (x) return true.
    Add a big comment.
    Cc to stable.

 arch/powerpc/perf/core-book3s.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 12b638425bb9..d90893b76e7c 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -131,7 +131,16 @@ static void pmao_restore_workaround(bool ebb) { }
 
 static bool regs_use_siar(struct pt_regs *regs)
 {
-	return !!regs->result;
+	/*
+	 * When we take a performance monitor exception the regs are setup
+	 * using perf_read_regs() which overloads some fields, in particular
+	 * regs->result to tell us whether to use SIAR.
+	 *
+	 * However if the regs are from another exception, eg. a syscall, then
+	 * they have not been setup using perf_read_regs() and so regs->result
+	 * is something random.
+	 */
+	return ((TRAP(regs) == 0xf00) && regs->result);
 }
 
 /*
-- 
2.1.0
