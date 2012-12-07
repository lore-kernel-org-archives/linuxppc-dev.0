Return-Path: <holger.brunck@keymile.com>
Received: from mail-de.keymile.com (mail-de.keymile.com [195.8.104.1])
 by ozlabs.org (Postfix) with SMTP id 3AEF62C0147
 for <linuxppc-dev@ozlabs.org>; Sat,  8 Dec 2012 02:20:36 +1100 (EST)
From: Holger Brunck <holger.brunck@keymile.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/5] powerpc/83xx: refactor mpc8360e quirk for kmeter1
Date: Fri,  7 Dec 2012 16:09:14 +0100
Message-Id: <1354892956-14623-3-git-send-email-holger.brunck@keymile.com>
In-Reply-To: <1354892956-14623-1-git-send-email-holger.brunck@keymile.com>
References: <1354892956-14623-1-git-send-email-holger.brunck@keymile.com>
Cc: Holger Brunck <holger.brunck@keymile.com>,
 Gerlando Falauto <gerlando.falauto@keymile.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Gerlando Falauto <gerlando.falauto@keymile.com>

Move the code for this quirk to a dedicated function.

Signed-off-by: Gerlando Falauto <gerlando.falauto@keymile.com>
Signed-off-by: Holger Brunck <holger.brunck@keymile.com>
cc: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/platforms/83xx/km83xx.c |  149 +++++++++++++++++----------------
 1 files changed, 77 insertions(+), 72 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/km83xx.c b/arch/powerpc/platforms/83xx/km83xx.c
index cb6460c..88b1af0 100644
--- a/arch/powerpc/platforms/83xx/km83xx.c
+++ b/arch/powerpc/platforms/83xx/km83xx.c
@@ -43,6 +43,82 @@
 #include "mpc83xx.h"
 
 #define SVR_REV(svr)    (((svr) >>  0) & 0xFFFF) /* Revision field */
