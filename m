Return-Path: <npiggin@suse.de>
Received: from mx2.suse.de (ns2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2CEC3DDE1D
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Aug 2007 12:21:25 +1000 (EST)
Date: Tue, 21 Aug 2007 04:21:20 +0200
From: Nick Piggin <npiggin@suse.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [patch 1/2] powerpc: smp_wmb speedup
Message-ID: <20070821022119.GD2909@wotan.suse.de>
References: <20070821021143.GB2909@wotan.suse.de>
	<20070821021652.GC2909@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070821021652.GC2909@wotan.suse.de>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sorry, this is patch 2/2 of course.

On Tue, Aug 21, 2007 at 04:16:52AM +0200, Nick Piggin wrote:
> This one is perhaps not as straightforward. I'm pretty limited in the types
> of powerpc machines I can test with, so I don't actually know whether this
> is the right thing to do on power5/6 etc. I can supply the simple test program
> I used if anybody is interested.
> 
> ---
> On my dual G5, lwsync is over 5 times faster than eieio when used in a simple
> test case (that actually makes real use of lwsync to provide write ordering).
> 
> This is not surprising, as it avoids the IO access synchronisation of eieio,
> and still permits the important relaxation of executing loads before stores.
> The on sub-architectures where lwsync is unavailable, eieio is retained, as
> it should be faster than the alternative full sync (eieio is a proper subset
> of sync).
> 
> Signed-off-by: Nick Piggin <npiggin@suse.de>
> 
> Index: linux-2.6/include/asm-powerpc/system.h
> ===================================================================
> --- linux-2.6.orig/include/asm-powerpc/system.h
> +++ linux-2.6/include/asm-powerpc/system.h
> @@ -43,7 +43,11 @@
>  #ifdef CONFIG_SMP
>  #define smp_mb()	mb()
>  #define smp_rmb()	__asm__ __volatile__ (__stringify(LWSYNC) : : : "memory")
> +#ifdef __SUBARCH_HAS_LWSYNC
> +#define smp_wmb()	__asm__ __volatile__ (__stringify(LWSYNC) : : : "memory")
> +#else
>  #define smp_wmb()	eieio()
> +#endif
>  #define smp_read_barrier_depends()	read_barrier_depends()
>  #else
>  #define smp_mb()	barrier()
