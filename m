Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net
	[151.189.21.41])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CD3FDDDF73
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Apr 2007 02:41:45 +1000 (EST)
In-Reply-To: <1176382146.6379.28.camel@zod.rchland.ibm.com>
References: <1176382146.6379.28.camel@zod.rchland.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <aeef7937e978aec33074251c48dca389@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix PowerPC 750CL CPU features
Date: Thu, 12 Apr 2007 18:41:29 +0200
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> PowerPC 750CL has high BATs.  The patch below sets cpu_features to 
> match that.
> Without it, the original firmware mappings in the high BATs aren't 
> cleared
> which can cause "odd" address translations to occur.

> -		.cpu_features		= CPU_FTRS_750,
> +		.cpu_features		= CPU_FTRS_750GX,

The difference between these two is

#define CPU_FTRS_750GX  (CPU_FTR_DUAL_PLL_750FX | CPU_FTR_HAS_HIGH_BATS)
#define CPU_FTRS_750    (CPU_FTR_COMMON)

750GX excludes COMMON, which seems like a bug.  With
your change, 750CL uses DUAL_PLL_750FX; does it actually
have that feature?

Either way, it seems a good idea to create a CPU_FTRS_750CL,
the CL is an evolution of the CX, not the FX/GX (in name
at least, dunno about the gory details).

> -		.cpu_setup		= __setup_cpu_750cx,
> +		.cpu_setup		= __setup_cpu_750fx,

Same thing here.  Are you sure 750CL doesn't need
the NAP workaround?  [Is anyone sure the 750CX
actually needs it -- the comment in cpu_setup_6xx.S
doesn't instill much confidence.]


Segher
