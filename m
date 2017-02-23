Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vTrQq0H7LzDqHj
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 10:43:31 +1100 (AEDT)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vTrQp17kTz9s78
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2017 10:43:29 +1100 (AEDT)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: dri-devel@lists.freedesktop.org
Cc: "Y . C . Chen" <yc_chen@aspeedtech.com>, airlied@redhat.com,
 eich@suse.come, linuxppc-dev@ozlabs.org
Subject: [PATCH 05/12] drm/ast: Fix calculation of MCLK
Date: Fri, 24 Feb 2017 09:53:50 +1100
Message-Id: <20170223225357.9572-5-benh@kernel.crashing.org>
In-Reply-To: <20170223225357.9572-1-benh@kernel.crashing.org>
References: <20170223225357.9572-1-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some braces were missing causing an incorrect calculation.

Y.C. Chen from Aspeed provided me with the right formula
which I tested on AST2400 and 2500.

The MCLK isn't currently used by the driver (it will eventually
to filter modes) so the issue isn't catastrophic.

Also make the printed value a bit more meaningful

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/gpu/drm/ast/ast_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_main.c b/drivers/gpu/drm/ast/ast_main.c
index 718c15b..d194af3 100644
--- a/drivers/gpu/drm/ast/ast_main.c
+++ b/drivers/gpu/drm/ast/ast_main.c
@@ -352,7 +352,7 @@ static int ast_get_dram_info(struct drm_device *dev)
 		div = 0x1;
 		break;
 	}
-	ast->mclk = ref_pll * (num + 2) / (denum + 2) * (div * 1000);
+	ast->mclk = ref_pll * (num + 2) / ((denum + 2) * (div * 1000));
 	return 0;
 }
 
@@ -496,7 +496,9 @@ int ast_driver_load(struct drm_device *dev, unsigned long flags)
 		if (ret)
 			goto out_free;
 		ast->vram_size = ast_get_vram_info(dev);
-		DRM_INFO("dram %d %d %d %08x\n", ast->mclk, ast->dram_type, ast->dram_bus_width, ast->vram_size);
+		DRM_INFO("dram MCLK=%u Mhz type=%d bus_width=%d size=%08x\n",
+			 ast->mclk, ast->dram_type,
+			 ast->dram_bus_width, ast->vram_size);
 	}
 
 	if (need_post)
-- 
2.9.3
