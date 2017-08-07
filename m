Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xQwmG1PR2zDqkF
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Aug 2017 21:49:02 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Andreas Schwab <schwab@linux-m68k.org>, linuxppc-dev@ozlabs.org
Subject: Re: 4.13-rc3: Unrecoverable exception 4100
In-Reply-To: <20170807202638.4239c2d4@roar.ozlabs.ibm.com>
References: <87vam3lhtn.fsf__12885.8019285419$1501844971$gmane$org@linux-m68k.org>
 <87fud7ktqf.fsf__17563.3519575515$1501875675$gmane$org@linux-m68k.org>
 <877eyjkt0u.fsf@linux-m68k.org> <20170805233917.72e49d2f@roar.ozlabs.ibm.com>
 <877eyfpupf.fsf@concordia.ellerman.id.au>
 <20170807202638.4239c2d4@roar.ozlabs.ibm.com>
Date: Mon, 07 Aug 2017 21:49:00 +1000
Message-ID: <87valzoaxf.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin@gmail.com> writes:
> On Mon, 07 Aug 2017 19:56:28 +1000
> Michael Ellerman <mpe@ellerman.id.au> wrote:
>> Nicholas Piggin <npiggin@gmail.com> writes:
>> > On Fri, 04 Aug 2017 21:54:57 +0200
>> > Andreas Schwab <schwab@linux-m68k.org> wrote:
>> >  
>> >> No, this is really a 4.13-rc1 regression.
>> >
>> > SLB miss with MSR[RI]=0 on
>> >
>> > lbz     r0,THREAD+THREAD_LOAD_FP(r7)
>> >
>> > Caused by bc4f65e4cf9d6cc43e0e9ba0b8648cf9201cd55f  
>> 
>> > Hmm, I'll see if something can be done, but that MSR_RI stuff in syscall
>> > exit makes things fairly difficult (and will reduce performance improvement
>> > of this patch anyway).
>> >
>> > I'm trying to work to a point where we have a soft-RI bit for these kinds of
>> > uses that would avoid all this complexity. Until then it may be best to
>> > just revert this patch.  
>> 
>> OK. Let me know in the next day or two what you want to do.
>> 
>> One option would be to load THREAD_LOAD_FP/THREAD_LOAD_VEC before we
>> turn off RI.
>
> Yeah, although that's a couple of unnecessary loads when we haven't
> used the fp regs.
>
> This path hits often on return from context switch, but for general
> syscalls it's less clear. And considering it's fairly tricky code at
> this point I'm thinking maybe just revert it for now?

Yeah OK.

Related thought, why the hell do we use 0x4100 for unrecoverable SLB.
That is really confusing now that we have AIL.

... lots of git blaming ...

Looks like it first appeard in the commit below, a classic :)

We should really change it some other value.

cheers


  37b9416e7d6efb2168119ef12ce0b093da28ea19
  Author:     Andrew Morton <akpm@osdl.org>
  AuthorDate: Thu Mar 18 14:58:53 2004 -0800
  Commit:     Linus Torvalds <torvalds@ppc970.osdl.org>
  CommitDate: Thu Mar 18 14:58:53 2004 -0800

  [PATCH] ppc64: Fix SLB reload bug
  
  From: Paul Mackerras <paulus@samba.org>
  
  Recently we found a particularly nasty bug in the segment handling in the
  ppc64 kernel.  It would only happen rarely under heavy load, but when it
  did the machine would lock up with the whole of memory filled with
  exception stack frames.
  
  The primary cause was that we were losing the translation for the kernel
  stack from the SLB, but we still had it in the ERAT for a while longer.
  Now, there is a critical region in various exception exit paths where we
  have loaded the SRR0 and SRR1 registers from GPRs and we are loading those
  GPRs and the stack pointer from the exception frame on the kernel stack.
  If we lose the ERAT entry for the kernel stack in that region, we take an
  SLB miss on the next access to the kernel stack.  Taking the exception
  overwrites the values we have put into SRR0 and SRR1, which means we lose
  state.  In fact we ended up repeating that last section of the exception
  exit path, but using the user stack pointer this time.  That caused another
  exception (or if it didn't, we loaded a new value from the user stack and
  then went around and tried to use that).  And it spiralled downwards from
  there.
  
  The patch below fixes the primary problem by making sure that we really
  never cast out the SLB entry for the kernel stack.  It also improves
  debuggability in case anything like this happens again by:
  
  - In our exception exit paths, we now check whether the RI bit in the
    SRR1 value is 0.  We already set the RI bit to 0 before starting the
    critical region, but we never checked it.  Now, if we do ever get an
    exception in one of the critical regions, we will detect it before
    returning to the critical region, and instead we will print a nasty
    message and oops.
  
  - In the exception entry code, we now check that the kernel stack pointer
    value we're about to use isn't a userspace address.  If it is, we print a
    nasty message and oops.
  
  This has been tested on G5 and pSeries (both with and without hypervisor)
  and compile-tested on iSeries.


...

+unrecov_stab:
+	EXCEPTION_PROLOG_COMMON
+	li	r6,0x4100			<- ends up in regs->trap
+	li	r20,0
+	bl	.save_remaining_regs
+1:	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	.unrecoverable_exception
+	b	1b
