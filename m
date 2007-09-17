Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4A98BDDEEE
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Sep 2007 02:58:20 +1000 (EST)
Date: Mon, 17 Sep 2007 11:57:40 -0500
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH 11/28] cpm_uart: Issue STOP_TX command before initializing
	console.
Message-ID: <20070917165740.GK6563@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070917165643.GA6545@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This prevents some bootloader/bootwrapper characters from being lost.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 drivers/serial/cpm_uart/cpm_uart_core.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c b/drivers/serial/cpm_uart/cpm_uart_core.c
index c43706e..336e05e 100644
--- a/drivers/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/serial/cpm_uart/cpm_uart_core.c
@@ -1325,6 +1325,8 @@ static int __init cpm_uart_console_setup(struct console *co, char *options)
 	udbg_putc = NULL;
 #endif
 
+	cpm_line_cr_cmd(pinfo, CPM_CR_STOP_TX);
+
 	if (IS_SMC(pinfo)) {
 		clrbits8(&pinfo->smcp->smc_smcm, SMCM_RX | SMCM_TX);
 		clrbits16(&pinfo->smcp->smc_smcmr, SMCMR_REN | SMCMR_TEN);
@@ -1346,6 +1348,7 @@ static int __init cpm_uart_console_setup(struct console *co, char *options)
 		cpm_uart_init_scc(pinfo);
 
 	uart_set_options(port, co, baud, parity, bits, flow);
+	cpm_line_cr_cmd(pinfo, CPM_CR_RESTART_TX);
 
 	return 0;
 }
-- 
1.5.3.1
