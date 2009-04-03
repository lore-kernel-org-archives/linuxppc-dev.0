Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 29A9FDDDA5
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Apr 2009 08:16:35 +1100 (EST)
Date: Fri, 3 Apr 2009 16:15:49 -0500
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH] cpm_uart: Disable CPM udbg when re-initing CPM uart, even
	if not the console.
Message-ID: <20090403211549.GA22860@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Previously, if udbg was using the CPM uart, and the normal CPM uart driver
was enabled, but the console was directed elsewhere, udbg would not be
stopped prior to initialization.  This resulted in udbg hanging forever
waiting for the CPM to process a descriptor.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 drivers/serial/cpm_uart/cpm_uart_core.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c b/drivers/serial/cpm_uart/cpm_uart_core.c
index 4dd00be..f8df068 100644
--- a/drivers/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/serial/cpm_uart/cpm_uart_core.c
@@ -1106,6 +1106,10 @@ static int cpm_uart_init_port(struct device_node *np,
 	for (i = 0; i < NUM_GPIOS; i++)
 		pinfo->gpios[i] = of_get_gpio(np, i);
 
+#ifdef CONFIG_PPC_EARLY_DEBUG_CPM
+	udbg_putc = NULL;
+#endif
+
 	return cpm_uart_request_port(&pinfo->port);
 
 out_pram:
@@ -1255,10 +1259,6 @@ static int __init cpm_uart_console_setup(struct console *co, char *options)
 			baud = 9600;
 	}
 
-#ifdef CONFIG_PPC_EARLY_DEBUG_CPM
-	udbg_putc = NULL;
-#endif
-
 	if (IS_SMC(pinfo)) {
 		out_be16(&pinfo->smcup->smc_brkcr, 0);
 		cpm_line_cr_cmd(pinfo, CPM_CR_STOP_TX);
-- 
1.5.6.rc1.6.gc53ad.dirty
