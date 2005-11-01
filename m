Return-Path: <hs@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 0932B68660
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Nov 2005 18:17:45 +1100 (EST)
Received: from mail.m-online.net (svr20.m-online.net [192.168.3.148])
	by mail-out.m-online.net (Postfix) with ESMTP id 58ED070652
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Nov 2005 08:16:27 +0100 (CET)
Received: from embluxa7e0291e (82.131.207.191.pool.invitel.hu [82.131.207.191])
	by smtp-auth.mnet-online.de (Postfix) with ESMTP id 5206A1251AD
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Nov 2005 08:17:43 +0100 (CET)
From: "Heiko Schocher" <hs@denx.de>
To: <linuxppc-dev@ozlabs.org>
Date: Tue, 1 Nov 2005 08:17:43 +0100
Message-ID: <AHEILKONAKAEJPHNMOPNMEFBCDAA.hs@denx.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: [PATCH] ppc32: Fix SCC Uart write problem after 2. open()
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

on a MPC8260 based Board, i succesfully wrote chars
over a SCC in UART Mode, but after i closed the port
and opened it again, the write() call failed!
(cpm_uart_tx_empty()returns continually 0).
The following Patch will fix this problem.

thanks
Heiko Schocher

[PATCH] ppc32:  Fix SCC Uart write problem after 2. open().

Signed-off-by: Heiko Schocher <hs@denx.de>

---
commit f27d5789521e3f70a293075a63d195b22f8156ed
tree 1b459d4a9a2795e39e1d415ff21f2a25a0d0fbe5
parent d2fcbaa6d5fcb3c1f80c98997dbcf6f6ee075f1b
author Heiko Schocher <hs@pollux.(none)> Mon, 31 Oct 2005 15:46:50 +0100
committer Heiko Schocher <hs@pollux.(none)> Mon, 31 Oct 2005 15:46:50 +0100

 drivers/serial/cpm_uart/cpm_uart_core.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c
b/drivers/serial/cpm_uart/cpm_uart_core.c
index a452c38..ac05ee9 100644
--- a/drivers/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/serial/cpm_uart/cpm_uart_core.c
@@ -445,6 +445,10 @@ static void cpm_uart_shutdown(struct uar
 		/* Shut them really down and reinit buffer descriptors */
 		cpm_line_cr_cmd(line, CPM_CR_STOP_TX);
 		cpm_uart_initbd(pinfo);
+		if (IS_SMC(pinfo))
+			cpm_uart_init_smc(pinfo);
+		else
+			cpm_uart_init_scc(pinfo);
 	}
 }
