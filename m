Return-Path: <jsarha@ti.com>
Received: from lelnx193.ext.ti.com (lelnx193.ext.ti.com [198.47.27.77])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wx7Fw1PDNzDr1p
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Jun 2017 22:11:47 +1000 (AEST)
Subject: Re: [PATCH 6/7] drm/tilcdc: clean up ifdef hacks around iowrite64
To: Logan Gunthorpe <logang@deltatee.com>, <linux-kernel@vger.kernel.org>,
 <linux-arch@vger.kernel.org>, <linux-ntb@googlegroups.com>,
 <linux-alpha@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-crypto@vger.kernel.org>, <dri-devel@lists.freedesktop.org>
CC: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Stephen Bates <sbates@raithlin.com>, Tomi
 Valkeinen <tomi.valkeinen@ti.com>, David Airlie <airlied@linux.ie>
References: <20170622164817.25515-1-logang@deltatee.com>
 <20170622164817.25515-7-logang@deltatee.com>
From: Jyri Sarha <jsarha@ti.com>
Message-ID: <504da99a-838c-48ec-c5b2-6b611d587a10@ti.com>
Date: Mon, 26 Jun 2017 11:55:03 +0300
MIME-Version: 1.0
In-Reply-To: <20170622164817.25515-7-logang@deltatee.com>
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/22/17 19:48, Logan Gunthorpe wrote:
> Now that we can expect iowrite64 to always exist the hack is no longer
> necessary so we just call iowrite64 directly.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Cc: Jyri Sarha <jsarha@ti.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: David Airlie <airlied@linux.ie>

Acked-by: Jyri Sarha <jsarha@ti.com>

And thanks!

> ---
>  drivers/gpu/drm/tilcdc/tilcdc_regs.h | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_regs.h b/drivers/gpu/drm/tilcdc/tilcdc_regs.h
> index e9ce725698a9..0b901405f30a 100644
> --- a/drivers/gpu/drm/tilcdc/tilcdc_regs.h
> +++ b/drivers/gpu/drm/tilcdc/tilcdc_regs.h
> @@ -133,13 +133,7 @@ static inline void tilcdc_write64(struct drm_device *dev, u32 reg, u64 data)
>  	struct tilcdc_drm_private *priv = dev->dev_private;
>  	void __iomem *addr = priv->mmio + reg;
>  
> -#ifdef iowrite64
>  	iowrite64(data, addr);
> -#else
> -	__iowmb();
> -	/* This compiles to strd (=64-bit write) on ARM7 */
> -	*(u64 __force *)addr = __cpu_to_le64(data);
> -#endif
>  }
>  
>  static inline u32 tilcdc_read(struct drm_device *dev, u32 reg)
> 
