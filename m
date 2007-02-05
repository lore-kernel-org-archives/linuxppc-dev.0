Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5B155DDE40
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Feb 2007 02:16:58 +1100 (EST)
In-Reply-To: <45C6F46C.9000000@freescale.com>
References: <45C6F46C.9000000@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <297BF1F9-551F-43AD-9E76-00C79EC8BF31@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/3] add soc setup code for USB DR OTG mode
Date: Mon, 5 Feb 2007 09:15:56 -0600
To: Li Yang <leoli@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Paul <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 5, 2007, at 3:10 AM, Li Yang wrote:

You have no description about what this patch does and why its needed.

Nack.  See comments inline.

> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> arch/powerpc/sysdev/fsl_soc.c |   76 +++++++++++++++++++++++++++++ 
> +----------
> 1 files changed, 57 insertions(+), 19 deletions(-)
>
> diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/ 
> fsl_soc.c
> index ad31e56..d9541aa 100644
> --- a/arch/powerpc/sysdev/fsl_soc.c
> +++ b/arch/powerpc/sysdev/fsl_soc.c
> @@ -440,7 +440,8 @@ static int __init fsl_usb_of_init(void)
> {
> 	struct device_node *np;
> 	unsigned int i;
> -	struct platform_device *usb_dev_mph = NULL, *usb_dev_dr = NULL;
> +	struct platform_device *usb_dev_mph = NULL, *usb_dev_dr_host = NULL,
> +		*usb_dev_dr_client = NULL;
> 	int ret;
> 	for (np = NULL, i = 0;
> @@ -506,33 +507,70 @@ static int __init fsl_usb_of_init(void)
> 		of_irq_to_resource(np, 0, &r[1]);
> -		usb_dev_dr =
> -		    platform_device_register_simple("fsl-ehci", i, r, 2);
> -		if (IS_ERR(usb_dev_dr)) {
> -			ret = PTR_ERR(usb_dev_dr);
> -			goto err;
> -		}
> -
> -		usb_dev_dr->dev.coherent_dma_mask = 0xffffffffUL;
> -		usb_dev_dr->dev.dma_mask = &usb_dev_dr->dev.coherent_dma_mask;
> +		prop = get_property(np, "dr_mode", NULL);
> -		usb_data.operating_mode = FSL_USB2_DR_HOST;
> +		if (prop && !strcmp(prop, "host")) {
> +			usb_data.operating_mode = FSL_USB2_DR_HOST;
> +			usb_dev_dr_host = platform_device_register_simple(
> +					"fsl-ehci", i, r, 2);
> +			if (IS_ERR(usb_dev_dr_host)) {
> +				ret = PTR_ERR(usb_dev_dr_host);
> +				goto err;
> +			}
> +			
> +		} else if (prop && !strcmp(prop, "peripheral")) {
> +			usb_data.operating_mode = FSL_USB2_DR_DEVICE;
> +			usb_dev_dr_client = platform_device_register_simple(
> +					"fsl-usb2-udc", i, r, 2);
> +			if (IS_ERR(usb_dev_dr_client)) {
> +				ret = PTR_ERR(usb_dev_dr_client);
> +				goto err;
> +			}
> +		} else if (!prop || (prop && !strcmp(prop, "otg"))) {

Why do we assume if the prop is not defined we are OTG?  This will  
break existing users and is not acceptable.  If the prop doesn't  
exist we have to assume 'host' support to maintain compatibility.

> +			usb_data.operating_mode = FSL_USB2_DR_OTG;
> +			usb_dev_dr_host = platform_device_register_simple(
> +					"fsl-ehci", i, r, 2);
> +			if (IS_ERR(usb_dev_dr_host)) {
> +				ret = PTR_ERR(usb_dev_dr_host);
> +				goto err;
> +			}
> +			usb_dev_dr_client = platform_device_register_simple(
> +					"fsl-usb2-udc", i, r, 2);
> +			if (IS_ERR(usb_dev_dr_client)) {
> +				ret = PTR_ERR(usb_dev_dr_client);
> +				goto err;
> +			}
> +		}

shouldn't there be an error case if the string doesn't match any of  
the above?

> 		prop = get_property(np, "phy_type", NULL);
> 		usb_data.phy_mode = determine_usb_phy(prop);
> -		ret =
> -		    platform_device_add_data(usb_dev_dr, &usb_data,
> -					     sizeof(struct
> -						    fsl_usb2_platform_data));
> -		if (ret)
> -			goto unreg_dr;
> +		if (usb_dev_dr_host) {
> +			usb_dev_dr_host->dev.coherent_dma_mask = 0xffffffffUL;
> +			usb_dev_dr_host->dev.dma_mask = &usb_dev_dr_host->
> +				dev.coherent_dma_mask;
> +			if ((ret = platform_device_add_data(usb_dev_dr_host,
> +						&usb_data, sizeof(struct
> +						fsl_usb2_platform_data))))
> +				goto unreg_dr;
> +		}
> +		if (usb_dev_dr_client) {
> +			usb_dev_dr_client->dev.coherent_dma_mask = 0xffffffffUL;
> +			usb_dev_dr_client->dev.dma_mask = &usb_dev_dr_client->
> +				dev.coherent_dma_mask;
> +			if ((ret = platform_device_add_data(usb_dev_dr_client,
> +						&usb_data, sizeof(struct
> +						fsl_usb2_platform_data))))
> +				goto unreg_dr;
> +		}
> 	}
> 	return 0;
> unreg_dr:
> -	if (usb_dev_dr)
> -		platform_device_unregister(usb_dev_dr);
> +	if (usb_dev_dr_host)
> +		platform_device_unregister(usb_dev_dr_host);
> +	if (usb_dev_dr_client)
> +		platform_device_unregister(usb_dev_dr_client);
> unreg_mph:
> 	if (usb_dev_mph)
> 		platform_device_unregister(usb_dev_mph);

- k
