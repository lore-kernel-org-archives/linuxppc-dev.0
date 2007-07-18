Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F08F6DF143
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 11:36:14 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l6I1a9ZZ019219
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 18:36:10 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.83.16.18])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6I1a81F001592
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:36:09 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l6I1BSWi007992
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:11:28 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 35C96AEFC9
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:36:08 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l6I1a8sm015470
	for linuxppc-dev@ozlabs.org; Tue, 17 Jul 2007 20:36:08 -0500
Date: Tue, 17 Jul 2007 20:36:08 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 52/61] cpm_uart: Issue STOP_TX command before initializing
	console.
Message-ID: <20070718013608.GX15238@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070718013137.GA15217@ld0162-tx32.am.freescale.net>
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
index 805ca46..7772c87 100644
--- a/drivers/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/serial/cpm_uart/cpm_uart_core.c
@@ -1310,6 +1310,8 @@ static int __init cpm_uart_console_setup(struct console *co, char *options)
 	udbg_putc = NULL;
 #endif
 
+	cpm_line_cr_cmd(pinfo, CPM_CR_STOP_TX);
+
 	if (IS_SMC(pinfo)) {
 		pinfo->smcp->smc_smcm &= ~(SMCM_RX | SMCM_TX);
 		pinfo->smcp->smc_smcmr &= ~(SMCMR_REN | SMCMR_TEN);
@@ -1331,6 +1333,7 @@ static int __init cpm_uart_console_setup(struct console *co, char *options)
 		cpm_uart_init_scc(pinfo);
 
 	uart_set_options(port, co, baud, parity, bits, flow);
+	cpm_line_cr_cmd(pinfo, CPM_CR_RESTART_TX);
 
 	return 0;
 }
-- 
1.5.0.3
