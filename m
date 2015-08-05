Return-Path: <madalin.bucur@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0111.outbound.protection.outlook.com [65.55.169.111])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 322A01A1C15
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Aug 2015 01:43:42 +1000 (AEST)
From: Madalin Bucur <madalin.bucur@freescale.com>
To: <netdev@vger.kernel.org>
CC: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <davem@davemloft.net>, <scottwood@freescale.com>,
 <igal.liberman@freescale.com>, <ppc@mindchasers.com>, <joe@perches.com>,
 <pebolle@tiscali.nl>, <joakim.tjernlund@transmode.se>, Madalin Bucur
 <madalin.bucur@freescale.com>
Subject: [v2 1/9] devres: add devm_alloc_percpu()
Date: Wed, 5 Aug 2015 18:41:21 +0300
Message-ID: <1438789289-16304-2-git-send-email-madalin.bucur@freescale.com>
In-Reply-To: <1438789289-16304-1-git-send-email-madalin.bucur@freescale.com>
References: <1438789289-16304-1-git-send-email-madalin.bucur@freescale.com>
Reply-To: <madalin.bucur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Introduce managed counterparts for alloc_percpu() and free_percpu().
Add devm_alloc_percpu() and devm_free_percpu() into the managed
interfaces list.

Signed-off-by: Madalin Bucur <madalin.bucur@freescale.com>
---
 Documentation/driver-model/devres.txt |  4 +++
 drivers/base/devres.c                 | 64 +++++++++++++++++++++++++++++++++++
 include/linux/device.h                | 19 +++++++++++
 3 files changed, 87 insertions(+)

diff --git a/Documentation/driver-model/devres.txt b/Documentation/driver-model/devres.txt
index 831a536..595fd1b 100644
--- a/Documentation/driver-model/devres.txt
+++ b/Documentation/driver-model/devres.txt
@@ -312,6 +312,10 @@ MEM
   devm_kvasprintf()
   devm_kzalloc()
 
+PER-CPU MEM
+  devm_alloc_percpu()
+  devm_free_percpu()
+
 PCI
   pcim_enable_device()	: after success, all PCI ops become managed
   pcim_pin_device()	: keep PCI device enabled after release
diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index c8a53d1..deb2ea0 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -10,6 +10,7 @@
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/percpu.h>
 
 #include "base.h"
 
@@ -984,3 +985,66 @@ void devm_free_pages(struct device *dev, unsigned long addr)
 			       &devres));
 }
 EXPORT_SYMBOL_GPL(devm_free_pages);
+
+static void devm_percpu_release(struct device *dev, void *pdata)
+{
+	void __percpu *p;
+
+	p = *(void __percpu **)pdata;
+	free_percpu(p);
+}
+
+static int devm_percpu_match(struct device *dev, void *data, void *p)
+{
+	struct devres *devr = container_of(data, struct devres, data);
+
+	return *(void **)devr->data == p;
+}
+
+/**
+ * __devm_alloc_percpu - Resource-managed alloc_percpu
+ * @dev: Device to allocate per-cpu memory for
+ * @size: Size of per-cpu memory to allocate
+ * @align: Alignement of per-cpu memory to allocate
+ *
+ * Managed alloc_percpu. Per-cpu memory allocated with this function is
+ * automatically freed on driver detach.
+ *
+ * RETURNS:
+ * Pointer to allocated memory on success, NULL on failure.
+ */
+void __percpu *__devm_alloc_percpu(struct device *dev, size_t size,
+		size_t align)
+{
+	void *p;
+	void __percpu *pcpu;
+
+	pcpu = __alloc_percpu(size, align);
+	if (!pcpu)
+		return NULL;
+
+	p = devres_alloc(devm_percpu_release, sizeof(void *), GFP_KERNEL);
+	if (!p)
+		return NULL;
+
+	*(void __percpu **)p = pcpu;
+
+	devres_add(dev, p);
+
+	return pcpu;
+}
+EXPORT_SYMBOL_GPL(__devm_alloc_percpu);
+
+/**
+ * devm_free_percpu - Resource-managed free_percpu
+ * @dev: Device this memory belongs to
+ * @pdata: Per-cpu memory to free
+ *
+ * Free memory allocated with devm_alloc_percpu().
+ */
+void devm_free_percpu(struct device *dev, void __percpu *pdata)
+{
+	WARN_ON(devres_destroy(dev, devm_percpu_release, devm_percpu_match,
+			       (void *)pdata));
+}
+EXPORT_SYMBOL_GPL(devm_free_percpu);
diff --git a/include/linux/device.h b/include/linux/device.h
index a2b4ea7..126c25b 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -673,6 +673,25 @@ void __iomem *devm_ioremap_resource(struct device *dev, struct resource *res);
 int devm_add_action(struct device *dev, void (*action)(void *), void *data);
 void devm_remove_action(struct device *dev, void (*action)(void *), void *data);
 
+/**
+ * devm_alloc_percpu - Resource-managed alloc_percpu
+ * @dev: Device to allocate per-cpu memory for
+ * @type: Type to allocate per-cpu memory for
+ *
+ * Managed alloc_percpu. Per-cpu memory allocated with this function is
+ * automatically freed on driver detach.
+ *
+ * RETURNS:
+ * Pointer to allocated memory on success, NULL on failure.
+ */
+#define devm_alloc_percpu(dev, type)      \
+	(typeof(type) __percpu *)__devm_alloc_percpu(dev, sizeof(type), \
+						     __alignof__(type))
+
+void __percpu *__devm_alloc_percpu(struct device *dev, size_t size,
+				   size_t align);
+void devm_free_percpu(struct device *dev, void __percpu *pdata);
+
 struct device_dma_parameters {
 	/*
 	 * a low level driver may set these to teach IOMMU code about
-- 
1.7.11.7
