Return-Path: <paulus@ozlabs.org>
Date: Wed, 5 Sep 2012 14:33:08 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2] powerpc: Make sure IPI handlers see data written by IPI
 senders
Message-ID: <20120905043308.GA10800@drongo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We have been observing hangs, both of KVM guest vcpu tasks and more
generally, where a process that is woken doesn't properly wake up and
continue to run, but instead sticks in TASK_WAKING state.  This
happens because the update of rq->wake_list in ttwu_queue_remote()
is not ordered with the update of ipi_message in
smp_muxed_ipi_message_pass(), and the reading of rq->wake_list in
scheduler_ipi() is not ordered with the reading of ipi_message in
smp_ipi_demux().  Thus it is possible for the IPI receiver not to see
the updated rq->wake_list and therefore conclude that there is nothing
for it to do.

In order to make sure that anything done before smp_send_reschedule()
is ordered before anything done in the resulting call to scheduler_ipi(),
this adds barriers in smp_muxed_message_pass() and smp_ipi_demux().
The barrier in smp_muxed_message_pass() is a full barrier to ensure that
there is a full ordering between the smp_send_reschedule() caller and
scheduler_ipi().  In smp_ipi_demux(), we use xchg() rather than
xchg_local() because xchg() includes release and acquire barriers.
Using xchg() rather than xchg_local() makes sense given that
ipi_message is not just accessed locally.

This moves the barrier between setting the message and calling the
cause_ipi() function into the individual cause_ipi implementations.
Most of them -- those that used outb, out_8 or similar -- already had
a full barrier because out_8 etc. include a sync before the MMIO
store.  This adds an explicit barrier in the two remaining cases.

These changes made no measurable difference to the speed of IPIs as
measured using a simple ping-pong latency test across two CPUs on
different cores of a POWER7 machine.

The analysis of the reason why processes were not waking up properly
is due to Milton Miller.

Cc: stable@vger.kernel.org # v3.0+
Reported-by: Milton Miller <miltonm@bga.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>
---
v2: Move the barrier between setting message and calling cause_ipi
    into the cause_ipi functions

 arch/powerpc/kernel/dbell.c       |    2 ++
 arch/powerpc/kernel/smp.c         |   11 +++++++++--
 arch/powerpc/sysdev/xics/icp-hv.c |    6 +++++-
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/dbell.c b/arch/powerpc/kernel/dbell.c
index 5b25c80..a892680 100644
--- a/arch/powerpc/kernel/dbell.c
+++ b/arch/powerpc/kernel/dbell.c
@@ -28,6 +28,8 @@ void doorbell_setup_this_cpu(void)
 
 void doorbell_cause_ipi(int cpu, unsigned long data)
 {
+	/* Order previous accesses vs. msgsnd, which is treated as a store */
+	mb();
 	ppc_msgsnd(PPC_DBELL, 0, data);
 }
 
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 0321007..8d4214a 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -198,8 +198,15 @@ void smp_muxed_ipi_message_pass(int cpu, int msg)
 	struct cpu_messages *info = &per_cpu(ipi_message, cpu);
 	char *message = (char *)&info->messages;
 
+	/*
+	 * Order previous accesses before accesses in the IPI handler.
+	 */
+	smp_mb();
 	message[msg] = 1;
-	mb();
+	/*
+	 * cause_ipi functions are required to include a full barrier
+	 * before doing whatever causes the IPI.
+	 */
 	smp_ops->cause_ipi(cpu, info->data);
 }
 
@@ -211,7 +218,7 @@ irqreturn_t smp_ipi_demux(void)
 	mb();	/* order any irq clear */
 
 	do {
-		all = xchg_local(&info->messages, 0);
+		all = xchg(&info->messages, 0);
 
 #ifdef __BIG_ENDIAN
 		if (all & (1 << (24 - 8 * PPC_MSG_CALL_FUNCTION)))
diff --git a/arch/powerpc/sysdev/xics/icp-hv.c b/arch/powerpc/sysdev/xics/icp-hv.c
index 14469cf..df0fc58 100644
--- a/arch/powerpc/sysdev/xics/icp-hv.c
+++ b/arch/powerpc/sysdev/xics/icp-hv.c
@@ -65,7 +65,11 @@ static inline void icp_hv_set_xirr(unsigned int value)
 static inline void icp_hv_set_qirr(int n_cpu , u8 value)
 {
 	int hw_cpu = get_hard_smp_processor_id(n_cpu);
-	long rc = plpar_hcall_norets(H_IPI, hw_cpu, value);
+	long rc;
+
+	/* Make sure all previous accesses are ordered before IPI sending */
+	mb();
+	rc = plpar_hcall_norets(H_IPI, hw_cpu, value);
 	if (rc != H_SUCCESS) {
 		pr_err("%s: bad return code qirr cpu=%d hw_cpu=%d mfrr=0x%x "
 			"returned %ld\n", __func__, n_cpu, hw_cpu, value, rc);
-- 
1.7.10
