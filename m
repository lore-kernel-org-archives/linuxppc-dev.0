Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo3so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 87BB1DDEF5
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 22:43:46 +1000 (EST)
Received: from pd2mr2so.prod.shaw.ca
	(pd2mr2so-qfe3.prod.shaw.ca [10.0.141.109]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0K03008U07CXP290@l-daemon> for linuxppc-dev@ozlabs.org;
	Tue, 29 Apr 2008 06:43:45 -0600 (MDT)
Received: from pn2ml7so.prod.shaw.ca ([10.0.121.151])
	by pd2mr2so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0K030031V7CVWA80@pd2mr2so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Tue, 29 Apr 2008 06:43:43 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0K03004J17CWL340@l-daemon> for linuxppc-dev@ozlabs.org;
	Tue, 29 Apr 2008 06:43:44 -0600 (MDT)
Date: Tue, 29 Apr 2008 06:43:44 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] [POWERPC] mpc5200: Fix unterminated of_device_id table
To: linuxppc-dev@ozlabs.org, linux_kernel@vger.kernel.org, paulus@samba.org
Message-id: <20080429124343.24177.15349.stgit@trillian.secretlab.ca>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

If CONFIG_PPC_MPC5121 is not set, then the of_device_id table for the
mpc5200 serial driver will not get terminated with a NULL entry.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/serial/mpc52xx_uart.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
index d93b357..7a3625f 100644
--- a/drivers/serial/mpc52xx_uart.c
+++ b/drivers/serial/mpc52xx_uart.c
@@ -1221,8 +1221,8 @@ static struct of_device_id mpc52xx_uart_of_match[] = {
 #endif
 #ifdef CONFIG_PPC_MPC512x
 	{ .compatible = "fsl,mpc5121-psc-uart", .data = &mpc512x_psc_ops, },
-	{},
 #endif
+	{},
 };
 
 static int __devinit
