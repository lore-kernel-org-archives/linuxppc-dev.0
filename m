Return-Path: <BATV+48ca1ab4adaecdf09dc3+5045+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wq7jc43hJzDq8W
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Jun 2017 04:11:32 +1000 (AEST)
From: Christoph Hellwig <hch@lst.de>
To: x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 xen-devel@lists.xenproject.org, linux-c6x-dev@linux-c6x.org,
 linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-mips@linux-mips.org, openrisc@lists.librecores.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, dmaengine@vger.kernel.org,
 linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 05/44] drm/armada: don't abuse DMA_ERROR_CODE
Date: Fri, 16 Jun 2017 20:10:20 +0200
Message-Id: <20170616181059.19206-6-hch@lst.de>
In-Reply-To: <20170616181059.19206-1-hch@lst.de>
References: <20170616181059.19206-1-hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

dev_addr isn't even a dma_addr_t, and DMA_ERROR_CODE has never been
a valid driver API.  Add a bool mapped flag instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/armada/armada_fb.c  | 2 +-
 drivers/gpu/drm/armada/armada_gem.c | 5 ++---
 drivers/gpu/drm/armada/armada_gem.h | 1 +
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/armada/armada_fb.c b/drivers/gpu/drm/armada/armada_fb.c
index 2a7eb6817c36..92e6b08ea64a 100644
--- a/drivers/gpu/drm/armada/armada_fb.c
+++ b/drivers/gpu/drm/armada/armada_fb.c
@@ -133,7 +133,7 @@ static struct drm_framebuffer *armada_fb_create(struct drm_device *dev,
 	}
 
 	/* Framebuffer objects must have a valid device address for scanout */
-	if (obj->dev_addr == DMA_ERROR_CODE) {
+	if (!obj->mapped) {
 		ret = -EINVAL;
 		goto err_unref;
 	}
diff --git a/drivers/gpu/drm/armada/armada_gem.c b/drivers/gpu/drm/armada/armada_gem.c
index d6c2a5d190eb..a76ca21d063b 100644
--- a/drivers/gpu/drm/armada/armada_gem.c
+++ b/drivers/gpu/drm/armada/armada_gem.c
@@ -175,6 +175,7 @@ armada_gem_linear_back(struct drm_device *dev, struct armada_gem_object *obj)
 
 		obj->phys_addr = obj->linear->start;
 		obj->dev_addr = obj->linear->start;
+		obj->mapped = true;
 	}
 
 	DRM_DEBUG_DRIVER("obj %p phys %#llx dev %#llx\n", obj,
@@ -205,7 +206,6 @@ armada_gem_alloc_private_object(struct drm_device *dev, size_t size)
 		return NULL;
 
 	drm_gem_private_object_init(dev, &obj->obj, size);
-	obj->dev_addr = DMA_ERROR_CODE;
 
 	DRM_DEBUG_DRIVER("alloc private obj %p size %zu\n", obj, size);
 
@@ -229,8 +229,6 @@ static struct armada_gem_object *armada_gem_alloc_object(struct drm_device *dev,
 		return NULL;
 	}
 
-	obj->dev_addr = DMA_ERROR_CODE;
-
 	mapping = obj->obj.filp->f_mapping;
 	mapping_set_gfp_mask(mapping, GFP_HIGHUSER | __GFP_RECLAIMABLE);
 
@@ -610,5 +608,6 @@ int armada_gem_map_import(struct armada_gem_object *dobj)
 		return -EINVAL;
 	}
 	dobj->dev_addr = sg_dma_address(dobj->sgt->sgl);
+	dobj->mapped = true;
 	return 0;
 }
diff --git a/drivers/gpu/drm/armada/armada_gem.h b/drivers/gpu/drm/armada/armada_gem.h
index b88d2b9853c7..6e524e0676bb 100644
--- a/drivers/gpu/drm/armada/armada_gem.h
+++ b/drivers/gpu/drm/armada/armada_gem.h
@@ -16,6 +16,7 @@ struct armada_gem_object {
 	void			*addr;
 	phys_addr_t		phys_addr;
 	resource_size_t		dev_addr;
+	bool			mapped;
 	struct drm_mm_node	*linear;	/* for linear backed */
 	struct page		*page;		/* for page backed */
 	struct sg_table		*sgt;		/* for imported */
-- 
2.11.0
