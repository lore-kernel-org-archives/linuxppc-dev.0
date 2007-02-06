Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EFA25DDEB9
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Feb 2007 03:34:35 +1100 (EST)
In-Reply-To: <45C844C5.6020108@freescale.com>
References: <45C844C5.6020108@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <700F8DFA-501E-4F2F-B3D1-7600BE795CA0@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/3] add platform_device for USB DR pheripheral driver
Date: Tue, 6 Feb 2007 10:33:38 -0600
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


On Feb 6, 2007, at 3:05 AM, Li Yang wrote:

> Add platform_device setup code for OTG/peripheral mode of
> 834x DR module.  It is needed for USB client driver to work.
>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> arch/powerpc/sysdev/fsl_soc.c |   76 ++++++++++++++++++++++++++++++ 
> +----------
> 1 files changed, 58 insertions(+), 18 deletions(-)
>
> diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/ 
> fsl_soc.c
> index ad31e56..8e4837a 100644
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
> @@ -506,33 +507,72 @@ static int __init fsl_usb_of_init(void)
> 		of_irq_to_resource(np, 0, &r[1]);
> -		usb_dev_dr =
> -		    platform_device_register_simple("fsl-ehci", i, r, 2);
> -		if (IS_ERR(usb_dev_dr)) {
> -			ret = PTR_ERR(usb_dev_dr);
> +		prop = get_property(np, "dr_mode", NULL);
> +

We should handle the !prop case as equivalent to "host".  The reason  
is that if I accept this patch its going to break people until the  
usb side is also in.  I'd prefer to maintain the exact meaning of  
'dr_mode' not existing as 'host'.

> +		if (prop && !strcmp(prop, "host")) {
> +			usb_data.operating_mode = FSL_USB2_DR_HOST;
> +			usb_dev_dr_host = platform_device_register_simple(
> +					"fsl-ehci", i, r, 2);
> +			if (IS_ERR(usb_dev_dr_host)) {
> +				ret = PTR_ERR(usb_dev_dr_host);
> +				goto err;
> +			}
> +		} else if (prop && !strcmp(prop, "peripheral")) {
> +			usb_data.operating_mode = FSL_USB2_DR_DEVICE;
> +			usb_dev_dr_client = platform_device_register_simple(
> +					"fsl-usb2-udc", i, r, 2);
> +			if (IS_ERR(usb_dev_dr_client)) {
> +				ret = PTR_ERR(usb_dev_dr_client);
> +				goto err;
> +			}
> +		} else if (!prop || (prop && !strcmp(prop, "otg"))) {
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
> +		} else {

- k
