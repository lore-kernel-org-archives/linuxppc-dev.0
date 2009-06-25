Return-Path: <yang.shi@windriver.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 27CF3B7093
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 25 Jun 2009 11:42:06 +1000 (EST)
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 90392DDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2009 11:42:04 +1000 (EST)
From: Yang Shi <yang.shi@windriver.com>
To: djiang@mvista.com, galak@kernel.crashing.org
Subject: [PATCH] Add EDAC support for P2020DS
Date: Thu, 25 Jun 2009 09:39:36 +0800
Message-Id: <1245893976-32678-1-git-send-email-yang.shi@windriver.com>
Cc: linuxppc-dev@ozlabs.org, bluesmoke-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Based on Kumar's new compatible types patch, add P2020 into
MPC85xx EDAC compatible lists so that EDAC can recognize
P2020 meomry controller and L2 cache controller and export
the relevant fields to sysfs.

EDAC MPC85xx DDR3 support is needed if DDR3 memory stick is
installed on a P2020DS board so that EDAC core can recognize
DDR3 memory type.

Signed-off-by: Yang Shi <yang.shi@windriver.com>
---
(85xx DDR3 EDAC patch is currently in akpm's mm tree)

 drivers/edac/mpc85xx_edac.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
index 7c8c2d7..85575fb 100644
--- a/drivers/edac/mpc85xx_edac.c
+++ b/drivers/edac/mpc85xx_edac.c
@@ -646,6 +646,7 @@ static struct of_device_id mpc85xx_l2_err_of_match[] = {
 	{ .compatible = "fsl,mpc8560-l2-cache-controller", },
 	{ .compatible = "fsl,mpc8568-l2-cache-controller", },
 	{ .compatible = "fsl,mpc8572-l2-cache-controller", },
+	{ .compatible = "fsl,p2020-l2-cache-controller", },
 	{},
 };
 
@@ -978,6 +979,7 @@ static struct of_device_id mpc85xx_mc_err_of_match[] = {
 	{ .compatible = "fsl,mpc8560-memory-controller", },
 	{ .compatible = "fsl,mpc8568-memory-controller", },
 	{ .compatible = "fsl,mpc8572-memory-controller", },
+	{ .compatible = "fsl,p2020-memory-controller", },
 	{},
 };
 
-- 
1.6.0.4
