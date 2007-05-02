Return-Path: <kevcorry@us.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 065B4DDFB2
	for <linuxppc-dev@ozlabs.org>; Thu,  3 May 2007 03:10:57 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l42HAsXM024840
	for <linuxppc-dev@ozlabs.org>; Wed, 2 May 2007 13:10:54 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l42HAsHe190058
	for <linuxppc-dev@ozlabs.org>; Wed, 2 May 2007 11:10:54 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l42HAsmQ006635
	for <linuxppc-dev@ozlabs.org>; Wed, 2 May 2007 11:10:54 -0600
From: Kevin Corry <kevcorry@us.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] powerpc: add smp_call_function_single()
Date: Wed, 2 May 2007 12:10:55 -0500
References: <200705021208.59068.kevcorry@us.ibm.com>
In-Reply-To: <200705021208.59068.kevcorry@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705021210.55317.kevcorry@us.ibm.com>
Cc: Stephane Eranian <eranian@hpl.hp.com>, Carl Love <carll@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add an smp_call_function_single() to the powerpc architecture. Since this
is very similar to the existing smp_call_function() routine, the common
portions have been split out into __smp_call_function(). Since the
spin_lock(&call_lock) was moved to __smp_call_function(),
smp_call_function() now explicitly calls preempt_disable() before getting
the count of online CPUs.

Signed-off-by: Kevin Corry <kevcorry@us.ibm.com>

Index: linux-2.6.21/arch/powerpc/kernel/smp.c
===================================================================
--- linux-2.6.21.orig/arch/powerpc/kernel/smp.c
+++ linux-2.6.21/arch/powerpc/kernel/smp.c
@@ -175,26 +175,11 @@ static struct call_data_struct {
 /* delay of at least 8 seconds */
 #define SMP_CALL_TIMEOUT	8
 
-/*
- * This function sends a 'generic call function' IPI to all other CPUs
- * in the system.
- *
- * [SUMMARY] Run a function on all other CPUs.
- * <func> The function to run. This must be fast and non-blocking.
- * <info> An arbitrary pointer to pass to the function.
- * <nonatomic> currently unused.
- * <wait> If true, wait (atomically) until function has completed on other CPUs.
- * [RETURNS] 0 on success, else a negative status code. Does not return until
- * remote CPUs are nearly ready to execute <<func>> or are or have executed.
- *
- * You must not call this function with disabled interrupts or from a
- * hardware interrupt handler or from a bottom half handler.
- */
-int smp_call_function (void (*func) (void *info), void *info, int nonatomic,
-		       int wait)
-{ 
+static int __smp_call_function(void (*func)(void *info), void *info,
+			       int wait, int target_cpu, int num_cpus)
+{
 	struct call_data_struct data;
-	int ret = -1, cpus;
+	int ret = -1;
 	u64 timeout;
 
 	/* Can deadlock when called with interrupts disabled */
@@ -211,40 +196,33 @@ int smp_call_function (void (*func) (voi
 		atomic_set(&data.finished, 0);
 
 	spin_lock(&call_lock);
-	/* Must grab online cpu count with preempt disabled, otherwise
-	 * it can change. */
-	cpus = num_online_cpus() - 1;
-	if (!cpus) {
-		ret = 0;
-		goto out;
-	}
 
 	call_data = &data;
 	smp_wmb();
 	/* Send a message to all other CPUs and wait for them to respond */
-	smp_ops->message_pass(MSG_ALL_BUT_SELF, PPC_MSG_CALL_FUNCTION);
+	smp_ops->message_pass(target_cpu, PPC_MSG_CALL_FUNCTION);
 
 	timeout = get_tb() + (u64) SMP_CALL_TIMEOUT * tb_ticks_per_sec;
 
 	/* Wait for response */
-	while (atomic_read(&data.started) != cpus) {
+	while (atomic_read(&data.started) != num_cpus) {
 		HMT_low();
 		if (get_tb() >= timeout) {
-			printk("smp_call_function on cpu %d: other cpus not "
-			       "responding (%d)\n", smp_processor_id(),
-			       atomic_read(&data.started));
+			printk("%s on cpu %d: other cpus not "
+			       "responding (%d)\n", __FUNCTION__,
+			       smp_processor_id(), atomic_read(&data.started));
 			debugger(NULL);
 			goto out;
 		}
 	}
 
 	if (wait) {
-		while (atomic_read(&data.finished) != cpus) {
+		while (atomic_read(&data.finished) != num_cpus) {
 			HMT_low();
 			if (get_tb() >= timeout) {
-				printk("smp_call_function on cpu %d: other "
-				       "cpus not finishing (%d/%d)\n",
-				       smp_processor_id(),
+				printk("%s on cpu %d: other cpus "
+				       "not finishing (%d/%d)\n",
+				       __FUNCTION__, smp_processor_id(),
 				       atomic_read(&data.finished),
 				       atomic_read(&data.started));
 				debugger(NULL);
@@ -262,8 +240,74 @@ int smp_call_function (void (*func) (voi
 	return ret;
 }
 
+/*
+ * This function sends a 'generic call function' IPI to all other CPUs
+ * in the system.
+ *
+ * [SUMMARY] Run a function on all other CPUs.
+ * <func> The function to run. This must be fast and non-blocking.
+ * <info> An arbitrary pointer to pass to the function.
+ * <nonatomic> currently unused.
+ * <wait> If true, wait (atomically) until function has completed on other CPUs.
+ * [RETURNS] 0 on success, else a negative status code. Does not return until
+ * remote CPUs are nearly ready to execute <<func>> or are or have executed.
+ *
+ * You must not call this function with disabled interrupts or from a
+ * hardware interrupt handler or from a bottom half handler.
+ */
+int smp_call_function (void (*func) (void *info), void *info, int nonatomic,
+		       int wait)
+{
+	int num_cpus, ret = 0;
+
+	/* Must grab online cpu count with preempt disabled, otherwise
+	 * it can change. */
+	preempt_disable();
+	num_cpus = num_online_cpus() - 1;
+	if (num_cpus) {
+		ret = __smp_call_function(func, info, wait,
+					  MSG_ALL_BUT_SELF, num_cpus);
+	}
+	preempt_enable();
+	return ret;
+}
+
 EXPORT_SYMBOL(smp_call_function);
 
+/*
+ * This function sends a 'generic call function' IPI to the specified CPU.
+ *
+ * [SUMMARY] Run a function on the specified CPUs.
+ * <cpuid> The CPU to run the function on.
+ * <func> The function to run. This must be fast and non-blocking.
+ * <info> An arbitrary pointer to pass to the function.
+ * <nonatomic> currently unused.
+ * <wait> If true, wait (atomically) until function has completed on the
+ * other CPU.
+ * [RETURNS] 0 on success, else a negative status code. Does not return until
+ * remote CPU is nearly ready to execute <<func>> or are or has executed.
+ *
+ * You must not call this function with disabled interrupts or from a
+ * hardware interrupt handler or from a bottom half handler.
+ */
+int smp_call_function_single(int cpuid, void (*func)(void *info), void *info,
+			     int nonatomic, int wait)
+{
+	int ret;
+
+	/* Prevent preemption and reschedule on another processor */
+	if (get_cpu() == cpuid) {
+		printk(KERN_INFO "%s: trying to call self\n", __FUNCTION__);
+		ret = -EBUSY;
+	} else
+		ret = __smp_call_function(func, info, wait, cpuid, 1);
+
+	put_cpu();
+	return ret;
+}
+
+EXPORT_SYMBOL(smp_call_function_single);
+
 void smp_call_function_interrupt(void)
 {
 	void (*func) (void *info);
