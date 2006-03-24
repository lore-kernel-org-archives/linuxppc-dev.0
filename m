Return-Path: <hollis@penguinppc.org>
Received: from over.co.us.ibm.com (over.co.us.ibm.com [32.97.110.157])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A4EC167A60
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Mar 2006 05:34:03 +1100 (EST)
Received: from e32.co.us.ibm.com (e32.boulder.ibm.com [9.17.249.42])
	by bldfb.esmtp.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k2OIQrXc012964
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Mar 2006 13:26:53 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k2OIQnxq015269
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Mar 2006 13:26:49 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k2OITq1r175548
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Mar 2006 11:29:52 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	k2OIQnUi026741
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Mar 2006 11:26:49 -0700
From: Hollis Blanchard <hollis@penguinppc.org>
To: linuxppc-dev@ozlabs.org, mikey@neuling.org
Subject: Re: [PATCH] powerpc: legacy_serial loop cleanup
Date: Fri, 24 Mar 2006 12:26:12 -0600
References: <20060324041727.F131267B56@ozlabs.org>
In-Reply-To: <20060324041727.F131267B56@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200603241226.13171.hollis@penguinppc.org>
Cc: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 23 March 2006 22:17, Michael Neuling wrote:
> We only ever execute the loop once, so let's move it to a function
> making it more readable.  Cleanup patch, no functional change.  

I don't understand: it's only used once, so make it a function? Why not just 
change the "while" to an "if"?

Regardless, two style issues:
- remove the plain "return"
- reduce indenting like so:
	if (console < 0)
		return;
	struct legacy_serial_info *info = ...

> Signed-off-by: Michael Neuling <mikey@neuling.org>
> ---
>  arch/powerpc/kernel/legacy_serial.c |   39 
+++++++++++++++++++-----------------
>  1 files changed, 21 insertions(+), 18 deletions(-)
> 
> Index: linux-2.6-linus/arch/powerpc/kernel/legacy_serial.c
> ===================================================================
> --- linux-2.6-linus.orig/arch/powerpc/kernel/legacy_serial.c
> +++ linux-2.6-linus/arch/powerpc/kernel/legacy_serial.c
> @@ -236,6 +236,26 @@ static int __init add_legacy_pci_port(st
>  }
>  #endif
>  
> +static void __init setup_legacy_serial_console(int console)
> +{
> +	if (console >= 0) {
> +		struct legacy_serial_info *info =
> +			&legacy_serial_infos[legacy_serial_console];
> +		void __iomem *addr;
> +
> +		if (info->taddr == 0)
> +			return;
> +		addr = ioremap(info->taddr, 0x1000);
> +		if (addr == NULL)
> +			return;
> +		if (info->speed == 0)
> +			info->speed = udbg_probe_uart_speed(addr, info->clock);
> +		DBG("default console speed = %d\n", info->speed);
> +		udbg_init_uart(addr, info->speed, info->clock);
> +	}
> +	return;
> +}
> +
>  /*
>   * This is called very early, as part of setup_system() or eventually
>   * setup_arch(), basically before anything else in this file. This function
> @@ -319,24 +339,7 @@ void __init find_legacy_serial_ports(voi
>  
>  	DBG("legacy_serial_console = %d\n", legacy_serial_console);
>  
> -	/* udbg is 64 bits only for now, that will change soon though ... */
> -	while (legacy_serial_console >= 0) {
> -		struct legacy_serial_info *info =
> -			&legacy_serial_infos[legacy_serial_console];
> -		void __iomem *addr;
> -
> -		if (info->taddr == 0)
> -			break;
> -		addr = ioremap(info->taddr, 0x1000);
> -		if (addr == NULL)
> -			break;
> -		if (info->speed == 0)
> -			info->speed = udbg_probe_uart_speed(addr, info->clock);
> -		DBG("default console speed = %d\n", info->speed);
> -		udbg_init_uart(addr, info->speed, info->clock);
> -		break;
> -	}
> -
> +	setup_legacy_serial_console(legacy_serial_console);
>  	DBG(" <- find_legacy_serial_port()\n");
>  }
>  
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
