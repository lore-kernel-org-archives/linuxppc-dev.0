Return-Path: <B32579@freescale.com>
Received: from TX2EHSOBE001.bigfish.com (mail-tx2.bigfish.com [65.55.88.10])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7AC3DB70A7
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Mar 2011 18:31:59 +1100 (EST)
From: Prabhakar Kushwaha <prabhakar@freescale.com>
To: <linux-ide@vger.kernel.org>
Subject: [PATCH][v3] driver/FSL SATA:Fix wrong Device Error Register usage
Date: Wed, 9 Mar 2011 12:47:18 +0530
Message-ID: <1299655038-727-1-git-send-email-prabhakar@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: jgarzik@pobox.com, Ashish Kalra <B00888@freescale.com>,
	linuxppc-dev@lists.ozlabs.org,
	Prabhakar Kushwaha <prabhakar@freescale.com>, meet2prabhu@gmail.com
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

Signed-off-by: Ashish Kalra <B00888@freescale.com>
Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
---

 git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git (branch master)

 This patch is already gone through review of linuxppc-dev mail list.
 Making CC linuxppc-dev@lists.ozlabs.org

 Changes for v2: Incorporated Sergei Shtylyov's comment
	- Put space after -
	- added a line
 Changes for v3: Incorporated David Laight's comment
 	- Condition check for dereg 0 for hardware error

 drivers/ata/sata_fsl.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index b0214d0..ad84ddc 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -1040,12 +1040,15 @@ static void sata_fsl_error_intr(struct ata_port *ap)
 
 		/* find out the offending link and qc */
 		if (ap->nr_pmp_links) {
+			unsigned int dev_num;
+
 			dereg = ioread32(hcr_base + DE);
 			iowrite32(dereg, hcr_base + DE);
 			iowrite32(cereg, hcr_base + CE);
 
-			if (dereg < ap->nr_pmp_links) {
-				link = &ap->pmp_link[dereg];
+			dev_num = ffs(dereg) - 1;
+			if (dev_num < ap->nr_pmp_links && dereg != 0) {
+				link = &ap->pmp_link[dev_num];
 				ehi = &link->eh_info;
 				qc = ata_qc_from_tag(ap, link->active_tag);
 				/*
-- 
1.7.3
