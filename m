Return-Path: <prabhakar@freescale.com>
Received: from TX2EHSOBE003.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 60C05B7191
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 21 Feb 2011 14:33:04 +1100 (EST)
From: Prabhakar Kushwaha <prabhakar@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] driver/FSL SATA: Update RX_WATER_MARK for TRANSCFG
Date: Mon, 21 Feb 2011 09:02:54 +0530
Message-ID: <1298259174-3461-1-git-send-email-prabhakar@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: meet2prabhu@gmail.com, Prabhakar Kushwaha <prabhakar@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

RX_WATER_MARK sets the number of locations in Rx FIFO that can be used before
the transport layer instructs the link layer to transmit HOLDS. Note that it
can take some time for the HOLDs to get to the other end, and that in the
interim there must be enough room in the FIFO to absorb all data that could
arrive.

Update the new recommended value to 16.

Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
---
 git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git (branch master)

 drivers/ata/sata_fsl.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index 895771c..29d2f29 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -186,6 +186,11 @@ enum {
 	COMMANDSTAT = 0x20,
 };
 
+/* TRANSCFG (transport-layer) configuration control */
+enum {
+	TRANSCFG_RX_WATER_MARK = (1 << 4),
+};
+
 /* PHY (link-layer) configuration control */
 enum {
 	PHY_BIST_ENABLE = 0x01,
@@ -1305,6 +1310,7 @@ static int sata_fsl_probe(struct platform_device *ofdev,
 	struct sata_fsl_host_priv *host_priv = NULL;
 	int irq;
 	struct ata_host *host;
+	u32 temp;
 
 	struct ata_port_info pi = sata_fsl_port_info[0];
 	const struct ata_port_info *ppi[] = { &pi, NULL };
@@ -1319,6 +1325,12 @@ static int sata_fsl_probe(struct platform_device *ofdev,
 	ssr_base = hcr_base + 0x100;
 	csr_base = hcr_base + 0x140;
 
+	if (!of_device_is_compatible(ofdev->dev.of_node, "fsl,mpc8315-sata")) {
+		temp = ioread32(csr_base + TRANSCFG);
+		temp = temp & 0xffffffe0;
+		iowrite32(temp | TRANSCFG_RX_WATER_MARK, csr_base + TRANSCFG);
+	}
+
 	DPRINTK("@reset i/o = 0x%x\n", ioread32(csr_base + TRANSCFG));
 	DPRINTK("sizeof(cmd_desc) = %d\n", sizeof(struct command_desc));
 	DPRINTK("sizeof(#define cmd_desc) = %d\n", SATA_FSL_CMD_DESC_SIZE);
-- 
1.7.3
