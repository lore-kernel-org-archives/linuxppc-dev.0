Return-Path: <srinivasa@in.ibm.com>
Received: from ausmtp04.au.ibm.com (ausmtp04.au.ibm.com [202.81.18.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D67A967CC7
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Nov 2006 23:52:03 +1100 (EST)
Received: from sd0208e0.au.ibm.com (d23rh904.au.ibm.com [202.81.18.202])
	by ausmtp04.au.ibm.com (8.13.8/8.13.5) with ESMTP id kAED2LAv102924
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Nov 2006 00:02:23 +1100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.250.244])
	by sd0208e0.au.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kAECsY8c202636
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Nov 2006 23:54:40 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kAECp7ND023412
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Nov 2006 23:51:08 +1100
Message-ID: <4559C6A9.4070204@in.ibm.com>
Date: Tue, 14 Nov 2006 19:07:45 +0530
From: Srinivasa Ds <srinivasa@in.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, anton@au1.ibm.com,
	paulus@samba.org, linuxppc-dev@ozlabs.org, ego@in.ibm.com,
	Srivatsa Vaddagiri <vatsa@in.ibm.com>
Subject: Re: [RFC] [PATCH] cpu_hotplug on IBM JS20 system
References: <45586EB5.40409@in.ibm.com>
	<1163453995.5940.11.camel@localhost.localdomain>
In-Reply-To: <1163453995.5940.11.camel@localhost.localdomain>
Content-Type: multipart/mixed; boundary="------------050308040008090205010205"
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
--------------050308040008090205010205
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi
when I tried to hot plug a cpu on IBM bladecentre JS20 system,it dropped 
in to xmon. On analyzing the problem,I found out that "self-stop" token  
is not exported
to the OS through rtas(Could be verified by looking in to 
/proc/device-tree/rtas file).

1:mon> e
cpu 0x1: Vector: 700 (Program Check) at [c00000000ff1bab0]
  pc: c00000000001b144: .rtas_stop_self+0x34/0x70
  lr: c0000000000439c0: .pSeries_mach_cpu_die+0x34/0x40
  sp: c00000000ff1bd30
 msr: 8000000000021032
current = 0xc00000000ff050b0
paca    = 0xc0000000005ec500
  pid   = 0, comm = swapper
kernel BUG in rtas_stop_self at arch/powerpc/kernel/rtas.c:829!
===========================================
void rtas_stop_self(void)
{
      struct rtas_args *rtas_args = &rtas_stop_self_args;

      local_irq_disable();

      BUG_ON(rtas_args->token == RTAS_UNKNOWN_SERVICE);
===================================================
#ifdef CONFIG_HOTPLUG_CPU
      rtas_stop_self_args.token = rtas_token("stop-self");
#endif /* CONFIG_HOTPLUG_CPU */
#ifdef CONFIG_RTAS_ERROR_LOGGING
      rtas_last_error_token = rtas_token("rtas-last-error");
===================================================

Since we are not supported by hardware for cpu hotplug. I have developed 
the patch which will disable cpu hotplug on IBM bladecentre JS20.  
Please let me know your comments on this please.

Signed-off-by: Srinivasa DS <srinivasa@in.ibm.com>






--------------050308040008090205010205
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
--- linux-2.6.19-rc5.orig/arch/powerpc/kernel/rtas.c	2006-11-08 07:54:20.000000000 +0530
+++ linux-2.6.19-rc5/arch/powerpc/kernel/rtas.c	2006-11-14 15:59:58.000000000 +0530
@@ -19,6 +19,7 @@
 #include <linux/init.h>
 #include <linux/capability.h>
 #include <linux/delay.h>
+#include <linux/cpu.h>
 
 #include <asm/prom.h>
 #include <asm/rtas.h>
@@ -881,6 +882,8 @@
 
 #ifdef CONFIG_HOTPLUG_CPU
 	rtas_stop_self_args.token = rtas_token("stop-self");
+	if(rtas_stop_self_args.token == RTAS_UNKNOWN_SERVICE)
+		disable_cpu_hotplug_perm();
 #endif /* CONFIG_HOTPLUG_CPU */
 #ifdef CONFIG_RTAS_ERROR_LOGGING
 	rtas_last_error_token = rtas_token("rtas-last-error");
Index: linux-2.6.19-rc5/kernel/cpu.c
===================================================================
--- linux-2.6.19-rc5.orig/kernel/cpu.c	2006-11-08 07:54:20.000000000 +0530
+++ linux-2.6.19-rc5/kernel/cpu.c	2006-11-14 16:06:17.000000000 +0530
@@ -63,6 +63,18 @@
 }
 EXPORT_SYMBOL_GPL(unlock_cpu_hotplug);
 
