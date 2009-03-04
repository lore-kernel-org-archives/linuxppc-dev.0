Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8F2FADE19D
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Mar 2009 15:04:19 +1100 (EST)
Subject: Re: [patch 2/2] powerpc: replace isync with lwsync
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nick Piggin <npiggin@suse.de>
In-Reply-To: <20090219172133.GK1747@wotan.suse.de>
References: <20090219171229.GJ1747@wotan.suse.de>
	<20090219172133.GK1747@wotan.suse.de>
Content-Type: text/plain
Date: Wed, 04 Mar 2009 15:04:11 +1100
Message-Id: <1236139451.6696.10.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2009-02-19 at 18:21 +0100, Nick Piggin wrote:
> OK, here is this patch again. You didn't think I'd let a 2% performance
> improvement be forgotten? :)
> 
> Anyway, patch won't work well on architecture without lwsync, but I won't
> bother fixing that kind of thing and making it merge worthy until you
> guys say something positive about it.
> 
> 20 runs of tbench on the G5
> 
> unpatched AVG=920.37 STD=2.36
>   patched AVG=938.89 STD=3.33
> 
> (throughput in MB/s) This is a 1.9% throughput increase.

Definitely worth it believe. We could use a macro that uses michael new
improvements on the CPU features code pathing so that the isync gets
changed to lwsync on some CPUs based on the availability of it.

Cheers,
Ben.
 
