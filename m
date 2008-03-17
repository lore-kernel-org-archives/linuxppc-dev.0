Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound9-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 9D3DCDDF36
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Mar 2008 04:36:48 +1100 (EST)
From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
To: grant.likely@secretlab.ca, git-dev@xilinx.com,
	linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] Xilinx: hwicap: Verify sync before reading idcode.
Date: Mon, 17 Mar 2008 10:36:31 -0700
In-Reply-To: <1205775392-32222-2-git-send-email-stephen.neuendorffer@xilinx.com>
References: <1205775392-32222-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<1205775392-32222-2-git-send-email-stephen.neuendorffer@xilinx.com>
Message-Id: <20080317173645.7A21D9A8069@mail131-sin.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It appears that in some cases, the sync word might not be recognized
by the hardware correctly.  If this happens, then attempting to read
from the port results in an unrecoverable error because of the design
of the FPGA core.  This patch updates the code to check the status of
the device before reading the IDCODE, in order to avoid entering this
unrecoverable state.  This patch also adds additional NOOP commands
into the sychronization sequence, which appears to be necessary to
avoid the condition on some hardware.

Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
---
 drivers/char/xilinx_hwicap/xilinx_hwicap.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/drivers/char/xilinx_hwicap/xilinx_hwicap.c b/drivers/char/xilinx_hwicap/xilinx_hwicap.c
index 304727d..5b8d646 100644
--- a/drivers/char/xilinx_hwicap/xilinx_hwicap.c
+++ b/drivers/char/xilinx_hwicap/xilinx_hwicap.c
@@ -250,8 +250,26 @@ static int hwicap_get_configuration_register(struct hwicap_drvdata *drvdata,
 	 * Create the data to be written to the ICAP.
 	 */
 	buffer[index++] = XHI_DUMMY_PACKET;
+	buffer[index++] = XHI_NOOP_PACKET;
 	buffer[index++] = XHI_SYNC_PACKET;
 	buffer[index++] = XHI_NOOP_PACKET;
+	buffer[index++] = XHI_NOOP_PACKET;
+
+	/*
+	 * Write the data to the FIFO and initiate the transfer of data present
+	 * in the FIFO to the ICAP device.
+	 */
+	status = drvdata->config->set_configuration(drvdata,
+						    &buffer[0], index);
+	if (status)
+		return status;
+
+	/* If the syncword was not found, then we need to start over. */
+	status = drvdata->config->get_status(drvdata);
+	if ((status & XHI_SR_DALIGN_MASK) != XHI_SR_DALIGN_MASK)
+		return -EIO;
+
+	index = 0;
 	buffer[index++] = hwicap_type_1_read(reg) | 1;
 	buffer[index++] = XHI_NOOP_PACKET;
 	buffer[index++] = XHI_NOOP_PACKET;
-- 
1.5.3.4-dirty
