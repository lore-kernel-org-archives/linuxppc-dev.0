Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp03.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 982DC2C011C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Nov 2013 16:36:31 +1100 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <deepthi@linux.vnet.ibm.com>;
 Mon, 11 Nov 2013 11:06:28 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 41AFA1258054
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Nov 2013 11:07:12 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rAB5aLip40894486
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Nov 2013 11:06:21 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rAB5aNGf028987
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Nov 2013 11:06:24 +0530
Subject: [PATCH v8 7/7] powernv/cpuidle: Enable idle powernv cpu to call
 into the cpuidle framework.
To: benh@kernel.crashing.org, linux-pm@lists.linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Date: Mon, 11 Nov 2013 11:06:10 +0530
Message-ID: <20131111053608.14797.41270.stgit@deepthi.in.ibm.com>
In-Reply-To: <20131111053450.14797.75544.stgit@deepthi.in.ibm.com>
References: <20131111053450.14797.75544.stgit@deepthi.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: b.zolnierkie@samsung.com, daniel.lezcano@linaro.org,
 dongsheng.wang@freescale.com, preeti@linux.vnet.ibm.com,
 srivatsa.bhat@linux.vnet.ibm.com, scottwood@freescale.com
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
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/powerpc/platforms/powernv/setup.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index e239dcf..42a6ba0 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -25,6 +25,7 @@
 #include <linux/of.h>
 #include <linux/interrupt.h>
 #include <linux/bug.h>
+#include <linux/cpuidle.h>
 
 #include <asm/machdep.h>
 #include <asm/firmware.h>
@@ -192,6 +193,16 @@ static void __init pnv_setup_machdep_rtas(void)
 }
 #endif /* CONFIG_PPC_POWERNV_RTAS */
 
+void powernv_idle(void)
+{
+	/* Hook to cpuidle framework if available, else
+	 * call on default platform idle code
+	 */
+	if (cpuidle_idle_call()) {
+		power7_idle();
+	}
+}
+
 static int __init pnv_probe(void)
 {
 	unsigned long root = of_get_flat_dt_root();
@@ -222,7 +233,7 @@ define_machine(powernv) {
 	.show_cpuinfo		= pnv_show_cpuinfo,
 	.progress		= pnv_progress,
 	.machine_shutdown	= pnv_shutdown,
-	.power_save             = power7_idle,
+	.power_save             = powernv_idle,
 	.calibrate_decr		= generic_calibrate_decr,
 #ifdef CONFIG_KEXEC
 	.kexec_cpu_down		= pnv_kexec_cpu_down,
