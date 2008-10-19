Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.238])
	by ozlabs.org (Postfix) with ESMTP id B70E5DDDE0
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Oct 2008 01:35:04 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so1268144rvb.9
	for <linuxppc-dev@ozlabs.org>; Sun, 19 Oct 2008 07:35:03 -0700 (PDT)
Date: Sun, 19 Oct 2008 08:35:00 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] Fix some minor errors in mpc5200 psc i2s driver
Message-ID: <20081019143500.GA8086@secretlab.ca>
References: <20081019134911.26576.13218.stgit@terra>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081019134911.26576.13218.stgit@terra>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Oct 19, 2008 at 09:49:11AM -0400, Jon Smirl wrote:
> Fix missing unsigned for irqsave flags in psc i2s driver
> Make attribute visiblity static
> Collect all sysfs errors before checking status
> 
> Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
>  sound/soc/fsl/mpc5200_psc_i2s.c |   12 ++++++------
>  1 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/sound/soc/fsl/mpc5200_psc_i2s.c b/sound/soc/fsl/mpc5200_psc_i2s.c
> index 8692329..809c5c4 100644
> --- a/sound/soc/fsl/mpc5200_psc_i2s.c
> +++ b/sound/soc/fsl/mpc5200_psc_i2s.c
> @@ -277,7 +277,7 @@ static int psc_i2s_trigger(struct snd_pcm_substream *substream, int cmd)
>  	struct mpc52xx_psc __iomem *regs = psc_i2s->psc_regs;
>  	u16 imr;
>  	u8 psc_cmd;
> -	long flags;
> +	unsigned long flags;
>  
>  	if (substream->pstr->stream == SNDRV_PCM_STREAM_CAPTURE)
>  		s = &psc_i2s->capture;
> @@ -699,9 +699,9 @@ static ssize_t psc_i2s_stat_store(struct device *dev,
>  	return count;
>  }
>  
> -DEVICE_ATTR(status, 0644, psc_i2s_status_show, NULL);
> -DEVICE_ATTR(playback_underrun, 0644, psc_i2s_stat_show, psc_i2s_stat_store);
> -DEVICE_ATTR(capture_overrun, 0644, psc_i2s_stat_show, psc_i2s_stat_store);
> +static DEVICE_ATTR(status, 0644, psc_i2s_status_show, NULL);
> +static DEVICE_ATTR(playback_underrun, 0644, psc_i2s_stat_show, psc_i2s_stat_store);
> +static DEVICE_ATTR(capture_overrun, 0644, psc_i2s_stat_show, psc_i2s_stat_store);
>  
>  /* ---------------------------------------------------------------------
>   * OF platform bus binding code:
> @@ -819,8 +819,8 @@ static int __devinit psc_i2s_of_probe(struct of_device *op,
>  
>  	/* Register the SYSFS files */
>  	rc = device_create_file(psc_i2s->dev, &dev_attr_status);
> -	rc = device_create_file(psc_i2s->dev, &dev_attr_capture_overrun);
> -	rc = device_create_file(psc_i2s->dev, &dev_attr_playback_underrun);
> +	rc |= device_create_file(psc_i2s->dev, &dev_attr_capture_overrun);
> +	rc |= device_create_file(psc_i2s->dev, &dev_attr_playback_underrun);
>  	if (rc)
>  		dev_info(psc_i2s->dev, "error creating sysfs files\n");
>  
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
