Return-Path: <Xiaotian.Feng@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 9A934DDEE1
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Mar 2009 13:59:29 +1100 (EST)
From: Xiaotian Feng <Xiaotian.Feng@windriver.com>
To: galak@kernel.crashing.org, panto@intracom.gr, linuxppc-dev@ozlabs.org
Subject: [PATCH] cpm_uart: fix non-console port startup bug
Date: Fri,  6 Mar 2009 11:01:23 +0800
Message-Id: <1236308483-20495-1-git-send-email-Xiaotian.Feng@windriver.com>
Cc: linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  After UART interrupt handler is installed and rx is enabled, if an rx
interrupt comes before hardware init, rx->cur will be updated. Then the
hardware init will reset BD and make rx->cur out of sync, move the hardware
init code before request_irq.

  Signed-off-by: Xiaotian Feng <xiaotian.feng@windriver.com>
---
 drivers/serial/cpm_uart/cpm_uart_core.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c b/drivers/serial/cpm_uart/cpm_uart_core.c
index bde4b4b..5c6ef51 100644
--- a/drivers/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/serial/cpm_uart/cpm_uart_core.c
@@ -406,6 +406,18 @@ static int cpm_uart_startup(struct uart_port *port)
 
 	pr_debug("CPM uart[%d]:startup\n", port->line);
 
+	/* If the port is not the console, make sure rx is disabled. */
+	if (!(pinfo->flags & FLAG_CONSOLE)) {
+		/* Disable UART rx */
+		if (IS_SMC(pinfo)) {
+			clrbits16(&pinfo->smcp->smc_smcmr, SMCMR_REN);
+			clrbits8(&pinfo->smcp->smc_smcm, SMCM_RX);
+		} else {
+			clrbits32(&pinfo->sccp->scc_gsmrl, SCC_GSMRL_ENR);
+			clrbits16(&pinfo->sccp->scc_sccm, UART_SCCM_RX);
+		}
+		cpm_line_cr_cmd(pinfo, CPM_CR_INIT_TRX);
+	}
 	/* Install interrupt handler. */
 	retval = request_irq(port->irq, cpm_uart_int, 0, "cpm_uart", port);
 	if (retval)
@@ -420,8 +432,6 @@ static int cpm_uart_startup(struct uart_port *port)
 		setbits32(&pinfo->sccp->scc_gsmrl, (SCC_GSMRL_ENR | SCC_GSMRL_ENT));
 	}
 
-	if (!(pinfo->flags & FLAG_CONSOLE))
-		cpm_line_cr_cmd(pinfo, CPM_CR_INIT_TRX);
 	return 0;
 }
 
-- 
1.5.5.1
