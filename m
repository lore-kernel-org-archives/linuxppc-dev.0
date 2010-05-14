Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp08.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 18EB0B7DE9
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 14 May 2010 12:03:41 +1000 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp08.au.ibm.com (8.14.3/8.13.1) with ESMTP id o4EC3s1x001517
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 May 2010 22:03:54 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o4E1uaI91368100
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 May 2010 11:56:36 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o4E23eNB011205
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 May 2010 12:03:41 +1000
Content-Type: text/plain; charset=UTF-8
Subject: Re: [PATCH 4/4] trace,
	powerpc: Implement raw syscall tracepoints on PowerPC
From: Ian Munsie <imunsie@au1.ibm.com>
To: michael <michael@ellerman.id.au>
In-reply-to: <1273752571.8067.12.camel@concordia>
References: <1273736594-19320-1-git-send-email-imunsie@au1.ibm.com>
	<1273736594-19320-5-git-send-email-imunsie@au1.ibm.com>
	<1273752571.8067.12.camel@concordia>
Date: Fri, 14 May 2010 12:03:15 +1000
Message-Id: <1273797196-sup-1141@au1.ibm.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>, Jason Baron <jbaron@redhat.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
	Paul Mackerras <paulus@samba.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from Michael Ellerman's message of Thu May 13 22:09:31 +1000 2010:
> On Thu, 2010-05-13 at 17:43 +1000, Ian Munsie wrote:
> > From: Ian Munsie <imunsie@au.ibm.com>
> 
> Hi Ian,
> 
> Just a few comments ..
> 
> > This patch implements the raw syscall tracepoints on PowerPC required
> > for ftrace syscalls.
> 
> OK. It also adds a bunch of code under CONFIG_FTRACE_*, so does it
> implement raw syscall tracepoints _and_ hook them up to ftrace?

Yes, that's correct. CONFIG_FTRACE_SYSCALLS depends solely on, and is
the primary consumer of, HAVE_SYSCALL_TRACEPOINTS. It makes little sense
to me to provide the raw syscall tracepoints without exporting the
syscall table for ftrace syscalls to use - otherwise they would be
available to select in make config, but broken.

> > To minimise reworking existing code, I slightly re-ordered the thread
> > info flags such that the new TIF_SYSCALL_TRACEPOINT bit would still fit
> > within the 16 bits of the andi instruction's UI field.
> 
> Which andi instruction? That could use a bit more explaining.

The ones under /arch/powerpc/kernel/entry_{32,64}.S using andi to
and the _TIF_SYSCALL_T_OR_A with the thread flags to see if system call
tracing is enabled.
 
For instance, from entry_64.S:
	ld	r10,TI_FLAGS(r11)
	andi.	r11,r10,_TIF_SYSCALL_T_OR_A   <-- that one
	bne-	syscall_dotrace
.......
syscall_dotrace:
	bl	.save_nvgprs
	addi	r3,r1,STACK_FRAME_OVERHEAD
	bl	.do_syscall_trace_enter

And similarly elsewhere in the same file:
	ld	r9,TI_FLAGS(r12)
	li	r11,-_LAST_ERRNO
	andi.	r0,r9,(_TIF_SYSCALL_T_OR_A|_TIF_SINGLESTEP|_TIF_USER_WORK_MASK|_TIF_PERSYSCALL_MASK)
	bne-	syscall_exit_work
.......
syscall_exit_work:
.......
	bl	.save_nvgprs
	addi	r3,r1,STACK_FRAME_OVERHEAD
	bl	.do_syscall_trace_leave

entry_32.S contains very similar assembly to the above.

The alternative to renumbering the thread flags would be to rework the
assembly to use and. instead of andi. to avoid having to squeeze that
flag into 16 bits.

> > In the case of 64bit PowerPC, arch_syscall_addr and
> > arch_syscall_match_sym_name are overridden to allow ftrace syscalls to
> > work given the unusual system call table structure and symbol names that
> > start with a period.
> 
> Not unusual, just different (ie. better) than x86 ;)

Fair enough ;)

> > diff --git a/arch/powerpc/include/asm/syscall.h b/arch/powerpc/include/asm/syscall.h
> > index 23913e9..4098105 100644
> > --- a/arch/powerpc/include/asm/syscall.h
> > +++ b/arch/powerpc/include/asm/syscall.h
> > @@ -15,6 +15,15 @@
> >  
> >  #include <linux/sched.h>
> >  
> > +/* ftrace syscalls requires exporting the sys_call_table */
> > +#ifdef CONFIG_FTRACE_SYSCALLS
> > +#ifdef CONFIG_PPC64
> > +extern const unsigned long long *sys_call_table;
> 
> I'm not sure why this is ULL ? UL and ULL are both 64 bits (on 64bit),
> and it would save you this ifdef block and a cast in
> arch_syscall_addr().

