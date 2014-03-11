Return-Path: <ego@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B5D1E2C0099
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 22:31:38 +1100 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Tue, 11 Mar 2014 21:31:36 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 0FEC52CE803F
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 22:31:34 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2BBBWXM64422018
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 22:11:32 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2BBVWAP019905
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 22:31:33 +1100
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [RFC PATCH 2/2] powerpc: powernv: Implement ppc_md.get_proc_freq()
Date: Tue, 11 Mar 2014 17:01:19 +0530
Message-Id: <1394537479-17231-3-git-send-email-ego@linux.vnet.ibm.com>
In-Reply-To: <1394537479-17231-1-git-send-email-ego@linux.vnet.ibm.com>
References: <1394537479-17231-1-git-send-email-ego@linux.vnet.ibm.com>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

Implement a method named pnv_get_proc_freq(unsigned int cpu) which
returns the current clock rate on the 'cpu' in Hz to be reported in
/proc/cpuinfo. This method uses the value reported by cpufreq when
such a value is sane. Otherwise it falls back to old way of reporting
the clockrate, i.e. ppc_proc_freq.

Set the ppc_md.get_proc_freq() hook to pnv_get_proc_freq() on the
PowerNV platform.

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/setup.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index 110f4fb..423e36d 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -28,6 +28,7 @@
 #include <linux/bug.h>
 #include <linux/cpuidle.h>
 #include <linux/pci.h>
+#include <linux/cpufreq.h>
 
 #include <asm/machdep.h>
 #include <asm/firmware.h>
@@ -235,6 +236,25 @@ void powernv_idle(void)
 	}
 }
 
+/*
+ * Returns the cpu frequency for 'cpu' in Hz. This is used by
+ * /proc/cpuinfo
+ */
+unsigned long pnv_get_proc_freq(unsigned int cpu)
+{
+	unsigned long ret_freq;
+
+	ret_freq = cpufreq_quick_get(cpu) * 1000ul;
+
+	/*
+	 * If the backend cpufreq driver does not exist,
+         * then fallback to old way of reporting the clockrate.
+	 */
+	if (!ret_freq)
+		ret_freq = ppc_proc_freq;
+	return ret_freq;
+}
+
 define_machine(powernv) {
 	.name			= "PowerNV",
 	.probe			= pnv_probe,
@@ -242,6 +262,7 @@ define_machine(powernv) {
 	.setup_arch		= pnv_setup_arch,
 	.init_IRQ		= pnv_init_IRQ,
 	.show_cpuinfo		= pnv_show_cpuinfo,
+	.get_proc_freq          = pnv_get_proc_freq,
 	.progress		= pnv_progress,
 	.machine_shutdown	= pnv_shutdown,
 	.power_save             = powernv_idle,
-- 
1.8.3.1
