Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vTqqC3LQjzDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 10:16:07 +1100 (AEDT)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vTqqB3V9Gz9s7N
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2017 10:16:05 +1100 (AEDT)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: dri-devel@lists.freedesktop.org
Cc: "Y . C . Chen" <yc_chen@aspeedtech.com>, airlied@redhat.com,
 eich@suse.come, linuxppc-dev@ozlabs.org
Subject: [PATCH 11/12] drm/ast: Fix test for VGA enabled
Date: Fri, 24 Feb 2017 09:53:56 +1100
Message-Id: <20170223225357.9572-11-benh@kernel.crashing.org>
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

(Get better description from Aspeed)

Signed-off-by: Y.C. Chen <yc_chen@aspeedtech.com>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/gpu/drm/ast/ast_post.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_post.c b/drivers/gpu/drm/ast/ast_post.c
index c15f643..a5a7809 100644
--- a/drivers/gpu/drm/ast/ast_post.c
+++ b/drivers/gpu/drm/ast/ast_post.c
@@ -59,13 +59,9 @@ bool ast_is_vga_enabled(struct drm_device *dev)
 		/* TODO 1180 */
 	} else {
 		ch = ast_io_read8(ast, AST_IO_VGA_ENABLE_PORT);
-		if (ch) {
-			ast_open_key(ast);
-			ch = ast_get_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xb6, 0xff);
-			return ch & 0x04;
-		}
+		return !!(ch & 0x01);
 	}
-	return 0;
+	return false;
 }
 
 static const u8 extreginfo[] = { 0x0f, 0x04, 0x1c, 0xff };
-- 
2.9.3
