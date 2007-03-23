Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17923.25798.710476.476462@cargo.ozlabs.ibm.com>
Date: Fri, 23 Mar 2007 16:25:26 +1100
From: Paul Mackerras <paulus@samba.org>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 2/8] bootwrapper: missing relocation in crt0.S
In-Reply-To: <boot-2-02.miltonm@bga.com>
References: <boot-2-00.miltonm@bga.com>
	<boot-2-02.miltonm@bga.com>
Cc: linuxppc-dev@ozlabs.org, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Milton Miller writes:

> crt0.S had provisions to provide run address relocaton to got2 and
> cache flush, but not on the bss clear or stack pointer load.  Apply
> the same fixup for them.
> 
> Signed-off-by: Milton Miller <miltonm@bga.com>
> --- 
> Compiles and links.  Stack is created within the image when linked at
> 4M and run at 0.  Did not verify bss relocation.
> 
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
>  5:	stw	r0,0(r9)

How about changing the last two instructions here to use r10 instead
of r0 so we don't need to recreate the relocation offset?

Paul.
