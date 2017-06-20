Return-Path: <frowand.list@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wshgX45PLzDqhp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 08:03:36 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id y7so26163571pfd.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 15:03:36 -0700 (PDT)
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v6 4/4] of: detect invalid phandle in overlay
Date: Tue, 20 Jun 2017 15:02:52 -0700
Message-Id: <1497996172-821-5-git-send-email-frowand.list@gmail.com>
In-Reply-To: <1497996172-821-1-git-send-email-frowand.list@gmail.com>
References: <1497996172-821-1-git-send-email-frowand.list@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Frank Rowand <frank.rowand@sony.com>

Overlays are not allowed to modify phandle values of previously existing
nodes because there is no information available to allow fixup up
properties that use the previously existing phandle.

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/overlay.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index ca0b85f5deb1..20ab49d2f7a4 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -130,6 +130,10 @@ static int of_overlay_apply_single_device_node(struct of_overlay *ov,
 	/* NOTE: Multiple mods of created nodes not supported */
 	tchild = of_get_child_by_name(target, cname);
 	if (tchild != NULL) {
+		/* new overlay phandle value conflicts with existing value */
+		if (child->phandle)
+			return -EINVAL;
+
 		/* apply overlay recursively */
 		ret = of_overlay_apply_one(ov, tchild, child);
 		of_node_put(tchild);
-- 
Frank Rowand <frank.rowand@sony.com>
