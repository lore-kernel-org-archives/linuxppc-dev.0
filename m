Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CA91ADDF17
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 08:17:47 +1000 (EST)
Subject: Re: [PATCH] legacy-serial: more meaningful names, terminate array
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
In-Reply-To: <1215443120-22004-1-git-send-email-paul.gortmaker@windriver.com>
References: <1215412426.8970.97.camel@pasglop>
	<1215443120-22004-1-git-send-email-paul.gortmaker@windriver.com>
Content-Type: text/plain
Date: Tue, 08 Jul 2008 08:17:18 +1000
Message-Id: <1215469038.8970.137.camel@pasglop>
Mime-Version: 1.0
Cc: scottwood@freescale.com, linuxppc-dev@ozlabs.org, arnd@arndb.de
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-07-07 at 11:05 -0400, Paul Gortmaker wrote:
> Terminate the array of possible legacy serial parents, and
> choose more meaningful names for better autopsy value. Fix
> and cleanups as suggested by Benjamin Herrenschmidt.
> 
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---

Hi Paul !

Linus already merged my fix for legacy_serial.c, can you split
out the ibmebus part and resend it ? I'll stick it in -next.

Cheers,
Ben.

>  arch/powerpc/kernel/ibmebus.c       |    4 ++--
>  arch/powerpc/kernel/legacy_serial.c |    5 +++--
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/ibmebus.c b/arch/powerpc/kernel/ibmebus.c
> index 9971159..58da8f8 100644
> --- a/arch/powerpc/kernel/ibmebus.c
> +++ b/arch/powerpc/kernel/ibmebus.c
> @@ -53,7 +53,7 @@ static struct device ibmebus_bus_device = { /* fake "parent" device */
>  struct bus_type ibmebus_bus_type;
>  
>  /* These devices will automatically be added to the bus during init */
> -static struct of_device_id __initdata builtin_matches[] = {
> +static struct of_device_id __initdata ibmebus_matches[] = {
>  	{ .compatible = "IBM,lhca" },
>  	{ .compatible = "IBM,lhea" },
>  	{},
> @@ -350,7 +350,7 @@ static int __init ibmebus_bus_init(void)
>  		return err;
>  	}
>  
> -	err = ibmebus_create_devices(builtin_matches);
> +	err = ibmebus_create_devices(ibmebus_matches);
>  	if (err) {
>  		device_unregister(&ibmebus_bus_device);
>  		bus_unregister(&ibmebus_bus_type);
> diff --git a/arch/powerpc/kernel/legacy_serial.c b/arch/powerpc/kernel/legacy_serial.c
> index 61dd174..4b01c2b 100644
> --- a/arch/powerpc/kernel/legacy_serial.c
> +++ b/arch/powerpc/kernel/legacy_serial.c
> @@ -33,13 +33,14 @@ static struct legacy_serial_info {
>  	phys_addr_t			taddr;
>  } legacy_serial_infos[MAX_LEGACY_SERIAL_PORTS];
>  
> -static struct __initdata of_device_id parents[] = {
> +static struct __initdata of_device_id uart_match[] = {
>  	{.type = "soc",},
>  	{.type = "tsi-bridge",},
>  	{.type = "opb", },
>  	{.compatible = "ibm,opb",},
>  	{.compatible = "simple-bus",},
>  	{.compatible = "wrs,epld-localbus",},
> +	{},
>  };
>  
>  static unsigned int legacy_serial_count;
> @@ -322,7 +323,7 @@ void __init find_legacy_serial_ports(void)
>  		struct device_node *parent = of_get_parent(np);
>  		if (!parent)
>  			continue;
> -		if (of_match_node(parents, parent) != NULL) {
> +		if (of_match_node(uart_match, parent) != NULL) {
>  			index = add_legacy_soc_port(np, np);
>  			if (index >= 0 && np == stdout)
>  				legacy_serial_console = index;
