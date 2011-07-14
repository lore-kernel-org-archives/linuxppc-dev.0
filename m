Return-Path: <B21989@freescale.com>
Received: from DB3EHSOBE001.bigfish.com (db3ehsobe001.messaging.microsoft.com
	[213.199.154.139])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0E7661007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Jul 2011 12:58:11 +1000 (EST)
From: Shaohui Xie <Shaohui.Xie@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] Correct offset_in_page mask bits in function
	edac_mc_handle_ce.
Date: Thu, 14 Jul 2011 10:01:42 +0800
Message-ID: <1310608902-14221-1-git-send-email-Shaohui.Xie@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: kumar.gala@freescale.com, "Kai.Jiang" <Kai.Jiang@freescale.com>,
	djiang@mvista.com, ptyser@xes-inc.com, dougthompson@xmission.com,
	scottwood@freescale.com, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Kai.Jiang <Kai.Jiang@freescale.com>

Parameter offset_in_page in function edac_mc_handle_ce should be masked
the higher bits above the page size, not the lower bits. The original input
sometimes causes crash.

Signed-off-by: Kai.Jiang <Kai.Jiang@freescale.com>
---
 drivers/edac/mpc85xx_edac.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
index 38ab8e2..b048a5f 100644
--- a/drivers/edac/mpc85xx_edac.c
+++ b/drivers/edac/mpc85xx_edac.c
@@ -854,11 +854,11 @@ static void mpc85xx_mc_check(struct mem_ctl_info *mci)
 		mpc85xx_mc_printk(mci, KERN_ERR, "PFN out of range!\n");
 
 	if (err_detect & DDR_EDE_SBE)
-		edac_mc_handle_ce(mci, pfn, err_addr & PAGE_MASK,
+		edac_mc_handle_ce(mci, pfn, err_addr & ~PAGE_MASK,
 				  syndrome, row_index, 0, mci->ctl_name);
 
 	if (err_detect & DDR_EDE_MBE)
-		edac_mc_handle_ue(mci, pfn, err_addr & PAGE_MASK,
+		edac_mc_handle_ue(mci, pfn, err_addr & ~PAGE_MASK,
 				  row_index, mci->ctl_name);
 
 	out_be32(pdata->mc_vbase + MPC85XX_MC_ERR_DETECT, err_detect);
-- 
1.6.4
