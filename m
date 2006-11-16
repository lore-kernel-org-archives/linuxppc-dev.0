Return-Path: <srinivasa@in.ibm.com>
Received: from ausmtp04.au.ibm.com (ausmtp04.au.ibm.com [202.81.18.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9108967B5B
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 00:52:34 +1100 (EST)
Received: from sd0208e0.au.ibm.com (d23rh904.au.ibm.com [202.81.18.202])
	by ausmtp04.au.ibm.com (8.13.8/8.13.5) with ESMTP id kAGE3VT7179862
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 01:03:31 +1100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.250.244])
	by sd0208e0.au.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kAGDtc6H242410
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 00:55:53 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kAGDqB5q030787
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 00:52:12 +1100
Message-ID: <455C783E.2040701@in.ibm.com>
Date: Thu, 16 Nov 2006 20:09:58 +0530
From: Srinivasa Ds <srinivasa@in.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, paulus@samba.org, ntl@pobox.com,
	michael@ellerman.id.au, anton@au1.ibm.com, vatsa@in.ibm.com, ego@in.ibm.com
Subject: [RFC] [PATCH]  cpu hotplug on power based systems.
Content-Type: multipart/mixed; boundary="------------030302070108020707090702"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------030302070108020707090702
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Linux kernel uses some of the rtas token to perform cpu hotplug on power 
systems. Some of the systems may not provide all the rtas services,which 
are required to perform cpu hotplug. Like for example
   1) JS20 doesn't provide "stop-self" token and cpu hotplug operations 
on these systems causes system to crash.
   2) some of the p630 systems doesn't provide "query-cpu-stopped-state" 
token and we are not sure of whether cpu is under stopped state or not  
or stop-self is still in progress .
So we can't take decision on whether cpu really has gone offline or not.

So we need to make sure that all required rtas tokens for cpu hotplug  
are available during rtas initialization phase and to disable cpu 
hotplug if they are not available.
I have developed the patch which does the above thing. Please let me 
know your comments on this.

Signed-off-by: Srinivasa DS <srinivasa@in.ibm.com>

 

--------------030302070108020707090702
Content-Type: text/plain;
 name="cpu_final.fix"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cpu_final.fix"

 arch/powerpc/kernel/rtas.c |    6 ++++++
 include/linux/cpu.h        |    4 ++++
 kernel/cpu.c               |   24 ++++++++++++++++++++++--
 3 files changed, 32 insertions(+), 2 deletions(-)

Index: linux-2.6.19-rc5/arch/powerpc/kernel/rtas.c
===================================================================
--- linux-2.6.19-rc5.orig/arch/powerpc/kernel/rtas.c
+++ linux-2.6.19-rc5/arch/powerpc/kernel/rtas.c
@@ -19,6 +19,7 @@
 #include <linux/init.h>
 #include <linux/capability.h>
 #include <linux/delay.h>
+#include <linux/cpu.h>
 
 #include <asm/prom.h>
 #include <asm/rtas.h>
@@ -843,6 +844,7 @@ void rtas_stop_self(void)
 void __init rtas_initialize(void)
 {
 	unsigned long rtas_region = RTAS_INSTANTIATE_MAX;
+	int qcss_tok;
 
 	/* Get RTAS dev node and fill up our "rtas" structure with infos
 	 * about it.
@@ -881,6 +883,10 @@ void __init rtas_initialize(void)
 
 #ifdef CONFIG_HOTPLUG_CPU
 	rtas_stop_self_args.token = rtas_token("stop-self");
+	qcss_tok = rtas_token("query-cpu-stopped-state");
+	if(rtas_stop_self_args.token == RTAS_UNKNOWN_SERVICE ||
+				 qcss_tok == RTAS_UNKNOWN_SERVICE)
+		disable_cpu_hotplug_perm();
 #endif /* CONFIG_HOTPLUG_CPU */
 #ifdef CONFIG_RTAS_ERROR_LOGGING
 	rtas_last_error_token = rtas_token("rtas-last-error");
Index: linux-2.6.19-rc5/kernel/cpu.c
===================================================================
--- linux-2.6.19-rc5.orig/kernel/cpu.c
+++ linux-2.6.19-rc5/kernel/cpu.c
@@ -63,8 +63,20 @@ void unlock_cpu_hotplug(void)
 }
 EXPORT_SYMBOL_GPL(unlock_cpu_hotplug);
 
