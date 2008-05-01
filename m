Return-Path: <bgill@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5ACE2DDE00
	for <linuxppc-dev@ozlabs.org>; Fri,  2 May 2008 09:21:23 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m41NLD10029910
	for <linuxppc-dev@ozlabs.org>; Thu, 1 May 2008 16:21:13 -0700 (MST)
Received: from monty.am.freescale.net (monty.am.freescale.net [10.82.19.26])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m41NLD0b013181
	for <linuxppc-dev@ozlabs.org>; Thu, 1 May 2008 18:21:13 -0500 (CDT)
Received: from monty.am.freescale.net (localhost.localdomain [127.0.0.1])
	by monty.am.freescale.net (8.14.2/8.14.2) with ESMTP id m41NFjKc008824
	for <linuxppc-dev@ozlabs.org>; Thu, 1 May 2008 18:15:46 -0500
Received: from localhost (bgill@localhost)
	by monty.am.freescale.net (8.14.2/8.14.2/Submit) with ESMTP id
	m41NFjv1008821
	for <linuxppc-dev@ozlabs.org>; Thu, 1 May 2008 18:15:45 -0500
Date: Thu, 1 May 2008 18:15:45 -0500 (CDT)
From: Becky Bruce <bgill@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Squash build warning for print of resource_size_t in fsl_soc.c
Message-ID: <Pine.LNX.4.64.0805011814110.8816@monty.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


When resource_size_t is larger than an int, the current code
generates a build warning.  Kill it.

Signed-off-by: Becky Bruce <becky.bruce@freescale.com>
---
 arch/powerpc/sysdev/fsl_soc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 7b45670..b594087 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -389,8 +389,8 @@ static int __init gfar_of_init(void)
 			}
 
 			gfar_data.phy_id = *id;
-			snprintf(gfar_data.bus_id, MII_BUS_ID_SIZE, "%x",
-					res.start);
+			snprintf(gfar_data.bus_id, MII_BUS_ID_SIZE, "%llx",
+				 (unsigned long long)res.start);
 
 			of_node_put(phy);
 			of_node_put(mdio);
-- 
1.5.4.1
