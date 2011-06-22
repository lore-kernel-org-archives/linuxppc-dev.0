Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE002.bigfish.com (tx2ehsobe001.messaging.microsoft.com
	[65.55.88.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B2318B6FCA
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Jun 2011 03:53:26 +1000 (EST)
Date: Wed, 22 Jun 2011 12:53:20 -0500
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 3/3] powerpc: Dont require a dma_ops struct to set dma mask
Message-ID: <20110622125320.79b97a9c@schlenkerla.am.freescale.net>
In-Reply-To: <1308744176-24491-3-git-send-email-galak@kernel.crashing.org>
References: <1308744176-24491-1-git-send-email-galak@kernel.crashing.org>
	<1308744176-24491-2-git-send-email-galak@kernel.crashing.org>
	<1308744176-24491-3-git-send-email-galak@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 22 Jun 2011 07:02:56 -0500
Kumar Gala <galak@kernel.crashing.org> wrote:

> The only reason to require a dma_ops struct is to see if it has
> implemented set_dma_mask.  If not we can fall back to setting the mask
> directly.
> 
> This resolves an issue with how to sequence the setting of a DMA mask
> for platform devices.  Before we had an issue in that we have no way of
> setting the DMA mask before the various low level bus notifiers get
> called that might check it (swiotlb).
> 
> So now we can do:
> 
> 	pdev = platform_device_alloc("foobar", 0);
> 	dma_set_mask(&pdev->dev, DMA_BIT_MASK(37));
> 	platform_device_register(pdev);

Despite what Documentation/driver-model/platform.txt says, it looks like
platform_device_add() is what you want after platform_device_alloc().
Otherwise device_initialize() gets called twice, as would a call to the
archdata hook if one is added to platform_device_register().

-Scott
