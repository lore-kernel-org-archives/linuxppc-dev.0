Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 41413DDE07
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Aug 2007 06:34:55 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l72KYqLq012623
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Aug 2007 16:34:52 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l72KYqLY209628
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Aug 2007 14:34:52 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l72KYqwu013569
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Aug 2007 14:34:52 -0600
Date: Thu, 2 Aug 2007 15:34:51 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [PATCH 5/6] PowerPC 440EPx: Sequoia board support
Message-ID: <20070802153451.5a92947b@weaponx.rchland.ibm.com>
In-Reply-To: <20070730151628.GA5100@ru.mvista.com>
References: <20070730151628.GA5100@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 30 Jul 2007 19:16:28 +0400
Valentine Barshak <vbarshak@ru.mvista.com> wrote:

> diff -ruN linux.orig/arch/powerpc/kernel/cputable.c linux/arch/powerpc/kernel/cputable.c
> --- linux.orig/arch/powerpc/kernel/cputable.c	2007-07-27 20:37:10.000000000 +0400
> +++ linux/arch/powerpc/kernel/cputable.c	2007-07-27 20:44:26.000000000 +0400
> @@ -1132,6 +1132,42 @@
>  		.dcache_bsize		= 32,
>  		.platform		= "ppc440",
>  	},
> +	{ /* 440EPX  - with Security/Kasumi  */
> +		.pvr_mask		= 0xf0000fff,
> +		.pvr_value		= 0x200008D0,
> +		.cpu_name		= "440EPX - with Security/Kasumi",
> +		.cpu_features		= CPU_FTRS_44X,
> +		.cpu_user_features	= COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU, /* 440EPX has an FPU */
> +		.icache_bsize		= 32,
> +		.dcache_bsize		= 32,
> +	},
> +	{ /* 440EPX  - without Security/Kasumi  */
> +		.pvr_mask		= 0xf0000fff,
> +		.pvr_value		= 0x200008D4,
> +		.cpu_name		= "440EPX - no Security/Kasumi",
> +		.cpu_features		= CPU_FTRS_44X,
> +		.cpu_user_features	= COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU, /* 440EPX has an FPU */
> +		.icache_bsize		= 32,
> +		.dcache_bsize		= 32,
> +	},
> +	{ /* 440GRX  - with Security/Kasumi  */
> +		.pvr_mask		= 0xf0000fff,
> +		.pvr_value		= 0x200008D8,
> +		.cpu_name		= "440GRX - with Security/Kasumi",
> +		.cpu_features		= CPU_FTRS_44X,
> +		.cpu_user_features	= COMMON_USER_BOOKE, /* 440GRX has no FPU */
> +		.icache_bsize		= 32,
> +		.dcache_bsize		= 32,
> +	},
> +	{ /* 440GRX  - without Security/Kasumi  */
> +		.pvr_mask		= 0xf0000fff,
> +		.pvr_value		= 0x200008DC,
> +		.cpu_name		= "440GRX - no Security/Kasumi",
> +		.cpu_features		= CPU_FTRS_44X,
> +		.cpu_user_features	= COMMON_USER_BOOKE, /* 440GRX has no FPU */
> +		.icache_bsize		= 32,
> +		.dcache_bsize		= 32,
> +	},

Should the 440GRX PVR additions be done in a separate patch?  Or is the
PVR and cpu features truly the only difference between 440EPx and
440GRx?

> diff -ruN linux.orig/arch/powerpc/platforms/44x/sequoia.c linux/arch/powerpc/platforms/44x/sequoia.c
> --- linux.orig/arch/powerpc/platforms/44x/sequoia.c	1970-01-01 03:00:00.000000000 +0300
> +++ linux/arch/powerpc/platforms/44x/sequoia.c	2007-07-27 20:44:26.000000000 +0400
> @@ -0,0 +1,66 @@
> +/*
> + * Sequoia board specific routines
> + *
> + * Wade Farnsworth <wfarnsworth@mvista.com>
> + * Copyright 2004-2007 MontaVista Software Inc.
> + *
> + * Rewritten and ported to the merged powerpc tree:
> + * Josh Boyer <jwboyer@linux.vnet.ibm.com>
> + * Copyright 2007 IBM Corporation

I didn't really do this.  Might want to give yourself credit instead :).

josh
