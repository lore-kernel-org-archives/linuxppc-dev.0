Return-Path: <ptyser@xes-inc.com>
Received: from xes-mad.com (xes-mad.com [216.165.139.218])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 85D55100946
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Nov 2009 11:43:02 +1100 (EST)
From: Peter Tyser <ptyser@xes-inc.com>
To: bluesmoke-devel@lists.sourceforge.net
Subject: [PATCH 1/4] edac: Remove unused mpc85xx debug code
Date: Thu, 19 Nov 2009 18:42:26 -0600
Message-Id: <1258677749-15968-1-git-send-email-ptyser@xes-inc.com>
Cc: Peter Tyser <ptyser@xes-inc.com>, linuxppc-dev@ozlabs.org,
	djiang@mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some unused, unsupported debug code existed in the mpc85xx EDAC driver
that resulted in a build failure when CONFIG_EDAC_DEBUG was defined:

  drivers/edac/mpc85xx_edac.c: In function 'mpc85xx_mc_err_probe':
  drivers/edac/mpc85xx_edac.c:1031: error: implicit declaration of function 'edac_mc_register_mcidev_debug'
  drivers/edac/mpc85xx_edac.c:1031: error: 'debug_attr' undeclared (first use in this function)
  drivers/edac/mpc85xx_edac.c:1031: error: (Each undeclared identifier is reported only once
  drivers/edac/mpc85xx_edac.c:1031: error: for each function it appears in.)

Signed-off-by: Peter Tyser <ptyser@xes-inc.com>
---
 drivers/edac/mpc85xx_edac.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
index cf27402..28d3211 100644
--- a/drivers/edac/mpc85xx_edac.c
+++ b/drivers/edac/mpc85xx_edac.c
@@ -892,10 +892,6 @@ static int __devinit mpc85xx_mc_err_probe(struct of_device *op,
 
 	mpc85xx_init_csrows(mci);
 
-#ifdef CONFIG_EDAC_DEBUG
-	edac_mc_register_mcidev_debug((struct attribute **)debug_attr);
-#endif
-
 	/* store the original error disable bits */
 	orig_ddr_err_disable =
 	    in_be32(pdata->mc_vbase + MPC85XX_MC_ERR_DISABLE);
-- 
1.6.2.1
