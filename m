Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 92845DDDF8
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Dec 2007 15:01:04 +1100 (EST)
Date: Thu, 27 Dec 2007 22:08:36 -0600
From: Olof Johansson <olof@lixom.net>
To: paulus@samba.org
Subject: [PATCH 1/2] [POWERPC] smp_call_function_map should be static
Message-ID: <20071228040836.GA23635@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

smp_call_function_map should be static, and for consistency prepend it
with __ like other local helper functions in the same file.

Signed-off-by: Olof Johansson <olof@lixom.net>

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 338950a..cefeee8 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -181,12 +181,13 @@ static struct call_data_struct {
  * <wait> If true, wait (atomically) until function has completed on other CPUs.
  * [RETURNS] 0 on success, else a negative status code. Does not return until
  * remote CPUs are nearly ready to execute <<func>> or are or have executed.
+ * <map> is a cpu map of the cpus to send IPI to.
  *
  * You must not call this function with disabled interrupts or from a
  * hardware interrupt handler or from a bottom half handler.
  */
-int smp_call_function_map(void (*func) (void *info), void *info, int nonatomic,
-			int wait, cpumask_t map)
+static int __smp_call_function_map(void (*func) (void *info), void *info,
+				   int nonatomic, int wait, cpumask_t map)
 {
 	struct call_data_struct data;
 	int ret = -1, num_cpus;
@@ -265,7 +266,8 @@ int smp_call_function_map(void (*func) (void *info), void *info, int nonatomic,
 static int __smp_call_function(void (*func)(void *info), void *info,
 			       int nonatomic, int wait)
 {
-	return smp_call_function_map(func,info,nonatomic,wait,cpu_online_map);
+	return __smp_call_function_map(func, info, nonatomic, wait,
+				       cpu_online_map);
 }
 
 int smp_call_function(void (*func) (void *info), void *info, int nonatomic,
@@ -278,8 +280,8 @@ int smp_call_function(void (*func) (void *info), void *info, int nonatomic,
 }
 EXPORT_SYMBOL(smp_call_function);
 
-int smp_call_function_single(int cpu, void (*func) (void *info), void *info, int nonatomic,
-			int wait)
+int smp_call_function_single(int cpu, void (*func) (void *info), void *info,
+			     int nonatomic, int wait)
 {
 	cpumask_t map = CPU_MASK_NONE;
 	int ret = 0;
@@ -292,7 +294,7 @@ int smp_call_function_single(int cpu, void (*func) (void *info), void *info, int
 
 	cpu_set(cpu, map);
 	if (cpu != get_cpu())
-		ret = smp_call_function_map(func,info,nonatomic,wait,map);
+		ret = __smp_call_function_map(func, info, nonatomic, wait, map);
 	else {
 		local_irq_disable();
 		func(info);