Good point - I was just following the format from
/arch/powerpc/kernel/systbl.S, which uses pairs of .llong on PPC64 and
single .long on PPC32. Does the assembler treat .llong different from
.long on 64bit?

> > +#else /* !CONFIG_PPC64 */
> > +extern const unsigned long *sys_call_table;
> > +#endif /* CONFIG_PPC64 */
> > +#endif /* CONFIG_FTRACE_SYSCALLS */
> > +
> >  static inline long syscall_get_nr(struct task_struct *task,
> >                    struct pt_regs *regs)
> >  {
> > diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
> > index aa9d383..e7a8af2 100644
> > --- a/arch/powerpc/include/asm/thread_info.h
> > +++ b/arch/powerpc/include/asm/thread_info.h
> > @@ -110,7 +110,8 @@ static inline struct thread_info *current_thread_info(void)
> >  #define TIF_NOERROR        12    /* Force successful syscall return */
> >  #define TIF_NOTIFY_RESUME    13    /* callback before returning to user */
> >  #define TIF_FREEZE        14    /* Freezing for suspend */
> > -#define TIF_RUNLATCH        15    /* Is the runlatch enabled? */
> > +#define TIF_SYSCALL_TRACEPOINT    15    /* syscall tracepoint instrumentation */
> > +#define TIF_RUNLATCH        16    /* Is the runlatch enabled? */
> 
> I don't grok why this is good or safe, not that it isn't but please tell
> me why it is :)

Ok - now I could be wrong on this, but AFAICT the flags are only used
internally within the kernel by name and not exported to userspace (ie,
not part of the kernel ABI).  That specific flag is only set and cleared
within /arch/powerpc/kernel/process.c so recompiling the kernel should
be sufficient to change those instances of TIF_RUNLATCH from 15 to 16.

> > diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
> > index 8773263..9c404bb 100644
> > --- a/arch/powerpc/kernel/Makefile
> > +++ b/arch/powerpc/kernel/Makefile
> > @@ -98,6 +98,7 @@ obj64-$(CONFIG_AUDIT)        += compat_audit.o
> >  
> >  obj-$(CONFIG_DYNAMIC_FTRACE)    += ftrace.o
> >  obj-$(CONFIG_FUNCTION_GRAPH_TRACER)    += ftrace.o
> > +obj-$(CONFIG_FTRACE_SYSCALLS)    += ftrace.o
> 
> You're following the existing pattern there, but it's a little odd.
> Seems like those three config options should really all depend on
> something common and that should trigger the build of ftrace.c

There isn't anything in the arch specific ftrace.c that depends purely on
ftrace. It's all stuff that depends on the above specific ftrace options
that have some arch specific implementation.

> > diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
> > index ce1f3e4..b34171e 100644
> > --- a/arch/powerpc/kernel/ftrace.c
> > +++ b/arch/powerpc/kernel/ftrace.c
> > @@ -22,6 +22,7 @@
> >  #include <asm/cacheflush.h>
> >  #include <asm/code-patching.h>
> >  #include <asm/ftrace.h>
> > +#include <asm/syscall.h>
> >  
> > 
> >  #ifdef CONFIG_DYNAMIC_FTRACE
> > @@ -600,3 +601,15 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr)
> >      }
> >  }
> >  #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
> > +
> > +#if defined(CONFIG_FTRACE_SYSCALLS) && defined(CONFIG_PPC64)
> 
> Does 32-bit just work using the existing routines? Or do we not support
> it on 32-bit (though that's not what your Kconfig change said).

It should work with the existing routines - I still need to test this on
feugo to make sure, but following from /arch/powerpc/kernel/systbl.S it
seems that the symbol names should match the function names and the
system call table is a trivial lookup table, both of which will work
with the generic implementation.

> > +unsigned long __init arch_syscall_addr(int nr)
> > +{
> > +    return (unsigned long)sys_call_table[nr*2];
> 
> That's the cast I was referring to.

Ok, I'll change that in v2.

> > +}
> > +
> > +inline bool arch_syscall_match_sym_name(const char *sym, const char *name)
> > +{
> > +    return (!strcmp(sym + 4, name + 3));
> 
> So the +4 is to skip ".sys" and the +3 is to skip "sys" ? That could use
> a comment IMHO :)

Yeah that's right, I'll add a comment there to clarify that.

> 
> cheers


Thanks for the feedback,
-Ian
