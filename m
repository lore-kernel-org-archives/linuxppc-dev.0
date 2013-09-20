Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [IPv6:2002:4e20:1eda::1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 51E0A2C0163
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Sep 2013 00:01:35 +1000 (EST)
Date: Fri, 20 Sep 2013 15:00:18 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 39/51] DMA-API: others: use dma_set_coherent_mask()
Message-ID: <20130920140018.GP25647@n2100.arm.linux.org.uk>
References: <20130919212235.GD12758@n2100.arm.linux.org.uk>
 <E1VMnNq-0007s4-HN@rmk-PC.arm.linux.org.uk>
 <20130920121652.GA7630@mtj.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130920121652.GA7630@mtj.dyndns.org>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: alsa-devel@alsa-project.org, linux-doc@vger.kernel.org,
 David Airlie <airlied@linux.ie>, linux-mmc@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-ide@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-samsung-soc@vger.kernel.org, Joonyoung Shim <jy0922.shim@samsung.com>,
 linux-scsi@vger.kernel.org, e1000-devel@lists.sourceforge.net,
 Seung-Woo Kim <sw0312.kim@samsung.com>, b43-dev@lists.infradead.org,
 linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>,
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-wireless@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>,
 linux-crypto@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 20, 2013 at 07:16:52AM -0500, Tejun Heo wrote:
> On Fri, Sep 20, 2013 at 12:11:38AM +0100, Russell King wrote:
> > The correct way for a driver to specify the coherent DMA mask is
> > not to directly access the field in the struct device, but to use
> > dma_set_coherent_mask().  Only arch and bus code should access this
> > member directly.
> > 
> > Convert all direct write accesses to using the correct API.
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> Acked-by: Tejun Heo <tj@kernel.org>
> 
> The patch is pretty widely spread.  I don't mind how it gets routed
> but what's the plan?

The plan is... I'm going to try and avoid going through the hell of
re-posting this patch series to all the recipients another time...
(It's taken some 17 hours and lots of hand holding to get this patch
set out without exim jumping off a cliff into deep OOM - soo deep that
even the OOM killer doesn't run and the CPU is 100% idle because
every single process stuck in an uninterruptible sleep waiting for
every other process to free some memory - ouch!)

I know that dealing with this patch set will be a problem due to how
widespread this is, but much of the driver level changes come down to
depending on a couple of patches.  One solution would be if I published
a branch with just the dependencies in, which subsystem maintainers
could pull, and then apply the appropriate patches on top.

Another would be if subsystem maintainers are happy that I carry them,
I can add the acks, and then later on towards the end of the cycle,
provide a branch subsystem maintainers could pull.

Or... if you can think of something easier...
