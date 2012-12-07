Return-Path: <holger.brunck@keymile.com>
Received: from mail-de.keymile.com (mail-de.keymile.com [195.8.104.1])
 by ozlabs.org (Postfix) with SMTP id 256CD2C0131
 for <linuxppc-dev@ozlabs.org>; Sat,  8 Dec 2012 02:20:36 +1100 (EST)
From: Holger Brunck <holger.brunck@keymile.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 4/5] powerpc/83xx: apply mpc8360e quirk for kmeter1 only when
 par_io is present
Date: Fri,  7 Dec 2012 16:09:15 +0100
Message-Id: <1354892956-14623-4-git-send-email-holger.brunck@keymile.com>
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

There is no point in applying this quirk when par_io is not present.

Signed-off-by: Gerlando Falauto <gerlando.falauto@keymile.com>
Signed-off-by: Holger Brunck <holger.brunck@keymile.com>
cc: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/platforms/83xx/km83xx.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/km83xx.c b/arch/powerpc/platforms/83xx/km83xx.c
index 88b1af0..bf4c447 100644
--- a/arch/powerpc/platforms/83xx/km83xx.c
+++ b/arch/powerpc/platforms/83xx/km83xx.c
@@ -148,11 +148,13 @@ static void __init mpc83xx_km_setup_arch(void)
 
 		for_each_node_by_name(np, "ucc")
 			par_io_of_config(np);
-	}
-	np = of_find_compatible_node(NULL, "network", "ucc_geth");
-	if (np != NULL) {
-		quirk_mpc8360e_qe_enet10();
-		of_node_put(np);
+
+		/* Only apply this quirk when par_io is available */
+		np = of_find_compatible_node(NULL, "network", "ucc_geth");
+		if (np != NULL) {
+			quirk_mpc8360e_qe_enet10();
+			of_node_put(np);
+		}
 	}
 #endif	/* CONFIG_QUICC_ENGINE */
 }
-- 
1.7.1
