Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp01.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6E18B2C02CA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 19:55:16 +1000 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <deepthi@linux.vnet.ibm.com>;
 Thu, 22 Aug 2013 19:44:50 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 0487F2BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 19:55:13 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7M9dEV764946364
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 19:39:14 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r7M9tBxP021156
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 19:55:12 +1000
Subject: [PATCH V5 5/5] powernv/cpuidle: Enable idle powernv cpu to call
 into the cpuidle framework.
To: benh@kernel.crashing.org, daniel.lezcano@linaro.org,
 linux-kernel@vger.kernel.org, scottwood@freescale.com,
 linux-pm@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org
From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Date: Thu, 22 Aug 2013 15:24:34 +0530
Message-ID: <20130822095430.27416.43919.stgit@deepthi.in.ibm.com>
In-Reply-To: <20130822095323.27416.79369.stgit@deepthi.in.ibm.com>
References: <20130822095323.27416.79369.stgit@deepthi.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: preeti@linux.vnet.ibm.com, dongsheng.wang@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch enables idle cpu on the powernv platform  to hook on to the cpuidle
framework, if available, else call on to default idle platform
code.

Signed-off-by: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/setup.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index 84438af..fc62f21 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -25,6 +25,7 @@
 #include <linux/of.h>
 #include <linux/interrupt.h>
 #include <linux/bug.h>
+#include <linux/cpuidle.h>
 
 #include <asm/machdep.h>
 #include <asm/firmware.h>
@@ -175,6 +176,17 @@ static void __init pnv_setup_machdep_rtas(void)
 }
 #endif /* CONFIG_PPC_POWERNV_RTAS */
 
+void powernv_idle(void)
+{
+	/* Hook to cpuidle framework if available, else
+	 * call on default platform idle code
+	 */
+	if (cpuidle_idle_call()) {
+		HMT_low();
+		HMT_very_low();
+	}
+}
+
 static int __init pnv_probe(void)
 {
 	unsigned long root = of_get_flat_dt_root();
@@ -205,7 +217,7 @@ define_machine(powernv) {
 	.show_cpuinfo		= pnv_show_cpuinfo,
 	.progress		= pnv_progress,
 	.machine_shutdown	= pnv_shutdown,
-	.power_save             = power7_idle,
+	.power_save             = powernv_idle,
 	.calibrate_decr		= generic_calibrate_decr,
 #ifdef CONFIG_KEXEC
 	.kexec_cpu_down		= pnv_kexec_cpu_down,
