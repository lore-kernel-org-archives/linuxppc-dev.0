Return-Path: <oohall@gmail.com>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 406x964lYHzF20R
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 19:12:26 +1100 (AEDT)
Received: by mail-pl0-x241.google.com with SMTP id n15-v6so7004382plp.12
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 01:12:26 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linux-nvdimm@lists.01.org
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Oliver O'Halloran <oohall@gmail.com>
Subject: [PATCH 2/6] libnvdimm: Add nd_region_destroy()
Date: Fri, 23 Mar 2018 19:12:05 +1100
Message-Id: <20180323081209.31387-2-oohall@gmail.com>
In-Reply-To: <20180323081209.31387-1-oohall@gmail.com>
References: <20180323081209.31387-1-oohall@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently there's no way to remove a region from and nvdimm_bus without
tearing down the whole bus. This patch adds an API for removing a single
region from the bus so that we can implement a sensible unbind operation
for the of_nd_region platform driver.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 drivers/nvdimm/region_devs.c | 6 ++++++
 include/linux/libnvdimm.h    | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index 2f1d5771100e..76f46fd1fae0 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -1039,6 +1039,12 @@ struct nd_region *nvdimm_blk_region_create(struct nvdimm_bus *nvdimm_bus,
 }
 EXPORT_SYMBOL_GPL(nvdimm_blk_region_create);
 
+void nd_region_destroy(struct nd_region *region)
+{
+	nd_device_unregister(&region->dev, ND_SYNC);
+}
+EXPORT_SYMBOL_GPL(nd_region_destroy);
+
 struct nd_region *nvdimm_volatile_region_create(struct nvdimm_bus *nvdimm_bus,
 		struct nd_region_desc *ndr_desc)
 {
diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
index f61cb5050297..df21ca176e98 100644
--- a/include/linux/libnvdimm.h
+++ b/include/linux/libnvdimm.h
@@ -192,6 +192,7 @@ struct nd_region *nvdimm_blk_region_create(struct nvdimm_bus *nvdimm_bus,
 		struct nd_region_desc *ndr_desc);
 struct nd_region *nvdimm_volatile_region_create(struct nvdimm_bus *nvdimm_bus,
 		struct nd_region_desc *ndr_desc);
+void nd_region_destroy(struct nd_region *region);
 void *nd_region_provider_data(struct nd_region *nd_region);
 void *nd_blk_region_provider_data(struct nd_blk_region *ndbr);
 void nd_blk_region_set_provider_data(struct nd_blk_region *ndbr, void *data);
-- 
2.9.5
