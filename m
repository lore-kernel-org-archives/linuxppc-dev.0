Return-Path: <mchehab@linuxtv.org>
Received: from www.linuxtv.org (www.linuxtv.org [130.149.80.248])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E0AD62C0690
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Aug 2012 12:38:12 +1000 (EST)
Message-Id: <E1SxTx7-0003No-FT@www.linuxtv.org>
From: Mauro Carvalho Chehab <mchehab@redhat.com>
Subject: [git:v4l-dvb/for_v3.6] pasemi_edac: convert driver to use the new
 edac ABI
To: linuxtv-commits@linuxtv.org
Cc: Olof Johansson <olof@lixom.net>, Egor Martovetsky <egor@pasemi.com>,
 linuxppc-dev@lists.ozlabs.org
Reply-To: linux-media@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Date: Sat, 04 Aug 2012 02:38:13 -0000

This is an automatic generated email to let you know that the following patch were queued at the 
http://git.linuxtv.org/media_tree.git tree:

Subject: pasemi_edac: convert driver to use the new edac ABI
Author:  Mauro Carvalho Chehab <mchehab@redhat.com>
Date:    Mon Apr 16 15:11:36 2012 -0300

The legacy edac ABI is going to be removed. Port the driver to use
and benefit from the new API functionality.

Cc: Olof Johansson <olof@lixom.net>
Cc: Egor Martovetsky <egor@pasemi.com>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Mauro Carvalho Chehab <mchehab@redhat.com>

 drivers/edac/pasemi_edac.c |   25 ++++++++++++++++---------
 1 files changed, 16 insertions(+), 9 deletions(-)

---

http://git.linuxtv.org/media_tree.git?a=commitdiff;h=f34575aca9ea92bf61e428fb4584d9ebbff9807c

diff --git a/drivers/edac/pasemi_edac.c b/drivers/edac/pasemi_edac.c
index 3fcefda..46aed62 100644
--- a/drivers/edac/pasemi_edac.c
+++ b/drivers/edac/pasemi_edac.c
@@ -110,15 +110,16 @@ static void pasemi_edac_process_error_info(struct mem_ctl_info *mci, u32 errsta)
 	/* uncorrectable/multi-bit errors */
 	if (errsta & (MCDEBUG_ERRSTA_MBE_STATUS |
 		      MCDEBUG_ERRSTA_RFL_STATUS)) {
-		edac_mc_handle_ue(mci, mci->csrows[cs].first_page, 0,
-				  cs, mci->ctl_name);
+		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci,
+				     mci->csrows[cs].first_page, 0, 0,
+				     cs, 0, -1, mci->ctl_name, "", NULL);
 	}
 
 	/* correctable/single-bit errors */
-	if (errsta & MCDEBUG_ERRSTA_SBE_STATUS) {
-		edac_mc_handle_ce(mci, mci->csrows[cs].first_page, 0,
-				  0, cs, 0, mci->ctl_name);
-	}
+	if (errsta & MCDEBUG_ERRSTA_SBE_STATUS)
+		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci,
+				     mci->csrows[cs].first_page, 0, 0,
+				     cs, 0, -1, mci->ctl_name, "", NULL);
 }
 
 static void pasemi_edac_check(struct mem_ctl_info *mci)
@@ -191,6 +192,7 @@ static int __devinit pasemi_edac_probe(struct pci_dev *pdev,
 		const struct pci_device_id *ent)
 {
 	struct mem_ctl_info *mci = NULL;
+	struct edac_mc_layer layers[2];
 	u32 errctl1, errcor, scrub, mcen;
 
 	pci_read_config_dword(pdev, MCCFG_MCEN, &mcen);
@@ -207,9 +209,14 @@ static int __devinit pasemi_edac_probe(struct pci_dev *pdev,
 		MCDEBUG_ERRCTL1_RFL_LOG_EN;
 	pci_write_config_dword(pdev, MCDEBUG_ERRCTL1, errctl1);
 
-	mci = edac_mc_alloc(0, PASEMI_EDAC_NR_CSROWS, PASEMI_EDAC_NR_CHANS,
-				system_mmc_id++);
-
+	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
+	layers[0].size = PASEMI_EDAC_NR_CSROWS;
+	layers[0].is_virt_csrow = true;
+	layers[1].type = EDAC_MC_LAYER_CHANNEL;
+	layers[1].size = PASEMI_EDAC_NR_CHANS;
+	layers[1].is_virt_csrow = false;
+	mci = new_edac_mc_alloc(system_mmc_id++, ARRAY_SIZE(layers), layers,
+			    0);
 	if (mci == NULL)
 		return -ENOMEM;
 
