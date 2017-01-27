Return-Path: <valentin.longchamp@keymile.com>
Received: from mail-de.keymile.com (mail-de.keymile.com [195.8.104.250])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v8zv61365zDqZl
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Jan 2017 00:21:06 +1100 (AEDT)
From: Valentin Longchamp <valentin.longchamp@keymile.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: qiang.zhao@nxp.com, oss@buserror.net,
 Valentin Longchamp <valentin.longchamp@keymile.com>
Subject: [RFC 1/3] soc/fsl/qe: round brg_freq to 1kHz granularity
Date: Fri, 27 Jan 2017 14:15:15 +0100
Message-Id: <1485522917-2150-2-git-send-email-valentin.longchamp@keymile.com>
In-Reply-To: <1485522917-2150-1-git-send-email-valentin.longchamp@keymile.com>
References: <1485522917-2150-1-git-send-email-valentin.longchamp@keymile.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Because of integer computation rounding in u-boot (that sets the QE
brg-frequency DTS prop), the clk value is 99999999 Hz even though it is
100 MHz.

When setting brg clks that are exact divisors of 100 MHz, this small
differnce plays a role and can result in lower clks to be output (for
instance 20 MHz - divide by 5 - results in 16.666 MHz - divide by 6).

This patch fixes that by "forcing" the brg_clk to the nearest kHz when
the difference is below 2 integer rouding errors (i.e. 4).

Signed-off-by: Valentin Longchamp <valentin.longchamp@keymile.com>
---
 drivers/soc/fsl/qe/qe.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/soc/fsl/qe/qe.c b/drivers/soc/fsl/qe/qe.c
index 2707a82..5482302 100644
--- a/drivers/soc/fsl/qe/qe.c
+++ b/drivers/soc/fsl/qe/qe.c
@@ -163,11 +163,15 @@ int qe_issue_cmd(u32 cmd, u32 device, u8 mcn_protocol, u32 cmd_input)
  */
 static unsigned int brg_clk = 0;
 
+#define CLK_GRAN	(1000)
+#define CLK_GRAN_LIMIT	(5)
+
 unsigned int qe_get_brg_clk(void)
 {
 	struct device_node *qe;
 	int size;
 	const u32 *prop;
+	unsigned int mod;
 
 	if (brg_clk)
 		return brg_clk;
@@ -185,6 +189,15 @@ unsigned int qe_get_brg_clk(void)
 
 	of_node_put(qe);
 
+	/* round this if near to a multiple of CLK_GRAN */
+	mod = brg_clk % CLK_GRAN;
+	if (mod) {
+		if (mod < CLK_GRAN_LIMIT)
+			brg_clk -= mod;
+		else if (mod > (CLK_GRAN - CLK_GRAN_LIMIT))
+			brg_clk += CLK_GRAN - mod;
+	}
+
 	return brg_clk;
 }
 EXPORT_SYMBOL(qe_get_brg_clk);
-- 
1.8.3.1
