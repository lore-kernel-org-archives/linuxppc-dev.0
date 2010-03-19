Return-Path: <npiggin@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 41231B7D18
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Mar 2010 12:08:22 +1100 (EST)
Date: Fri, 19 Mar 2010 12:08:13 +1100
From: Nick Piggin <npiggin@suse.de>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 4/6] powerpc: Rename LWSYNC_ON_SMP to
	PPC_RELEASE_BARRIER, ISYNC_ON_SMP to PPC_ACQUIRE_BARRIER
Message-ID: <20100319010813.GF25636@laptop>
References: <20100210105728.GA3399@kryten> <20100210110236.GB3399@kryten>
	<20100210110306.GC3399@kryten> <20100210110406.GD3399@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100210110406.GD3399@kryten>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 10, 2010 at 10:04:06PM +1100, Anton Blanchard wrote:
> 
> For performance reasons we are about to change ISYNC_ON_SMP to sometimes be
> lwsync. Now that the macro name doesn't make sense, change it and LWSYNC_ON_SMP
> to better explain what the barriers are doing.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
> 
> Index: powerpc.git/arch/powerpc/include/asm/atomic.h
> ===================================================================
> --- powerpc.git.orig/arch/powerpc/include/asm/atomic.h	2010-02-10 17:12:30.264322204 +1100
> +++ powerpc.git/arch/powerpc/include/asm/atomic.h	2010-02-10 17:13:05.355571902 +1100
> @@ -49,13 +49,13 @@ static __inline__ int atomic_add_return(
>  	int t;
>  
>  	__asm__ __volatile__(
> -	LWSYNC_ON_SMP
> +	PPC_RELEASE_BARRIER
>  "1:	lwarx	%0,0,%2		# atomic_add_return\n\
>  	add	%0,%1,%0\n"
>  	PPC405_ERR77(0,%2)
>  "	stwcx.	%0,0,%2 \n\
>  	bne-	1b"
> -	ISYNC_ON_SMP
> +	PPC_ACQUIRE_BARRIER

I wonder if this shouldn't be called PPC_ISYNC_ACQUIRE_BARRIER ?

Unlike PPC_RELEASE_BARRIER, it is not an acquire barrier unless it
is used like an isync.
