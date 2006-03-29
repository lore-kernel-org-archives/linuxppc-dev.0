Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net
	[151.189.21.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F1AC867A01
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Mar 2006 02:06:37 +1100 (EST)
In-Reply-To: <442AA34B.7050801@de.ibm.com>
References: <442AA34B.7050801@de.ibm.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <2691DBEE-C7E2-46A3-8455-6F98806C3102@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Extends HCALL interface for InfiniBand usage
Date: Wed, 29 Mar 2006 17:09:24 +0200
To: Heiko J Schick <schihei@de.ibm.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> below (and attached) you will find my ib_hcall patch, which extends
> the HCALL interface for InfiniBand usage. I've made the patch
> agains the lates Linux kernel snapshot (linux-2.6.16-git14) from
> kernel.org. We moved this into the common powerpc code based on
> comments we got after posting the first eHCA InfiniBand device
> driver patch.
>
> Any comments or proposals for my patch?

Looks good /an sich/, but...

>   #define H_Success    0
>   #define H_Busy        1    /* Hardware busy -- retry later */
>   #define H_Closed    2    /* Resource closed */
> +#define H_NOT_AVAILABLE    3
>   #define H_Constrained    4    /* Resource request constrained to  
> max allowed */
> +#define H_PARTIAL          5
>   #define H_InProgress   14    /* Kind of like busy */
> +#define H_PARTIAL_STORE   16
> +#define H_PAGE_REGISTERED 15

All the other defines use StudlyCaps, yours use SHOUTING_CAPS, you
might want to choose just one style (though I prefer the shouting one).

> diff -Nurpw linux-2.6.16-git14/arch/powerpc/platforms/pseries/ 
> hvCall.S.orig linux-2.6.16-git14-ib/arch/powerpc/platforms/pseries/ 
> hvCall.S.orig
> --- linux-2.6.16-git14/arch/powerpc/platforms/pseries/hvCall.S.orig	 
> 1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.16-git14-ib/arch/powerpc/platforms/pseries/ 
> hvCall.S.orig	2006-03-28 14:19:51.140018464 +0200

Erm...  you messed up here :-)

In fact, the patch is broken in more places, please make sure just to
diff the files you wanted to diff, and it looks like you posted two  
patches
in one?


Segher
