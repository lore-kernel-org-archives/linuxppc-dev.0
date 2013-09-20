Return-Path: <bhutchings@solarflare.com>
Received: from webmail.solarflare.com (webmail.solarflare.com [12.187.104.25])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "WEBMAIL.SOLARFLARE.COM",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D85AF2C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Sep 2013 11:27:20 +1000 (EST)
Message-ID: <1379640097.2500.4.camel@bwh-desktop.uk.level5networks.com>
Subject: Re: [PATCH 01/51] DMA-API: provide a helper to set both DMA and
 coherent DMA masks
From: Ben Hutchings <bhutchings@solarflare.com>
To: Russell King <rmk+kernel@arm.linux.org.uk>
Date: Fri, 20 Sep 2013 02:21:37 +0100
In-Reply-To: <E1VMlja-0007fA-HU@rmk-PC.arm.linux.org.uk>
References: <20130919212235.GD12758@n2100.arm.linux.org.uk>
 <E1VMlja-0007fA-HU@rmk-PC.arm.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: alsa-devel@alsa-project.org, linux-doc@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-ide@vger.kernel.org,
 devel@driverdev.osuosl.org, linux-samsung-soc@vger.kernel.org,
 linux-scsi@vger.kernel.org, e1000-devel@lists.sourceforge.net,
 b43-dev@lists.infradead.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-tegra@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Solarflare
 linux maintainers <linux-net-drivers@solarflare.com>, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
 Vinod Koul <vinod.koul@intel.com>, linux-crypto@vger.kernel.org,
 Rob Landley <rob@landley.net>, uclinux-dist-devel@blackfin.uclinux.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-09-19 at 22:25 +0100, Russell King wrote:
> Provide a helper to set both the DMA and coherent DMA masks to the
> same value - this avoids duplicated code in a number of drivers,
> sometimes with buggy error handling, and also allows us identify
> which drivers do things differently.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  Documentation/DMA-API-HOWTO.txt |   37 ++++++++++++++++++++++---------------
>  Documentation/DMA-API.txt       |    8 ++++++++
>  include/linux/dma-mapping.h     |   14 ++++++++++++++
>  3 files changed, 44 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/DMA-API-HOWTO.txt b/Documentation/DMA-API-HOWTO.txt
> index 14129f1..5e98303 100644
> --- a/Documentation/DMA-API-HOWTO.txt
> +++ b/Documentation/DMA-API-HOWTO.txt
[...]
> -dma_set_coherent_mask() will always be able to set the same or a
> -smaller mask as dma_set_mask(). However for the rare case that a
> +The coherent coherent mask will always be able to set the same or a
> +smaller mask as the streaming mask. However for the rare case that a
[...]

The new wording doesn't make sense; a mask doesn't set itself.  I would
suggest:

"The coherent mask can always be set to the same or a smaller mask than
the streaming mask."

Ben.

-- 
Ben Hutchings, Staff Engineer, Solarflare
Not speaking for my employer; that's the marketing department's job.
They asked us to note that Solarflare product names are trademarked.
