Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1D584B6FA6
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Sep 2011 14:59:57 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 13/20] powerpc/powernv: Hookup reboot and poweroff functions
Date: Tue, 20 Sep 2011 13:45:00 +1000
Message-Id: <1316490307-28030-13-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1316490307-28030-1-git-send-email-benh@kernel.crashing.org>
References: <1316490307-28030-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This calls the respective HAL functions, and spin on hal_poll_event()
to ensure the HAL has a chance to communicate with the FSP to trigger
the reboot or shutdown operation

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/platforms/powernv/setup.c |   32 ++++++++++++++++++++++++++------
 1 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index 07ba1ec..0fac0a6 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -83,19 +83,39 @@ static void pnv_show_cpuinfo(struct seq_file *m)
 	of_node_put(root);
 }
 
-static void pnv_restart(char *cmd)
+static void  __noreturn pnv_restart(char *cmd)
 {
-	for (;;);
+	long rc = OPAL_BUSY;
+
+	while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
+		rc = opal_cec_reboot();
+		if (rc == OPAL_BUSY_EVENT)
+			opal_poll_events(NULL);
+		else
+			mdelay(10);
+	}
+	for (;;)
+		opal_poll_events(NULL);
 }
 
-static void pnv_power_off(void)
+static void __noreturn pnv_power_off(void)
 {
-	for (;;);
+	long rc = OPAL_BUSY;
+
+	while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
+		rc = opal_cec_power_down(0);
+		if (rc == OPAL_BUSY_EVENT)
+			opal_poll_events(NULL);
+		else
+			mdelay(10);
+	}
+	for (;;)
+		opal_poll_events(NULL);
 }
 
-static void pnv_halt(void)
+static void __noreturn pnv_halt(void)
 {
-	for (;;);
+	pnv_power_off();
 }
 
 static unsigned long __init pnv_get_boot_time(void)
-- 
1.7.4.1
