Return-Path: <andriy.shevchenko@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by lists.ozlabs.org (Postfix) with ESMTP id 3qvHFG66TpzDq9m
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Apr 2016 19:03:30 +1000 (AEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 Christian Lamparter <chunkeey@googlemail.com>,
 =?UTF-8?q?M=C3=A5ns=20Rullg=C3=A5rd?= <mans@mansr.com>,
 Julian Margetson <runaway@candw.ms>
Subject: [PATCH v2 02/23] ata: sata_dwc_460ex: fix crash on offline links
 without an attached drive
Date: Tue, 26 Apr 2016 12:03:03 +0300
Message-Id: <1461661404-1952-3-git-send-email-andriy.shevchenko@linux.intel.com>
In-Reply-To: <1461661404-1952-1-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1461661404-1952-1-git-send-email-andriy.shevchenko@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Christian Lamparter <chunkeey@googlemail.com>

This patch fixes Machine Check "Data Write PLB Error" which happens
when libata-sff's ata_sff_dev_select is trying to write into the
device_addr in order to select a drive. However, SATA has no master
or slave devices like the old ATA Bus, therefore selecting a
different drive is kind of pointless.

Data Write PLB Error
Oops: Machine check, sig: 7 [#1]
PowerPC 44x Platform
Modules linked in:
CPU: 0 PID: 508 Comm: scsi_eh_0 Not tainted 4.6.0-rc3-next-20160412+ #10
[...]
NIP [c027e820] ata_sff_dev_select+0x3c/0x44
LR [c027e810] ata_sff_dev_select+0x2c/0x44
Call Trace:
[cec31cd0] [c027da00] ata_sff_postreset+0x40/0xb4 (unreliable)
[cec31ce0] [c027a03c] ata_eh_reset+0x5cc/0x928
[cec31d60] [c027a840] ata_eh_recover+0x330/0x10bc
[cec31df0] [c027bae0] ata_do_eh+0x4c/0xa4
[...]

Signed-off-by: Christian Lamparter <chunkeey@googlemail.com>
---
 drivers/ata/sata_dwc_460ex.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 5213e22..7f95389 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -1134,6 +1134,11 @@ static int sata_dwc_hardreset(struct ata_link *link, unsigned int *class,
 	return ret;
 }
 
+static void sata_dwc_dev_select(struct ata_port *ap, unsigned int device)
+{
+	/* SATA DWC is master only */
+}
+
 /*
  * scsi mid-layer and libata interface structures
  */
@@ -1164,6 +1169,8 @@ static struct ata_port_operations sata_dwc_ops = {
 	.port_start		= sata_dwc_port_start,
 	.port_stop		= sata_dwc_port_stop,
 
+	.sff_dev_select		= sata_dwc_dev_select,
+
 	.bmdma_setup		= sata_dwc_bmdma_setup,
 	.bmdma_start		= sata_dwc_bmdma_start,
 };
-- 
2.8.0.rc3
