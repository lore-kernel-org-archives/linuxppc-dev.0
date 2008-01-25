Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 37D2CDDE18
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 13:46:07 +1100 (EST)
Date: Thu, 24 Jan 2008 20:46:00 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: linuxppc-dev@ozlabs.org, Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 2/9] powerpc: add base platform support for the mpc8315 rdb
	board
Message-Id: <20080124204600.d16c5142.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

mpc8315 identical to mpc8313 here, just check compatible.

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
 arch/powerpc/platforms/83xx/Kconfig       |    2 +-
 arch/powerpc/platforms/83xx/mpc831x_rdb.c |    3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/Kconfig b/arch/powerpc/platforms/83xx/Kconfig
index faaa651..b478312 100644
--- a/arch/powerpc/platforms/83xx/Kconfig
+++ b/arch/powerpc/platforms/83xx/Kconfig
@@ -7,7 +7,7 @@ config MPC831x_RDB
 	bool "Freescale MPC831x RDB"
 	select DEFAULT_UIMAGE
 	help
-	  This option enables support for the MPC8313 RDB board.
+	  This option enables support for the MPC8313 RDB and MPC8315 RDB boards.
 
 config MPC832x_MDS
 	bool "Freescale MPC832x MDS"
diff --git a/arch/powerpc/platforms/83xx/mpc831x_rdb.c b/arch/powerpc/platforms/83xx/mpc831x_rdb.c
index b484b2b..c4db517 100644
--- a/arch/powerpc/platforms/83xx/mpc831x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc831x_rdb.c
@@ -64,7 +64,8 @@ static int __init mpc831x_rdb_probe(void)
 {
 	unsigned long root = of_get_flat_dt_root();
 
-	return of_flat_dt_is_compatible(root, "MPC8313ERDB");
+	return of_flat_dt_is_compatible(root, "MPC8313ERDB") ||
+	       of_flat_dt_is_compatible(root, "fsl,mpc8315erdb");
 }
 
 static struct of_device_id __initdata of_bus_ids[] = {
-- 
1.5.2.2
