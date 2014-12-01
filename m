Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C87DC1A0053
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Dec 2014 06:56:43 +1100 (AEDT)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl_ssi: free irq before
 irq_dispose_mapping()
Date: Mon, 01 Dec 2014 20:56:23 +0100
Message-ID: <2547588.Qc4F2IfZke@wuerfel>
In-Reply-To: <20141201194147.GP7712@sirena.org.uk>
References: <1417402251-6596-1-git-send-email-jiada_wang@mentor.com>
 <547CC407.30308@metafoo.de> <20141201194147.GP7712@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>,
 lgirdwood@gmail.com, Jiada Wang <jiada_wang@mentor.com>,
 Li.Xiubo@freescale.com, Timur Tabi <timur@tabi.org>,
 linux-kernel@vger.kernel.org, nicoleotsuka@gmail.com, tiwai@suse.de,
 Mark Brown <broonie@kernel.org>, Markus Pargmann <mpa@pengutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday 01 December 2014 19:41:47 Mark Brown wrote:
> On Mon, Dec 01, 2014 at 08:39:51PM +0100, Lars-Peter Clausen wrote:
> > On 12/01/2014 07:48 PM, Timur Tabi wrote:
> 
> > >A quick grep shows the following drivers that call both functions:
> 
> > Most of these drivers will probably work fine without irq_of_parse_and_map().
> 
> I'd also note that quite a few of these drivers look pretty legacy - a
> very large proportion are for old PowerPC hardware, though by no means
> all.

Right, from the times before we were using platform_device for probing
device tree based devices and they had to map the interrupt themselves.

Some of them like arch/powerpc/sysdev/fsl_pci.c seem fine, this one
is does not expect to ever destroy a device, and it only unmaps the
interrupt if request_irq fails. drivers/ata/pata_mpc52xx.c on the
other hand seems wrong in the same was as drivers/edac/mpc85xx_edac.c
and sound/soc/fsl/fsl_ssi.c.

All other drivers that call irq_of_parse_and_map and pass that into
devm_request_irq just never unmap, and their interrupts are already
mapped by the platform code, so I think it's not even a leak.

	Arnd
