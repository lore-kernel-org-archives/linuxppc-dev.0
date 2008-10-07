Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8DA04DDE21
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Oct 2008 05:32:43 +1100 (EST)
In-Reply-To: <20081007161003.GA5727@yoda.jdub.homelinux.org>
References: <20081007161003.GA5727@yoda.jdub.homelinux.org>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <427A187A-5F86-419F-8D4D-636DF040E43B@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix error path in kernel_thread function
Date: Tue, 7 Oct 2008 20:30:20 +0200
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Cc: jpoimboe@us.ibm.com, paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -	cmpwi	0,r3,0		/* parent or child? */
> -	bne	1f		/* return if parent */
> +	bns+	1f		/* did system call indicate error? */
> +	neg	r3,r3		/* if so, make return code negative */
> +1:	cmpwi	0,r3,0		/* parent or child? */
> +	bne	2f		/* return if parent */
>  	li	r0,0		/* make top-level stack frame */
>  	stwu	r0,-16(r1)
>  	mtlr	r30		/* fn addr in lr */
> @@ -857,7 +859,7 @@ _GLOBAL(kernel_thread)
>  	li	r0,__NR_exit	/* exit if function returns */
>  	li	r3,0
>  	sc
> -1:	lwz	r30,8(r1)
> +2:	lwz	r30,8(r1)

You don't need to renumber the labels, FWIW.  Some people might
find it more readable this way of course (but then, you could
use actual label _names_ -- what a novel idea! ;-) )


Segher
