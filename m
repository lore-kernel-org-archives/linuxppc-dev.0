Return-Path: <laurent.pinchart@tbox.biz>
Received: from outmx015.isp.belgacom.be (outmx015.isp.belgacom.be
	[195.238.4.87])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 367EF67E9A
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 31 Oct 2006 18:54:58 +1100 (EST)
Received: from outmx015.isp.belgacom.be (localhost [127.0.0.1])
	by outmx015.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k9V7sptm005655
	for <linuxppc-embedded@ozlabs.org>; Tue, 31 Oct 2006 08:54:51 +0100
	(envelope-from <laurent.pinchart@tbox.biz>)
From: Laurent Pinchart <laurent.pinchart@tbox.biz>
To: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: [PATCH] CPM UART: Fix break generation
Date: Tue, 31 Oct 2006 08:58:28 +0100
References: <200610261002.44688.laurent.pinchart@tbox.biz>
	<200610301623.51537.laurent.pinchart@tbox.biz>
	<20061030184002.35611755@vitb.ru.mvista.com>
In-Reply-To: <20061030184002.35611755@vitb.ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200610310858.28622.laurent.pinchart@tbox.biz>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

When generating a break condition on a serial port, the CPM must be told
beforehand how long the break should be. Unfortunately, this information is
not available through the current serial break handling API. This patch works
around the problem by requesting a 32767 characters break followed by a 0
characters break after the requested duration. The CPM will stop the first
break when the second one is requested. This might not work with future CPM
revisions.

Signed-off-by: Laurent Pinchart <laurent@pclaurent.technotrade>
---
 drivers/serial/cpm_uart/cpm_uart_core.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c 
b/drivers/serial/cpm_uart/cpm_uart_core.c
index c29d87d..aa0a284 100644
--- a/drivers/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/serial/cpm_uart/cpm_uart_core.c
@@ -239,14 +239,23 @@ static void cpm_uart_break_ctl(struct ua
 {
 	struct uart_cpm_port *pinfo = (struct uart_cpm_port *)port;
 	int line = pinfo - cpm_uart_ports;
+	volatile u16 *brkcr = IS_SMC(pinfo) ? &pinfo->smcup->smc_brkcr
+				: &pinfo->sccup->scc_brkcr;
 
 	pr_debug("CPM uart[%d]:break ctrl, break_state: %d\n", port->line,
 		break_state);
 
 	if (break_state)
+	{
+		*brkcr = 32767;
 		cpm_line_cr_cmd(line, CPM_CR_STOP_TX);
+	}
 	else
+	{
+		*brkcr = 0;
+		cpm_line_cr_cmd(line, CPM_CR_STOP_TX);
 		cpm_line_cr_cmd(line, CPM_CR_RESTART_TX);
+	}
 }
 
 /*
-- 
1.4.GIT
