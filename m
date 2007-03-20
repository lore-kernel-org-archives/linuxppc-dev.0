Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id 60EA8DE0CD
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Mar 2007 07:09:05 +1100 (EST)
Date: Tue, 20 Mar 2007 13:09:53 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 5/7] bootwrapper: missing relocation in crt0.S
Message-ID: <20070320200953.GC16902@mag.az.mvista.com>
References: <boot-00.miltonm@bga.com> <boot-05.miltonm@bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <boot-05.miltonm@bga.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 19, 2007 at 02:58:05PM -0600, Milton Miller wrote:

> Index: kernel/arch/powerpc/boot/crt0.S
> ===================================================================
> --- kernel.orig/arch/powerpc/boot/crt0.S	2007-03-16 23:22:00.000000000 -0500
> +++ kernel/arch/powerpc/boot/crt0.S	2007-03-16 23:42:42.000000000 -0500
> @@ -63,21 +63,30 @@ _zimage_start:
>  	/* Clear the BSS */
>  	lis	r9,__bss_start@ha
>  	addi	r9,r9,__bss_start@l
> +	add	r9,r0,r9
>  	lis	r8,_end@ha
>  	addi	r8,r8,_end@l
> +	add	r8,r0,r8
>  	li	r0,0
                ^^
		Use some reg other than r0?

>  5:	stw	r0,0(r9)
>  	addi	r9,r9,4
>  	cmplw	cr0,r9,r8
>  	blt	5b
>  
> +	/* recreate relocation offset */
> +	lis	r9,_end@ha
> +	addi	r9,r9,_end@l
> +	subf	r0,r9,r8
> +

Wouldn't it make sense to just use another reg to zero out the bss so
you don't have to recreate the relocation offset?

Mark
