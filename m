Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AD36ADDECD
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Apr 2007 15:15:18 +1000 (EST)
Message-Id: <200704220515.l3M5F7eH005962@sullivan.realtime.net>
Subject: Re: generic check_legacy_ioport
To: Olaf Hering <olaf@aepfle.de>
In-Reply-To: <20070420185107.GA4972@aepfle.de>
From: Milton Miller <miltonm@bga.com>
Sender: Milton Miller <miltonm@realtime.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Date: Sun, 22 Apr 2007 05:15:19 -0000

On 2007-04-21 at 04:51:07, Olaf Hering wrote:
> check_legacy_ioport makes only sense on PREP, CHRP and pSeries.
> They may have an isa node with PS/2, parport, floppy and serial ports.
> Cell has IPMI, check for that too.
> 
> Remove the check_legacy_ioport call from ppc_md, its not needed anymore.
> Hardware capabilities come from the device-tree.

..
> Index: b/arch/powerpc/kernel/setup-common.c
> ===================================================================
> --- a/arch/powerpc/kernel/setup-common.c
> +++ b/arch/powerpc/kernel/setup-common.c
> @@ -498,9 +498,47 @@ void probe_machine(void)
>  
>  int check_legacy_ioport(unsigned long base_port)
>  {
> -	if (ppc_md.check_legacy_ioport == NULL)
> +	struct device_node *np;
> +
> +	switch(base_port) {
> +#ifdef CONFIG_SERIO_I8042
> +	case I8042_DATA_REG:
> +		np = of_find_node_by_type(NULL, "8042");
> +		if (np == NULL)
> +			return -ENODEV;
> +		of_node_put(np);
> +		return 0;
> +#endif
> +#ifdef CONFIG_BLK_DEV_FD
> +	case FDC_BASE: /* FDC1 */
> +		np = of_find_node_by_type(NULL, "fdc");
> +		if (np == NULL)
> +			return -ENODEV;
> +		of_node_put(np);
> +		return 0;
> +#endif
> +#ifdef CONFIG_IPMI_HANDLER
> +	/* IPMI */
> +	case 0xca2:
> +	case 0xca9:
> +	case 0xe4:
> +		np = of_find_node_by_type(NULL, "ipmi");
> +		if (np == NULL)
> +			return -ENODEV;
> +		of_node_put(np);
>  		return 0;
> -	return ppc_md.check_legacy_ioport(base_port);
> +#endif

These are all ifdef'd for the driver being built-in.   Also,
they check that a given type of device exists, but not that
the device is at the expected address.

Can we write someting generic instead that finds the isa
bus, then walks children looking for a direct child that
has a matching reg to the requested port?

If this doesn't catch the cell IPMI case then another
approach is to have a table of (port, expected device type)
and loop rather than the case statement.   

milton
