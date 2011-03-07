Return-Path: <prabhakar@freescale.com>
Received: from VA3EHSOBE009.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 20BC0B70CE
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  7 Mar 2011 15:29:37 +1100 (EST)
From: Prabhakar Kushwaha <prabhakar@freescale.com>
To: <linux-ide@vger.kernel.org>
Subject: [PATCH] driver/FSL SATA:Fix wrong Device Error Register usage
Date: Mon, 7 Mar 2011 10:00:21 +0530
Message-ID: <1299472221-3613-1-git-send-email-prabhakar@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: meet2prabhu@gmail.com, Ashish Kalra <B00888@freescale.com>,
	jgarzik@pobox.com, linuxppc-dev@lists.ozlabs.org,
	Prabhakar Kushwaha <prabhakar@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When a single device error is detected, the device under the error is indicated
by the error bit set in the DER. There is a one to one mapping between register
bit and devices on Port multiplier(PMP) i.e. bit 0 represents PMP device 0 and
bit 1 represents PMP device 1 etc.

Current implementation treats Device error register value as device number not
set of bits representing multiple device on PMP. It is changed to consider bit
level.
No need to check for each set bit as all command is going to be aborted.

Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
Signed-off-by: Ashish Kalra <B00888@freescale.com>
---
 git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git (branch master)

 This patch is already gone through review of linuxppc-dev mail list.
 Making CC linuxppc-dev@lists.ozlabs.org

 drivers/ata/sata_fsl.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index b0214d0..895771c 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -1040,12 +1040,14 @@ static void sata_fsl_error_intr(struct ata_port *ap)
 
 		/* find out the offending link and qc */
 		if (ap->nr_pmp_links) {
+			unsigned int dev_num;
 			dereg = ioread32(hcr_base + DE);
 			iowrite32(dereg, hcr_base + DE);
 			iowrite32(cereg, hcr_base + CE);
 
-			if (dereg < ap->nr_pmp_links) {
-				link = &ap->pmp_link[dereg];
+			dev_num = ffs(dereg)-1;
+			if (dev_num < ap->nr_pmp_links) {
+				link = &ap->pmp_link[dev_num];
 				ehi = &link->eh_info;
 				qc = ata_qc_from_tag(ap, link->active_tag);
 				/*
-- 
1.7.3
