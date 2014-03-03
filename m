Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: benh@kernel.crashing.org
MIME-Version: 1.0
Subject: powerpc/tm: Fix crash when forking inside a transaction
Date: Mon, 03 Mar 2014 14:21:40 +1100
Message-ID: <13012.1393816900@ale.ozlabs.ibm.com>
Cc: Linux PPC dev <linuxppc-dev@ozlabs.org>,
 Adhemerval Zanella Neto <azanella@br.ibm.com>,
 Paul Mackerras <paulus@samba.org>, matt@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When we fork/clone we currently don't copy any of the TM state to the new
thread.  This results in a TM bad thing (program check) when the new process is
switched in as the kernel does a tmrechkpt with TEXASR FS not set.  Also, since
R1 is from userspace, we trigger the bad kernel stack pointer detection.  So we
end up with something like this:

   Bad kernel stack pointer 0 at c0000000000404fc
   cpu 0x2: Vector: 700 (Program Check) at [c00000003ffefd40]
       pc: c0000000000404fc: restore_gprs+0xc0/0x148
       lr: 0000000000000000
       sp: 0
      msr: 9000000100201030
     current = 0xc000001dd1417c30
     paca    = 0xc00000000fe00800   softe: 0        irq_happened: 0x01
       pid   = 0, comm = swapper/2
   WARNING: exception is not recoverable, can't continue

The below fixes this by flushing the TM state before we copy the task_struct to
the clone.  To do this we go through the tmreclaim patch, which removes the
checkpointed registers from the CPU and transitions the CPU out of TM suspend
mode.  Hence we need to call tmrechkpt after to restore the checkpointed state
and the TM mode for the current task.

To make this fail from userspace is simply:
	tbegin
	li	r0, 2
	sc
	<boom>

Kudos to Adhemerval Zanella Neto for finding this.

Signed-off-by: Michael Neuling <mikey@neuling.org>
cc: Adhemerval Zanella Neto <azanella@br.ibm.com>
cc: stable@vger.kernel.org

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 8d4c247f1..af064d2 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1048,6 +1048,15 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 	flush_altivec_to_thread(src);
 	flush_vsx_to_thread(src);
 	flush_spe_to_thread(src);
+	/*
+	 * Flush TM state out so we can copy it.  __switch_to_tm() does this
+	 * flush but it removes the checkpointed state from the current CPU and
+	 * transitions the CPU out of TM mode.  Hence we need to call
+	 * tm_recheckpoint_new_task() (on the same task) to restore the
+	 * checkpointed state back and the TM mode.
+	 */
+	__switch_to_tm(src);
+	tm_recheckpoint_new_task(src);
 
 	*dst = *src;
 
