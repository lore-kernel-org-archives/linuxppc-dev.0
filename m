Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/9] powerpc: Add macros to access floating point
	registers in thread_struct.
In-reply-to: <0DCAAAC2-52AB-4704-98C0-4E9235C3AC88@kernel.crashing.org> 
References: <20080624105750.0610170295@localhost.localdomain>
	<0DCAAAC2-52AB-4704-98C0-4E9235C3AC88@kernel.crashing.org>
Date: Wed, 25 Jun 2008 10:25:18 +1000
Message-ID: <13124.1214353518@neuling.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



In message <0DCAAAC2-52AB-4704-98C0-4E9235C3AC88@kernel.crashing.org> you wrote
:
> 
> On Jun 24, 2008, at 5:57 AM, Michael Neuling wrote:
> 
> > We are going to change where the floating point registers are stored
> > in the thread_struct, so in preparation add some macros to access the
> > floating point registers.  Update all code to use these new macros.
> >
> > Signed-off-by: Michael Neuling <mikey@neuling.org>
> > ---
> >
> > arch/powerpc/kernel/align.c      |    6 ++--
> > arch/powerpc/kernel/process.c    |    5 ++-
> > arch/powerpc/kernel/ptrace.c     |   14 +++++----
> > arch/powerpc/kernel/ptrace32.c   |   14 +++++++--
> > arch/powerpc/kernel/softemu8xx.c |    4 +-
> > arch/powerpc/math-emu/math.c     |   56 ++++++++++++++++++ 
> > +--------------------
> > include/asm-powerpc/ppc_asm.h    |    5 ++-
> > include/asm-powerpc/processor.h  |    3 ++
> > 8 files changed, 61 insertions(+), 46 deletions(-)
> >
> 
> > Index: linux-2.6-ozlabs/arch/powerpc/kernel/ptrace.c
> > ===================================================================
> > --- linux-2.6-ozlabs.orig/arch/powerpc/kernel/ptrace.c
> > +++ linux-2.6-ozlabs/arch/powerpc/kernel/ptrace.c
> > @@ -218,10 +218,10 @@ static int fpr_get(struct task_struct *t
> > 	flush_fp_to_thread(target);
> >
> > 	BUILD_BUG_ON(offsetof(struct thread_struct, fpscr) !=
> > -		     offsetof(struct thread_struct, fpr[32]));
> > +		     offsetof(struct thread_struct, TS_FPR(32)));
> >
> > 	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
> > -				   &target->thread.fpr, 0, -1);
> > +				   target->thread.fpr, 0, -1);
> 
> is there a reason we can drop the '&'? (I'm only look at this as a  
> textual diff, not at what the code is trying to do).

Oops.. I'll fix.

