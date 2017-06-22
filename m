Return-Path: <gunthorp@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com [207.54.116.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtpCb0Pw2zDqjM
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jun 2017 03:16:43 +1000 (AEST)
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-ntb@googlegroups.com, linux-alpha@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Stephen Bates <sbates@raithlin.com>, Logan Gunthorpe <logang@deltatee.com>,
 Jyri Sarha <jsarha@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>,
 David Airlie <airlied@linux.ie>
Date: Thu, 22 Jun 2017 10:48:16 -0600
Message-Id: <20170622164817.25515-7-logang@deltatee.com>
In-Reply-To: <20170622164817.25515-1-logang@deltatee.com>
References: <20170622164817.25515-1-logang@deltatee.com>
Subject: [PATCH 6/7] drm/tilcdc: clean up ifdef hacks around iowrite64
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that we can expect iowrite64 to always exist the hack is no longer
necessary so we just call iowrite64 directly.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Jyri Sarha <jsarha@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: David Airlie <airlied@linux.ie>
---
 drivers/gpu/drm/tilcdc/tilcdc_regs.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_regs.h b/drivers/gpu/drm/tilcdc/tilcdc_regs.h
index e9ce725698a9..0b901405f30a 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_regs.h
+++ b/drivers/gpu/drm/tilcdc/tilcdc_regs.h
@@ -133,13 +133,7 @@ static inline void tilcdc_write64(struct drm_device *dev, u32 reg, u64 data)
 	struct tilcdc_drm_private *priv = dev->dev_private;
 	void __iomem *addr = priv->mmio + reg;
 
-#ifdef iowrite64
 	iowrite64(data, addr);
-#else
-	__iowmb();
-	/* This compiles to strd (=64-bit write) on ARM7 */
-	*(u64 __force *)addr = __cpu_to_le64(data);
-#endif
 }
 
 static inline u32 tilcdc_read(struct drm_device *dev, u32 reg)
-- 
2.11.0
