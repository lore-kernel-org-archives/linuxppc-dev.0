Return-Path: <cyrilbur@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1EE571A006B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 09:18:35 +1100 (AEDT)
Received: from mail-pa0-x232.google.com (mail-pa0-x232.google.com
 [IPv6:2607:f8b0:400e:c03::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8FBE81402BC
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Nov 2015 09:18:34 +1100 (AEDT)
Received: by pacdm15 with SMTP id dm15so171425511pac.3
 for <linuxppc-dev@ozlabs.org>; Sun, 22 Nov 2015 14:18:32 -0800 (PST)
Date: Mon, 23 Nov 2015 09:18:18 +1100
From: Cyril Bur <cyrilbur@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: mikey@neuling.org, anton@samba.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 5/8] powerpc: Restore FPU/VEC/VSX if previously used
Message-ID: <20151123091818.576d92af@camb691>
In-Reply-To: <1448017264.25731.1.camel@ellerman.id.au>
References: <1447817215-15804-1-git-send-email-cyrilbur@gmail.com>
 <1447817215-15804-6-git-send-email-cyrilbur@gmail.com>
 <1448017264.25731.1.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 20 Nov 2015 22:01:04 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> On Wed, 2015-11-18 at 14:26 +1100, Cyril Bur wrote:
> > diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> > index c8b4225..46e9869 100644
> > --- a/arch/powerpc/kernel/entry_64.S
> > +++ b/arch/powerpc/kernel/entry_64.S
> > @@ -210,7 +210,54 @@ system_call:			/* label this so stack traces look sane */
> >  	li	r11,-MAX_ERRNO
> >  	andi.	r0,r9,(_TIF_SYSCALL_DOTRACE|_TIF_SINGLESTEP|_TIF_USER_WORK_MASK|_TIF_PERSYSCALL_MASK)
> >  	bne-	syscall_exit_work
> > -	cmpld	r3,r11
> > +
> > +	/*
> > +	 * This is an assembly version of checks performed in restore_math()
> > +	 * to avoid calling C unless absolutely necessary.
> > +	 * Note: In order to simplify the assembly, if the FP or VEC registers
> > +	 * are hot (and therefore restore_math() isn't called) the
> > +	 * LOAD_{FP,VEC} thread counter doesn't get incremented.
> > +	 * This is likely the best thing to do anyway because hot regs indicate
> > +	 * that the workload is doing a lot of syscalls that can be handled
> > +	 * quickly and without the need to touch FP or VEC regs (by the kernel).
> > +	 * a) If this workload is long running then this is exactly what the
> > +	 * kernel should be doing.
> > +	 * b) If this workload isn't long running then we'll soon fall back to
> > +	 * calling into C and the counter will be incremented regularly again
> > +	 * anyway.
> > +	 */
> > +	ld	r9,PACACURRENT(r13)
> > +	andi.	r0,r8,MSR_FP
> > +	addi	r9,r9,THREAD
> > +	lbz	r5,THREAD_LOAD_FP(r9)
> > +	/*
> > +	 * Goto 2 if !r0 && r5
> > +	 * The cmpb works because r5 can only have bits set in the lowest byte
> > +	 * and r0 may or may not have bit 13 set (different byte) but will have
> > +	 * a zero low byte therefore the low bytes must differ if r5 == true
> > +	 * and the bit 13 byte must be the same if !r0
> > +	 */
> > +	cmpb	r7,r0,r5  
> 
> cmpb is new since Power6, which means it doesn't exist on Cell -> Program Check :)
> 
Oops, sorry.

> I'm testing a patch using crandc, but I don't like it.
> 
> I'm not a big fan of the logic here, it's unpleasantly complicated. Did you
> benchmark going to C to do the checks? Or I wonder if we could just check
> THREAD_LOAD_FP || THREAD_LOAD_VEC and if either is set we go to restore_math().
> 

I didn't benchmark going to C mostly because you wanted to avoid calling C
unless necessary in that path. Based off the results I got benchmarking the
this series I expect calling C will also be in the noise of removing the
exception.

> Or on the other hand we check !MSR_FP && !MSR_VEC and if so we go to
> restore_math()?
> 

That seems like the best check to leave in the assembly if you want to avoid
complicated assembly in there.

> > +	cmpldi	r7,0xff0
> > +#ifdef CONFIG_ALTIVEC
> > +	beq	2f
> > +
> > +	lbz	r9,THREAD_LOAD_VEC(r9)
> > +	andis.	r0,r8,MSR_VEC@h
> > +	/* Skip (goto 3) if r0 || !r9 */
> > +	bne	3f
> > +	cmpldi	r9,0
> > +	beq 3f
> > +#else
> > +	bne 3f
> > +#endif
> > +2:	addi    r3,r1,STACK_FRAME_OVERHEAD
> > +	bl	restore_math
> > +	ld	r8,_MSR(r1)
> > +	ld	r3,RESULT(r1)
> > +	li	r11,-MAX_ERRNO
> > +
> > +3:	cmpld	r3,r11
> >  	ld	r5,_CCR(r1)
> >  	bge-	syscall_error
> >  .Lsyscall_error_cont:  
> 
> 
> cheers
> 
