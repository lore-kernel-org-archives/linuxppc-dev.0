Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 89CCFDDF69
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Apr 2007 18:40:57 +1000 (EST)
Date: Fri, 27 Apr 2007 03:41:18 -0500
To: paulus@samba.org
Subject: [PATCH] powerpc: Show current speed in /proc/cpuinfo
Message-ID: <20070427084118.GA8842@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On other architectures, the frequency in /proc/cpuinfo moves with cpufreq
changes. It makes sense to do the same on powerpc to keep users from
getting confused. Fall back to old ppc_proc_freq for non-cpufreq systems.

Also change the format to three decimals, having full Hz granularity is
silly these days.


Signed-off-by: Olof Johansson <olof@lixom.net>


Index: powerpc/arch/powerpc/kernel/setup-common.c
===================================================================
--- powerpc.orig/arch/powerpc/kernel/setup-common.c
+++ powerpc/arch/powerpc/kernel/setup-common.c
@@ -29,6 +29,7 @@
 #include <linux/root_dev.h>
 #include <linux/notifier.h>
 #include <linux/cpu.h>
+#include <linux/cpufreq.h>
 #include <linux/unistd.h>
 #include <linux/serial.h>
 #include <linux/serial_8250.h>
@@ -160,6 +161,7 @@ static int show_cpuinfo(struct seq_file 
 	unsigned int pvr;
 	unsigned short maj;
 	unsigned short min;
+	unsigned int freq;
 
 	if (cpu_id == NR_CPUS) {
 #if defined(CONFIG_SMP) && defined(CONFIG_PPC32)
@@ -226,13 +228,15 @@ static int show_cpuinfo(struct seq_file 
 	}
 #endif /* CONFIG_TAU */
 
-	/*
-	 * Assume here that all clock rates are the same in a
-	 * smp system.  -- Cort
-	 */
-	if (ppc_proc_freq)
-		seq_printf(m, "clock\t\t: %lu.%06luMHz\n",
-			   ppc_proc_freq / 1000000, ppc_proc_freq % 1000000);
+	/* cpufreq_speed_get() is in kHz */
+	freq = cpufreq_quick_get(cpu_id);
+
+	if (!freq)
+		/* ppc_proc_freq is in Hz */
+		freq = ppc_proc_freq / 1000;
+
+	if (freq)
+		seq_printf(m, "clock\t\t: %u.%03uMHz\n", freq / 1000, freq % 1000);
 
 	if (ppc_md.show_percpuinfo != NULL)
 		ppc_md.show_percpuinfo(m, cpu_id);
