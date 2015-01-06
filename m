Return-Path: <mathieu.poirier@linaro.org>
Received: from mail-pa0-f52.google.com (mail-pa0-f52.google.com
 [209.85.220.52])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D4D751A083A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Jan 2015 04:54:28 +1100 (AEDT)
Received: by mail-pa0-f52.google.com with SMTP id eu11so31218784pac.25
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Jan 2015 09:54:26 -0800 (PST)
From: mathieu.poirier@linaro.org
To: geert@linux-m68k.org
Subject: [PATCH] coresight: Fixing wrong #ifdef/#endif placement
Date: Tue,  6 Jan 2015 10:54:12 -0700
Message-Id: <1420566852-20816-1-git-send-email-mathieu.poirier@linaro.org>
Cc: mathieu.poirier@linaro.org, linux-sh@vger.kernel.org,
 pratikp@codeaurora.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mathieu Poirier <mathieu.poirier@linaro.org>

Fixing problem reported by:
        https://lkml.org/lkml/2015/1/6/86

The #ifdef/#endif is wrong and prevents the stub of function
of_get_coresight_platform_data() from being visible when
CONFIG_OF is not defined.

Moving CONFIG_OF condition out of CONFIG_CORESIGHT, making
them both independent.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 include/linux/coresight.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 5d3c54311f7a..4404033ee879 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -239,10 +239,6 @@ extern void coresight_disable(struct coresight_device *csdev);
 extern int coresight_is_bit_set(u32 val, int position, int value);
 extern int coresight_timeout(void __iomem *addr, u32 offset,
 			     int position, int value);
-#ifdef CONFIG_OF
-extern struct coresight_platform_data *of_get_coresight_platform_data(
-				struct device *dev, struct device_node *node);
-#endif
 #else
 static inline struct coresight_device *
 coresight_register(struct coresight_desc *desc) { return NULL; }
@@ -254,10 +250,14 @@ static inline int coresight_is_bit_set(u32 val, int position, int value)
 					 { return 0; }
 static inline int coresight_timeout(void __iomem *addr, u32 offset,
 				     int position, int value) { return 1; }
+#endif
+
 #ifdef CONFIG_OF
+extern struct coresight_platform_data *of_get_coresight_platform_data(
+				struct device *dev, struct device_node *node);
+#else
 static inline struct coresight_platform_data *of_get_coresight_platform_data(
 	struct device *dev, struct device_node *node) { return NULL; }
 #endif
-#endif
 
 #endif
-- 
1.9.1
