Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B2FF5DDF25
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Apr 2007 23:31:30 +1000 (EST)
Message-ID: <461A3817.8080303@genesi-usa.com>
Date: Mon, 09 Apr 2007 13:56:55 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Olaf Hering <olaf@aepfle.de>
Subject: Re: [PATCH] autodetect serial console on efika
References: <20070331150823.GA25421@aepfle.de>
In-Reply-To: <20070331150823.GA25421@aepfle.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, Paul Mackeras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Can I suggest a further update to this patch; the serial redirection should
be done on the basis of the node *name* too. The only serial output device
that is 'tied' to the serial console that way is the /failsafe node (if this
is in fact the chosen stdout/stdin device).

It is entirely possible that a user may redirect the OF console output to
the PSC6 controller or another internal or external serial device (PCI
serial controller or so). In this case, the boot console will simply switch
to the UART on the back, which may be some other custom device and not a
valid console.

It is also entirely possible that we move failsafe, too, however. Is it
possible to check the PSC numbering and ensure that it only uses ttyPSC0
for the serial console, if it is in fact using the PSC connected to the
RS232 port on the back of the board (this is in the device tree isn't it?
If not.. can someone suggest how we report this information?? :)

Please tell me if that's an insane suggestion or too much like a fringe
benefit for users and not a useful actual feature?

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

Olaf Hering wrote:
> Efika boards have to be booted with console=ttyPSC0 unless there is a
> graphics card plugged in. Detect if the firmware stdout is the serial
> connector.
> 
> Signed-off-by: Olaf Hering <olaf@aepfle.de>
> 
> ---
>  arch/powerpc/platforms/52xx/efika.c |   26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> Index: b/arch/powerpc/platforms/52xx/efika.c
> ===================================================================
> --- a/arch/powerpc/platforms/52xx/efika.c
> +++ b/arch/powerpc/platforms/52xx/efika.c
> @@ -21,6 +21,7 @@
>  #include <linux/initrd.h>
>  #include <linux/timer.h>
>  #include <linux/pci.h>
> +#include <linux/console.h>
>  
>  #include <asm/io.h>
>  #include <asm/irq.h>
> @@ -221,12 +222,37 @@ static int __init efika_probe(void)
>  	return 1;
>  }
>  
> +static void __init efika_init_early(void)
> +{
> +#ifdef CONFIG_SERIAL_MPC52xx
> +	struct device_node *stdout_node;
> +	const char *device_type;
> +
> +	if (strstr(cmd_line, "console="))
> +		return;
> +	/* find the boot console from /chosen/stdout */
> +	if (!of_chosen)
> +		return;
> +	device_type = get_property(of_chosen, "linux,stdout-path", NULL);
> +	if (!device_type)
> +		return;
> +	stdout_node = of_find_node_by_path(device_type);
> +	if (stdout_node) {
> +		device_type = get_property(stdout_node, "device_type", NULL);
> +		if (device_type && strcmp(device_type, "serial") == 0)
> +			add_preferred_console("ttyPSC", 0, NULL);
> +		of_node_put(stdout_node);
> +	}
> +#endif
> +}
> +
>  define_machine(efika)
>  {
>  	.name			= EFIKA_PLATFORM_NAME,
>  	.probe			= efika_probe,
>  	.setup_arch		= efika_setup_arch,
>  	.init			= mpc52xx_declare_of_platform_devices,
> +	.init_early		= efika_init_early,
>  	.show_cpuinfo		= efika_show_cpuinfo,
>  	.init_IRQ		= mpc52xx_init_irq,
>  	.get_irq		= mpc52xx_get_irq,
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
