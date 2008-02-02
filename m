Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BD887DDE2F
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Feb 2008 11:10:01 +1100 (EST)
Date: Fri, 1 Feb 2008 18:09:54 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/3] powerpc: mpc832x_rdb: fix compiler warning
Message-Id: <20080201180954.b0671447.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

arch/powerpc/platforms/83xx/mpc832x_rdb.c: In function ‘mpc832x_rdb_setup_arch’:
arch/powerpc/platforms/83xx/mpc832x_rdb.c:104: warning: ‘np’ is used uninitialized in this function

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
 arch/powerpc/platforms/83xx/mpc832x_rdb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/mpc832x_rdb.c b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
index 9f0fd88..e7f706b 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
@@ -101,7 +101,7 @@ static void __init mpc832x_rdb_setup_arch(void)
 #ifdef CONFIG_QUICC_ENGINE
 	qe_reset();
 
-	if ((np = of_find_node_by_name(np, "par_io")) != NULL) {
+	if ((np = of_find_node_by_name(NULL, "par_io")) != NULL) {
 		par_io_init(np);
 		of_node_put(np);
 
-- 
1.5.2.2
