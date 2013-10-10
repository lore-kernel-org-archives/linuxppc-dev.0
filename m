Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3BDC82C0146
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Oct 2013 19:18:13 +1100 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id r9A8I4Yp023972
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Oct 2013 03:18:06 -0500
Message-ID: <1381393082.4330.38.camel@pasglop>
Subject: [PATCH 1/3] powerpc/scom: Enable 64-bit addresses
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Thu, 10 Oct 2013 19:18:02 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On P8, XSCOM addresses has a special "indirect" form that
requires more than 32-bits, so let's use u64 everywhere in
the code instead of u32.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

This applies on top of my previously posted scom series

 arch/powerpc/include/asm/scom.h             | 8 ++++----
 arch/powerpc/platforms/powernv/opal-xscom.c | 6 +++---
 arch/powerpc/platforms/wsp/scom_wsp.c       | 4 ++--
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/scom.h b/arch/powerpc/include/asm/scom.h
index 07dcdcf..f5cde45 100644
--- a/arch/powerpc/include/asm/scom.h
+++ b/arch/powerpc/include/asm/scom.h
@@ -54,8 +54,8 @@ struct scom_controller {
 	scom_map_t (*map)(struct device_node *ctrl_dev, u64 reg, u64 count);
 	void (*unmap)(scom_map_t map);
 
-	int (*read)(scom_map_t map, u32 reg, u64 *value);
-	int (*write)(scom_map_t map, u32 reg, u64 value);
+	int (*read)(scom_map_t map, u64 reg, u64 *value);
+	int (*write)(scom_map_t map, u64 reg, u64 value);
 };
 
 extern const struct scom_controller *scom_controller;
@@ -137,7 +137,7 @@ static inline void scom_unmap(scom_map_t map)
  *
  * Returns 0 (success) or a negative error code
  */
-static inline int scom_read(scom_map_t map, u32 reg, u64 *value)
+static inline int scom_read(scom_map_t map, u64 reg, u64 *value)
 {
 	int rc;
 
@@ -155,7 +155,7 @@ static inline int scom_read(scom_map_t map, u32 reg, u64 *value)
  *
  * Returns 0 (success) or a negative error code
  */
-static inline int scom_write(scom_map_t map, u32 reg, u64 value)
+static inline int scom_write(scom_map_t map, u64 reg, u64 value)
 {
 	return scom_controller->write(map, reg, value);
 }
diff --git a/arch/powerpc/platforms/powernv/opal-xscom.c b/arch/powerpc/platforms/powernv/opal-xscom.c
index 3ed5c64..09a90d8 100644
--- a/arch/powerpc/platforms/powernv/opal-xscom.c
+++ b/arch/powerpc/platforms/powernv/opal-xscom.c
@@ -27,7 +27,7 @@
  */
 struct opal_scom_map {
 	uint32_t chip;
-	uint32_t addr;
+	uint64_t addr;
 };
 
 static scom_map_t opal_scom_map(struct device_node *dev, u64 reg, u64 count)
@@ -71,7 +71,7 @@ static int opal_xscom_err_xlate(int64_t rc)
 	}
 }
 
-static int opal_scom_read(scom_map_t map, u32 reg, u64 *value)
+static int opal_scom_read(scom_map_t map, u64 reg, u64 *value)
 {
 	struct opal_scom_map *m = map;
 	int64_t rc;
@@ -80,7 +80,7 @@ static int opal_scom_read(scom_map_t map, u32 reg, u64 *value)
 	return opal_xscom_err_xlate(rc);
 }
 
-static int opal_scom_write(scom_map_t map, u32 reg, u64 value)
+static int opal_scom_write(scom_map_t map, u64 reg, u64 value)
 {
 	struct opal_scom_map *m = map;
 	int64_t rc;
diff --git a/arch/powerpc/platforms/wsp/scom_wsp.c b/arch/powerpc/platforms/wsp/scom_wsp.c
index 54172c4..8928507 100644
--- a/arch/powerpc/platforms/wsp/scom_wsp.c
+++ b/arch/powerpc/platforms/wsp/scom_wsp.c
@@ -50,7 +50,7 @@ static void wsp_scom_unmap(scom_map_t map)
 	iounmap((void *)map);
 }
 
-static int wsp_scom_read(scom_map_t map, u32 reg, u64 *value)
+static int wsp_scom_read(scom_map_t map, u64 reg, u64 *value)
 {
 	u64 __iomem *addr = (u64 __iomem *)map;
 
@@ -59,7 +59,7 @@ static int wsp_scom_read(scom_map_t map, u32 reg, u64 *value)
 	return 0;
 }
 
-static int wsp_scom_write(scom_map_t map, u32 reg, u64 value)
+static int wsp_scom_write(scom_map_t map, u64 reg, u64 value)
 {
 	u64 __iomem *addr = (u64 __iomem *)map;
 
