Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [IPv6:2002:4e20:1eda::1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A963F2C009E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Sep 2013 17:56:02 +1000 (EST)
Date: Thu, 26 Sep 2013 08:54:25 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH 28/51] DMA-API: sound: fix dma mask handling in a lot
 of drivers
Message-ID: <20130926075425.GX25647@n2100.arm.linux.org.uk>
References: <20130919212235.GD12758@n2100.arm.linux.org.uk>
 <E1VMm9m-0007ij-ER@rmk-PC.arm.linux.org.uk> <s5h1u4cf2bo.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <s5h1u4cf2bo.wl%tiwai@suse.de>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: alsa-devel@alsa-project.org, linux-doc@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linux-nvme@lists.infradead.org, Jaroslav Kysela <perex@perex.cz>,
 Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-ide@vger.kernel.org,
 Kukjin Kim <kgene.kim@samsung.com>, devel@driverdev.osuosl.org,
 linux-samsung-soc@vger.kernel.org, linux-scsi@vger.kernel.org,
 e1000-devel@lists.sourceforge.net, b43-dev@lists.infradead.org,
 linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 Haojian Zhuang <haojian.zhuang@gmail.com>, Timur Tabi <timur@tabi.org>,
 Mark Brown <broonie@kernel.org>, dri-devel@lists.freedesktop.org,
 Ben Dooks <ben-linux@fluff.org>, linux-tegra@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
 Eric Miao <eric.y.miao@gmail.com>, Sangbeom Kim <sbkim73@samsung.com>,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-wireless@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 linux-crypto@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org,
 linuxppc-dev@lists.ozlabs.org, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 26, 2013 at 09:51:23AM +0200, Takashi Iwai wrote:
> Hi,
> 
> sorry for the lat response, as I've been traveling in the last weeks.
> 
> At Thu, 19 Sep 2013 22:53:02 +0100,
> Russell King wrote:
> > 
> > This code sequence is unsafe in modules:
> > 
> > static u64 mask = DMA_BIT_MASK(something);
> > ...
> > 	if (!dev->dma_mask)
> > 		dev->dma_mask = &mask;
> > 
> > as if a module is reloaded, the mask will be pointing at the original
> > module's mask address, and this can lead to oopses.  Moreover, they
> > all follow this with:
> > 
> > 	if (!dev->coherent_dma_mask)
> > 		dev->coherent_dma_mask = mask;
> > 
> > where 'mask' is the same value as the statically defined mask, and this
> > bypasses the architecture's check on whether the DMA mask is possible.
> > 
> > Fix these issues by using the new dma_coerce_coherent_and_mask()
> > function.
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> Applied with Mark's ack now.

Which is a very stupid thing to do because you won't have
dma_coerce_coherent_and_mask() in your tree, so all these drivers
will fail to build for you.
