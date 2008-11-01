Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E1835DDDEF
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Nov 2008 03:48:10 +1100 (EST)
Message-Id: <02812037-F4FA-4257-8A8A-5D0E400D1FF1@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Nick Piggin <npiggin@suse.de>
In-Reply-To: <20081101123339.GA32055@wotan.suse.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [patch] powerpc: smp_wmb lwsync optimisation fix
Date: Sat, 1 Nov 2008 11:47:58 -0500
References: <20081101123339.GA32055@wotan.suse.de>
Cc: paulus@samba.org, Anton Blanchard <anton@samba.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 1, 2008, at 7:33 AM, Nick Piggin wrote:

> A previous change removed __SUBARCH_HAS_LWSYNC define, and replaced it
> with __powerpc64__. smp_wmb() seems to be the last place not updated.

Uugh... no.. I missed the patch that removed __SUBARCH_HAS_LWSYNC, but  
thats no good.  We have LWSYNC on non-powerpc64 machines.  Will go  
figure out who forgets we have ppc32 machines :)

- k

>
>
> Signed-off-by: Nick Piggin <npiggin@suse.de>
> ---
> Index: linux-2.6/arch/powerpc/include/asm/system.h
> ===================================================================
> --- linux-2.6.orig/arch/powerpc/include/asm/system.h	2008-11-01  
> 20:31:51.000000000 +1100
> +++ linux-2.6/arch/powerpc/include/asm/system.h	2008-11-01  
> 20:32:33.000000000 +1100
> @@ -44,7 +44,7 @@
> #define AT_VECTOR_SIZE_ARCH 6 /* entries in ARCH_DLINFO */
> #ifdef CONFIG_SMP
>
> -#ifdef __SUBARCH_HAS_LWSYNC
> +#if defined(__powerpc64__)
> #    define SMPWMB      lwsync
> #else
> #    define SMPWMB      eieio
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
