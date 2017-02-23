Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vTqSq27R9zDqD2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 10:00:11 +1100 (AEDT)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vTqSn4zNNz9s7D
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2017 10:00:09 +1100 (AEDT)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: dri-devel@lists.freedesktop.org
Cc: "Y . C . Chen" <yc_chen@aspeedtech.com>, airlied@redhat.com,
 eich@suse.come, linuxppc-dev@ozlabs.org
Subject: [PATCH 09/12] drm/ast: Rename ast_init_dram_2300 to ast_post_chip_2300
Date: Fri, 24 Feb 2017 09:53:54 +1100
Message-Id: <20170223225357.9572-9-benh@kernel.crashing.org>
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

The function does more than initializing the DRAM and in turns
calls other functions to do the actual init. This will keeping
things more consistent with the upcoming AST2500 POST code.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/gpu/drm/ast/ast_post.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_post.c b/drivers/gpu/drm/ast/ast_post.c
index c55067c..561fd7d 100644
--- a/drivers/gpu/drm/ast/ast_post.c
+++ b/drivers/gpu/drm/ast/ast_post.c
@@ -31,7 +31,7 @@
 
 #include "ast_dram_tables.h"
 
-static void ast_init_dram_2300(struct drm_device *dev);
+static void ast_post_chip_2300(struct drm_device *dev);
 
 void ast_enable_vga(struct drm_device *dev)
 {
@@ -381,7 +381,7 @@ void ast_post_gpu(struct drm_device *dev)
 
 	if (ast->config_mode == ast_use_p2a) {
 		if (ast->chip == AST2300 || ast->chip == AST2400)
-			ast_init_dram_2300(dev);
+			ast_post_chip_2300(dev);
 		else
 			ast_init_dram_reg(dev);
 
@@ -1589,7 +1589,7 @@ static void ddr2_init(struct ast_private *ast, struct ast2300_dram_param *param)
 
 }
 
-static void ast_init_dram_2300(struct drm_device *dev)
+static void ast_post_chip_2300(struct drm_device *dev)
 {
 	struct ast_private *ast = dev->dev_private;
 	struct ast2300_dram_param param;
-- 
2.9.3
