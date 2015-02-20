Return-Path: <linux@roeck-us.net>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net [208.91.199.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 01B171A0FC3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Feb 2015 03:53:13 +1100 (AEDT)
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
 (envelope-from <linux@roeck-us.net>) id 1YOqpC-001ySk-SK
 for linuxppc-dev@lists.ozlabs.org; Fri, 20 Feb 2015 16:53:11 +0000
Date: Fri, 20 Feb 2015 08:53:06 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@fr.ibm.com>
Subject: Re: [RFC PATCH 1/3] powerpc/powernv: Check OPAL sensor calls exist
Message-ID: <20150220165306.GF22752@roeck-us.net>
References: <1423117857-32759-1-git-send-email-clg@fr.ibm.com>
 <1424444857-13805-2-git-send-email-clg@fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1424444857-13805-2-git-send-email-clg@fr.ibm.com>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, lm-sensors@lm-sensors.org,
 Neelesh Gupta <neelegup@linux.vnet.ibm.com>, skiboot@lists.ozlabs.org,
 linuxppc-dev@lists.ozlabs.org, Jean Delvare <jdelvare@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 20, 2015 at 04:07:35PM +0100, Cédric Le Goater wrote:

You should explain here why this patch is needed.

> Signed-off-by: Cédric Le Goater <clg@fr.ibm.com>
> ---
>  arch/powerpc/platforms/powernv/opal-sensor.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/powerpc/platforms/powernv/opal-sensor.c b/arch/powerpc/platforms/powernv/opal-sensor.c
> index 4ab67ef7abc9..544292f2020f 100644
> --- a/arch/powerpc/platforms/powernv/opal-sensor.c
> +++ b/arch/powerpc/platforms/powernv/opal-sensor.c
> @@ -72,6 +72,9 @@ static __init int opal_sensor_init(void)
>  	struct platform_device *pdev;
>  	struct device_node *sensor;
>  
> +	if (!opal_check_token(OPAL_SENSOR_READ))
> +		return -ENODEV;
> +
>  	sensor = of_find_node_by_path("/ibm,opal/sensors");
>  	if (!sensor) {
>  		pr_err("Opal node 'sensors' not found\n");
> -- 
> 1.7.10.4
> 