+void disable_cpu_hotplug_perm(void)
+{
+	mutex_lock(&cpu_add_remove_lock);
+	cpu_hotplug_disabled = PERM_DISABLED_CPU_HOTPLUG;
+	mutex_unlock(&cpu_add_remove_lock);
+}
+
 #endif	/* CONFIG_HOTPLUG_CPU */
 
+static int is_cpu_hotplug_perm_disabled()
+{
+	return cpu_hotplug_disabled == PERM_DISABLED_CPU_HOTPLUG;
+}
+
 /* Need to know about CPUs going up/down? */
 int __cpuinit register_cpu_notifier(struct notifier_block *nb)
 {
@@ -193,7 +205,7 @@ int cpu_down(unsigned int cpu)
 	int err = 0;
 
 	mutex_lock(&cpu_add_remove_lock);
-	if (cpu_hotplug_disabled)
+	if (cpu_hotplug_disabled || is_cpu_hotplug_perm_disabled())
 		err = -EBUSY;
 	else
 		err = _cpu_down(cpu);
@@ -244,7 +256,7 @@ int __devinit cpu_up(unsigned int cpu)
 	int err = 0;
 
 	mutex_lock(&cpu_add_remove_lock);
-	if (cpu_hotplug_disabled)
+	if (cpu_hotplug_disabled || is_cpu_hotplug_perm_disabled())
 		err = -EBUSY;
 	else
 		err = _cpu_up(cpu);
@@ -261,6 +273,10 @@ int disable_nonboot_cpus(void)
 	int cpu, first_cpu, error;
 
 	mutex_lock(&cpu_add_remove_lock);
+	if(is_cpu_hotplug_perm_disabled()) {
+		error = -EBUSY;
+		goto out;
+	}
 	first_cpu = first_cpu(cpu_present_map);
 	if (!cpu_online(first_cpu)) {
 		error = _cpu_up(first_cpu);
@@ -311,6 +327,10 @@ void enable_nonboot_cpus(void)
 
 	/* Allow everyone to use the CPU hotplug again */
 	mutex_lock(&cpu_add_remove_lock);
+	if(is_cpu_hotplug_perm_disabled()) {
+		mutex_unlock(&cpu_add_remove_lock);
+		return;
+	}
 	cpu_hotplug_disabled = 0;
 	mutex_unlock(&cpu_add_remove_lock);
 
Index: linux-2.6.19-rc5/include/linux/cpu.h
===================================================================
--- linux-2.6.19-rc5.orig/include/linux/cpu.h
+++ linux-2.6.19-rc5/include/linux/cpu.h
@@ -31,6 +31,8 @@ struct cpu {
 	struct sys_device sysdev;
 };
 
+#define  PERM_DISABLED_CPU_HOTPLUG -1
+
 extern int register_cpu(struct cpu *cpu, int num);
 extern struct sys_device *get_cpu_sysdev(unsigned cpu);
 #ifdef CONFIG_HOTPLUG_CPU
@@ -68,6 +70,7 @@ extern struct sysdev_class cpu_sysdev_cl
 /* Stop CPUs going up and down. */
 extern void lock_cpu_hotplug(void);
 extern void unlock_cpu_hotplug(void);
+extern void disable_cpu_hotplug_perm(void);
 #define hotcpu_notifier(fn, pri) {				\
 	static struct notifier_block fn##_nb =			\
 		{ .notifier_call = fn, .priority = pri };	\
@@ -80,6 +83,7 @@ int cpu_down(unsigned int cpu);
 #else
 #define lock_cpu_hotplug()	do { } while (0)
 #define unlock_cpu_hotplug()	do { } while (0)
+#define disable_cpu_hotplug_perm()     do { } while (0)
 #define lock_cpu_hotplug_interruptible() 0
 #define hotcpu_notifier(fn, pri)	do { } while (0)
 #define register_hotcpu_notifier(nb)	do { } while (0)

--------------030302070108020707090702--
