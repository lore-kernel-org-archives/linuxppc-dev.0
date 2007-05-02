Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 222C1DDF7F
	for <linuxppc-dev@ozlabs.org>; Thu,  3 May 2007 03:13:07 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l42HD5Zv024707
	for <linuxppc-dev@ozlabs.org>; Wed, 2 May 2007 13:13:05 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l42HD52a175188
	for <linuxppc-dev@ozlabs.org>; Wed, 2 May 2007 11:13:05 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l42HD4Ks030900
	for <linuxppc-dev@ozlabs.org>; Wed, 2 May 2007 11:13:04 -0600
From: Will Schmidt <will_schmidt@vnet.ibm.com>
Subject: [PATCH] add smp_call_function_map and smp_call_function_single
To: linuxppc-dev@ozlabs.org, paulus@samba.org, anton@samba.org
Date: Wed, 02 May 2007 12:12:34 -0500
Message-ID: <20070502171234.13831.8483.stgit@farscape.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Add a new function named smp_call_function_single().  This matches a generic
prototype from include/linux/smp.h.

Add a function smp_call_function_map().  This is, for the most part, a rename
of smp_call_function, with some added cpumask support.  smp_call_function and
smp_call_function_single call into smp_call_function_map.

Lightly tested on 970mp (blade), power4 and power5.

Signed-off-by: Will Schmidt <will_schmidt@vnet.ibm.com>
cc: Anton Blanchard <anton@samba.org>
---

 arch/powerpc/kernel/smp.c |   73 ++++++++++++++++++++++++++++++++-------------
 1 files changed, 52 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 924d692..4878588 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -176,10 +176,10 @@ static struct call_data_struct {
 #define SMP_CALL_TIMEOUT	8
 
 /*
- * This function sends a 'generic call function' IPI to all other CPUs
- * in the system.
+ * These functions send a 'generic call function' IPI to other online
+ * CPUS in the system.
  *
- * [SUMMARY] Run a function on all other CPUs.
+ * [SUMMARY] Run a function on other CPUs.
  * <func> The function to run. This must be fast and non-blocking.
  * <info> An arbitrary pointer to pass to the function.
  * <nonatomic> currently unused.
@@ -190,18 +190,26 @@ static struct call_data_struct {
  * You must not call this function with disabled interrupts or from a
  * hardware interrupt handler or from a bottom half handler.
  */
-int smp_call_function (void (*func) (void *info), void *info, int nonatomic,
-		       int wait)
-{ 
+int smp_call_function_map(void (*func) (void *info), void *info, int nonatomic,
+			int wait, cpumask_t map)
+{
 	struct call_data_struct data;
-	int ret = -1, cpus;
+	int ret = -1, num_cpus;
+	int cpu;
 	u64 timeout;
 
 	/* Can deadlock when called with interrupts disabled */
 	WARN_ON(irqs_disabled());
 
+	/* remove 'self' from the map */
+	if (cpu_isset(smp_processor_id(), map))
+		cpu_clear(smp_processor_id(), map);
+
+	/* sanity check the map, remove any non-online processors. */
+	cpus_and(map, map, cpu_online_map);
+
 	if (unlikely(smp_ops == NULL))
-		return -1;
+		return ret;
 
 	data.func = func;
 	data.info = info;
@@ -213,40 +221,42 @@ int smp_call_function (void (*func) (void *info), void *info, int nonatomic,
 	spin_lock(&call_lock);
 	/* Must grab online cpu count with preempt disabled, otherwise
 	 * it can change. */
-	cpus = num_online_cpus() - 1;
-	if (!cpus) {
+	num_cpus = num_online_cpus() - 1;
+	if (!num_cpus || cpus_empty(map)) {
 		ret = 0;
 		goto out;
 	}
 
 	call_data = &data;
 	smp_wmb();
-	/* Send a message to all other CPUs and wait for them to respond */
-	smp_ops->message_pass(MSG_ALL_BUT_SELF, PPC_MSG_CALL_FUNCTION);
+	/* Send a message to all CPUs in the map */
+	for_each_cpu_mask(cpu, map)
+		smp_ops->message_pass(cpu, PPC_MSG_CALL_FUNCTION);
 
 	timeout = get_tb() + (u64) SMP_CALL_TIMEOUT * tb_ticks_per_sec;
 
-	/* Wait for response */
-	while (atomic_read(&data.started) != cpus) {
+	/* Wait for indication that they have received the message */
+	while (atomic_read(&data.started) != num_cpus) {
 		HMT_low();
 		if (get_tb() >= timeout) {
 			printk("smp_call_function on cpu %d: other cpus not "
-			       "responding (%d)\n", smp_processor_id(),
-			       atomic_read(&data.started));
+				"responding (%d)\n", smp_processor_id(),
+				atomic_read(&data.started));
 			debugger(NULL);
 			goto out;
 		}
 	}
 
+	/* optionally wait for the CPUs to complete */
 	if (wait) {
-		while (atomic_read(&data.finished) != cpus) {
+		while (atomic_read(&data.finished) != num_cpus) {
 			HMT_low();
 			if (get_tb() >= timeout) {
 				printk("smp_call_function on cpu %d: other "
-				       "cpus not finishing (%d/%d)\n",
-				       smp_processor_id(),
-				       atomic_read(&data.finished),
-				       atomic_read(&data.started));
+					"cpus not finishing (%d/%d)\n",
+					smp_processor_id(),
+					atomic_read(&data.finished),
+					atomic_read(&data.started));
 				debugger(NULL);
 				goto out;
 			}
@@ -262,8 +272,29 @@ int smp_call_function (void (*func) (void *info), void *info, int nonatomic,
 	return ret;
 }
 
+int smp_call_function(void (*func) (void *info), void *info, int nonatomic,
+			int wait)
+{
+	return smp_call_function_map(func,info,nonatomic,wait,cpu_online_map);
+}
 EXPORT_SYMBOL(smp_call_function);
 
+int smp_call_function_single(int cpu, void (*func) (void *info), void *info, int nonatomic,
+			int wait)
+{
+	cpumask_t map=CPU_MASK_NONE;
+
+	if (!cpu_online(cpu))
+		return -EINVAL;
+
+	if (cpu == smp_processor_id())
+		return -EBUSY;
+
+	cpu_set(cpu, map);
+	return smp_call_function_map(func,info,nonatomic,wait,map);
+}
+EXPORT_SYMBOL(smp_call_function_single);
+
 void smp_call_function_interrupt(void)
 {
 	void (*func) (void *info);
