Return-Path: <jacmet@gmail.com>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.191])
	by ozlabs.org (Postfix) with ESMTP id 73B5ADDEC8
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Oct 2007 01:44:00 +1000 (EST)
Received: by mu-out-0910.google.com with SMTP id w1so5365632mue
	for <linuxppc-dev@ozlabs.org>; Wed, 03 Oct 2007 08:43:58 -0700 (PDT)
To: galak@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] fsl_spi_init: Support non-QE processors
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Wed, 03 Oct 2007 17:43:50 +0200
Message-ID: <87lkakxky1.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Peter Korsgaard <jacmet@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On non-QE processors (mpc831x/mpc834x) the SPI clock is the SoC clock.

Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
---
 arch/powerpc/sysdev/fsl_soc.c |   27 +++++++++++++++++++--------
 1 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index a57fe56..59e4188 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -1220,14 +1220,17 @@ int __init fsl_spi_init(struct spi_board_info *board_infos,
 {
 	struct device_node *np;
 	unsigned int i;
-	const u32 *sysclk;
+	const u32 *qe_sysclk = 0, *soc_sysclk = 0;
 
 	np = of_find_node_by_type(NULL, "qe");
-	if (!np)
-		return -ENODEV;
+	if (np)
+		qe_sysclk = of_get_property(np, "bus-frequency", NULL);
+
+	np = of_find_node_by_type(NULL, "soc");
+	if (np)
+		soc_sysclk = of_get_property(np, "bus-frequency", NULL);
 
-	sysclk = of_get_property(np, "bus-frequency", NULL);
-	if (!sysclk)
+	if (!(qe_sysclk || soc_sysclk))
 		return -ENODEV;
 
 	for (np = NULL, i = 1;
@@ -1245,16 +1248,24 @@ int __init fsl_spi_init(struct spi_board_info *board_infos,
 
 		memset(res, 0, sizeof(res));
 
-		pdata.sysclk = *sysclk;
-
 		prop = of_get_property(np, "reg", NULL);
 		if (!prop)
 			goto err;
 		pdata.bus_num = *(u32 *)prop;
 
 		prop = of_get_property(np, "mode", NULL);
-		if (prop && !strcmp(prop, "qe"))
+		if (prop && !strcmp(prop, "qe")) {
 			pdata.qe_mode = 1;
+			if (qe_sysclk)
+				pdata.sysclk = *qe_sysclk;
+			else
+				goto err;
+		} else {
+			if (soc_sysclk)
+				pdata.sysclk = *soc_sysclk;
+			else
+				goto err;
+		}
 
 		for (j = 0; j < num_board_infos; j++) {
 			if (board_infos[j].bus_num == pdata.bus_num)
-- 
1.5.3.2


-- 
Bye, Peter Korsgaard