+
+static void quirk_mpc8360e_qe_enet10(void)
+{
+	/*
+	 * handle mpc8360E Erratum QE_ENET10:
+	 * RGMII AC values do not meet the specification
+	 */
+	uint svid = mfspr(SPRN_SVR);
+	struct	device_node *np_par;
+	struct	resource res;
+	void	__iomem *base;
+	int	ret;
+
+	np_par = of_find_node_by_name(NULL, "par_io");
+	if (np_par == NULL) {
+		pr_warn("%s couldn;t find par_io node\n", __func__);
+		return;
+	}
+	/* Map Parallel I/O ports registers */
+	ret = of_address_to_resource(np_par, 0, &res);
+	if (ret) {
+		pr_warn("%s couldn;t map par_io registers\n", __func__);
+		return;
+	}
+
+	base = ioremap(res.start, res.end - res.start + 1);
+
+	/*
+	 * set output delay adjustments to default values according
+	 * table 5 in Errata Rev. 5, 9/2011:
+	 *
+	 * write 0b01 to UCC1 bits 18:19
+	 * write 0b01 to UCC2 option 1 bits 4:5
+	 * write 0b01 to UCC2 option 2 bits 16:17
+	 */
+	clrsetbits_be32((base + 0xa8), 0x0c00f000, 0x04005000);
+
+	/*
+	 * set output delay adjustments to default values according
+	 * table 3-13 in Reference Manual Rev.3 05/2010:
+	 *
+	 * write 0b01 to UCC2 option 2 bits 16:17
+	 * write 0b0101 to UCC1 bits 20:23
+	 * write 0b0101 to UCC2 option 1 bits 24:27
+	 */
+	clrsetbits_be32((base + 0xac), 0x0000cff0, 0x00004550);
+
+	if (SVR_REV(svid) == 0x0021) {
+		/*
+		 * UCC2 option 1: write 0b1010 to bits 24:27
+		 * at address IMMRBAR+0x14AC
+		 */
+		clrsetbits_be32((base + 0xac), 0x000000f0, 0x000000a0);
+	} else if (SVR_REV(svid) == 0x0020) {
+		/*
+		 * UCC1: write 0b11 to bits 18:19
+		 * at address IMMRBAR+0x14A8
+		 */
+		setbits32((base + 0xa8), 0x00003000);
+
+		/*
+		 * UCC2 option 1: write 0b11 to bits 4:5
+		 * at address IMMRBAR+0x14A8
+		 */
+		setbits32((base + 0xa8), 0x0c000000);
+
+		/*
+		 * UCC2 option 2: write 0b11 to bits 16:17
+		 * at address IMMRBAR+0x14AC
+		 */
+		setbits32((base + 0xac), 0x0000c000);
+	}
+	iounmap(base);
+	of_node_put(np_par);
+}
+
 /* ************************************************************************
  *
  * Setup the architecture
@@ -73,80 +149,9 @@ static void __init mpc83xx_km_setup_arch(void)
 		for_each_node_by_name(np, "ucc")
 			par_io_of_config(np);
 	}
-
 	np = of_find_compatible_node(NULL, "network", "ucc_geth");
 	if (np != NULL) {
-		/*
-		 * handle mpc8360E Erratum QE_ENET10:
-		 * RGMII AC values do not meet the specification
-		 */
-		uint svid = mfspr(SPRN_SVR);
-		struct	device_node *np_par;
-		struct	resource res;
-		void	__iomem *base;
-		int	ret;
-
-		np_par = of_find_node_by_name(NULL, "par_io");
-		if (np_par == NULL) {
-			pr_warn("%s couldn;t find par_io node\n", __func__);
-			return;
-		}
-		/* Map Parallel I/O ports registers */
-		ret = of_address_to_resource(np_par, 0, &res);
-		if (ret) {
-			pr_warn("%s couldn;t map par_io registers\n", __func__);
-			return;
-		}
-
-		base = ioremap(res.start, res.end - res.start + 1);
-
-		/*
-		 * set output delay adjustments to default values according
-		 * table 5 in Errata Rev. 5, 9/2011:
-		 *
-		 * write 0b01 to UCC1 bits 18:19
-		 * write 0b01 to UCC2 option 1 bits 4:5
-		 * write 0b01 to UCC2 option 2 bits 16:17
-		 */
-		clrsetbits_be32((base + 0xa8), 0x0c00f000, 0x04005000);
-
-		/*
-		 * set output delay adjustments to default values according
-		 * table 3-13 in Reference Manual Rev.3 05/2010:
-		 *
-		 * write 0b01 to UCC2 option 2 bits 16:17
-		 * write 0b0101 to UCC1 bits 20:23
-		 * write 0b0101 to UCC2 option 1 bits 24:27
-		 */
-		clrsetbits_be32((base + 0xac), 0x0000cff0, 0x00004550);
-
-		if (SVR_REV(svid) == 0x0021) {
-			/*
-			 * UCC2 option 1: write 0b1010 to bits 24:27
-			 * at address IMMRBAR+0x14AC
-			 */
-			clrsetbits_be32((base + 0xac), 0x000000f0, 0x000000a0);
-		} else if (SVR_REV(svid) == 0x0020) {
-			/*
-			 * UCC1: write 0b11 to bits 18:19
-			 * at address IMMRBAR+0x14A8
-			 */
-			setbits32((base + 0xa8), 0x00003000);
-
-			/*
-			 * UCC2 option 1: write 0b11 to bits 4:5
-			 * at address IMMRBAR+0x14A8
-			 */
-			setbits32((base + 0xa8), 0x0c000000);
-
-			/*
-			 * UCC2 option 2: write 0b11 to bits 16:17
-			 * at address IMMRBAR+0x14AC
-			 */
-			setbits32((base + 0xac), 0x0000c000);
-		}
-		iounmap(base);
-		of_node_put(np_par);
+		quirk_mpc8360e_qe_enet10();
 		of_node_put(np);
 	}
 #endif	/* CONFIG_QUICC_ENGINE */
-- 
1.7.1
