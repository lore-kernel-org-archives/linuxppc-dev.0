Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vTqZq26T3zDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 10:05:23 +1100 (AEDT)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vTqZp15t3z9s7D
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2017 10:05:21 +1100 (AEDT)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: dri-devel@lists.freedesktop.org
Cc: "Y . C . Chen" <yc_chen@aspeedtech.com>, airlied@redhat.com,
 eich@suse.come, linuxppc-dev@ozlabs.org
Subject: [PATCH 12/12] drm/ast: Call open_key before enable_mmio in POST code
Date: Fri, 24 Feb 2017 09:53:57 +1100
Message-Id: <20170223225357.9572-12-benh@kernel.crashing.org>
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

open_key enables access the registers used by enable_mmio

Signed-off-by: Y.C. Chen <yc_chen@aspeedtech.com>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/gpu/drm/ast/ast_post.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ast/ast_post.c b/drivers/gpu/drm/ast/ast_post.c
index a5a7809..f7d4213 100644
--- a/drivers/gpu/drm/ast/ast_post.c
+++ b/drivers/gpu/drm/ast/ast_post.c
@@ -374,8 +374,8 @@ void ast_post_gpu(struct drm_device *dev)
 	pci_write_config_dword(ast->dev->pdev, 0x04, reg);
 
 	ast_enable_vga(dev);
-	ast_enable_mmio(dev);
 	ast_open_key(ast);
+	ast_enable_mmio(dev);
 	ast_set_def_ext_reg(dev);
 
 	if (ast->config_mode == ast_use_p2a) {
-- 
2.9.3
