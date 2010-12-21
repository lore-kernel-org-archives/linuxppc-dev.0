Return-Path: <b21284@freescale.com>
Received: from AM1EHSOBE002.bigfish.com (am1ehsobe002.messaging.microsoft.com
	[213.199.154.205])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2079EB70BA
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Dec 2010 13:06:42 +1100 (EST)
From: Mingkai Hu <Mingkai.hu@freescale.com>
To: <linuxppc-dev@ozlabs.org>, <spi-devel-general@lists.sourceforge.net>
Subject: [PATCH 2/2] eSPI: fix wrong setting of the address in the command
	buffer
Date: Tue, 21 Dec 2010 09:27:02 +0800
Message-ID: <1292894822-7983-1-git-send-email-Mingkai.hu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: kumar.gala@freescale.com, Mingkai Hu <Mingkai.hu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Or else we cann't operate on the right address when the trans length
is greater than 65535.

Signed-off-by: Mingkai Hu <Mingkai.hu@freescale.com>
---
 drivers/spi/spi_fsl_espi.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi_fsl_espi.c b/drivers/spi/spi_fsl_espi.c
index ae78926..a99e233 100644
--- a/drivers/spi/spi_fsl_espi.c
+++ b/drivers/spi/spi_fsl_espi.c
@@ -258,18 +258,18 @@ static int fsl_espi_bufs(struct spi_device *spi, struct spi_transfer *t)
 	return mpc8xxx_spi->count;
 }
 
-static void fsl_espi_addr2cmd(unsigned int addr, u8 *cmd)
+static inline void fsl_espi_addr2cmd(unsigned int addr, u8 *cmd)
 {
-	if (cmd[1] && cmd[2] && cmd[3]) {
+	if (cmd) {
 		cmd[1] = (u8)(addr >> 16);
 		cmd[2] = (u8)(addr >> 8);
 		cmd[3] = (u8)(addr >> 0);
 	}
 }
 
-static unsigned int fsl_espi_cmd2addr(u8 *cmd)
+static inline unsigned int fsl_espi_cmd2addr(u8 *cmd)
 {
-	if (cmd[1] && cmd[2] && cmd[3])
+	if (cmd)
 		return cmd[1] << 16 | cmd[2] << 8 | cmd[3] << 0;
 
 	return 0;
@@ -395,9 +395,11 @@ static void fsl_espi_rw_trans(struct spi_message *m,
 			}
 		}
 
-		addr = fsl_espi_cmd2addr(local_buf);
-		addr += pos;
-		fsl_espi_addr2cmd(addr, local_buf);
+		if (pos > 0) {
+			addr = fsl_espi_cmd2addr(local_buf);
+			addr += pos;
+			fsl_espi_addr2cmd(addr, local_buf);
+		}
 
 		espi_trans->n_tx = n_tx;
 		espi_trans->n_rx = trans_len;
-- 
1.6.4
