Return-Path: <prabhakar@localhost.localdomain.freescale.net>
Received: from DB3EHSOBE002.bigfish.com (db3ehsobe002.messaging.microsoft.com
	[213.199.154.140])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F1531B70D6
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 18 Feb 2011 16:50:39 +1100 (EST)
Received: from mail31-db3 (localhost.localdomain [127.0.0.1])	by
	mail31-db3-R.bigfish.com (Postfix) with ESMTP id 5A218109042B	for
	<linuxppc-dev@lists.ozlabs.org>; Fri, 18 Feb 2011 05:35:25 +0000 (UTC)
Received: from DB3EHSMHS011.bigfish.com (unknown [10.3.81.240])	by
	mail31-db3.bigfish.com (Postfix) with ESMTP id 05C921908052	for
	<linuxppc-dev@lists.ozlabs.org>; Fri, 18 Feb 2011 05:35:25 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by de01egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id p1I5ZMBQ000730	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 17 Feb 2011 22:35:22 -0700 (MST)
Received: from localhost.localdomain ([10.232.14.58])	by
	az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	p1I5ZIkd020369	for
	<linuxppc-dev@lists.ozlabs.org>; Thu, 17 Feb 2011 23:35:21 -0600 (CST)
From: Prabhakar Kushwaha <prabhakar@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] driver/FSL SATA:Fix wrong Device Error Register usage
Date: Fri, 18 Feb 2011 11:04:58 +0530
Message-ID: <1298007298-12511-1-git-send-email-prabhakar@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Ashish Kalra <B00888@freescale.com>,
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

 drivers/ata/sata_fsl.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index 2546f38..8ad335f 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -1047,8 +1047,9 @@ static void sata_fsl_error_intr(struct ata_port *ap)
 			iowrite32(dereg, hcr_base + DE);
 			iowrite32(cereg, hcr_base + CE);
 
-			if (dereg < ap->nr_pmp_links) {
-				link = &ap->pmp_link[dereg];
+			if ((ffs(dereg)-1) < ap->nr_pmp_links) {
+				/* array start from 0 */
+				link = &ap->pmp_link[ffs(dereg)-1];
 				ehi = &link->eh_info;
 				qc = ata_qc_from_tag(ap, link->active_tag);
 				/*
-- 
1.7.3
