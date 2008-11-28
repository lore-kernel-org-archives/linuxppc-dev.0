Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 8D37CDDDDF
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Nov 2008 06:13:27 +1100 (EST)
Date: Fri, 28 Nov 2008 22:13:23 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 1/2] powerpc and sparc: Introduce dev_archdata node accessors
Message-ID: <20081128191323.GA27260@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: David Miller <davem@davemloft.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The name of the device_node field differ across the platforms, so we
have to implement inlined accessors. This is needed to avoid ugly
#ifdef in the generic code.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
Acked-by: David S. Miller <davem@davemloft.net>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
---
 arch/powerpc/include/asm/device.h |   12 ++++++++++++
 arch/sparc/include/asm/device.h   |   12 ++++++++++++
 2 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/device.h b/arch/powerpc/include/asm/device.h
index dfd504c..7d2277c 100644
--- a/arch/powerpc/include/asm/device.h
+++ b/arch/powerpc/include/asm/device.h
@@ -18,4 +18,16 @@ struct dev_archdata {
 	void			*dma_data;
 };
 
+static inline void dev_archdata_set_node(struct dev_archdata *ad,
+					 struct device_node *np)
+{
+	ad->of_node = np;
+}
+
+static inline struct device_node *
+dev_archdata_get_node(const struct dev_archdata *ad)
+{
+	return ad->of_node;
+}
+
 #endif /* _ASM_POWERPC_DEVICE_H */
diff --git a/arch/sparc/include/asm/device.h b/arch/sparc/include/asm/device.h
index 19790eb..3702e08 100644
--- a/arch/sparc/include/asm/device.h
+++ b/arch/sparc/include/asm/device.h
@@ -20,4 +20,16 @@ struct dev_archdata {
 	int			numa_node;
 };
 
+static inline void dev_archdata_set_node(struct dev_archdata *ad,
+					 struct device_node *np)
+{
+	ad->prom_node = np;
+}
+
+static inline struct device_node *
+dev_archdata_get_node(const struct dev_archdata *ad)
+{
+	return ad->prom_node;
+}
+
 #endif /* _ASM_SPARC_DEVICE_H */
-- 
1.5.6.5
