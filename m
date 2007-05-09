Return-Path: <akira2.iguchi@toshiba.co.jp>
Received: from imx9.toshiba.co.jp (imx9.toshiba.co.jp [202.33.96.51])
	by ozlabs.org (Postfix) with ESMTP id A83F1DDE1D
	for <linuxppc-dev@ozlabs.org>; Wed,  9 May 2007 16:12:36 +1000 (EST)
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5 [202.33.96.24])
	by imx9.toshiba.co.jp  with ESMTP id l496CUA8017994
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Wed, 9 May 2007 15:12:30 +0900 (JST)
Received: from tsb-wall.toshiba.co.jp ([133.199.160.134])
	by inet-tsb5.toshiba.co.jp  with ESMTP id l496CJ9Z026992
	for <linuxppc-dev@ozlabs.org>; Wed, 9 May 2007 15:12:19 +0900 (JST)
Received: (from root@localhost) by tsb-wall.toshiba.co.jp  id l496CKWA025823
	for linuxppc-dev@ozlabs.org; Wed, 9 May 2007 15:12:20 +0900 (JST)
Received: from mx2.toshiba.co.jp (localhost [127.0.0.1])
	by ovp1.toshiba.co.jp  with ESMTP id l496CJWE027144
	for <linuxppc-dev@ozlabs.org>; Wed, 9 May 2007 15:12:19 +0900 (JST)
Message-Id: <200705090612.l496CGfm013469@toshiba.co.jp>
MIME-Version: 1.0
Date: Wed, 09 May 2007 15:14:00 +0900
From: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
To: jeff@garzik.org
Subject: [PATCH] drivers/ata/pata_scc.c: compile error fix
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The previous change (ata_probe_ent -> ata_host) was incomplete
and generated compile error. This patch fix it.

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
Signed-off-by: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
---

diff -purN -X linux-powerpc-git/Documentation/dontdiff linux-powerpc-git/drivers/ata/pata_scc.c linux-powerpc-git_mod/drivers/ata/pata_scc.c
--- linux-powerpc-git/drivers/ata/pata_scc.c	2007-05-08 09:41:52.000000000 +0900
+++ linux-powerpc-git_mod/drivers/ata/pata_scc.c	2007-05-09 14:13:15.000000000 +0900
@@ -1142,14 +1142,14 @@ static int scc_init_one (struct pci_dev 
 	static int printed_version;
 	unsigned int board_idx = (unsigned int) ent->driver_data;
 	const struct ata_port_info *ppi[] = { &scc_port_info[board_idx], NULL };
-	struct device *dev = &pdev->dev;
+	struct ata_host *host;
 	int rc;
 
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev,
 			   "version " DRV_VERSION "\n");
 
-	host = ata_port_alloc_pinfo(&pdev->dev, ppi, 1);
+	host = ata_host_alloc_pinfo(&pdev->dev, ppi, 1);
 	if (!host)
 		return -ENOMEM;
 
