Return-Path: <glikely@secretlab.ca>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BA586B70E2
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 31 Dec 2010 18:43:20 +1100 (EST)
Received: by iwn42 with SMTP id 42so12712583iwn.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Dec 2010 23:43:17 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
Date: Fri, 31 Dec 2010 00:43:14 -0700
From: Grant Likely <grant.likely@secretlab.ca>
To: Deepak Saxena <deepak_saxena@mentor.com>
Subject: Re: [PATCH 1/5] of/device: Centralize checking of 'status' properties
Message-ID: <20101231074314.GB4195@angua.secretlab.ca>
References: <cover.1291799069.git.deepak_saxena@mentor.com>
	<20101208192913.GB32473@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20101208192913.GB32473@mentor.com>
Cc: devicetree-discuss@ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Dec 08, 2010 at 11:29:13AM -0800, Deepak Saxena wrote:
> Don't call any of_platform_driver's probe() function if the device node is
> not accessible (as denoted in the status property).
> 
> Signed-off-by: Hollis Blanchard <hollis_blanchard@mentor.com>
> Signed-off-by: Deepak Saxena <deepak_saxena@mentor.com>
> ---
>  arch/powerpc/platforms/83xx/suspend.c |    3 ---
>  drivers/mmc/host/sdhci-of-core.c      |    3 ---
>  drivers/net/gianfar.c                 |    2 +-
>  drivers/net/ibm_newemac/core.c        |    2 +-
>  drivers/of/platform.c                 |    7 +++++--
>  5 files changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/83xx/suspend.c b/arch/powerpc/platforms/83xx/suspend.c
> index 75ae77f..a5a54aa 100644
> --- a/arch/powerpc/platforms/83xx/suspend.c
> +++ b/arch/powerpc/platforms/83xx/suspend.c
> @@ -326,9 +326,6 @@ static int pmc_probe(struct platform_device *ofdev,
>  	struct pmc_type *type = match->data;
>  	int ret = 0;
>  
> -	if (!of_device_is_available(np))
> -		return -ENODEV;
> -
>  	has_deep_sleep = type->has_deep_sleep;
>  	immrbase = get_immrbase();
>  	pmc_dev = ofdev;
> diff --git a/drivers/mmc/host/sdhci-of-core.c b/drivers/mmc/host/sdhci-of-core.c
> index c51b711..51218d4 100644
> --- a/drivers/mmc/host/sdhci-of-core.c
> +++ b/drivers/mmc/host/sdhci-of-core.c
> @@ -126,9 +126,6 @@ static int __devinit sdhci_of_probe(struct platform_device *ofdev,
>  	int size;
>  	int ret;
>  
> -	if (!of_device_is_available(np))
> -		return -ENODEV;
> -
>  	host = sdhci_alloc_host(&ofdev->dev, sizeof(*of_host));
>  	if (IS_ERR(host))
>  		return -ENOMEM;
> diff --git a/drivers/net/gianfar.c b/drivers/net/gianfar.c
> index d1bec62..9918914 100644
> --- a/drivers/net/gianfar.c
> +++ b/drivers/net/gianfar.c
> @@ -620,7 +620,7 @@ static int gfar_of_init(struct platform_device *ofdev, struct net_device **pdev)
>  	unsigned int num_tx_qs, num_rx_qs;
>  	u32 *tx_queues, *rx_queues;
>  
> -	if (!np || !of_device_is_available(np))
> +	if (!np)
>  		return -ENODEV;
>  
>  	/* parse the num of tx and rx queues */
> diff --git a/drivers/net/ibm_newemac/core.c b/drivers/net/ibm_newemac/core.c
> index 06bb9b7..290fff2 100644
> --- a/drivers/net/ibm_newemac/core.c
> +++ b/drivers/net/ibm_newemac/core.c
> @@ -2732,7 +2732,7 @@ static int __devinit emac_probe(struct platform_device *ofdev,
>  	 * property here for now, but new flat device trees should set a
>  	 * status property to "disabled" instead.
>  	 */
> -	if (of_get_property(np, "unused", NULL) || !of_device_is_available(np))
> +	if (of_get_property(np, "unused", NULL))
>  		return -ENODEV;
>  
>  	/* Find ourselves in the bootlist if we are there */
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index 5b4a07f..14370a0 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -56,7 +56,10 @@ static int platform_driver_probe_shim(struct platform_device *pdev)
>  	 * come up empty.  Return -EINVAL in this case so other drivers get
>  	 * the chance to bind. */
>  	match = of_match_device(pdev->dev.driver->of_match_table, &pdev->dev);
> -	return match ? ofpdrv->probe(pdev, match) : -EINVAL;
> +	if (match && of_device_is_available(pdev->dev.of_node))
> +		return ofpdrv->probe(pdev, match);
> +
> +	return -EINVAL;

Hi Deepak,

This works for drivers still using the deprecated of_platform_driver
structure, but all of those users are being converted into
platform_drivers which do not use this shim.  Fixing it here will not
work after conversion.

I think it would be better to inhibit the devices from getting registered in
the first place instead of short circuiting the probe path.

g.

>  }
>  
>  static void platform_driver_shutdown_shim(struct platform_device *pdev)
> @@ -142,7 +145,7 @@ static int of_platform_device_probe(struct device *dev)
>  	of_dev_get(of_dev);
>  
>  	match = of_match_device(drv->driver.of_match_table, dev);
> -	if (match)
> +	if (match && of_device_is_available(dev->of_node))
>  		error = drv->probe(of_dev, match);
>  	if (error)
>  		of_dev_put(of_dev);
> -- 
> 1.6.3.3
> 
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
