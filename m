Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 36360140131
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Apr 2014 16:14:37 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id s3O6EQkW017637
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Apr 2014 01:14:30 -0500
Message-ID: <1398320065.14519.1.camel@pasglop>
Subject: [PATCH] powerpc/powernv: Fix kexec races going back to OPAL
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Date: Thu, 24 Apr 2014 16:14:25 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We have a subtle race when sending CPUs back to OPAL on kexec.

We mark them as "in real mode" right before we send them down. Once
we've booted the new kernel, it might try to call opal_reinit_cpus()
to change endianness, and that requires all CPUs to be spinning inside
OPAL.

However there is no synchronization here and we've observed cases
where the returning CPUs hadn't established their new state inside
OPAL before opal_reinit_cpus() is called, causing it to fail.

The proper fix is to actually wait for them to go down all the way
from the kexec'ing kernel.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/platforms/powernv/setup.c | 48 ++++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index 42c16a6..1eb3684 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -183,18 +183,62 @@ static void pnv_shutdown(void)
 }
 
 #ifdef CONFIG_KEXEC
+static void pnv_kexec_wait_secondaries_down(void)
+{
+	int my_cpu, i, notified = -1;
+
+	my_cpu = get_cpu();
+
+	for_each_online_cpu(i) {
+		uint8_t status;
+		int64_t rc;
+
+		if (i == my_cpu)
+			continue;
+
+		for (;;) {
+			rc = opal_query_cpu_status(get_hard_smp_processor_id(i),
+						   &status);
+			if (rc != OPAL_SUCCESS || status != OPAL_THREAD_STARTED)
+				break;
+			barrier();
+			if (i != notified) {
+				printk(KERN_INFO "kexec: waiting for cpu %d "
+				       "(physical %d) to enter OPAL\n",
+				       i, paca[i].hw_cpu_id);
+				notified = i;
+			}
+		}
+	}
+}
+
 static void pnv_kexec_cpu_down(int crash_shutdown, int secondary)
 {
 	xics_kexec_teardown_cpu(secondary);
 
-	/* Return secondary CPUs to firmware on OPAL v3 */
-	if (firmware_has_feature(FW_FEATURE_OPALv3) && secondary) {
+	/* On OPAL v3, we return all CPUs to firmware */
+
+	if (!firmware_has_feature(FW_FEATURE_OPALv3))
+		return;
+
+	if (secondary) {
+		/* Return secondary CPUs to firmware on OPAL v3 */
 		mb();
 		get_paca()->kexec_state = KEXEC_STATE_REAL_MODE;
 		mb();
 
 		/* Return the CPU to OPAL */
 		opal_return_cpu();
+	} else if (crash_shutdown) {
+		/*
+		 * On crash, we don't wait for secondaries to go
+		 * down as they might be unreachable or hung, so
+		 * instead we just wait a bit and move on.
+		 */
+		mdelay(1);
+	} else {
+		/* Primary waits for the secondaries to have reached OPAL */
+		pnv_kexec_wait_secondaries_down();
 	}
 }
 #endif /* CONFIG_KEXEC */