> ---
> 
> Index: linux-2.6/arch/powerpc/include/asm/atomic.h
> ===================================================================
> --- linux-2.6.orig/arch/powerpc/include/asm/atomic.h	2009-02-20 01:50:20.000000000 +1100
> +++ linux-2.6/arch/powerpc/include/asm/atomic.h	2009-02-20 02:13:22.000000000 +1100
> @@ -55,7 +55,7 @@
>  	PPC405_ERR77(0,%2)
>  "	stwcx.	%0,0,%2 \n\
>  	bne-	1b"
> -	ISYNC_ON_SMP
> +	LWSYNC_ON_SMP
>  	: "=&r" (t)
>  	: "r" (a), "r" (&v->counter)
>  	: "cc", "memory");
> @@ -91,7 +91,7 @@
>  	PPC405_ERR77(0,%2)
>  "	stwcx.	%0,0,%2 \n\
>  	bne-	1b"
> -	ISYNC_ON_SMP
> +	LWSYNC_ON_SMP
>  	: "=&r" (t)
>  	: "r" (a), "r" (&v->counter)
>  	: "cc", "memory");
> @@ -125,7 +125,7 @@
>  	PPC405_ERR77(0,%1)
>  "	stwcx.	%0,0,%1 \n\
>  	bne-	1b"
> -	ISYNC_ON_SMP
> +	LWSYNC_ON_SMP
>  	: "=&r" (t)
>  	: "r" (&v->counter)
>  	: "cc", "xer", "memory");
> @@ -169,7 +169,7 @@
>  	PPC405_ERR77(0,%1)
>  "	stwcx.	%0,0,%1\n\
>  	bne-	1b"
> -	ISYNC_ON_SMP
> +	LWSYNC_ON_SMP
>  	: "=&r" (t)
>  	: "r" (&v->counter)
>  	: "cc", "xer", "memory");
> @@ -202,7 +202,7 @@
>  	PPC405_ERR77(0,%2)
>  "	stwcx.	%0,0,%1 \n\
>  	bne-	1b \n"
> -	ISYNC_ON_SMP
> +	LWSYNC_ON_SMP
>  "	subf	%0,%2,%0 \n\
>  2:"
>  	: "=&r" (t)
> @@ -235,7 +235,7 @@
>  	PPC405_ERR77(0,%1)
>  "	stwcx.	%0,0,%1\n\
>  	bne-	1b"
> -	ISYNC_ON_SMP
> +	LWSYNC_ON_SMP
>  	"\n\
>  2:"	: "=&b" (t)
>  	: "r" (&v->counter)
> @@ -291,7 +291,7 @@
>  	add	%0,%1,%0\n\
>  	stdcx.	%0,0,%2 \n\
>  	bne-	1b"
> -	ISYNC_ON_SMP
> +	LWSYNC_ON_SMP
>  	: "=&r" (t)
>  	: "r" (a), "r" (&v->counter)
>  	: "cc", "memory");
> @@ -325,7 +325,7 @@
>  	subf	%0,%1,%0\n\
>  	stdcx.	%0,0,%2 \n\
>  	bne-	1b"
> -	ISYNC_ON_SMP
> +	LWSYNC_ON_SMP
>  	: "=&r" (t)
>  	: "r" (a), "r" (&v->counter)
>  	: "cc", "memory");
> @@ -357,7 +357,7 @@
>  	addic	%0,%0,1\n\
>  	stdcx.	%0,0,%1 \n\
>  	bne-	1b"
> -	ISYNC_ON_SMP
> +	LWSYNC_ON_SMP
>  	: "=&r" (t)
>  	: "r" (&v->counter)
>  	: "cc", "xer", "memory");
> @@ -399,7 +399,7 @@
>  	addic	%0,%0,-1\n\
>  	stdcx.	%0,0,%1\n\
>  	bne-	1b"
> -	ISYNC_ON_SMP
> +	LWSYNC_ON_SMP
>  	: "=&r" (t)
>  	: "r" (&v->counter)
>  	: "cc", "xer", "memory");
> @@ -425,7 +425,7 @@
>  	blt-	2f\n\
>  	stdcx.	%0,0,%1\n\
>  	bne-	1b"
> -	ISYNC_ON_SMP
> +	LWSYNC_ON_SMP
>  	"\n\
>  2:"	: "=&r" (t)
>  	: "r" (&v->counter)
> @@ -458,7 +458,7 @@
>  	add	%0,%2,%0 \n"
>  "	stdcx.	%0,0,%1 \n\
>  	bne-	1b \n"
> -	ISYNC_ON_SMP
> +	LWSYNC_ON_SMP
>  "	subf	%0,%2,%0 \n\
>  2:"
>  	: "=&r" (t)
> Index: linux-2.6/arch/powerpc/include/asm/bitops.h
> ===================================================================
> --- linux-2.6.orig/arch/powerpc/include/asm/bitops.h	2009-02-20 01:50:20.000000000 +1100
> +++ linux-2.6/arch/powerpc/include/asm/bitops.h	2009-02-20 02:13:22.000000000 +1100
> @@ -139,7 +139,7 @@
>  	PPC405_ERR77(0,%3)
>  	PPC_STLCX "%1,0,%3 \n"
>  	"bne-	1b"
> -	ISYNC_ON_SMP
> +	LWSYNC_ON_SMP
>  	: "=&r" (old), "=&r" (t)
>  	: "r" (mask), "r" (p)
>  	: "cc", "memory");
> @@ -160,7 +160,7 @@
>  	PPC405_ERR77(0,%3)
>  	PPC_STLCX "%1,0,%3 \n"
>  	"bne-	1b"
> -	ISYNC_ON_SMP
> +	LWSYNC_ON_SMP
>  	: "=&r" (old), "=&r" (t)
>  	: "r" (mask), "r" (p)
>  	: "cc", "memory");
> @@ -182,7 +182,7 @@
>  	PPC405_ERR77(0,%3)
>  	PPC_STLCX "%1,0,%3 \n"
>  	"bne-	1b"
> -	ISYNC_ON_SMP
> +	LWSYNC_ON_SMP
>  	: "=&r" (old), "=&r" (t)
>  	: "r" (mask), "r" (p)
>  	: "cc", "memory");
> @@ -204,7 +204,7 @@
>  	PPC405_ERR77(0,%3)
>  	PPC_STLCX "%1,0,%3 \n"
>  	"bne-	1b"
> -	ISYNC_ON_SMP
> +	LWSYNC_ON_SMP
>  	: "=&r" (old), "=&r" (t)
>  	: "r" (mask), "r" (p)
>  	: "cc", "memory");
> Index: linux-2.6/arch/powerpc/include/asm/futex.h
> ===================================================================
> --- linux-2.6.orig/arch/powerpc/include/asm/futex.h	2009-02-20 01:50:20.000000000 +1100
> +++ linux-2.6/arch/powerpc/include/asm/futex.h	2009-02-20 02:13:22.000000000 +1100
> @@ -97,7 +97,7 @@
>          PPC405_ERR77(0,%2)
>  "2:     stwcx.  %4,0,%2\n\
>          bne-    1b\n"
> -        ISYNC_ON_SMP
> +        LWSYNC_ON_SMP
>  "3:	.section .fixup,\"ax\"\n\
>  4:	li	%0,%5\n\
>  	b	3b\n\
> Index: linux-2.6/arch/powerpc/include/asm/spinlock.h
> ===================================================================
> --- linux-2.6.orig/arch/powerpc/include/asm/spinlock.h	2009-02-20 01:50:20.000000000 +1100
> +++ linux-2.6/arch/powerpc/include/asm/spinlock.h	2009-02-20 02:13:22.000000000 +1100
> @@ -65,7 +65,7 @@
>  	bne-		2f\n\
>  	stwcx.		%1,0,%2\n\
>  	bne-		1b\n\
> -	isync\n\
> +	lwsync\n\
>  2:"	: "=&r" (tmp)
>  	: "r" (token), "r" (&lock->slock)
>  	: "cr0", "memory");
> @@ -193,7 +193,7 @@
>  	PPC405_ERR77(0,%1)
>  "	stwcx.		%0,0,%1\n\
>  	bne-		1b\n\
> -	isync\n\
> +	lwsync\n\
>  2:"	: "=&r" (tmp)
>  	: "r" (&rw->lock)
>  	: "cr0", "xer", "memory");
> @@ -217,7 +217,7 @@
>  	PPC405_ERR77(0,%1)
>  "	stwcx.		%1,0,%2\n\
>  	bne-		1b\n\
> -	isync\n\
> +	lwsync\n\
>  2:"	: "=&r" (tmp)
>  	: "r" (token), "r" (&rw->lock)
>  	: "cr0", "memory");
> Index: linux-2.6/arch/powerpc/include/asm/system.h
> ===================================================================
> --- linux-2.6.orig/arch/powerpc/include/asm/system.h	2009-02-20 02:09:41.000000000 +1100
> +++ linux-2.6/arch/powerpc/include/asm/system.h	2009-02-20 02:13:22.000000000 +1100
> @@ -246,7 +246,7 @@
>  	PPC405_ERR77(0,%2)
>  "	stwcx.	%3,0,%2 \n\
>  	bne-	1b"
> -	ISYNC_ON_SMP
> +	LWSYNC_ON_SMP
>  	: "=&r" (prev), "+m" (*(volatile unsigned int *)p)
>  	: "r" (p), "r" (val)
>  	: "cc", "memory");
> @@ -289,7 +289,7 @@
>  	PPC405_ERR77(0,%2)
>  "	stdcx.	%3,0,%2 \n\
>  	bne-	1b"
> -	ISYNC_ON_SMP
> +	LWSYNC_ON_SMP
>  	: "=&r" (prev), "+m" (*(volatile unsigned long *)p)
>  	: "r" (p), "r" (val)
>  	: "cc", "memory");
> @@ -382,7 +382,7 @@
>  	PPC405_ERR77(0,%2)
>  "	stwcx.	%4,0,%2\n\
>  	bne-	1b"
> -	ISYNC_ON_SMP
> +	LWSYNC_ON_SMP
>  	"\n\
>  2:"
>  	: "=&r" (prev), "+m" (*p)
> @@ -427,7 +427,7 @@
>  	bne-	2f\n\
>  	stdcx.	%4,0,%2\n\
>  	bne-	1b"
> -	ISYNC_ON_SMP
> +	LWSYNC_ON_SMP
>  	"\n\
>  2:"
>  	: "=&r" (prev), "+m" (*p)
> Index: linux-2.6/arch/powerpc/include/asm/synch.h
> ===================================================================
> --- linux-2.6.orig/arch/powerpc/include/asm/synch.h	2009-02-20 01:50:20.000000000 +1100
> +++ linux-2.6/arch/powerpc/include/asm/synch.h	2009-02-20 02:13:22.000000000 +1100
> @@ -38,7 +38,7 @@
>  
>  #ifdef CONFIG_SMP
>  #define ISYNC_ON_SMP	"\n\tisync\n"
> -#define LWSYNC_ON_SMP	stringify_in_c(LWSYNC) "\n"
> +#define LWSYNC_ON_SMP	"\n\t" stringify_in_c(LWSYNC) "\n"
>  #else
>  #define ISYNC_ON_SMP
>  #define LWSYNC_ON_SMP
> Index: linux-2.6/arch/powerpc/include/asm/mutex.h
> ===================================================================
> --- linux-2.6.orig/arch/powerpc/include/asm/mutex.h	2009-02-20 01:50:20.000000000 +1100
> +++ linux-2.6/arch/powerpc/include/asm/mutex.h	2009-02-20 02:13:22.000000000 +1100
> @@ -15,7 +15,7 @@
>  	PPC405_ERR77(0,%1)
>  "	stwcx.	%3,0,%1\n\
>  	bne-	1b"
> -	ISYNC_ON_SMP
> +	LWSYNC_ON_SMP
>  	"\n\
>  2:"
>  	: "=&r" (t)
> @@ -35,7 +35,7 @@
>  	PPC405_ERR77(0,%1)
>  "	stwcx.	%0,0,%1\n\
>  	bne-	1b"
> -	ISYNC_ON_SMP
> +	LWSYNC_ON_SMP
>  	: "=&r" (t)
>  	: "r" (&v->counter)
>  	: "cc", "memory");
> Index: linux-2.6/arch/powerpc/mm/hash_low_64.S
> ===================================================================
> --- linux-2.6.orig/arch/powerpc/mm/hash_low_64.S	2009-02-20 01:50:20.000000000 +1100
> +++ linux-2.6/arch/powerpc/mm/hash_low_64.S	2009-02-20 02:13:22.000000000 +1100
> @@ -110,7 +110,7 @@
>  	/* Write the linux PTE atomically (setting busy) */
>  	stdcx.	r30,0,r6
>  	bne-	1b
> -	isync
> +	lwsync
>  
>  	/* Step 2:
>  	 *
> @@ -393,7 +393,7 @@
>  	/* Write the linux PTE atomically (setting busy) */
>  	stdcx.	r30,0,r6
>  	bne-	1b
> -	isync
> +	lwsync
>  
>  	/* Step 2:
>  	 *
> @@ -734,7 +734,7 @@
>  	/* Write the linux PTE atomically (setting busy) */
>  	stdcx.	r30,0,r6
>  	bne-	1b
> -	isync
> +	lwsync
>  
>  	/* Step 2:
>  	 *
