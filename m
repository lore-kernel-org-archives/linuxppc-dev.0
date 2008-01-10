Return-Path: <glikely@secretlab.ca>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.241])
	by ozlabs.org (Postfix) with ESMTP id 6F5A7DDE09
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 10:02:11 +1100 (EST)
Received: by ag-out-0708.google.com with SMTP id 33so572594agc.0
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 15:02:10 -0800 (PST)
Message-ID: <fa686aa40801101502v264d8caw6faf935d71b15c9@mail.gmail.com>
Date: Thu, 10 Jan 2008 16:02:10 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Timur Tabi" <timur@freescale.com>
Subject: Re: [PATCH v2] [ALSA] Add ASoC drivers for the Freescale MPC8610 SoC
In-Reply-To: <12000050682718-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <12000050651235-git-send-email-timur@freescale.com>
	<12000050664035-git-send-email-timur@freescale.com>
	<12000050682718-git-send-email-timur@freescale.com>
Cc: olof@lixom.net, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/10/08, Timur Tabi <timur@freescale.com> wrote:
> Add the ASoC drivers for the Freescale MPC8610 SoC and the MPC8610 HPCD
> reference board.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>

This is a very big patch, but I'm going to keep my nose out of the
ALSA stuff.  I've got no problem against it being merged, but I do
have a concern about access to shared registers (see below)

> diff --git a/sound/soc/fsl/mpc8610_hpcd.c b/sound/soc/fsl/mpc8610_hpcd.c
> new file mode 100644
> index 0000000..f26c4b2
> --- /dev/null
> +++ b/sound/soc/fsl/mpc8610_hpcd.c
> +/**
> + * mpc8610_hpcd_probe: OF probe function for the fabric driver
> + *
> + * This function gets called when an SSI node is found in the device tree.
> + *
> + * Although this is a fabric driver, the SSI node is the "master" node with
> + * respect to audio hardware connections.  Therefore, we create a new ASoC
> + * device for each new SSI node that has a codec attached.
> + *
> + * FIXME: Currently, we only support one DMA controller, so if there are
> + * multiple SSI nodes with codecs, only the first will be supported.
> + *
> + * FIXME: Even if we did support multiple DMA controllers, we have no
> + * mechanism for assigning DMA controllers and channels to the individual
> + * SSI devices.  We also probably aren't compatible with the generic Elo DMA
> + * device driver.
> + */
> +static int mpc8610_hpcd_probe(struct of_device *ofdev,
> +       const struct of_device_id *match)
> +{
<snip>
> +       /* Map the global utilities registers. */
> +       guts_np = of_find_compatible_node(NULL, NULL, "fsl,mpc8610-guts");
> +       if (!guts_np) {
> +               dev_err(&ofdev->dev, "could not obtain address of GUTS\n");
> +               ret = -EINVAL;
> +               goto error;
> +       }

This...

> +       /* Find the DMA channels to use.  For now, we always use the first DMA
> +          controller. */
> +       for_each_compatible_node(dma_np, NULL, "fsl,mpc8610-dma") {
> +               iprop = of_get_property(dma_np, "cell-index", NULL);
> +               if (iprop && (*iprop == 0)) {
> +                       of_node_put(dma_np);
> +                       break;
> +               }
> +       }

and this...

Does the driver access the DMA and GUTS registers directly?  If so,
what do you have to protect against race conditions of other drivers
accessing them also.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
