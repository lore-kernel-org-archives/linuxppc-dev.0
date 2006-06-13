Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7376867B5B
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Jun 2006 08:31:57 +1000 (EST)
In-Reply-To: <IIEEICKJLNEPBBDJICNGCEFHLDAA.chuckmeade@mindspring.com>
References: <IIEEICKJLNEPBBDJICNGCEFHLDAA.chuckmeade@mindspring.com>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4E69849F-EC8B-48C0-9036-74EDCD14B2F5@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: No ttyS device at I/O port 0xfe004500 for console
Date: Tue, 13 Jun 2006 17:32:27 -0500
To: Chuck Meade <chuckmeade@mindspring.com>
Cc: linuxppc-embedded@ozlabs.org,
	Joakim Tjernlund <joakim.tjernlund@transmode.se>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> Here you go:

Let me know if this fixes the issues you guys are seeing with your  
83xx boards.  If so, I'll clean up this patch and push it upstream.

- k

> --- mpc83xx_sys.c-ORIG	2006-06-13 17:54:36.577339832 -0400
> +++ mpc83xx_sys.c	2006-06-13 17:56:02.394293672 -0400
> @@ -136,6 +136,23 @@ struct ppc_sys_spec ppc_sys_specs[] = {
>  #endif
>  		},
>  	},
> +	{
> +		.ppc_sys_name	= "8323E",
> +		.mask		= 0xFFFF0000,
> +		.value		= 0x80620000,
> +#ifdef CONFIG_QE
> +		.num_devices	= 4,
> +#else
> +		.num_devices	= 2,
> +#endif
> +		.device_list	= (enum ppc_sys_devices[])
> +		{
> +			MPC83xx_IIC1, MPC83xx_DUART,
> +#ifdef CONFIG_QE
> +			MPC83xx_QE_UCC3, MPC83xx_QE_UCC4,
> +#endif
> +		},
> +	},
>  	{	/* default match */
>  		.ppc_sys_name	= "",
>  		.mask 		= 0x00000000,
>
>
> Regards,
> Chuck
>
