Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [IPv6:2002:4e20:1eda::1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2FA5D2C0114
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Sep 2013 04:51:18 +1000 (EST)
Date: Mon, 23 Sep 2013 19:42:26 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 36/51] DMA-API: usb: use dma_set_coherent_mask()
Message-ID: <20130923184226.GU25647@n2100.arm.linux.org.uk>
References: <E1VMmHX-0007jq-Cj@rmk-PC.arm.linux.org.uk>
 <Pine.LNX.4.44L0.1309231418030.1348-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.44L0.1309231418030.1348-100000@iolanthe.rowland.org>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: alsa-devel@alsa-project.org, linux-doc@vger.kernel.org,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 linux-wireless@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-ide@vger.kernel.org,
 devel@driverdev.osuosl.org, linux-samsung-soc@vger.kernel.org,
 linux-scsi@vger.kernel.org, e1000-devel@lists.sourceforge.net,
 b43-dev@lists.infradead.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>,
 Kukjin Kim <kgene.kim@samsung.com>, linux-nvme@lists.infradead.org,
 linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org, linux-mmc@vger.kernel.org,
 Felipe Balbi <balbi@ti.com>, linux-crypto@vger.kernel.org,
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

On Mon, Sep 23, 2013 at 02:27:39PM -0400, Alan Stern wrote:
> On Thu, 19 Sep 2013, Russell King wrote:
> 
> > The correct way for a driver to specify the coherent DMA mask is
> > not to directly access the field in the struct device, but to use
> > dma_set_coherent_mask().  Only arch and bus code should access this
> > member directly.
> > 
> > Convert all direct write accesses to using the correct API.
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> > diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
> > index f6b790c..5b0cd2d 100644
> > --- a/drivers/usb/host/ehci-platform.c
> > +++ b/drivers/usb/host/ehci-platform.c
> 
> > @@ -91,8 +91,9 @@ static int ehci_platform_probe(struct platform_device *dev)
> >  		dev->dev.platform_data = &ehci_platform_defaults;
> >  	if (!dev->dev.dma_mask)
> >  		dev->dev.dma_mask = &dev->dev.coherent_dma_mask;
> > -	if (!dev->dev.coherent_dma_mask)
> > -		dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
> > +	err = dma_set_coherent_mask(&dev->dev, DMA_BIT_MASK(32));
> > +	if (err)
> > +		return err;
> >  
> >  	pdata = dev_get_platdata(&dev->dev);
> 
> ehci-platform.c is a generic file, intended for use by multiple
> platforms.  Is it not possible that on some platforms, the arch or bus
> code may already have initialized the DMA masks?  Isn't something like 
> this (i.e., DMA bindings) planned for Device Tree?
> 
> By eliminating the tests above and calling dma_set_coherent_mask or
> dma_coerce_mask_and_coherent unconditionally, this patch (and the next)
> would overwrite those initial settings.
> 
> I don't know to what extent the same may be true for the other,
> platform-specific, drivers changed by this patch.  But it's something 
> to be aware of.

Please check the DMA API documentation:

=====
For correct operation, you must interrogate the kernel in your device
probe routine to see if the DMA controller on the machine can properly
support the DMA addressing limitation your device has.  It is good
style to do this even if your device holds the default setting,
because this shows that you did think about these issues wrt. your
device.

The query is performed via a call to dma_set_mask():

        int dma_set_mask(struct device *dev, u64 mask);

The query for consistent allocations is performed via a call to
dma_set_coherent_mask():

        int dma_set_coherent_mask(struct device *dev, u64 mask);
=====

So, All drivers which use DMA are supposed to issue the appropriate
calls to check the DMA masks before they perform DMA, even if the
"default" is correct.

And yes, this is all part of sorting out the DT mess - we should
start not from the current mess (which is really totally haphazard)
but from the well established position of how the DMA API _should_
be used.  What that means is that all drivers should be issuing
these calls as appropriate today.

The default mask setup when the device is created is just that -
it's a default mask, and it should not be used to decide anything
about the device.  That's something which the driver should compute
on its own accord and then inform the various other layers via the
appropriate call.

Remember, on PCI, even when we have 64-bit, we do not declare PCI
devices with a 64-bit DMA mask: that's up to PCI device drivers to
_try_ to set a 64-bit DMA mask, which when successful _allows_ them
to use 64-bit DMA.  If it fails, they have to only use 32-bit.  If
they want a smaller mask, the _driver_ has to set the smaller mask,
not the device creating code.

The reason we're into this (particularly on ARM) is that we got lazy
because we could get by with declaring a DMA mask at device creation
time, since all devices were statically declared.  Now it's time to
get rid of those old lazy ways and start doing things correctly and
to the requirements of the APIs.
