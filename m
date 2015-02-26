Return-Path: <haokexin@gmail.com>
Received: from mail-yh0-x22d.google.com (mail-yh0-x22d.google.com
 [IPv6:2607:f8b0:4002:c01::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1CFF91A002B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Feb 2015 23:09:18 +1100 (AEDT)
Received: by yhl29 with SMTP id 29so4203690yhl.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Feb 2015 04:09:16 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2 01/11] sata_svw: remove the dependency on PPC_OF
Date: Thu, 26 Feb 2015 20:08:13 +0800
Message-Id: <1424952503-8247-2-git-send-email-haokexin@gmail.com>
In-Reply-To: <1424952503-8247-1-git-send-email-haokexin@gmail.com>
References: <1424952503-8247-1-git-send-email-haokexin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The OF functionality has moved to a common place and be used by many
archs. So we don't need to include the ppc arch specific header files
and depend on PPC_OF option any more. This is a preparation for
killing PPC_OF.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
v2: Add the ack from Tejun Heo.

 drivers/ata/sata_svw.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/ata/sata_svw.c b/drivers/ata/sata_svw.c
index c630fa812624..4c06f6281d74 100644
--- a/drivers/ata/sata_svw.c
+++ b/drivers/ata/sata_svw.c
@@ -47,11 +47,7 @@
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi.h>
 #include <linux/libata.h>
-
-#ifdef CONFIG_PPC_OF
-#include <asm/prom.h>
-#include <asm/pci-bridge.h>
-#endif /* CONFIG_PPC_OF */
+#include <linux/of.h>
 
 #define DRV_NAME	"sata_svw"
 #define DRV_VERSION	"2.3"
@@ -320,7 +316,6 @@ static u8 k2_stat_check_status(struct ata_port *ap)
 	return readl(ap->ioaddr.status_addr);
 }
 
-#ifdef CONFIG_PPC_OF
 static int k2_sata_show_info(struct seq_file *m, struct Scsi_Host *shost)
 {
 	struct ata_port *ap;
@@ -350,14 +345,10 @@ static int k2_sata_show_info(struct seq_file *m, struct Scsi_Host *shost)
 	}
 	return 0;
 }
-#endif /* CONFIG_PPC_OF */
-
 
 static struct scsi_host_template k2_sata_sht = {
 	ATA_BMDMA_SHT(DRV_NAME),
-#ifdef CONFIG_PPC_OF
 	.show_info		= k2_sata_show_info,
-#endif
 };
 
 
-- 
1.9.3
