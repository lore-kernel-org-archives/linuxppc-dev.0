Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 7EF7FDDE00
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Dec 2007 15:03:37 +1100 (EST)
Date: Thu, 27 Dec 2007 22:11:09 -0600
From: Olof Johansson <olof@lixom.net>
To: paulus@samba.org
Subject: [PATCH 2/2] [POWERPC] Make smp_send_stop() handle panic and xmon
	reboot
Message-ID: <20071228041109.GB23635@lixom.net>
References: <20071228040836.GA23635@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071228040836.GA23635@lixom.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

smp_send_stop() will send an IPI to all other cpus to shut them down.
However, for the case of xmon-based reboots (as well as potentially some
panics), the other cpus are (or might be) spinning with interrupts off,
and won't take the IPI.

Current code will drop us into the debugger when the IPI fails, which
means we're in an infinite loop that we can't get out of without an
external reset of some sort.

Instead, make the smp_send_stop() IPI call path just print the warning
about being unable to send IPIs, but make it return so the rest of the
shutdown sequence can continue. It's not perfect, but the lesser of
two evils.

Also move the call_lock handling outside of smp_call_function_map so we
can avoid deadlocks in smp_send_stop().


Signed-off-by: Olof Johansson <olof@lixom.net>

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index cefeee8..8730687 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -76,6 +76,8 @@ void smp_call_function_interrupt(void);
 
 int smt_enabled_at_boot = 1;
 
+static int ipi_fail_ok;
+
 static void (*crash_ipi_function_ptr)(struct pt_regs *) = NULL;
 
 #ifdef CONFIG_PPC64
@@ -204,8 +206,6 @@ static int __smp_call_function_map(void (*func) (void *info), void *info,
 	if (wait)
 		atomic_set(&data.finished, 0);
 
-	spin_lock(&call_lock);
-
 	/* remove 'self' from the map */
 	if (cpu_isset(smp_processor_id(), map))
 		cpu_clear(smp_processor_id(), map);
@@ -232,7 +232,8 @@ static int __smp_call_function_map(void (*func) (void *info), void *info,
 			printk("smp_call_function on cpu %d: other cpus not "
 				"responding (%d)\n", smp_processor_id(),
 				atomic_read(&data.started));
-			debugger(NULL);
+			if (!ipi_fail_ok)
+				debugger(NULL);
 			goto out;
 		}
 	}
@@ -259,15 +260,18 @@ static int __smp_call_function_map(void (*func) (void *info), void *info,
  out:
 	call_data = NULL;
 	HMT_medium();
-	spin_unlock(&call_lock);
 	return ret;
 }
 
 static int __smp_call_function(void (*func)(void *info), void *info,
 			       int nonatomic, int wait)
 {
-	return __smp_call_function_map(func, info, nonatomic, wait,
+	int ret;
+	spin_lock(&call_lock);
+	ret =__smp_call_function_map(func, info, nonatomic, wait,
 				       cpu_online_map);
+	spin_unlock(&call_lock);
+	return ret;
 }
 
 int smp_call_function(void (*func) (void *info), void *info, int nonatomic,
@@ -293,9 +297,11 @@ int smp_call_function_single(int cpu, void (*func) (void *info), void *info,
 		return -EINVAL;
 
 	cpu_set(cpu, map);
-	if (cpu != get_cpu())
+	if (cpu != get_cpu()) {
+		spin_lock(&call_lock);
 		ret = __smp_call_function_map(func, info, nonatomic, wait, map);
-	else {
+		spin_unlock(&call_lock);
+	} else {
 		local_irq_disable();
 		func(info);
 		local_irq_enable();
@@ -307,7 +313,22 @@ EXPORT_SYMBOL(smp_call_function_single);
 
 void smp_send_stop(void)
 {
-	__smp_call_function(stop_this_cpu, NULL, 1, 0);
+	int nolock;
+
+	/* It's OK to fail sending the IPI, since the alternative is to
+	 * be stuck forever waiting on the other CPU to take the interrupt.
+	 *
+	 * It's better to at least continue and go through reboot, since this
+	 * function is usually called at panic or reboot time in the first
+	 * place.
+	 */
+	ipi_fail_ok = 1;
+
+	/* Don't deadlock in case we got called through panic */
+	nolock = !spin_trylock(&call_lock);
+	__smp_call_function_map(stop_this_cpu, NULL, 1, 0, cpu_online_map);
+	if (!nolock)
+		spin_unlock(&call_lock);
 }
 
 void smp_call_function_interrupt(void)
