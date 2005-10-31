Return-Path: <hs@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 387FA68604
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Oct 2005 22:13:50 +1100 (EST)
Received: from mail.m-online.net (svr20.m-online.net [192.168.3.148])
	by mail-out.m-online.net (Postfix) with ESMTP id 4A71B70AEF
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Oct 2005 11:52:05 +0100 (CET)
Received: from svr5.m-online.net (svr5.m-online.net [62.245.150.227])
	by mail.m-online.net (Postfix) with ESMTP id 15F03123D99
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Oct 2005 11:53:20 +0100 (CET)
Received: (from wmrun@localhost)
	by svr5.m-online.net (8.13.4/8.12.6/Submit) id j9VArJfU025034
	for linuxppc-dev@ozlabs.org; Mon, 31 Oct 2005 11:53:19 +0100
Message-ID: <1130755999.4365f79f826de@webmail.mnet-online.de>
Date: Mon, 31 Oct 2005 11:53:19 +0100
From: Heiko Schocher <hs@denx.de>
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [PATCH] ppc32:  Fix SCC Uart write problem after 2. open()
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

on a MPC8260 based Board, i succesfully wrote chars
over a SCC in UART Mode, but after i closed the port
and opened it again, the write() call failed! 
(cpm_uart_tx_empty()returns continually 0).
The following Patch will fix this problem.

thanks
Heiko Schocher

---

 drivers/serial/cpm_uart/cpm_uart_core.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c 
b/drivers/serial/cpm_uart/cpm_uart_core.c
index 25825f2..4c3ea05 100644
--- a/drivers/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/serial/cpm_uart/cpm_uart_core.c
@@ -445,6 +445,10 @@ static void cpm_uart_shutdown(struct uar
                /* Shut them really down and reinit buffer descriptors */
                cpm_line_cr_cmd(line, CPM_CR_STOP_TX);
                cpm_uart_initbd(pinfo);
+               if (IS_SMC(pinfo))
+                       cpm_uart_init_smc(pinfo);
+               else
+                       cpm_uart_init_scc(pinfo);
        }
 }
