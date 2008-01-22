Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 018B0DDE1F
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 03:51:19 +1100 (EST)
Message-Id: <24D901DC-8F2B-42A5-88B5-E360C44092C9@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Wade Farnsworth <wfarnsworth@mvista.com>
In-Reply-To: <1201020432.5716.159.camel@rhino>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH 2/2] MPC8641 HPCN: publish all soc and flash devices
Date: Tue, 22 Jan 2008 10:50:51 -0600
References: <1201019917.5716.154.camel@rhino> <1201020432.5716.159.camel@rhino>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 22, 2008, at 10:47 AM, Wade Farnsworth wrote:

> Publish all soc and flash devices from the device tree, similar to  
> what
> is done for other boards.
>
> Signed-off-by: Wade Farnsworth <wfarnsworth@mvista.com>
>
> ---
> arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |   16 ++++++++++++++++
> 1 file changed, 16 insertions(+)
>
> diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/ 
> powerpc/platforms/86xx/mpc86xx_hpcn.c
> index 14f4e52..f266264 100644
> --- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
> +++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
> @@ -18,6 +18,7 @@
> #include <linux/kdev_t.h>
> #include <linux/delay.h>
> #include <linux/seq_file.h>
> +#include <linux/of_platform.h>
>
> #include <asm/system.h>
> #include <asm/time.h>
> @@ -212,6 +213,21 @@ mpc86xx_time_init(void)
> 	return 0;
> }
>
> +static struct of_device_id mpc86xx_ids[] = {
> +	{ .type = "soc", },
> +	{ .compatible = "soc", },
> +	{ .compatible = "cfi-flash", },
> +	{},
> +};
> +
> +static int __init mpc86xx_publish_devices(void)
> +{
> +	of_platform_bus_probe(NULL, mpc86xx_ids, NULL);
> +
> +	return 0;
> +}
> +device_initcall(mpc86xx_publish_devices);
> +

this should look more like:

+static struct of_device_id __initdata of_bus_ids[] = {
+       { .compatible = "simple-bus" },
+       {},
+};
+
+static int __init declare_of_platform_devices(void)
+{
+       of_platform_bus_probe(NULL, of_bus_ids, NULL);
+       return 0;
+}
+machine_device_initcall(mpc86xx_hpcn, mpc86xx_publish_devices);
+


>
> define_machine(mpc86xx_hpcn) {
> 	.name			= "MPC86xx HPCN",
> 	.probe			= mpc86xx_hpcn_probe,
>