> >
> > }
> >
> > static int fpr_set(struct task_struct *target, const struct  
> > user_regset *regset,
> > @@ -231,10 +231,10 @@ static int fpr_set(struct task_struct *t
> > 	flush_fp_to_thread(target);
> >
> > 	BUILD_BUG_ON(offsetof(struct thread_struct, fpscr) !=
> > -		     offsetof(struct thread_struct, fpr[32]));
> > +		     offsetof(struct thread_struct, TS_FPR(32)));
> >
> > 	return user_regset_copyin(&pos, &count, &kbuf, &ubuf,
> > -				  &target->thread.fpr, 0, -1);
> > +				  target->thread.fpr, 0, -1);
> 
> ditto.
> >
> > }
> >
> >
> > @@ -728,7 +728,8 @@ long arch_ptrace(struct task_struct *chi
> > 			tmp = ptrace_get_reg(child, (int) index);
> > 		} else {
> > 			flush_fp_to_thread(child);
> > -			tmp = ((unsigned long *)child->thread.fpr)[index - PT_F
PR0];
> > +			tmp = ((unsigned long *)child->thread.fpr)
> > +				[TS_FPRSPACING * (index - PT_FPR0)];
> > 		}
> > 		ret = put_user(tmp,(unsigned long __user *) data);
> > 		break;
> > @@ -755,7 +756,8 @@ long arch_ptrace(struct task_struct *chi
> > 			ret = ptrace_put_reg(child, index, data);
> > 		} else {
> > 			flush_fp_to_thread(child);
> > -			((unsigned long *)child->thread.fpr)[index - PT_FPR0] =
 data;
> > +			((unsigned long *)child->thread.fpr)
> > +				[TS_FPRSPACING * (index - PT_FPR0)] = data;
> > 			ret = 0;
> > 		}
> > 		break;
> > Index: linux-2.6-ozlabs/arch/powerpc/kernel/ptrace32.c
> > ===================================================================
> > --- linux-2.6-ozlabs.orig/arch/powerpc/kernel/ptrace32.c
> > +++ linux-2.6-ozlabs/arch/powerpc/kernel/ptrace32.c
> > @@ -64,6 +64,11 @@ static long compat_ptrace_old(struct tas
> > 	return -EPERM;
> > }
> >
> > +/* Macros to workout the correct index for the FPR in the thread  
> > struct */
> > +#define FPRNUMBER(i) (((i) - PT_FPR0) >> 1)
> > +#define FPRHALF(i) (((i) - PT_FPR0) % 2)
> > +#define FPRINDEX(i) TS_FPRSPACING * FPRNUMBER(i) + FPRHALF(i)
> 
> we should either use this macros in both ptrace.c and ptrace32.c or  
> drop them

This set of macros is really only 32 bit specific since in ptrace 32 we
access the registers as 32 bits (hence needing two accesses to get the
full 64 bits), but in ptrace 64, we access them as 64 bit (hence only 1
access).

Theses macros are really only here to deal with the unique indexing into
the thread struct that we now need to do for ptrace 32 only (thanks to
paulus who pointed out I got this wrong first time).

The only macro here that could potentially be reused is FPRNUMER(i).  

> 
> >
> > +
> > long compat_arch_ptrace(struct task_struct *child, compat_long_t  
> > request,
> > 			compat_ulong_t caddr, compat_ulong_t cdata)
> > {
> > @@ -122,7 +127,8 @@ long compat_arch_ptrace(struct task_stru
> > 			 * to be an array of unsigned int (32 bits) - the
> > 			 * index passed in is based on this assumption.
> > 			 */
> > -			tmp = ((unsigned int *)child->thread.fpr)[index - PT_FP
R0];
> > +			tmp = ((unsigned int *)child->thread.fpr)
> > +				[FPRINDEX(index)];
> > 		}
> > 		ret = put_user((unsigned int)tmp, (u32 __user *)data);
> > 		break;
> > @@ -162,7 +168,8 @@ long compat_arch_ptrace(struct task_stru
> > 		CHECK_FULL_REGS(child->thread.regs);
> > 		if (numReg >= PT_FPR0) {
> > 			flush_fp_to_thread(child);
> > -			tmp = ((unsigned long int *)child->thread.fpr)[numReg -
 PT_FPR0];
> > +			tmp = ((unsigned long int *)child->thread.fpr)
> > +				[FPRINDEX(numReg)];
> > 		} else { /* register within PT_REGS struct */
> > 			tmp = ptrace_get_reg(child, numReg);
> > 		}
> > @@ -217,7 +224,8 @@ long compat_arch_ptrace(struct task_stru
> > 			 * to be an array of unsigned int (32 bits) - the
> > 			 * index passed in is based on this assumption.
> > 			 */
> > -			((unsigned int *)child->thread.fpr)[index - PT_FPR0] = 
data;
> > +			((unsigned int *)child->thread.fpr)
> > +				[TS_FPRSPACING * (index - PT_FPR0)] = data;
> 
> is there a reason this isn't FPRINDEX(index)?

Oops, fixed.  

Can you tell I only tested peek not poke user :-D 

> 
> - k
> 
