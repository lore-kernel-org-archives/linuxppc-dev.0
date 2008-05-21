Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2AAFDDE060
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 06:16:49 +1000 (EST)
In-Reply-To: <20080521141231.GD8897@wotan.suse.de>
References: <20080521141056.GC8897@wotan.suse.de>
	<20080521141231.GD8897@wotan.suse.de>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <376f1f8b20b4be2a5f1e57afbf245add@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch 2/2] powerpc: optimise smp_wmb
Date: Wed, 21 May 2008 22:16:31 +0200
To: Nick Piggin <npiggin@suse.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +#ifdef __SUBARCH_HAS_LWSYNC
> +#    define SMPWMB      lwsync
> +#else
> +#    define SMPWMB      eieio
> +#endif
> +
>  #define smp_mb()	mb()
>  #define smp_rmb()	rmb()
> -#define smp_wmb()	eieio()
> +#define smp_wmb()	__asm__ __volatile__ (__stringify(SMPWMB) : : 
> :"memory")

SMPWMB is used only here.  Why not just

#ifdef __SUBARCH_HAS_LWSYNC
#define smp_wmb() lwsync()
#else
#define smp_wmb() eieio()
#endif

?


Segher
