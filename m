Return-Path: <b07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 7FA85DDF93
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Mar 2007 09:01:11 +1100 (EST)
Date: Wed, 7 Mar 2007 16:01:04 -0600
From: Scott Wood <scottwood@freescale.com>
To: Anton Blanchard <anton@samba.org>
Subject: Re: speed up kernel_thread
Message-ID: <20070307220104.GA32067@ld0162-tx32.am.freescale.net>
References: <20070307212910.GA3648@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070307212910.GA3648@kryten>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 07, 2007 at 03:29:10PM -0600, Anton Blanchard wrote:
> Index: linux-2.6/arch/powerpc/kernel/misc_32.S
> ===================================================================
> --- linux-2.6.orig/arch/powerpc/kernel/misc_32.S	2007-03-07 14:27:57.000000000 -0600
> +++ linux-2.6/arch/powerpc/kernel/misc_32.S	2007-03-07 15:15:16.000000000 -0600
[snip]
> +_GLOBAL(kernel_thread_helper)
> +	li	r0,0
> +	mtctr	r15
> +	stdu	r0,-STACK_FRAME_OVERHEAD(r1)

Shouldn't this be stwu on 32-bit?

-Scott
