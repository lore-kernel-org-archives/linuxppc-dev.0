Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 20513DDEA3
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 24 Sep 2007 06:17:42 +1000 (EST)
Message-ID: <46F6C9DC.90008@scram.de>
Date: Sun, 23 Sep 2007 22:17:32 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH4/4] [POWERPC] Fix cpm_uart driver
Content-Type: multipart/mixed; boundary="------------090404010006030000030102"
Cc: linux-kernel@vger.kernel.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------090404010006030000030102
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


In cpm_uart_core, functions cpm_uart_init_bd and cpm_uart_init_scc
an offset into DP RAM is calculated by substracting a physical
memory constant from an virtual address. This patch fixes the
problem by converting the virtual address into a physical
first.

Signed-off-by: Jochen Friedrich <jochen@scram.de>
---
 drivers/serial/cpm_uart/cpm_uart_core.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

--------------090404010006030000030102
Content-Type: text/x-patch;
 name="2c5cf6868e9aa6eadea285e524d88859cc5e54fb.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2c5cf6868e9aa6eadea285e524d88859cc5e54fb.diff"

diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c b/drivers/serial/cpm_uart/cpm_uart_core.c
index cefde58..7f5db7c 100644
--- a/drivers/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/serial/cpm_uart/cpm_uart_core.c
@@ -752,8 +752,10 @@ static void cpm_uart_init_scc(struct uart_cpm_port *pinfo)
 	sup = pinfo->sccup;
 
 	/* Store address */
-	pinfo->sccup->scc_genscc.scc_rbase = (unsigned char *)pinfo->rx_bd_base - DPRAM_BASE;
-	pinfo->sccup->scc_genscc.scc_tbase = (unsigned char *)pinfo->tx_bd_base - DPRAM_BASE;
+	pinfo->sccup->scc_genscc.scc_rbase = 
+		(u_char *)cpm_dpram_phys((u8 *)pinfo->rx_bd_base) - DPRAM_BASE;
+	pinfo->sccup->scc_genscc.scc_tbase = 
+		(u_char *)cpm_dpram_phys((u8 *)pinfo->tx_bd_base) - DPRAM_BASE;
 
 	/* Set up the uart parameters in the
 	 * parameter ram.
@@ -813,8 +815,10 @@ static void cpm_uart_init_smc(struct uart_cpm_port *pinfo)
 	up = pinfo->smcup;
 
 	/* Store address */
-	pinfo->smcup->smc_rbase = (u_char *)pinfo->rx_bd_base - DPRAM_BASE;
-	pinfo->smcup->smc_tbase = (u_char *)pinfo->tx_bd_base - DPRAM_BASE;
+	pinfo->smcup->smc_rbase = 
+		(u_char *)cpm_dpram_phys((u8 *)pinfo->rx_bd_base) - DPRAM_BASE;
+	pinfo->smcup->smc_tbase = 
+		(u_char *)cpm_dpram_phys((u8 *)pinfo->tx_bd_base) - DPRAM_BASE;
 
 /*
  *  In case SMC1 is being relocated...


--------------090404010006030000030102--
