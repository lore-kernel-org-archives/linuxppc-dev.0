Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DAF9067C0A
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Nov 2006 02:45:48 +1100 (EST)
In-Reply-To: <1164208814.1954.372.camel@goblue>
References: <1164208814.1954.372.camel@goblue>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <AA60A1D7-D271-4CE1-A39F-2CE9F605DB16@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] CAS DFP support
Date: Wed, 22 Nov 2006 09:46:22 -0600
To: Jake Moilanen <moilanen@austin.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 22, 2006, at 9:20 AM, Jake Moilanen wrote:

> When booting a Power6 in compat mode, the DFP bit must be set in the
> client architecture call, or else firmware will downgrade the  
> compliance
> to P5 compat mode, thus removing VMX and DFP instructions.
>
> Signed-off-by: Jake Moilanen <moilanen@austin.ibm.com>
>
> --- 2.6/arch/powerpc/kernel/prom_init.c~	2006-11-13 15:01:13.000000000
> -0600
> +++ 2.6/arch/powerpc/kernel/prom_init.c	2006-11-21 18:38:27.000000000
> -0600
> @@ -627,6 +627,7 @@ static void __init early_cmdline_parse(v
>  /* Option vector 3: processor options supported */
>  #define OV3_FP			0x80	/* floating point */
>  #define OV3_VMX			0x40	/* VMX/Altivec */
> +#define OV3_DFP			0x20	/* decimal floating point */

Can we make the flag OV3_DECFP to distinguish it from Double FP.

>
>  /* Option vector 5: PAPR/OF options supported */
>  #define OV5_LPAR		0x80	/* logical partitioning supported */
> @@ -674,7 +675,7 @@ static unsigned char ibm_architecture_ve
>  	/* option vector 3: processor options supported */
>  	3 - 2,				/* length */
>  	0,				/* don't ignore, don't halt */
> -	OV3_FP | OV3_VMX,
> +	OV3_FP | OV3_VMX | OV3_DFP,
>
>  	/* option vector 4: IBM PAPR implementation */
>  	2 - 2,				/* length */
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
