Return-Path: <hs@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id B6D9468660
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Nov 2005 00:01:14 +1100 (EST)
Received: from mail.m-online.net (svr20.m-online.net [192.168.3.148])
	by mail-out.m-online.net (Postfix) with ESMTP id D65F17068C
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Nov 2005 13:59:53 +0100 (CET)
Received: from embluxa7e0291e (82.131.201.147.pool.invitel.hu [82.131.201.147])
	by smtp-auth.mnet-online.de (Postfix) with ESMTP id D8455125A11
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Nov 2005 14:01:11 +0100 (CET)
From: "Heiko Schocher" <hs@denx.de>
To: <linuxppc-dev@ozlabs.org>
Date: Wed, 2 Nov 2005 14:01:08 +0100
Message-ID: <AHEILKONAKAEJPHNMOPNEEFNCDAA.hs@denx.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: [PATCH] ppc32: fix: swallowed chars when booting.
Reply-To: hs@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

during I am searching the right solution for my
other patch, i found another way for solving the
swallowed chars problem when booting on SMC2.

Please comment.

thanks
Heiko Schocher

[PATCH] ppc32:  Fix: swallowed chars on SMC2 Console.

Signed-off-by: Heiko Schocher <hs@denx.de>

---
 drivers/serial/cpm_uart/cpm_uart_core.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c
b/drivers/serial/cpm_uart/cpm_uart_core.c
index 25825f2..baedd74 100644
--- a/drivers/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/serial/cpm_uart/cpm_uart_core.c
@@ -552,9 +552,9 @@ static void cpm_uart_set_termios(struct
 		 * enables, because we want to put them back if they were
 		 * present.
 		 */
-		prev_mode = smcp->smc_smcmr;
-		smcp->smc_smcmr = smcr_mk_clen(bits) | cval | SMCMR_SM_UART;
-		smcp->smc_smcmr |= (prev_mode & (SMCMR_REN | SMCMR_TEN));
+		prev_mode = smcp->smc_smcmr & (SMCMR_REN | SMCMR_TEN);
+		smcp->smc_smcmr = smcr_mk_clen(bits) | cval | SMCMR_SM_UART
+				| prev_mode;
 	} else {
 		sccp->scc_psmr = (sbits << 12) | scval;
 	}
