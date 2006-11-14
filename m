Return-Path: <srinivasa@in.ibm.com>
Received: from ausmtp04.au.ibm.com (ausmtp04.au.ibm.com [202.81.18.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 03F0E67C5D
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Nov 2006 00:27:52 +1100 (EST)
Received: from sd0208e0.au.ibm.com (d23rh904.au.ibm.com [202.81.18.202])
	by ausmtp04.au.ibm.com (8.13.8/8.13.5) with ESMTP id kAEDcdGt085288
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Nov 2006 00:38:39 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.250.243])
	by sd0208e0.au.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kAEDV624192540
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Nov 2006 00:31:06 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kAEDRdUJ011157
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Nov 2006 00:27:40 +1100
Message-ID: <4559CF39.8090908@in.ibm.com>
Date: Tue, 14 Nov 2006 19:44:17 +0530
From: Srinivasa Ds <srinivasa@in.ibm.com>
MIME-Version: 1.0
To: Srinivasa Ds <srinivasa@in.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, anton@au1.ibm.com,
	paulus@samba.org, linuxppc-dev@ozlabs.org, ego@in.ibm.com,
	Srivatsa Vaddagiri <vatsa@in.ibm.com>
Subject: Re: [RFC] [PATCH] cpu_hotplug on IBM JS20 system
References: <45586EB5.40409@in.ibm.com>
	<1163453995.5940.11.camel@localhost.localdomain>
	<4559C6A9.4070204@in.ibm.com>
In-Reply-To: <4559C6A9.4070204@in.ibm.com>
Content-Type: multipart/mixed; boundary="------------050203040909020402000004"
Cc: linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------050203040909020402000004
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Srinivasa Ds wrote:
>
> Since we are not supported by hardware for cpu hotplug. I have 
> developed the patch which will disable cpu hotplug on IBM bladecentre 
> JS20.  Please let me know your comments on this please.
>
  Iam sorry, Just resending the patch after formatting it again.
 
    Signed-off-by: Srinivasa DS <srinivasa@in.ibm.com>



--------------050203040909020402000004
Content-Type: text/plain;
 name="cpu_hotplug.fix"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cpu_hotplug.fix"

 arch/powerpc/kernel/rtas.c |    3 +++
 include/linux/cpu.h        |    4 ++++
 kernel/cpu.c               |   24 ++++++++++++++++++++++--
 3 files changed, 29 insertions(+), 2 deletions(-)

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
@@ -881,6 +882,8 @@ void __init rtas_initialize(void)
 
 #ifdef CONFIG_HOTPLUG_CPU
 	rtas_stop_self_args.token = rtas_token("stop-self");
+	if(rtas_stop_self_args.token == RTAS_UNKNOWN_SERVICE)
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

--------------050203040909020402000004--
