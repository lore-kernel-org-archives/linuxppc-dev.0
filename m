Return-Path: <paulus@ozlabs.org>
Date: Sat, 25 Aug 2012 15:04:23 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Make sure IPI handlers see data written by IPI
 senders
Message-ID: <20120825050423.GD7051@bloggs.ozlabs.ibm.com>
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

We have been observing hangs, both in KVM guest vcpus and more
generally, where a process that is woken doesn't properly wake up and
continue to run, but instead sticks in TASK_WAKING state.  This
happens because the update of rq->wake_list in ttwu_queue_remote()
is not ordered with the update of ipi_message in
smp_muxed_ipi_message_pass(), and the reading of rq->wake_list in
scheduler_ipi() is not ordered with the reading of ipi_message in
smp_ipi_demux().  Thus it is possible for the IPI receiver not to see
the updated rq->wake_list and therefore conclude that there is nothing
for it to do.

In order to make sure that anything done before calling
smp_send_reschedule() is ordered before anything done in the resulting
call to scheduler_ipi(), this adds barriers in
smp_muxed_message_pass() and smp_ipi_demux().  The barrier in
smp_muxed_message_pass() is a full barrier to ensure that there is a
full ordering between the smp_send_reschedule() caller and
scheduler_ipi().  In smp_ipi_demux(), we use xchg() rather than
xchg_local() because xchg() includes release and acquire barriers.
Using xchg() rather than xchg_local() makes sense given that
ipi_message is not just accessed locally.

These changes made no measurable difference to the speed of IPIs as
measured using a simple ping-pong latency test across two CPUs on
different cores of a POWER7 machine.

The analysis of the reason why processes were not waking up properly
is due to Milton Miller.

Cc: stable@vger.kernel.org
Reported-by: Milton Miller <miltonm@bga.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/kernel/smp.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index e292ff2..ca1040a 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -197,8 +197,15 @@ void smp_muxed_ipi_message_pass(int cpu, int msg)
 	struct cpu_messages *info = &per_cpu(ipi_message, cpu);
 	char *message = (char *)&info->messages;
 
+	/*
+	 * Order previous accesses before accesses in the IPI handler.
+	 */
+	smp_mb();
 	message[msg] = 1;
-	mb();
+	/*
+	 * Order setting of message before IPI.
+	 */
+	smp_wmb();
 	smp_ops->cause_ipi(cpu, info->data);
 }
 
@@ -210,7 +217,7 @@ irqreturn_t smp_ipi_demux(void)
 	mb();	/* order any irq clear */
 
 	do {
-		all = xchg_local(&info->messages, 0);
+		all = xchg(&info->messages, 0);
 
 #ifdef __BIG_ENDIAN
 		if (all & (1 << (24 - 8 * PPC_MSG_CALL_FUNCTION)))
-- 
1.7.10.rc3.219.g53414
