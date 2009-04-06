Return-Path: <mikey@neuling.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9FF33DDE0D
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Apr 2009 16:59:40 +1000 (EST)
From: Michael Neuling <mikey@neuling.org>
To: Andreas Schwab <schwab@linux-m68k.org>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Fix ptrace compat wrapper for fpu register access 
In-reply-to: <8394.1239000531@neuling.org> 
References: <m2k568xlfg.fsf@igel.home> <13580.1238371079@neuling.org>
	<m2vdpr2wv4.fsf@igel.home> <29891.1238406751@neuling.org>
	<m2myb32rk8.fsf@igel.home> <12572.1238453639@neuling.org>
	<8394.1239000531@neuling.org>
Date: Mon, 06 Apr 2009 16:59:39 +1000
Message-ID: <11602.1239001179@neuling.org>
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <8394.1239000531@neuling.org> you wrote:
> > > >> @@ -263,7 +263,9 @@ long compat_arch_ptrace(struct task_stru
> > > >>  			ret = ptrace_put_reg(child, numReg, freg);
> > > >>  		} else {
> > > >>  			flush_fp_to_thread(child);
> > > >> -			((unsigned int *)child->thread.regs)[index] = d
> ata;
> > > >> +			((unsigned int *)child->thread.fpr)
> > > >> +				[TS_FPRWIDTH * (numReg - PT_FPR0) * 2 +
> > > >> +				 index % 2] = data;
> > > >
> > > > I think the indexing here should be the same as PEEKUSR_3264.  This
> > > > looks better but all this magic indexing makes me want to vomit.
> > > 
> > > How about this instead:
> > > 
> > > @@ -241,6 +241,7 @@ long compat_arch_ptrace(struct task_stru
> > >  	case PPC_PTRACE_POKEUSR_3264: {
> > >  		u32 index;
> > >  		u32 numReg;
> > > +		u32 *tmp;
> > >  
> > >  		ret = -EIO;
> > >  		/* Determine which register the user wants */
> > > @@ -263,7 +264,8 @@ long compat_arch_ptrace(struct task_stru
> > >  			ret = ptrace_put_reg(child, numReg, freg);
> > >  		} else {
> > >  			flush_fp_to_thread(child);
> > > -			((unsigned int *)child->thread.regs)[index] = data;
> > > +			tmp = (u32 *)child->thread.fpr[numReg - PT_FPR0];
> > > +			tmp[index % 2] = data;
> > 
> > I do like this approach better (two arrays) but there is no accounting
> > for TS_WIDTH, so I'm not sure it works.
> 
> Ok, here's another stab at trying to fix this and clean it up.  

... and now without the c++ style comments...

Mikey

powerpc: Fix ptrace compat wrapper for fpu register access

The ptrace compat wrapper mishandles access to the fpu registers.  The
PTRACE_PEEKUSR and PTRACE_POKEUSR requests miscalculate the index into
the fpr array due to the broken FPINDEX macro.  The
PPC_PTRACE_PEEKUSR_3264 request needs to use the same formula that the
native ptrace interface uses when operating on the register number (as
opposed to the 4-byte offset).  The PPC_PTRACE_POKEUSR_3264 request
didn't take TS_FPRWIDTH into account.

Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kernel/ptrace32.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

Index: linux-2.6-ozlabs/arch/powerpc/kernel/ptrace32.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/ptrace32.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/ptrace32.c
@@ -67,7 +67,8 @@ static long compat_ptrace_old(struct tas
 /* Macros to workout the correct index for the FPR in the thread struct */
 #define FPRNUMBER(i) (((i) - PT_FPR0) >> 1)
 #define FPRHALF(i) (((i) - PT_FPR0) & 1)
-#define FPRINDEX(i) TS_FPRWIDTH * FPRNUMBER(i) + FPRHALF(i)
+#define FPRINDEX(i) TS_FPRWIDTH * FPRNUMBER(i) * 2 + FPRHALF(i)
+#define FPRINDEX_3264(i) (TS_FPRWIDTH * ((i) - PT_FPR0))
 
 long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 			compat_ulong_t caddr, compat_ulong_t cdata)
@@ -168,8 +169,9 @@ long compat_arch_ptrace(struct task_stru
 		CHECK_FULL_REGS(child->thread.regs);
 		if (numReg >= PT_FPR0) {
 			flush_fp_to_thread(child);
-			tmp = ((unsigned long int *)child->thread.fpr)
-				[FPRINDEX(numReg)];
+			/* get 64 bit FPR */
+			tmp = ((u64 *)child->thread.fpr)
+				[FPRINDEX_3264(numReg)];
 		} else { /* register within PT_REGS struct */
 			tmp = ptrace_get_reg(child, numReg);
 		} 
@@ -262,8 +264,13 @@ long compat_arch_ptrace(struct task_stru
 				freg = (freg & 0xfffffffful) | (data << 32);
 			ret = ptrace_put_reg(child, numReg, freg);
 		} else {
+			u64 *tmp;
 			flush_fp_to_thread(child);
-			((unsigned int *)child->thread.regs)[index] = data;
+			/* get 64 bit FPR ... */
+			tmp = &(((u64 *)child->thread.fpr)
+				[FPRINDEX_3264(numReg)]);
+			/* ... write the 32 bit part we want */
+			((u32 *)tmp)[index % 2] = data;
 			ret = 0;
 		}
 		break;
