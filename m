Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D380A1A08FB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Sep 2014 14:39:47 +1000 (EST)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Subject: [PATCH 5/6] powerpc: Add printk levels to powernv platform code
Date: Wed, 17 Sep 2014 14:39:38 +1000
Message-Id: <1410928779-20938-5-git-send-email-anton@samba.org>
In-Reply-To: <1410928779-20938-1-git-send-email-anton@samba.org>
References: <1410928779-20938-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add printk levels to powernv platform code, and convert to
pr_err() etc while here.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/platforms/powernv/opal-nvram.c | 2 +-
 arch/powerpc/platforms/powernv/opal.c       | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-nvram.c b/arch/powerpc/platforms/powernv/opal-nvram.c
index acd9f7e..f9896fd 100644
--- a/arch/powerpc/platforms/powernv/opal-nvram.c
+++ b/arch/powerpc/platforms/powernv/opal-nvram.c
@@ -78,7 +78,7 @@ void __init opal_nvram_init(void)
 	}
 	nvram_size = be32_to_cpup(nbytes_p);
 
-	printk(KERN_INFO "OPAL nvram setup, %u bytes\n", nvram_size);
+	pr_info("OPAL nvram setup, %u bytes\n", nvram_size);
 	of_node_put(np);
 
 	ppc_md.nvram_read = opal_nvram_read;
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index b44eec3..cf85ba8 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -105,12 +105,12 @@ int __init early_init_dt_scan_opal(unsigned long node,
 	if (of_flat_dt_is_compatible(node, "ibm,opal-v3")) {
 		powerpc_firmware_features |= FW_FEATURE_OPALv2;
 		powerpc_firmware_features |= FW_FEATURE_OPALv3;
-		printk("OPAL V3 detected !\n");
+		pr_info("OPAL V3 detected !\n");
 	} else if (of_flat_dt_is_compatible(node, "ibm,opal-v2")) {
 		powerpc_firmware_features |= FW_FEATURE_OPALv2;
-		printk("OPAL V2 detected !\n");
+		pr_info("OPAL V2 detected !\n");
 	} else {
-		printk("OPAL V1 detected !\n");
+		pr_info("OPAL V1 detected !\n");
 	}
 
 	/* Reinit all cores with the right endian */
-- 
1.9.1
