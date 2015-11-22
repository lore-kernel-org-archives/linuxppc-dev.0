Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B201A1A000C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 10:07:13 +1100 (AEDT)
Message-ID: <1448233633.15853.1.camel@ellerman.id.au>
Subject: Re: [PATCH 5/8] powerpc: Restore FPU/VEC/VSX if previously used
From: Michael Ellerman <mpe@ellerman.id.au>
To: Cyril Bur <cyrilbur@gmail.com>
Cc: mikey@neuling.org, anton@samba.org, linuxppc-dev@ozlabs.org
Date: Mon, 23 Nov 2015 10:07:13 +1100
In-Reply-To: <20151123091818.576d92af@camb691>
References: <1447817215-15804-1-git-send-email-cyrilbur@gmail.com>
 <1447817215-15804-6-git-send-email-cyrilbur@gmail.com>
 <1448017264.25731.1.camel@ellerman.id.au> <20151123091818.576d92af@camb691>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-11-23 at 09:18 +1100, Cyril Bur wrote:
> On Fri, 20 Nov 2015 22:01:04 +1100
> Michael Ellerman <mpe@ellerman.id.au> wrote:
> > On Wed, 2015-11-18 at 14:26 +1100, Cyril Bur wrote:
> > > diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> > > index c8b4225..46e9869 100644
> > > --- a/arch/powerpc/kernel/entry_64.S
> > > +++ b/arch/powerpc/kernel/entry_64.S
> > > @@ -210,7 +210,54 @@ system_call:			/* label this so stack traces look sane */
> > >  	li	r11,-MAX_ERRNO
> > >  	andi.	r0,r9,(_TIF_SYSCALL_DOTRACE|_TIF_SINGLESTEP|_TIF_USER_WORK_MASK|_TIF_PERSYSCALL_MASK)
> > >  	bne-	syscall_exit_work
> > > -	cmpld	r3,r11
> > > +
> > > +	/*
> > > +	 * This is an assembly version of checks performed in restore_math()
> > > +	 * to avoid calling C unless absolutely necessary.
> > > +	 * Note: In order to simplify the assembly, if the FP or VEC registers
> > > +	 * are hot (and therefore restore_math() isn't called) the
> > > +	 * LOAD_{FP,VEC} thread counter doesn't get incremented.
> > > +	 * This is likely the best thing to do anyway because hot regs indicate
> > > +	 * that the workload is doing a lot of syscalls that can be handled
> > > +	 * quickly and without the need to touch FP or VEC regs (by the kernel).
> > > +	 * a) If this workload is long running then this is exactly what the
> > > +	 * kernel should be doing.
> > > +	 * b) If this workload isn't long running then we'll soon fall back to
> > > +	 * calling into C and the counter will be incremented regularly again
> > > +	 * anyway.
> > > +	 */
> > > +	ld	r9,PACACURRENT(r13)
> > > +	andi.	r0,r8,MSR_FP
> > > +	addi	r9,r9,THREAD
> > > +	lbz	r5,THREAD_LOAD_FP(r9)
> > > +	/*
> > > +	 * Goto 2 if !r0 && r5
> > > +	 * The cmpb works because r5 can only have bits set in the lowest byte
> > > +	 * and r0 may or may not have bit 13 set (different byte) but will have
> > > +	 * a zero low byte therefore the low bytes must differ if r5 == true
> > > +	 * and the bit 13 byte must be the same if !r0
> > > +	 */
> > > +	cmpb	r7,r0,r5  
> > 
> > cmpb is new since Power6, which means it doesn't exist on Cell -> Program Check :)
> > 
> Oops, sorry.

That's fine, there's almost no way for you to know that from reading the
documentation.

> > I'm testing a patch using crandc, but I don't like it.
> > 
> > I'm not a big fan of the logic here, it's unpleasantly complicated. Did you
> > benchmark going to C to do the checks? Or I wonder if we could just check
> > THREAD_LOAD_FP || THREAD_LOAD_VEC and if either is set we go to restore_math().
> > 
> 
> I didn't benchmark going to C mostly because you wanted to avoid calling C
> unless necessary in that path. Based off the results I got benchmarking the
> this series I expect calling C will also be in the noise of removing the
> exception.

Yeah I figured it was probably me that said "avoid C at all costs". But I've
changed my mind ;)

> > Or on the other hand we check !MSR_FP && !MSR_VEC and if so we go to
> > restore_math()?
> 
> That seems like the best check to leave in the assembly if you want to avoid
> complicated assembly in there.

Cool. If you can benchmark that that'd be great, mmkay.

cheers
