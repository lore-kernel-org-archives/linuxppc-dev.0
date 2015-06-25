Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 10FC31A0FBF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2015 11:05:16 +1000 (AEST)
Message-ID: <1435194300.3790.28.camel@kernel.crashing.org>
Subject: Re: [PATCH v4 2/3] powerpc/powernv: Create LED platform device
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-leds@vger.kernel.org,
 stewart@linux.vnet.ibm.com, j.anaszewski81@gmail.com,
 cooloney@gmail.com, rpurdie@rpsys.net, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com
Date: Thu, 25 Jun 2015 11:05:00 +1000
In-Reply-To: <20150428100958.26912.78396.stgit@localhost.localdomain>
References: <20150428100535.26912.29607.stgit@localhost.localdomain>
 <20150428100958.26912.78396.stgit@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-04-28 at 15:40 +0530, Vasant Hegde wrote:
> This patch adds paltform devices for leds. Also export LED related
> OPAL API's so that led driver can use these APIs.
> 
> Signed-off-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>


> ---
>  arch/powerpc/platforms/powernv/opal.c |   12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
> index 2241565..b1951aa 100644
> --- a/arch/powerpc/platforms/powernv/opal.c
> +++ b/arch/powerpc/platforms/powernv/opal.c
> @@ -784,7 +784,7 @@ static void opal_init_heartbeat(void)
>  
>  static int __init opal_init(void)
>  {
> -	struct device_node *np, *consoles;
> +	struct device_node *np, *consoles, *led;
>  	int rc;
>  
>  	opal_node = of_find_node_by_path("/ibm,opal");
> @@ -813,6 +813,13 @@ static int __init opal_init(void)
>  	/* Setup a heatbeat thread if requested by OPAL */
>  	opal_init_heartbeat();
>  
> +	/* Create led platform devices */
> +	led = of_find_node_by_path("/ibm,opal/led");
> +	if (led) {
> +		of_platform_device_create(led, "opal_led", NULL);
> +		of_node_put(led);
> +	}
> +
>  	/* Find all OPAL interrupts and request them */
>  	opal_irq_init(opal_node);
>  
> @@ -970,3 +977,6 @@ EXPORT_SYMBOL_GPL(opal_rtc_write);
>  EXPORT_SYMBOL_GPL(opal_tpo_read);
>  EXPORT_SYMBOL_GPL(opal_tpo_write);
>  EXPORT_SYMBOL_GPL(opal_i2c_request);
> +/* Export these symbols for PowerNV LED class driver */
> +EXPORT_SYMBOL_GPL(opal_leds_get_ind);
> +EXPORT_SYMBOL_GPL(opal_leds_set_ind);
