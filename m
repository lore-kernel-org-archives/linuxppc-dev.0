Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [IPv6:2002:4e20:1eda::1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E809E2C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Nov 2013 01:53:21 +1100 (EST)
Date: Thu, 31 Oct 2013 14:49:30 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Mauro Carvalho Chehab <m.chehab@samsung.com>
Subject: Re: [PATCH 19/51] DMA-API: media: dt3155v4l: replace
 dma_set_mask()+dma_set_coherent_mask() with new helper
Message-ID: <20131031144929.GC25039@n2100.arm.linux.org.uk>
References: <20130919212235.GD12758@n2100.arm.linux.org.uk>
 <E1VMm13-0007hO-9l@rmk-PC.arm.linux.org.uk> <5249673B.5020705@xs4all.nl>
 <20131031094640.205840a2@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131031094640.205840a2@samsung.com>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: alsa-devel@alsa-project.org, linux-doc@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Hans Verkuil <hverkuil@xs4all.nl>,
 linux-ide@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-samsung-soc@vger.kernel.org, linux-scsi@vger.kernel.org,
 e1000-devel@lists.sourceforge.net, b43-dev@lists.infradead.org,
 linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-tegra@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-crypto@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 uclinux-dist-devel@blackfin.uclinux.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 31, 2013 at 09:46:40AM -0200, Mauro Carvalho Chehab wrote:
> Hi Russell,
> 
> Em Mon, 30 Sep 2013 13:57:47 +0200
> Hans Verkuil <hverkuil@xs4all.nl> escreveu:
> 
> > On 09/19/2013 11:44 PM, Russell King wrote:
> > > Replace the following sequence:
> > > 
> > > 	dma_set_mask(dev, mask);
> > > 	dma_set_coherent_mask(dev, mask);
> > > 
> > > with a call to the new helper dma_set_mask_and_coherent().
> > > 
> > > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > 
> > Acked-by: Hans Verkuil <hans.verkuil@cisco.com>
> 
> Somehow, I lost your original post (I got unsubscribed on a few days 
> from all vger mailing lists at the end of september).
> 
> I suspect that you want to sent this via your tree, right?

Yes please.

> If so:
> 
> Acked-by: Mauro Carvalho Chehab <m.chehab@samsung.com>

Added, thanks.

> > > -	err = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
> > > -	if (err)
> > > -		return -ENODEV;
> > > -	err = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
> > > +	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> > >  	if (err)
> > >  		return -ENODEV;

One thing I've just noticed is that return should be "return err" not
"return -ENODEV" - are you okay for me to change that in this patch?

Thanks.
