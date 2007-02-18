Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound1-dub-R.bigfish.com (mail-dub.bigfish.com
	[213.199.154.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 77A8FDDE30
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Feb 2007 12:22:32 +1100 (EST)
Message-ID: <45D7AA50.3090408@am.sony.com>
Date: Sat, 17 Feb 2007 17:22:24 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 3/3] zImage: Cleanup and improve zImage entry point
References: <20070216062739.6DFDBDDD05@ozlabs.org>
In-Reply-To: <20070216062739.6DFDBDDD05@ozlabs.org>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> Index: working-2.6/arch/powerpc/boot/crt0.S
> @@ -59,6 +60,29 @@ _zimage_start:
>  	sync
>  	isync
>  
> -	mr	r6,r1
> -	b	start
> +	/* Possibly set up a custom stack */
> +.weak	_platform_stack_top
> +	lis	r8,_platform_stack_top@ha
> +	addi	r8,r8,_platform_stack_top@l
> +	cmpwi	r8,0
> +	beq	5f
> +	lwz	r1,0(r8)


Do you need to make a stack frame here for your
call to platform_init so it will have a place when it
stores the link register?


> +5:
> +
> +	/* Clear the BSS */
> +	lis	r9,__bss_start@ha
> +	addi	r9,r9,__bss_start@l
> +	lis	r8,_end@ha
> +	addi	r8,r8,_end@l
> +	li	r0,0
> +6:	stw	r0,0(r9)
> +	addi	r9,r9,4
> +	cmplw	cr0,r9,r8
> +	blt	6b


This messed me up a bit since I had two stacks in the bss, one for each
processor thread.  By the time this was called on the primary thread the
secondary thread could already be using its stack.  I changed the secondary
thread to use a small stack in the data section, so this seems OK.


-Geoff
