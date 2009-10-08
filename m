Return-Path: <dmitch71@gmail.com>
Received: from mail-fx0-f214.google.com (mail-fx0-f214.google.com
	[209.85.220.214]) by ozlabs.org (Postfix) with ESMTP id 8319CB7043
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  9 Oct 2009 03:32:36 +1100 (EST)
Received: by fxm10 with SMTP id 10so5732748fxm.8
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 08 Oct 2009 09:32:33 -0700 (PDT)
Sender: David Mitchell <dmitch71@gmail.com>
From: Dave Mitchell <dmitchell@appliedmicro.com>
To: netdev@vger.kernel.org
Subject: [PATCH][v2] ibm_newemac: Added 16K Tx FIFO size support for EMAC4
Date: Thu,  8 Oct 2009 11:32:21 -0500
Message-Id: <1255019541-1974-1-git-send-email-dmitchell@appliedmicro.com>
Cc: linuxppc-dev@lists.ozlabs.org, Dave Mitchell <dmitchell@appliedmicro.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some of the EMAC V4 implementations support 16K Tx FIFOs. This
patch adds support for this functionality and fixes typos in the
Tx FIFO size error messages.

Signed-off-by: Dave Mitchell <dmitchell@appliedmicro.com>
Acked-by: Prodyut Hazarika <phazarika@appliedmicro.com>
Acked-by: Victor Gallardo <vgallardo@appliedmicro.com>
Acked-by: Loc Ho <lho@appliedmicro.com>
---
 v1->v2: local date/time was out-of-sync and thus mail was as well
 
 drivers/net/ibm_newemac/core.c |    7 +++++--
 drivers/net/ibm_newemac/emac.h |    1 +
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ibm_newemac/core.c b/drivers/net/ibm_newemac/core.c
index 89c82c5..c6591cb 100644
--- a/drivers/net/ibm_newemac/core.c
+++ b/drivers/net/ibm_newemac/core.c
@@ -443,7 +443,7 @@ static u32 __emac_calc_base_mr1(struct emac_instance *dev, int tx_size, int rx_s
 		ret |= EMAC_MR1_TFS_2K;
 		break;
 	default:
-		printk(KERN_WARNING "%s: Unknown Rx FIFO size %d\n",
+		printk(KERN_WARNING "%s: Unknown Tx FIFO size %d\n",
 		       dev->ndev->name, tx_size);
 	}
 
@@ -470,6 +470,9 @@ static u32 __emac4_calc_base_mr1(struct emac_instance *dev, int tx_size, int rx_
 	DBG2(dev, "__emac4_calc_base_mr1" NL);
 
 	switch(tx_size) {
+	case 16384:
+		ret |= EMAC4_MR1_TFS_16K;
+		break;
 	case 4096:
 		ret |= EMAC4_MR1_TFS_4K;
 		break;
@@ -477,7 +480,7 @@ static u32 __emac4_calc_base_mr1(struct emac_instance *dev, int tx_size, int rx_
 		ret |= EMAC4_MR1_TFS_2K;
 		break;
 	default:
-		printk(KERN_WARNING "%s: Unknown Rx FIFO size %d\n",
+		printk(KERN_WARNING "%s: Unknown Tx FIFO size %d\n",
 		       dev->ndev->name, tx_size);
 	}
 
diff --git a/drivers/net/ibm_newemac/emac.h b/drivers/net/ibm_newemac/emac.h
index 0afc2cf..d34adf9 100644
--- a/drivers/net/ibm_newemac/emac.h
+++ b/drivers/net/ibm_newemac/emac.h
@@ -153,6 +153,7 @@ struct emac_regs {
 #define EMAC4_MR1_RFS_16K		0x00280000
 #define EMAC4_MR1_TFS_2K       		0x00020000
 #define EMAC4_MR1_TFS_4K		0x00030000
+#define EMAC4_MR1_TFS_16K		0x00050000
 #define EMAC4_MR1_TR			0x00008000
 #define EMAC4_MR1_MWSW_001		0x00001000
 #define EMAC4_MR1_JPSM			0x00000800
-- 
1.6.3.2