+void disable_cpu_hotplug_perm(void)
+{
+	mutex_lock(&cpu_add_remove_lock);
+	cpu_hotplug_disabled = PERM_DISABLED_CPU_HOTPLUG;
+	mutex_unlock(&cpu_add_remove_lock);
+}
+
+static int is_cpu_hotplug_perm_disabled()
+{
+	return cpu_hotplug_disabled == PERM_DISABLED_CPU_HOTPLUG;
+}
+
 #endif	/* CONFIG_HOTPLUG_CPU */
 
 /* Need to know about CPUs going up/down? */
@@ -193,7 +205,7 @@
 	int err = 0;
 
 	mutex_lock(&cpu_add_remove_lock);
-	if (cpu_hotplug_disabled)
+	if (cpu_hotplug_disabled || is_cpu_hotplug_perm_disabled())
 		err = -EBUSY;
 	else
 		err = _cpu_down(cpu);
@@ -244,7 +256,7 @@
 	int err = 0;
 
 	mutex_lock(&cpu_add_remove_lock);
-	if (cpu_hotplug_disabled)
+	if (cpu_hotplug_disabled || is_cpu_hotplug_perm_disabled())
 		err = -EBUSY;
 	else
 		err = _cpu_up(cpu);
@@ -261,6 +273,10 @@
 	int cpu, first_cpu, error;
 
 	mutex_lock(&cpu_add_remove_lock);
+	if(is_cpu_hotplug_perm_disabled()) {
+		error = -EBUSY;
+		goto out;
+	}
 	first_cpu = first_cpu(cpu_present_map);
 	if (!cpu_online(first_cpu)) {
 		error = _cpu_up(first_cpu);
@@ -311,6 +327,10 @@
 
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
--- linux-2.6.19-rc5.orig/include/linux/cpu.h	2006-11-14 15:55:26.000000000 +0530
+++ linux-2.6.19-rc5/include/linux/cpu.h	2006-11-14 16:08:36.000000000 +0530
@@ -31,6 +31,8 @@
 	struct sys_device sysdev;
 };
 
+#define  PERM_DISABLED_CPU_HOTPLUG -1
+
 extern int register_cpu(struct cpu *cpu, int num);
 extern struct sys_device *get_cpu_sysdev(unsigned cpu);
 #ifdef CONFIG_HOTPLUG_CPU
@@ -68,6 +70,7 @@
 /* Stop CPUs going up and down. */
 extern void lock_cpu_hotplug(void);
 extern void unlock_cpu_hotplug(void);
+extern void disable_cpu_hotplug_perm(void);
 #define hotcpu_notifier(fn, pri) {				\
 	static struct notifier_block fn##_nb =			\
 		{ .notifier_call = fn, .priority = pri };	\
@@ -80,6 +83,7 @@
 #else
 #define lock_cpu_hotplug()	do { } while (0)
 #define unlock_cpu_hotplug()	do { } while (0)
+#define disable_cpu_hotplug_perm()     do { } while (0)
 #define lock_cpu_hotplug_interruptible() 0
 #define hotcpu_notifier(fn, pri)	do { } while (0)
 #define register_hotcpu_notifier(nb)	do { } while (0)

--------------050308040008090205010205--
