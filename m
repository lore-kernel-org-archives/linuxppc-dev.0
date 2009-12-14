Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 048DFB70BA
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 14 Dec 2009 14:31:49 +1100 (EST)
Subject: [PATCH] nouveau: Fix endianness with new context program loader
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ben Skeggs <skeggsb@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 14 Dec 2009 14:31:40 +1100
Message-ID: <1260761500.2217.10.camel@pasglop>
Mime-Version: 1.0
Cc: nouveau@lists.freedesktop.org, Dave Airlie <airlied@gmail.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When switching to request_firmware() to load the context programs,
some endian fixes need to be applied. This makes it work again on
my quad g5 nvidia 6600.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/gpu/drm/nouveau/nv40_graph.c |   20 ++++++++++++--------
 1 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nv40_graph.c b/drivers/gpu/drm/nouveau/nv40_graph.c
index d3e0a2a..7e8547c 100644
--- a/drivers/gpu/drm/nouveau/nv40_graph.c
+++ b/drivers/gpu/drm/nouveau/nv40_graph.c
@@ -252,8 +252,9 @@ nv40_grctx_init(struct drm_device *dev)
 		memcpy(pgraph->ctxprog, fw->data, fw->size);
 
 		cp = pgraph->ctxprog;
-		if (cp->signature != 0x5043564e || cp->version != 0 ||
-		    cp->length != ((fw->size - 7) / 4)) {
+		if (le32_to_cpu(cp->signature) != 0x5043564e ||
+		    cp->version != 0 ||
+		    le16_to_cpu(cp->length) != ((fw->size - 7) / 4)) {
 			NV_ERROR(dev, "ctxprog invalid\n");
 			release_firmware(fw);
 			nv40_grctx_fini(dev);
@@ -281,8 +282,9 @@ nv40_grctx_init(struct drm_device *dev)
 		memcpy(pgraph->ctxvals, fw->data, fw->size);
 
 		cv = (void *)pgraph->ctxvals;
-		if (cv->signature != 0x5643564e || cv->version != 0 ||
-		    cv->length != ((fw->size - 9) / 8)) {
+		if (le32_to_cpu(cv->signature) != 0x5643564e ||
+		    cv->version != 0 ||
+		    le32_to_cpu(cv->length) != ((fw->size - 9) / 8)) {
 			NV_ERROR(dev, "ctxvals invalid\n");
 			release_firmware(fw);
 			nv40_grctx_fini(dev);
@@ -294,8 +296,9 @@ nv40_grctx_init(struct drm_device *dev)
 	cp = pgraph->ctxprog;
 
 	nv_wr32(dev, NV40_PGRAPH_CTXCTL_UCODE_INDEX, 0);
-	for (i = 0; i < cp->length; i++)
-		nv_wr32(dev, NV40_PGRAPH_CTXCTL_UCODE_DATA, cp->data[i]);
+	for (i = 0; i < le16_to_cpu(cp->length); i++)
+		nv_wr32(dev, NV40_PGRAPH_CTXCTL_UCODE_DATA,
+			le32_to_cpu(cp->data[i]));
 
 	pgraph->accel_blocked = false;
 	return 0;
@@ -329,8 +332,9 @@ nv40_grctx_vals_load(struct drm_device *dev, struct nouveau_gpuobj *ctx)
 	if (!cv)
 		return;
 
-	for (i = 0; i < cv->length; i++)
-		nv_wo32(dev, ctx, cv->data[i].offset, cv->data[i].value);
+	for (i = 0; i < le32_to_cpu(cv->length); i++)
+		nv_wo32(dev, ctx, le32_to_cpu(cv->data[i].offset),
+			le32_to_cpu(cv->data[i].value));
 }
 
 /*
