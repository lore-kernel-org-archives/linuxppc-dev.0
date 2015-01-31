Return-Path: <haokexin@gmail.com>
Received: from mail-yk0-x22f.google.com (mail-yk0-x22f.google.com
 [IPv6:2607:f8b0:4002:c07::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7F5921A0F71
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Feb 2015 00:48:18 +1100 (AEDT)
Received: by mail-yk0-f175.google.com with SMTP id 9so19103696ykp.6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Jan 2015 05:48:16 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	linux-ide@vger.kernel.org
Subject: [PATCH 02/15] sata_svw: remove the dependency on PPC_OF
Date: Sat, 31 Jan 2015 21:47:32 +0800
Message-Id: <1422712065-9403-3-git-send-email-haokexin@gmail.com>
In-Reply-To: <1422712065-9403-1-git-send-email-haokexin@gmail.com>
References: <1422712065-9403-1-git-send-email-haokexin@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Kevin Hao <haokexin@gmail.com>
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
---
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
