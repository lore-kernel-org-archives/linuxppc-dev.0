Return-Path: <grant.likely@secretlab.ca>
Received: from sandbox.secretlab.ca (S01060016b61d1226.cg.shawcable.net
	[68.147.191.145]) by ozlabs.org (Postfix) with ESMTP id AB308DDF54
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Jan 2007 09:45:45 +1100 (EST)
From: grant.likely@secretlab.ca
To: tnt@246tnt.com,
	paulus@samba.org,
	linuxppc-dev@ozlabs.org
Subject: [POWERPC] Fix mpc52xx serial driver to work for arch/ppc again
Date: Tue,  2 Jan 2007 15:45:37 -0700
Message-Id: <11677779373025-git-send-email-grant.likely@secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

The mpc52xx_uart_of_enumerate() function was added when adding 52xx
support to arch/powerpc, but it must not be called for arch/ppc.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

Please include for .20; without this patch you cannot build an arch/ppc
kernel for the lite52xx.

 drivers/serial/mpc52xx_uart.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
index 9d11a75..3c4b6c2 100644
--- a/drivers/serial/mpc52xx_uart.c
+++ b/drivers/serial/mpc52xx_uart.c
@@ -789,7 +789,9 @@ static struct console mpc52xx_console = 
 static int __init
 mpc52xx_console_init(void)
 {
+#if defined(CONFIG_PPC_MERGE)
 	mpc52xx_uart_of_enumerate();
+#endif
 	register_console(&mpc52xx_console);
 	return 0;
 }
-- 
1.4.3.rc2.g0503
