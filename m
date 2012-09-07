Return-Path: <B21989@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 65D4D2C0083
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Sep 2012 20:34:15 +1000 (EST)
From: Shaohui Xie <Shaohui.Xie@freescale.com>
To: <jgarzik@pobox.com>, <linux-ide@vger.kernel.org>
Subject: [PATCH][v3] sata_fsl: add workaround for data length mismatch on
 freescale V2 controller
Date: Fri, 7 Sep 2012 18:01:35 +0800
Message-ID: <1347012095-4404-1-git-send-email-Shaohui.Xie@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Anju Bhartiya <Anju.Bhartiya@freescale.com>,
 Shaohui Xie <Shaohui.Xie@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The freescale V2 SATA controller checks if the received data length matches
the programmed length 'ttl', if not, it assumes that this is an error.
In ATAPI, the 'ttl' is based on max allocation length and not the actual
data transfer length, controller will raise 'DLM' (Data length Mismatch)
error bit in Hstatus register. Along with 'DLM', DE (Device error) and
FE (fatal Error) bits are also set in Hstatus register, 'E' (Internal Error)
bit is set in Serror register and CE (Command Error) and DE (Device error)
registers have the corresponding bit set. In this condition, we need to
clear errors in following way: in the service routine, based on 'DLM' flag,
HCONTROL[27] operation clears Hstatus, CE and DE registers, clear Serror
register.

Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
Signed-off-by: Anju Bhartiya <Anju.Bhartiya@freescale.com>
---
changes for v3:
1. not using uppercase for variable names;
2. remove unnecessary parens;

changes for v2:
1. remove the using of quirk;
2. wrap errata codes in condition;

 drivers/ata/sata_fsl.c |   39 +++++++++++++++++++++++++++++++++++----
 1 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index d6577b9..9fbab68 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -143,6 +143,7 @@ enum {
 	    FATAL_ERR_CRC_ERR_RX |
 	    FATAL_ERR_FIFO_OVRFL_TX | FATAL_ERR_FIFO_OVRFL_RX,
 
+	INT_ON_DATA_LENGTH_MISMATCH = (1 << 12),
 	INT_ON_FATAL_ERR = (1 << 5),
 	INT_ON_PHYRDY_CHG = (1 << 4),
 
@@ -1181,25 +1182,55 @@ static void sata_fsl_host_intr(struct ata_port *ap)
 	u32 hstatus, done_mask = 0;
 	struct ata_queued_cmd *qc;
 	u32 SError;
+	u32 tag;
+	u32 status_mask = INT_ON_ERROR;
 
 	hstatus = ioread32(hcr_base + HSTATUS);
 
 	sata_fsl_scr_read(&ap->link, SCR_ERROR, &SError);
 
+	/* Read command completed register */
+	done_mask = ioread32(hcr_base + CC);
+
+	/* Workaround for data length mismatch errata */
+	if (unlikely(hstatus & INT_ON_DATA_LENGTH_MISMATCH)) {
+		for (tag = 0; tag < ATA_MAX_QUEUE; tag++) {
+			qc = ata_qc_from_tag(ap, tag);
+			if (qc && ata_is_atapi(qc->tf.protocol)) {
+				u32 hcontrol;
+#define HCONTROL_CLEAR_ERROR	(1 << 27)
+				/* Set HControl[27] to clear error registers */
+				hcontrol = ioread32(hcr_base + HCONTROL);
+				iowrite32(hcontrol | HCONTROL_CLEAR_ERROR,
+						hcr_base + HCONTROL);
+
+				/* Clear HControl[27] */
+				iowrite32(hcontrol & ~HCONTROL_CLEAR_ERROR,
+						hcr_base + HCONTROL);
+
+				/* Clear SError[E] bit */
+				sata_fsl_scr_write(&ap->link, SCR_ERROR,
+						SError);
+
+				/* Ignore fatal error and device error */
+				status_mask &= ~(INT_ON_SINGL_DEVICE_ERR
+						| INT_ON_FATAL_ERR);
+				break;
+			}
+		}
+	}
+
 	if (unlikely(SError & 0xFFFF0000)) {
 		DPRINTK("serror @host_intr : 0x%x\n", SError);
 		sata_fsl_error_intr(ap);
 	}
 
-	if (unlikely(hstatus & INT_ON_ERROR)) {
+	if (unlikely(hstatus & status_mask)) {
 		DPRINTK("error interrupt!!\n");
 		sata_fsl_error_intr(ap);
 		return;
 	}
 
-	/* Read command completed register */
-	done_mask = ioread32(hcr_base + CC);
-
 	VPRINTK("Status of all queues :\n");
 	VPRINTK("done_mask/CC = 0x%x, CA = 0x%x, CE=0x%x,CQ=0x%x,apqa=0x%x\n",
 		done_mask,
-- 
1.6.4
