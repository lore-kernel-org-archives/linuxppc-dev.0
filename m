Return-Path: <grant.likely@secretlab.ca>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A0EC2B6FAB
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 May 2012 15:54:40 +1000 (EST)
Received: by pbbrp16 with SMTP id rp16so7041780pbb.38
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 May 2012 22:54:38 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/3] of: Add prefix parameter to of_modalias_node().
To: David Daney <ddaney.cavm@gmail.com>, devicetree-discuss@lists.ozlabs.org,
 Rob Herring <rob.herring@calxeda.com>, spi-devel-general@lists.sourceforge.net
In-Reply-To: <1336773923-17866-2-git-send-email-ddaney.cavm@gmail.com>
References: <1336773923-17866-1-git-send-email-ddaney.cavm@gmail.com>
 <1336773923-17866-2-git-send-email-ddaney.cavm@gmail.com>
Date: Sat, 19 May 2012 23:54:36 -0600
Message-Id: <20120520055436.13AF03E03B8@localhost>
Cc: linux-mips@linux-mips.org, alsa-devel@alsa-project.org,
 Mark Brown <broonie@opensource.wolfsonmicro.com>,
 David Daney <david.daney@cavium.com>, Takashi Iwai <tiwai@suse.de>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Liam Girdwood <lrg@ti.com>, Jaroslav Kysela <perex@perex.cz>,
 linuxppc-dev@lists.ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 11 May 2012 15:05:21 -0700, David Daney <ddaney.cavm@gmail.com> wrote:
> From: David Daney <david.daney@cavium.com>
> 
> When generating MODALIASes, it is convenient to add things like "spi:"
> or "i2c:" to the front of the strings.  This allows the standard
> modprobe to find the right driver when automatically populating bus
> children from the device tree structure.
> 
> Add a prefix parameter, and adjust callers.  For
> of_register_spi_devices() use the "spi:" prefix.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>

Applied, thanks.  Some notes below...

> Cc: Liam Girdwood <lrg@ti.com>
> Cc: Timur Tabi <timur@freescale.com>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.de>
> Cc: alsa-devel@alsa-project.org
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
>  drivers/of/base.c            |   22 ++++++++++++++++------
>  drivers/of/of_i2c.c          |    2 +-
>  drivers/of/of_spi.c          |    2 +-
>  include/linux/of.h           |    3 ++-
>  sound/soc/fsl/mpc8610_hpcd.c |    2 +-
>  sound/soc/fsl/p1022_ds.c     |    2 +-
>  6 files changed, 22 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 5806449..f05a520 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -575,26 +575,36 @@ EXPORT_SYMBOL(of_find_matching_node);
>  /**
>   * of_modalias_node - Lookup appropriate modalias for a device node
>   * @node:	pointer to a device tree node
> + * @prefix:	prefix to be added to the compatible property, may be NULL
>   * @modalias:	Pointer to buffer that modalias value will be copied into
>   * @len:	Length of modalias value
>   *
> - * Based on the value of the compatible property, this routine will attempt
> - * to choose an appropriate modalias value for a particular device tree node.
> - * It does this by stripping the manufacturer prefix (as delimited by a ',')
> - * from the first entry in the compatible list property.
> + * Based on the value of the compatible property, this routine will
> + * attempt to choose an appropriate modalias value for a particular
> + * device tree node.  It does this by stripping the manufacturer
> + * prefix (as delimited by a ',') from the first entry in the
> + * compatible list property, and appending it to the prefix.

Not sure why this text block was reformatted.  I've formatted it back
to the way it was so the diff shows specifically what has changed in
the content.

I don't want to discourage cleanups, but I need to be careful that
cleanups don't obscure important changes when looking at the diff.

g.
