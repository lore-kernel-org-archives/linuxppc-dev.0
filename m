Return-Path: <jsarha@ti.com>
Received: from lelnx194.ext.ti.com (lelnx194.ext.ti.com [198.47.27.80])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wx5SJ2wzpzDr1p
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Jun 2017 20:50:39 +1000 (AEST)
Subject: Re: [PATCH 1/7] drm/tilcdc: don't use volatile with iowrite64
To: Logan Gunthorpe <logang@deltatee.com>, <linux-kernel@vger.kernel.org>,
 <linux-arch@vger.kernel.org>, <linux-ntb@googlegroups.com>,
 <linux-alpha@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-crypto@vger.kernel.org>, <dri-devel@lists.freedesktop.org>
CC: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Stephen Bates <sbates@raithlin.com>, Tomi
 Valkeinen <tomi.valkeinen@ti.com>, David Airlie <airlied@linux.ie>
References: <20170622164817.25515-1-logang@deltatee.com>
 <20170622164817.25515-2-logang@deltatee.com>
From: Jyri Sarha <jsarha@ti.com>
Message-ID: <33b6c00f-1982-69dd-86b2-107266d238d0@ti.com>
Date: Mon, 26 Jun 2017 11:54:25 +0300
MIME-Version: 1.0
In-Reply-To: <20170622164817.25515-2-logang@deltatee.com>
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
> This is a prep patch for adding a universal iowrite64.
> 
> The patch is to prevent compiler warnings when we add iowrite64 that
> would occur because there is an unnecessary volatile in this driver.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Cc: Jyri Sarha <jsarha@ti.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: David Airlie <airlied@linux.ie>

Acked-by: Jyri Sarha <jsarha@ti.com>

> ---
>  drivers/gpu/drm/tilcdc/tilcdc_regs.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_regs.h b/drivers/gpu/drm/tilcdc/tilcdc_regs.h
> index 9d528c0a67a4..e9ce725698a9 100644
> --- a/drivers/gpu/drm/tilcdc/tilcdc_regs.h
> +++ b/drivers/gpu/drm/tilcdc/tilcdc_regs.h
> @@ -131,14 +131,14 @@ static inline void tilcdc_write(struct drm_device *dev, u32 reg, u32 data)
>  static inline void tilcdc_write64(struct drm_device *dev, u32 reg, u64 data)
>  {
>  	struct tilcdc_drm_private *priv = dev->dev_private;
> -	volatile void __iomem *addr = priv->mmio + reg;
> +	void __iomem *addr = priv->mmio + reg;
>  
>  #ifdef iowrite64
>  	iowrite64(data, addr);
>  #else
>  	__iowmb();
>  	/* This compiles to strd (=64-bit write) on ARM7 */
> -	*(volatile u64 __force *)addr = __cpu_to_le64(data);
> +	*(u64 __force *)addr = __cpu_to_le64(data);
>  #endif
>  }
>  
> 
