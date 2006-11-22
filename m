Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 93FBC67C58
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Nov 2006 05:37:04 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e31.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kAMIb13s006235
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Nov 2006 13:37:01 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kAMIb1T1540704
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Nov 2006 11:37:01 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kAMIb1iI012367
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Nov 2006 11:37:01 -0700
Subject: Re: [PATCH] CAS DFP support
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: Jake Moilanen <moilanen@austin.ibm.com>
In-Reply-To: <1164208814.1954.372.camel@goblue>
References: <1164208814.1954.372.camel@goblue>
Content-Type: text/plain
Date: Wed, 22 Nov 2006 12:36:59 -0600
Message-Id: <1164220619.8536.9.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-22-11 at 09:20 -0600, Jake Moilanen wrote:
> When booting a Power6 in compat mode, the DFP bit must be set in the
> client architecture call, or else firmware will downgrade the compliance
> to P5 compat mode, thus removing VMX and DFP instructions.
> 
> Signed-off-by: Jake Moilanen <moilanen@austin.ibm.com>

Acked-by: Will Schmidt <will_schmidt@vnet.ibm.com>

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
