Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vTrQt17WDzDqHl
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 10:43:34 +1100 (AEDT)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vTrQs30XDz9s7N
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2017 10:43:33 +1100 (AEDT)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: dri-devel@lists.freedesktop.org
Cc: "Y . C . Chen" <yc_chen@aspeedtech.com>, airlied@redhat.com,
 eich@suse.come, linuxppc-dev@ozlabs.org
Subject: [PATCH 07/12] drm/ast: Fixed vram size incorrect issue on POWER
Date: Fri, 24 Feb 2017 09:53:52 +1100
Message-Id: <20170223225357.9572-7-benh@kernel.crashing.org>
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

From: "Y.C. Chen" <yc_chen@aspeedtech.com>

The default value of VGA scratch may incorrect.
Should initial h/w before get vram info.

Signed-off-by: Y.C. Chen <yc_chen@aspeedtech.com>
---
 drivers/gpu/drm/ast/ast_main.c | 6 +++---
 drivers/gpu/drm/ast/ast_post.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_main.c b/drivers/gpu/drm/ast/ast_main.c
index f19669f..8684f3c 100644
--- a/drivers/gpu/drm/ast/ast_main.c
+++ b/drivers/gpu/drm/ast/ast_main.c
@@ -516,6 +516,9 @@ int ast_driver_load(struct drm_device *dev, unsigned long flags)
 
 	ast_detect_chip(dev, &need_post);
 
+	if (need_post)
+		ast_post_gpu(dev);
+
 	if (ast->chip != AST1180) {
 		ret = ast_get_dram_info(dev);
 		if (ret)
@@ -526,9 +529,6 @@ int ast_driver_load(struct drm_device *dev, unsigned long flags)
 			 ast->dram_bus_width, ast->vram_size);
 	}
 
-	if (need_post)
-		ast_post_gpu(dev);
-
 	ret = ast_mm_init(ast);
 	if (ret)
 		goto out_free;
diff --git a/drivers/gpu/drm/ast/ast_post.c b/drivers/gpu/drm/ast/ast_post.c
index 64549ce..e802450 100644
--- a/drivers/gpu/drm/ast/ast_post.c
+++ b/drivers/gpu/drm/ast/ast_post.c
@@ -79,7 +79,7 @@ ast_set_def_ext_reg(struct drm_device *dev)
 	const u8 *ext_reg_info;
 
 	/* reset scratch */
-	for (i = 0x81; i <= 0x8f; i++)
+	for (i = 0x81; i <= 0x9f; i++)
 		ast_set_index_reg(ast, AST_IO_CRTC_PORT, i, 0x00);
 
 	if (ast->chip == AST2300 || ast->chip == AST2400) {
-- 
2.9.3
