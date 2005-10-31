Return-Path: <hs@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id C5D7068604
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Oct 2005 22:29:24 +1100 (EST)
Received: from mail.m-online.net (svr20.m-online.net [192.168.3.148])
	by mail-out.m-online.net (Postfix) with ESMTP id DDFFF7046D
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Oct 2005 12:28:07 +0100 (CET)
Received: from svr5.m-online.net (svr5.m-online.net [62.245.150.227])
	by mail.m-online.net (Postfix) with ESMTP id ABC9F123F5D
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Oct 2005 12:29:22 +0100 (CET)
Received: (from wmrun@localhost)
	by svr5.m-online.net (8.13.4/8.12.6/Submit) id j9VBTMaZ026289
	for linuxppc-dev@ozlabs.org; Mon, 31 Oct 2005 12:29:22 +0100
Message-ID: <1130758162.436600128a9fe@webmail.mnet-online.de>
Date: Mon, 31 Oct 2005 12:29:22 +0100
From: Heiko Schocher <hs@denx.de>
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [PATCH]     ppc32: fix: swallowed chars when booting.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

on a MPC8260 based Board, i lost some chars on the SMC2
Console, when booting the kernel. The following Patch
will fix this.

thanks
Heiko Schocher

Signed-off-by: Heiko Schocher <hs@denx.de>

---

 drivers/serial/cpm_uart/cpm_uart_core.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c 
b/drivers/serial/cpm_uart/cpm_uart_core.c
index 4c3ea05..ac05ee9 100644
--- a/drivers/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/serial/cpm_uart/cpm_uart_core.c
@@ -557,6 +557,11 @@ static void cpm_uart_set_termios(struct
                 * present.
                 */
                prev_mode = smcp->smc_smcmr;
+                /* Wait for all the BDs marked sent */
+                while(!cpm_uart_tx_empty(port)) {
+                        set_current_state(TASK_UNINTERRUPTIBLE);
+                        schedule_timeout(4);
+                }
                smcp->smc_smcmr = smcr_mk_clen(bits) | cval | SMCMR_SM_UART;
                smcp->smc_smcmr |= (prev_mode & (SMCMR_REN | SMCMR_TEN));
        } else {
