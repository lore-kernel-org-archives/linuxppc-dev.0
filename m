Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 54846DE240
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 01:27:08 +1000 (EST)
Subject: Re: [patch 1/2] powerpc: rmb fix
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nick Piggin <npiggin@suse.de>
In-Reply-To: <20080521141056.GC8897@wotan.suse.de>
References: <20080521141056.GC8897@wotan.suse.de>
Content-Type: text/plain
Date: Wed, 21 May 2008 11:27:03 -0400
Message-Id: <1211383623.8297.197.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2008-05-21 at 16:10 +0200, Nick Piggin wrote:
> Hi,
> 
> I'm sure I've sent these patches before, but I can't remember why they
> weren't merged. They still seem obviously correct to me.

We should already do all that's needed in our IO accessors no ?

> --
> 
> lwsync is explicitly defined not to have any effect on the ordering of
> accesses to device memory, so it cannot be used for rmb(). sync appears
> to be the only barrier which fits the bill.
> 
> Signed-off-by: Nick Piggin <npiggin@suse.de>
> ---
> Index: linux-2.6/include/asm-powerpc/system.h
> ===================================================================
> --- linux-2.6.orig/include/asm-powerpc/system.h
> +++ linux-2.6/include/asm-powerpc/system.h
> @@ -34,7 +34,7 @@
>   * SMP since it is only used to order updates to system memory.
>   */
>  #define mb()   __asm__ __volatile__ ("sync" : : : "memory")
> -#define rmb()  __asm__ __volatile__ (__stringify(LWSYNC) : : : "memory")
> +#define rmb()  __asm__ __volatile__ ("sync" : : : "memory")
>  #define wmb()  __asm__ __volatile__ ("sync" : : : "memory")
>  #define read_barrier_depends()  do { } while(0)
>  
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
