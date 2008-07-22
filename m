Return-Path: <glikely@secretlab.ca>
Received: from qb-out-0506.google.com (qb-out-0506.google.com [72.14.204.238])
	by ozlabs.org (Postfix) with ESMTP id ADBE4DE073
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 07:25:16 +1000 (EST)
Received: by qb-out-0506.google.com with SMTP id c8so2348618qbc.39
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 14:25:15 -0700 (PDT)
Date: Tue, 22 Jul 2008 17:24:52 -0400
From: Grant Likely <grant.likely@secretlab.ca>
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: Make OpenFirmware helper include file
	conditional
Message-ID: <20080722212452.GD12412@secretlab.ca>
References: <20080722115205.GA12555@sirena.org.uk>
	<1216727589-19544-1-git-send-email-broonie@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1216727589-19544-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: alsa-project.org@rakim.wolfsonmicro.main, linuxppc-dev@ozlabs.org,
	timur@freescale.com, liam.girdwood@wolfsonmicro.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 22, 2008 at 12:53:07PM +0100, Mark Brown wrote:
> The OpenFirmware API headers don't build on all platforms so ensure
> that they are not included unless they are being used.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

I actually fixed this in my tree, but I forgot to roll it into the patch
before I emailed it.  Thanks.

g.

> ---
>  include/sound/soc-of-simple.h |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/include/sound/soc-of-simple.h b/include/sound/soc-of-simple.h
> index 696fc51..a064e19 100644
> --- a/include/sound/soc-of-simple.h
> +++ b/include/sound/soc-of-simple.h
> @@ -7,6 +7,8 @@
>  #ifndef _INCLUDE_SOC_OF_H_
>  #define _INCLUDE_SOC_OF_H_
>  
> +#if defined(CONFIG_SND_SOC_OF_SIMPLE) || defined(CONFIG_SND_SOC_OF_SIMPLE_MODULE)
> +
>  #include <linux/of.h>
>  #include <sound/soc.h>
>  
> @@ -18,4 +20,6 @@ int of_snd_soc_register_platform(struct snd_soc_platform *platform,
>  				 struct device_node *node,
>  				 struct snd_soc_dai *cpu_dai);
>  
> +#endif
> +
>  #endif /* _INCLUDE_SOC_OF_H_ */
> -- 
> 1.5.6.3
> 
