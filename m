Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id A23F51A0A16
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Nov 2014 03:24:22 +1100 (AEDT)
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH] spi: fsl-spi: Don't use cpm_command on CPM1
Message-Id: <20141120162418.04FAC1A9BFC@localhost.localdomain>
Date: Thu, 20 Nov 2014 17:24:17 +0100 (CET)
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On CPM1, when the SPI parameter RAM is relocated to somewhere else than the
default location, in accordance with freescale documentation
(refer micropatch SPI application note EB662), init RX/TX params command shall
not be used because it doesn't take into account the new location, and
overwrites data that is in original location of SPI param ram at addresses 
SCC2 param base +  (u32*)0x88 (u16*)0x90 (u32*)0x98 (u16*)0xA0, hence breaking
activity on SCC2 if SCC2 is used in a mode like QMC for instance.

Therefore, the action shall be done manually as described by freescale and as
was already partly done by the driver.

Reported-by: Patrick Vasseur <patrick.vasseur@c-s.fr>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Tested-by: Patrick Vasseur <patrick.vasseur@c-s.fr>

---
 drivers/spi/spi-fsl-cpm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-cpm.c b/drivers/spi/spi-fsl-cpm.c
index 54b0637..da97988 100644
--- a/drivers/spi/spi-fsl-cpm.c
+++ b/drivers/spi/spi-fsl-cpm.c
@@ -56,12 +56,15 @@ void fsl_spi_cpm_reinit_txrx(struct mpc8xxx_spi *mspi)
 		qe_issue_cmd(QE_INIT_TX_RX, mspi->subblock,
 			     QE_CR_PROTOCOL_UNSPECIFIED, 0);
 	} else {
-		cpm_command(CPM_SPI_CMD, CPM_CR_INIT_TRX);
 		if (mspi->flags & SPI_CPM1) {
+			out_be32(&mspi->pram->rstate, 0);
 			out_be16(&mspi->pram->rbptr,
 				 in_be16(&mspi->pram->rbase));
+			out_be32(&mspi->pram->tstate, 0);
 			out_be16(&mspi->pram->tbptr,
 				 in_be16(&mspi->pram->tbase));
+		} else {
+			cpm_command(CPM_SPI_CMD, CPM_CR_INIT_TRX);
 		}
 	}
 }
-- 
2.1.0
