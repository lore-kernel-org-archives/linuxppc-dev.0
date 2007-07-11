Return-Path: <laurent.pinchart@technotrade.biz>
Received: from mailgate101.isp.belgacom.be (mailrelay101.isp.belgacom.be
	[195.238.6.82]) by ozlabs.org (Postfix) with ESMTP id 0B157DDE24
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Jul 2007 23:17:55 +1000 (EST)
Received: from mail.technotrade.biz (localhost [127.0.0.1])
	by mail.technotrade.biz (Postfix) with ESMTP id 803291FBF
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Jul 2007 15:17:53 +0200 (CEST)
Received: from pclaurent.technotrade.biz (pclaurent.technotrade.biz
	[192.168.1.47])
	by mail.technotrade.biz (Postfix) with ESMTP id 3714C114A
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Jul 2007 15:17:53 +0200 (CEST)
From: Laurent Pinchart <laurent.pinchart@technotrade.biz>
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH 1/2] [POWERPC] Add SCC clock support to cpm2_clk_setup()
Date: Wed, 11 Jul 2007 15:17:52 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200707111517.52663.laurent.pinchart@technotrade.biz>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

cpm2_clk_setup() supports setting FCC clocks only, even though the
cpm_clk_target enumeration lists SCC clocks. This patch adds SCC clock
support.

Signed-off-by: Laurent Pinchart <laurent.pinchart@technotrade.biz>
---
 arch/powerpc/sysdev/cpm2_common.c |   38 ++++++++++++++++++++++++++++++++++--
 1 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/sysdev/cpm2_common.c 
b/arch/powerpc/sysdev/cpm2_common.c
index 9244129..459fead 100644
--- a/arch/powerpc/sysdev/cpm2_common.c
+++ b/arch/powerpc/sysdev/cpm2_common.c
@@ -138,7 +138,39 @@ int cpm2_clk_setup(enum cpm_clk_target target, int clock, 
int mode)
 	cpmux_t *im_cpmux;
 	u32 *reg;
 	u32 mask = 7;
-	u8 clk_map [24][3] = {
+	u8 clk_map [][3] = {
+		{CPM_CLK_SCC1, CPM_BRG1, 0},
+		{CPM_CLK_SCC1, CPM_BRG2, 1},
+		{CPM_CLK_SCC1, CPM_BRG3, 2},
+		{CPM_CLK_SCC1, CPM_BRG4, 3},
+		{CPM_CLK_SCC1, CPM_CLK5, 4},
+		{CPM_CLK_SCC1, CPM_CLK6, 5},
+		{CPM_CLK_SCC1, CPM_CLK7, 6},
+		{CPM_CLK_SCC1, CPM_CLK8, 7},
+		{CPM_CLK_SCC2, CPM_BRG1, 0},
+		{CPM_CLK_SCC2, CPM_BRG2, 1},
+		{CPM_CLK_SCC2, CPM_BRG3, 2},
+		{CPM_CLK_SCC2, CPM_BRG4, 3},
+		{CPM_CLK_SCC2, CPM_CLK5, 4},
+		{CPM_CLK_SCC2, CPM_CLK6, 5},
+		{CPM_CLK_SCC2, CPM_CLK7, 6},
+		{CPM_CLK_SCC2, CPM_CLK8, 7},
+		{CPM_CLK_SCC3, CPM_BRG1, 0},
+		{CPM_CLK_SCC3, CPM_BRG2, 1},
+		{CPM_CLK_SCC3, CPM_BRG3, 2},
+		{CPM_CLK_SCC3, CPM_BRG4, 3},
+		{CPM_CLK_SCC3, CPM_CLK5, 4},
+		{CPM_CLK_SCC3, CPM_CLK6, 5},
+		{CPM_CLK_SCC3, CPM_CLK7, 6},
+		{CPM_CLK_SCC3, CPM_CLK8, 7},
+		{CPM_CLK_SCC4, CPM_BRG1, 0},
+		{CPM_CLK_SCC4, CPM_BRG2, 1},
+		{CPM_CLK_SCC4, CPM_BRG3, 2},
+		{CPM_CLK_SCC4, CPM_BRG4, 3},
+		{CPM_CLK_SCC4, CPM_CLK5, 4},
+		{CPM_CLK_SCC4, CPM_CLK6, 5},
+		{CPM_CLK_SCC4, CPM_CLK7, 6},
+		{CPM_CLK_SCC4, CPM_CLK8, 7},
 		{CPM_CLK_FCC1, CPM_BRG5, 0},
 		{CPM_CLK_FCC1, CPM_BRG6, 1},
 		{CPM_CLK_FCC1, CPM_BRG7, 2},
@@ -203,13 +235,13 @@ int cpm2_clk_setup(enum cpm_clk_target target, int 
clock, int mode)
 	if (mode == CPM_CLK_RX)
 		shift +=3;
 
-	for (i=0; i<24; i++) {
+	for (i=0; i<ARRAY_SIZE(clk_map); i++) {
 		if (clk_map[i][0] == target && clk_map[i][1] == clock) {
 			bits = clk_map[i][2];
 			break;
 		}
 	}
-	if (i == sizeof(clk_map)/3)
+	if (i == ARRAY_SIZE(clk_map))
 	    ret = -EINVAL;
 
 	bits <<= shift;
-- 
1.5.0
