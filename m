In-Reply-To: <1087207803.7360.83.camel@newt>
References: <1087207803.7360.83.camel@newt>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <FF1E1EF0-BE0A-11D8-91C4-000393DBC2E8@freescale.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: [PATCH][RFC] OCP support for MPC107 and relatives
Date: Mon, 14 Jun 2004 08:59:04 -0500
To: Adrian Cox <adrian@humboldt.co.uk>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> diff -Nru a/arch/ppc/syslib/mpc10x_common.c
> b/arch/ppc/syslib/mpc10x_common.c
> --- a/arch/ppc/syslib/mpc10x_common.c	Mon Jun 14 10:18:30 2004
> +++ b/arch/ppc/syslib/mpc10x_common.c	Mon Jun 14 10:18:30 2004
> @@ -30,7 +30,25 @@
>  #include <asm/pci-bridge.h>
>  #include <asm/open_pic.h>
>  #include <asm/mpc10x.h>
> +#include <asm/ocp.h>
> +/* The OCP structure is fixed by code below, before OCP initialises.
> +   paddr depends on where the board places the EUMB.
> +    - fixed in mpc10x_bridge_init().
> +   irq depends on two things:
> +    > does the board use the EPIC at all? (PCORE does not).
> +    > is the EPIC in serial or parallel mode?
> +    - fixed in mpc10x_set_openpic().
> +*/
> +struct ocp_def core_ocp[] = {
> +	{ .vendor	= OCP_VENDOR_MOTOROLA,
> +	  .function	= OCP_FUNC_IIC,
> +	  .index	= 0,
> +	  .irq		= OCP_IRQ_NA
> +	},
> +	{ .vendor	= OCP_VENDOR_INVALID
> +	}
> +};
>  /* Set resources to match bridge memory map */
>  void __init
> @@ -213,7 +231,10 @@
>  					byte);
>  	}

Is there a reason why we dont support the 106 as well for OCP?  Do you
know if this will match for the 8241 and/or 824x?

> -	if (host_bridge != MPC10X_BRIDGE_106) {
> +	if (host_bridge == MPC10X_BRIDGE_106) {
> +		/* On-chip peripherals were introduced with the MPC107/MPC8240 */
> +		core_ocp[0].vendor = OCP_VENDOR_INVALID;
> +	} else {
>  		early_read_config_byte(hose,
>  				       0,
>  				       PCI_DEVFN(0,0),

My only other comments relate to consistency with how we are doing
things for 85xx with regards to OCP.  For example, how the config
options are handled (added a FSL_OCP) and how we update the paddr field
based on eumbar.  Also, I believe we have an ocp interface to delete an
OCP entry [which may or may not apply].

- kumar


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
