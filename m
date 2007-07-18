Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 65F0EDEE05
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 11:35:40 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l6I1ZYke027601
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 18:35:35 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.83.16.18])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6I1ZY5D001470
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:35:34 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l6I1ArLt007911
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:10:53 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 23E80AEFC9
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:35:33 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l6I1ZXqY015362
	for linuxppc-dev@ozlabs.org; Tue, 17 Jul 2007 20:35:33 -0500
Date: Tue, 17 Jul 2007 20:35:32 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 26/61] cpm2: Add SCCs to cpm2_clk_setup().
Message-ID: <20070718013532.GX15238@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070718013137.GA15217@ld0162-tx32.am.freescale.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/sysdev/cpm2_common.c |   42 ++++++++++++++++++++++++++++++++----
 1 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/sysdev/cpm2_common.c b/arch/powerpc/sysdev/cpm2_common.c
index daf7497..4e840bd 100644
--- a/arch/powerpc/sysdev/cpm2_common.c
+++ b/arch/powerpc/sysdev/cpm2_common.c
@@ -138,7 +138,7 @@ int cpm2_clk_setup(enum cpm_clk_target target, int clock, int mode)
 	cpmux_t *im_cpmux;
 	u32 *reg;
 	u32 mask = 7;
-	u8 clk_map [24][3] = {
+	u8 clk_map[][3] = {
 		{CPM_CLK_FCC1, CPM_BRG5, 0},
 		{CPM_CLK_FCC1, CPM_BRG6, 1},
 		{CPM_CLK_FCC1, CPM_BRG7, 2},
@@ -162,8 +162,40 @@ int cpm2_clk_setup(enum cpm_clk_target target, int clock, int mode)
 		{CPM_CLK_FCC3, CPM_CLK13, 4},
 		{CPM_CLK_FCC3, CPM_CLK14, 5},
 		{CPM_CLK_FCC3, CPM_CLK15, 6},
-		{CPM_CLK_FCC3, CPM_CLK16, 7}
-		};
+		{CPM_CLK_FCC3, CPM_CLK16, 7},
+		{CPM_CLK_SCC1, CPM_BRG1, 0},
+		{CPM_CLK_SCC1, CPM_BRG2, 1},
+		{CPM_CLK_SCC1, CPM_BRG3, 2},
+		{CPM_CLK_SCC1, CPM_BRG4, 3},
+		{CPM_CLK_SCC1, CPM_CLK11, 4},
+		{CPM_CLK_SCC1, CPM_CLK12, 5},
+		{CPM_CLK_SCC1, CPM_CLK3, 6},
+		{CPM_CLK_SCC1, CPM_CLK4, 7},
+		{CPM_CLK_SCC2, CPM_BRG1, 0},
+		{CPM_CLK_SCC2, CPM_BRG2, 1},
+		{CPM_CLK_SCC2, CPM_BRG3, 2},
+		{CPM_CLK_SCC2, CPM_BRG4, 3},
+		{CPM_CLK_SCC2, CPM_CLK11, 4},
+		{CPM_CLK_SCC2, CPM_CLK12, 5},
+		{CPM_CLK_SCC2, CPM_CLK3, 6},
+		{CPM_CLK_SCC2, CPM_CLK4, 7},
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
+	};
 
 	im_cpmux = cpm2_map(im_cpmux);
 
@@ -203,13 +235,13 @@ int cpm2_clk_setup(enum cpm_clk_target target, int clock, int mode)
 	if (mode == CPM_CLK_RX)
 		shift +=3;
 
-	for (i=0; i<24; i++) {
+	for (i = 0; i < ARRAY_SIZE(clk_map); i++) {
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
1.5.0.3
