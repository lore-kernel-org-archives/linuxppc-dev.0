Return-Path: <damm@opensource.se>
Received: from mail-slave.dataphone.se (ns3.dataphone.se [212.37.0.170])
	by ozlabs.org (Postfix) with ESMTP id BD43E2BF0E
	for <linuxppc-dev@ozlabs.org>; Sun,  9 Jan 2005 05:08:24 +1100 (EST)
From: Magnus Damm <damm@opensource.se>
To: linuxppc-dev@ozlabs.org
Message-Id: <20050108180050.14410.66973.89460@kubu>
Date: Sat,  8 Jan 2005 19:02:09 +0100 (CET)
Cc: Magnus Damm <damm@opensource.se>
Subject: [PATCH] ppc32: ide, mpc8xx - volatile fix
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch makes sure that a PCMCIA register is accessed with a volatile
pointer. Wierd things happen without the patch if compiled with gcc-3.

Signed-off-by: Magnus Damm <damm@opensource.se>

--- linux-2.6.10/drivers/ide/ppc/mpc8xx.c	2004-12-24 22:35:39.000000000 +0100
+++ linux-2.6.10-ppc32_ide_mpc8xx_volatile/drivers/ide/ppc/mpc8xx.c	2005-01-08 18:42:06.000000000 +0100
@@ -172,7 +172,7 @@
 	volatile pcmcia_win_t *win;
 	volatile pcmconf8xx_t *pcmp;
 
-	uint *pgcrx;
+	volatile uint *pgcrx;
 	u32 pcmcia_phy_base;
 	u32 pcmcia_phy_end;
 	static unsigned long pcmcia_base = 0;
