Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 978DBB7BEE
	for <linuxppc-dev@ozlabs.org>; Wed,  5 May 2010 08:19:05 +1000 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] serial: mpc52xx_uart: fix null pointer dereference
Date: Wed,  5 May 2010 00:18:59 +0200
Message-Id: <1273011539-13994-1-git-send-email-agust@denx.de>
In-Reply-To: <g2xc2d0b6ec1005041339r9c40822w7a642f9bba976820@mail.gmail.com>
References: <g2xc2d0b6ec1005041339r9c40822w7a642f9bba976820@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, leonardo.lists@gmail.com, gregkh@suse.de,
	Anatolij Gustschin <agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 6acc6833510db8f72b5ef343296d97480555fda9
introduced NULL pointer dereference and kernel crash
on ppc32 machines while booting. Fix this bug now.

Reported-by: Leonardo Chiquitto <leonardo.lists@gmail.com>
Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 drivers/serial/mpc52xx_uart.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
index a176ab4..02469c3 100644
--- a/drivers/serial/mpc52xx_uart.c
+++ b/drivers/serial/mpc52xx_uart.c
@@ -1467,7 +1467,7 @@ mpc52xx_uart_init(void)
 	/*
 	 * Map the PSC FIFO Controller and init if on MPC512x.
 	 */
-	if (psc_ops->fifoc_init) {
+	if (psc_ops && psc_ops->fifoc_init) {
 		ret = psc_ops->fifoc_init();
 		if (ret)
 			return ret;
-- 
1.7.0.4
