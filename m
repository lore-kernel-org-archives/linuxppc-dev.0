Return-Path: <clg@kaod.org>
Received: from 19.mo7.mail-out.ovh.net (19.mo7.mail-out.ovh.net
 [178.33.251.118])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40g9Vy6tLTzF1vj
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 May 2018 17:05:46 +1000 (AEST)
Received: from player737.ha.ovh.net (unknown [10.109.108.83])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id E898CA5C26
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 May 2018 09:05:42 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v2 2/4] powerpc/xive: fix hcall H_INT_RESET to support long
 busy delays
Date: Tue,  8 May 2018 09:05:15 +0200
Message-Id: <20180508070517.947-3-clg@kaod.org>
In-Reply-To: <20180508070517.947-1-clg@kaod.org>
References: <20180508070517.947-1-clg@kaod.org>
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

 Changes since v2:

 - replaced msleep() by mdelay() as some calling path are under lock. 

 arch/powerpc/sysdev/xive/spapr.c | 52 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 47 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/sysdev/xive/spapr.c b/arch/powerpc/sysdev/xive/spapr.c
index 3cf5f8bf4c29..31dc73cacd45 100644
--- a/arch/powerpc/sysdev/xive/spapr.c
+++ b/arch/powerpc/sysdev/xive/spapr.c
@@ -19,6 +19,7 @@
 #include <linux/spinlock.h>
 #include <linux/cpumask.h>
 #include <linux/mm.h>
+#include <linux/delay.h>
 
 #include <asm/prom.h>
 #include <asm/io.h>
@@ -108,6 +109,51 @@ static void xive_irq_bitmap_free(int irq)
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
+	ms = plpar_busy_delay_time(rc);
+	if (ms)
+		mdelay(ms);
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
@@ -433,11 +479,7 @@ static void xive_spapr_put_ipi(unsigned int cpu, struct xive_cpu *xc)
 
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
