Return-Path: <laurent.pinchart@technotrade.biz>
Received: from mailgate101.isp.belgacom.be (mailrelay101.isp.belgacom.be
	[195.238.6.82]) by ozlabs.org (Postfix) with ESMTP id BACF4DDE2E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Jul 2007 23:18:50 +1000 (EST)
Received: from mail.technotrade.biz (localhost [127.0.0.1])
	by mail.technotrade.biz (Postfix) with ESMTP id 0177D21DA
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Jul 2007 15:18:49 +0200 (CEST)
Received: from pclaurent.technotrade.biz (pclaurent.technotrade.biz
	[192.168.1.47])
	by mail.technotrade.biz (Postfix) with ESMTP id DE5572181
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Jul 2007 15:18:48 +0200 (CEST)
From: Laurent Pinchart <laurent.pinchart@technotrade.biz>
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH 2/2] [POWERPC] Use cpm2_clk_setup to configure SCC clocks for
	the MPC82xx ADS
Date: Wed, 11 Jul 2007 15:18:48 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200707111518.48394.laurent.pinchart@technotrade.biz>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Signed-off-by: Laurent Pinchart <laurent.pinchart@technotrade.biz>
---
 arch/powerpc/platforms/82xx/mpc82xx_ads.c |   16 ++++------------
 1 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/platforms/82xx/mpc82xx_ads.c 
b/arch/powerpc/platforms/82xx/mpc82xx_ads.c
index 47cb09f..c8a29b9 100644
--- a/arch/powerpc/platforms/82xx/mpc82xx_ads.c
+++ b/arch/powerpc/platforms/82xx/mpc82xx_ads.c
@@ -234,12 +234,8 @@ static void init_scc1_uart_ioports(struct 
fs_uart_platform_info *data)
 	clrbits32(&immap->im_ioport.iop_pdird, 0x00000001);
 	setbits32(&immap->im_ioport.iop_pdird, 0x00000002);
 
-	clrbits32(&immap->im_cpmux.cmx_scr, (0x00000007 << (4 - data->clk_tx)));
-	clrbits32(&immap->im_cpmux.cmx_scr, (0x00000038 << (4 - data->clk_rx)));
-	setbits32(&immap->im_cpmux.cmx_scr,
-		  ((data->clk_tx - 1) << (4 - data->clk_tx)));
-	setbits32(&immap->im_cpmux.cmx_scr,
-		  ((data->clk_rx - 1) << (4 - data->clk_rx)));
+	cpm2_clk_setup(CPM_CLK_SCC1, data->clk_rx, CPM_CLK_RX);
+	cpm2_clk_setup(CPM_CLK_SCC1, data->clk_tx, CPM_CLK_TX);
 
 	iounmap(immap);
 }
@@ -253,12 +249,8 @@ static void init_scc4_uart_ioports(struct 
fs_uart_platform_info *data)
 	clrbits32(&immap->im_ioport.iop_pdird, 0x00000200);
 	setbits32(&immap->im_ioport.iop_pdird, 0x00000400);
 
-	clrbits32(&immap->im_cpmux.cmx_scr, (0x00000007 << (4 - data->clk_tx)));
-	clrbits32(&immap->im_cpmux.cmx_scr, (0x00000038 << (4 - data->clk_rx)));
-	setbits32(&immap->im_cpmux.cmx_scr,
-		  ((data->clk_tx - 1) << (4 - data->clk_tx)));
-	setbits32(&immap->im_cpmux.cmx_scr,
-		  ((data->clk_rx - 1) << (4 - data->clk_rx)));
+	cpm2_clk_setup(CPM_CLK_SCC4, data->clk_rx, CPM_CLK_RX);
+	cpm2_clk_setup(CPM_CLK_SCC4, data->clk_tx, CPM_CLK_TX);
 
 	iounmap(immap);
 }
-- 
1.5.0
