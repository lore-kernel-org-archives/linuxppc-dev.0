Return-Path: <m.chehab@samsung.com>
Received: from usmailout4.samsung.com (mailout4.w2.samsung.com
 [211.189.100.14]) by ozlabs.org (Postfix) with ESMTP id E84A32C0376
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Oct 2013 22:56:57 +1100 (EST)
Received: from uscpsbgm2.samsung.com
 (u115.gpu85.samsung.co.kr [203.254.195.115]) by usmailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MVJ00I647DQ7C10@usmailout4.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Thu, 31 Oct 2013 07:46:52 -0400 (EDT)
Date: Thu, 31 Oct 2013 09:46:40 -0200
From: Mauro Carvalho Chehab <m.chehab@samsung.com>
To: Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [PATCH 19/51] DMA-API: media: dt3155v4l: replace
 dma_set_mask()+dma_set_coherent_mask() with new helper
Message-id: <20131031094640.205840a2@samsung.com>
In-reply-to: <5249673B.5020705@xs4all.nl>
References: <20130919212235.GD12758@n2100.arm.linux.org.uk>
 <E1VMm13-0007hO-9l@rmk-PC.arm.linux.org.uk> <5249673B.5020705@xs4all.nl>
MIME-version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: alsa-devel@alsa-project.org, linux-doc@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-ide@vger.kernel.org,
 devel@driverdev.osuosl.org, linux-samsung-soc@vger.kernel.org,
 linux-scsi@vger.kernel.org, e1000-devel@lists.sourceforge.net,
 b43-dev@lists.infradead.org, Russell King <rmk+kernel@arm.linux.org.uk>,
 linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-crypto@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 uclinux-dist-devel@blackfin.uclinux.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Russell,

Em Mon, 30 Sep 2013 13:57:47 +0200
Hans Verkuil <hverkuil@xs4all.nl> escreveu:

> On 09/19/2013 11:44 PM, Russell King wrote:
> > Replace the following sequence:
> > 
> > 	dma_set_mask(dev, mask);
> > 	dma_set_coherent_mask(dev, mask);
> > 
> > with a call to the new helper dma_set_mask_and_coherent().
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> Acked-by: Hans Verkuil <hans.verkuil@cisco.com>

Somehow, I lost your original post (I got unsubscribed on a few days 
from all vger mailing lists at the end of september).

I suspect that you want to sent this via your tree, right?
If so:

Acked-by: Mauro Carvalho Chehab <m.chehab@samsung.com>

> 
> Regards,
> 
> 	Hans
> 
> > ---
> >  drivers/staging/media/dt3155v4l/dt3155v4l.c |    5 +----
> >  1 files changed, 1 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/staging/media/dt3155v4l/dt3155v4l.c b/drivers/staging/media/dt3155v4l/dt3155v4l.c
> > index 90d6ac4..081407b 100644
> > --- a/drivers/staging/media/dt3155v4l/dt3155v4l.c
> > +++ b/drivers/staging/media/dt3155v4l/dt3155v4l.c
> > @@ -901,10 +901,7 @@ dt3155_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  	int err;
> >  	struct dt3155_priv *pd;
> >  
> > -	err = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
> > -	if (err)
> > -		return -ENODEV;
> > -	err = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
> > +	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> >  	if (err)
> >  		return -ENODEV;
> >  	pd = kzalloc(sizeof(*pd), GFP_KERNEL);
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-media" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 

Cheers,
Mauro
