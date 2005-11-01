Return-Path: <hs@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 66FCB68660
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Nov 2005 18:22:22 +1100 (EST)
Received: from mail.m-online.net (svr20.m-online.net [192.168.3.148])
	by mail-out.m-online.net (Postfix) with ESMTP id 11E0270608
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Nov 2005 08:21:05 +0100 (CET)
Received: from embluxa7e0291e (82.131.207.191.pool.invitel.hu [82.131.207.191])
	by smtp-auth.mnet-online.de (Postfix) with ESMTP id 0A4DC1251A5
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Nov 2005 08:22:20 +0100 (CET)
From: "Heiko Schocher" <hs@denx.de>
To: <linuxppc-dev@ozlabs.org>
Date: Tue, 1 Nov 2005 08:22:20 +0100
Message-ID: <AHEILKONAKAEJPHNMOPNEEFCCDAA.hs@denx.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: [PATCH] ppc32: fix: swallowed chars when booting.
Reply-To: hs@dexn.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

Sorry, here comes the resubmit of the Patch because
corruption of whitespaces.

on a MPC8260 based Board, i lost some chars on the SMC2
Console, when booting the kernel. The following Patch
will fix this.

thanks
Heiko Schocher

[PATCH]     ppc32: fix: swallowed chars when booting.

In cpm_uart_set_termios(): wait until all chars are transmitted,
before writing the SMC Mode Register.

Signed-off-by: Heiko Schocher <hs@denx.de>

---
commit d2fcbaa6d5fcb3c1f80c98997dbcf6f6ee075f1b
tree d602dae10d2010ca1506c6a02e6a6db36ac86aca
parent ed28f96ac1960f30f818374d65be71d2fdf811b0
author Heiko Schocher <hs@pollux.(none)> Mon, 31 Oct 2005 12:11:55 +0100
committer Heiko Schocher <hs@pollux.(none)> Mon, 31 Oct 2005 12:11:55 +0100

 drivers/serial/cpm_uart/cpm_uart_core.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c
b/drivers/serial/cpm_uart/cpm_uart_core.c
index 25825f2..a452c38 100644
--- a/drivers/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/serial/cpm_uart/cpm_uart_core.c
@@ -553,6 +553,11 @@ static void cpm_uart_set_termios(struct
 		 * present.
 		 */
 		prev_mode = smcp->smc_smcmr;
+		/* Wait for all the BDs marked sent */
+		while(!cpm_uart_tx_empty(port)) {
+			set_current_state(TASK_UNINTERRUPTIBLE);
+			schedule_timeout(4);
+		}
 		smcp->smc_smcmr = smcr_mk_clen(bits) | cval | SMCMR_SM_UART;
 		smcp->smc_smcmr |= (prev_mode & (SMCMR_REN | SMCMR_TEN));
 	} else {



!-------------------------------------------------------------flip-
