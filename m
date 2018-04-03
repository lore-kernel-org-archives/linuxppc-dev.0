Return-Path: <clg@kaod.org>
Received: from 4.mo177.mail-out.ovh.net (4.mo177.mail-out.ovh.net
 [46.105.37.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Fj435hrXzF288
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Apr 2018 18:31:29 +1000 (AEST)
Received: from player716.ha.ovh.net (unknown [10.109.120.50])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 3D5B0AAE50
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Apr 2018 09:16:05 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 2/4] powerpc/xive: fix hcall H_INT_RESET to support long busy
 delays
Date: Tue,  3 Apr 2018 09:15:46 +0200
Message-Id: <20180403071548.19829-3-clg@kaod.org>
In-Reply-To: <20180403071548.19829-1-clg@kaod.org>
References: <20180403071548.19829-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The hcall H_INT_RESET can take some time to complete and in such cases
it returns H_LONG_BUSY_* codes requiring the machine to sleep for a
while before retrying.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 arch/powerpc/sysdev/xive/spapr.c | 53 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 48 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/sysdev/xive/spapr.c b/arch/powerpc/sysdev/xive/spapr.c
index 091f1d0d0af1..7113f5d87952 100644
--- a/arch/powerpc/sysdev/xive/spapr.c
+++ b/arch/powerpc/sysdev/xive/spapr.c
@@ -19,6 +19,7 @@
 #include <linux/spinlock.h>
 #include <linux/cpumask.h>
 #include <linux/mm.h>
+#include <linux/delay.h>
 
 #include <asm/prom.h>
 #include <asm/io.h>
@@ -108,6 +109,52 @@ static void xive_irq_bitmap_free(int irq)
 	}
 }
 
+
+/* Based on the similar routines in RTAS */
+static unsigned int plpar_busy_delay_time(long rc)
+{
+	unsigned int ms = 0;
+
+	if (H_IS_LONG_BUSY(rc)) {
+		ms = get_longbusy_msecs(rc);
+	} else if (rc == H_BUSY) {
+		ms = 10; /* seems appropriate for XIVE hcalls */
+	}
+
+	return ms;
+}
+
+static unsigned int plpar_busy_delay(int rc)
+{
+	unsigned int ms;
+
+	might_sleep();
+	ms = plpar_busy_delay_time(rc);
+	if (ms && need_resched())
+		msleep(ms);
+
+	return ms;
+}
+
+/*
+ * Note: this call has a partition wide scope and can take a while to
+ * complete. If it returns H_LONG_BUSY_* it should be retried
+ * periodically.
+ */
+static long plpar_int_reset(unsigned long flags)
+{
+	long rc;
+
+	do {
+		rc = plpar_hcall_norets(H_INT_RESET, flags);
+	} while (plpar_busy_delay(rc));
+
+	if (rc)
+		pr_err("H_INT_RESET failed %ld\n", rc);
+
+	return rc;
+}
+
 static long plpar_int_get_source_info(unsigned long flags,
 				      unsigned long lisn,
 				      unsigned long *src_flags,
@@ -445,11 +492,7 @@ static void xive_spapr_put_ipi(unsigned int cpu, struct xive_cpu *xc)
 
 static void xive_spapr_shutdown(void)
 {
-	long rc;
-
-	rc = plpar_hcall_norets(H_INT_RESET, 0);
-	if (rc)
-		pr_err("H_INT_RESET failed %ld\n", rc);
+	plpar_int_reset(0);
 }
 
 /*
-- 
2.13.6
