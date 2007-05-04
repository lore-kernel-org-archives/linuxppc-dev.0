Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id C493EDDED3
	for <linuxppc-dev@ozlabs.org>; Fri,  4 May 2007 13:14:47 +1000 (EST)
Date: Thu, 3 May 2007 22:16:12 -0500
To: paulus@samba.org
Subject: [PATCH v3] powerpc: Show current speed in /proc/cpuinfo
Message-ID: <20070504031611.GB5567@lixom.net>
References: <20070427084118.GA8842@lixom.net>
	<20070430035339.GA15771@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070430035339.GA15771@lixom.net>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, arnd@arndb.de
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
getting confused.

Change the format to three decimals, having full Hz granularity is silly
these days. Also specify in output if it's cpufreq or firmware-reported:

clock           : 1250.000MHz (from firmware)
or:
clock           : 2500.000MHz (actual speed)


Signed-off-by: Olof Johansson <olof@lixom.net>


Index: 2.6.21/arch/powerpc/kernel/setup-common.c
===================================================================
--- 2.6.21.orig/arch/powerpc/kernel/setup-common.c
+++ 2.6.21/arch/powerpc/kernel/setup-common.c
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
@@ -226,14 +228,18 @@ static int show_cpuinfo(struct seq_file 
 	}
 #endif /* CONFIG_TAU */
 
-	/*
-	 * Assume here that all clock rates are the same in a
-	 * smp system.  -- Cort
-	 */
+	/* ppc_proc_freq is in MHz */
 	if (ppc_proc_freq)
 		seq_printf(m, "clock\t\t: %lu.%06luMHz\n",
 			   ppc_proc_freq / 1000000, ppc_proc_freq % 1000000);
 
+	/* cpufreq_quick_get() is in kHz */
+	freq = cpufreq_quick_get(cpu_id);
+
+	if (freq)
+		seq_printf(m, "current-clock\t: %u.%03u000MHz\n",
+			   freq / 1000, freq % 1000);
+
 	if (ppc_md.show_percpuinfo != NULL)
 		ppc_md.show_percpuinfo(m, cpu_id);
 
