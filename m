Return-Path: <B13201@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3F52B1007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Jan 2010 19:36:02 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.14.3/de01egw02-8.14.3) with ESMTP id
	o0E8Kq6M014610 for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Jan 2010 01:20:52 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o0E8QoDj027768
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Jan 2010 02:26:51 -0600 (CST)
From: Liu Yu <yu.liu@freescale.com>
To: galak@kernel.crashing.org, davem@davemloft.net
Subject: [PATCH 2/4] mpc8569mds: Add bscr setting for rtbi mode
Date: Thu, 14 Jan 2010 16:13:17 +0800
Message-Id: <1263456799-3306-2-git-send-email-yu.liu@freescale.com>
In-Reply-To: <1263456799-3306-1-git-send-email-yu.liu@freescale.com>
References: <1263456799-3306-1-git-send-email-yu.liu@freescale.com>
Cc: netdev@vger.kernel.org, Liu Yu <yu.liu@freescale.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Liu Yu <yu.liu@freescale.com>
---
 arch/powerpc/platforms/85xx/mpc85xx_mds.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index c5028a2..0872e4a 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -237,6 +237,8 @@ static void __init mpc85xx_mds_setup_arch(void)
 		} else if (machine_is(mpc8569_mds)) {
 #define BCSR7_UCC12_GETHnRST	(0x1 << 2)
 #define BCSR8_UEM_MARVELL_RST	(0x1 << 1)
+#define BCSR_UCC_RGMII		(0x1 << 6)
+#define BCSR_UCC_RTBI		(0x1 << 5)
 			/*
 			 * U-Boot mangles interrupt polarity for Marvell PHYs,
 			 * so reset built-in and UEM Marvell PHYs, this puts
@@ -247,6 +249,28 @@ static void __init mpc85xx_mds_setup_arch(void)
 
 			setbits8(&bcsr_regs[7], BCSR7_UCC12_GETHnRST);
 			clrbits8(&bcsr_regs[8], BCSR8_UEM_MARVELL_RST);
+
+			for (np = NULL; (np = of_find_compatible_node(np,
+							"network",
+							"ucc_geth")) != NULL;) {
+				const unsigned int *prop;
+				int ucc_num;
+
+				prop = of_get_property(np, "cell-index", NULL);
+				if (prop == NULL)
+					continue;
+
+				ucc_num = *prop - 1;
+
+				prop = of_get_property(np, "phy-connection-type", NULL);
+				if (prop == NULL)
+					continue;
+
+				if (strcmp("rtbi", (const char *)prop) == 0)
+					clrsetbits_8(&bcsr_regs[7 + ucc_num],
+						BCSR_UCC_RGMII, BCSR_UCC_RTBI);
+			}
+
 		}
 		iounmap(bcsr_regs);
 	}
-- 
1.6.4
