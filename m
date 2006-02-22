Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B1ACE679E7
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Feb 2006 11:52:14 +1100 (EST)
In-Reply-To: <200602212339.SAA1138491@shell.TheWorld.com>
References: <200602212339.SAA1138491@shell.TheWorld.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4A2CF403-20CC-4AE9-B955-9BA2E92A5474@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: fix altivec_unavailable_exception Oopses
Date: Tue, 21 Feb 2006 18:52:16 -0600
To: Alan Curry <pacman@TheWorld.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 21, 2006, at 5:39 PM, Alan Curry wrote:

> altivec_unavailable_exception is called without setting r3... it  
> looks like
> the r3 that actually gets passed in as struct pt_regs *regs is the
> undisturbed value of r3 at the time the altivec instruction was  
> encountered.
> The user actually gets to choose the pt_regs printed in the Oops!
>
> After applying the following patch to 2.6.16-rc4, I can no longer  
> cause an
> Oops by executing an altivec instruction with CONFIG_ALTIVEC=n. The  
> same
> change would probably also be good for arch/ppc/kernel/head.S to  
> fix the same
> Oops in 2.6.15.4, though I haven't tested that.
>
> --- arch/powerpc/kernel/head_32.S.orig	2006-02-21  
> 15:58:18.000000000 -0500
> +++ arch/powerpc/kernel/head_32.S	2006-02-21 15:59:23.000000000 -0500
> @@ -714,6 +714,7 @@
>  #ifdef CONFIG_ALTIVEC
>  	bne	load_up_altivec		/* if from user, just load it up */
>  #endif /* CONFIG_ALTIVEC */
> +	addi	r3,r1,STACK_FRAME_OVERHEAD
>  	EXC_XFER_EE_LITE(0xf20, altivec_unavailable_exception)
>
>  PerformanceMonitor:

Would you mine providing a patch for arch/ppc/kernel/head.S and  
adding a signed-off-by line.

- k
