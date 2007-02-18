Return-Path: <dgibson@ozlabs.org>
Date: Sun, 18 Feb 2007 18:23:10 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [PATCH 3/3] zImage: Cleanup and improve zImage entry point
Message-ID: <20070218072310.GB1859@localhost.localdomain>
References: <20070216062739.6DFDBDDD05@ozlabs.org>
	<45D7AA50.3090408@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45D7AA50.3090408@am.sony.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Feb 17, 2007 at 05:22:24PM -0800, Geoff Levand wrote:
> David Gibson wrote:
> > Index: working-2.6/arch/powerpc/boot/crt0.S
> > @@ -59,6 +60,29 @@ _zimage_start:
> >  	sync
> >  	isync
> >  
> > -	mr	r6,r1
> > -	b	start
> > +	/* Possibly set up a custom stack */
> > +.weak	_platform_stack_top
> > +	lis	r8,_platform_stack_top@ha
> > +	addi	r8,r8,_platform_stack_top@l
> > +	cmpwi	r8,0
> > +	beq	5f
> > +	lwz	r1,0(r8)
> 
> 
> Do you need to make a stack frame here for your
> call to platform_init so it will have a place when it
> stores the link register?

Err... isn't the called function responsible for setting up its own
stack frame if necessary.  I thought all that was needed was for r1 to
point to some free space.

> > +5:
> > +
> > +	/* Clear the BSS */
> > +	lis	r9,__bss_start@ha
> > +	addi	r9,r9,__bss_start@l
> > +	lis	r8,_end@ha
> > +	addi	r8,r8,_end@l
> > +	li	r0,0
> > +6:	stw	r0,0(r9)
> > +	addi	r9,r9,4
> > +	cmplw	cr0,r9,r8
> > +	blt	6b
> 
> 
> This messed me up a bit since I had two stacks in the bss, one for each
> processor thread.  By the time this was called on the primary thread the
> secondary thread could already be using its stack.  I changed the secondary
> thread to use a small stack in the data section, so this seems OK.

Hrm... if you're entering with multiple threads and stacks, you're
probably a prime candidate for providing your own zimage_start,
instead of using this code.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
