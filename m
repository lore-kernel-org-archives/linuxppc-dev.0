Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7A29F1A000C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 21:16:50 +1100 (AEDT)
Message-ID: <1455617809.31947.6.camel@ellerman.id.au>
Subject: Re: [PATCH V10 03/28] powerpc, ptrace: Enable in transaction
 NT_PRFPREG ptrace requests
From: Michael Ellerman <mpe@ellerman.id.au>
To: Denis Kirjanov <kda@linux-powerpc.org>, Anshuman Khandual
 <khandual@linux.vnet.ibm.com>
Cc: mikey@neuling.org, james.hogan@imgtec.com, avagin@openvz.org,
 Paul.Clothier@imgtec.com, davem@davemloft.net, peterz@infradead.org,
 palves@redhat.com, Ulrich.Weigand@de.ibm.com, linux-kernel@vger.kernel.org,
 shuahkh@osg.samsung.com, dhowells@redhat.com, linuxppc-dev@ozlabs.org,
 kirjanov@gmail.com, tglx@linutronix.de, oleg@redhat.com, davej@redhat.com,
 akpm@linux-foundation.org, sukadev@linux.vnet.ibm.com,
 emachado@linux.vnet.ibm.com, sam.bobroff@au1.ibm.com
Date: Tue, 16 Feb 2016 21:16:49 +1100
In-Reply-To: <CAOJe8K11GOHeMdy-LMyhUn-s5=R6xaPvtLP__+qCNH4R=NavGQ@mail.gmail.com>
References: <1455613198-5113-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1455613198-5113-4-git-send-email-khandual@linux.vnet.ibm.com>
 <CAOJe8K11GOHeMdy-LMyhUn-s5=R6xaPvtLP__+qCNH4R=NavGQ@mail.gmail.com>
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

On Tue, 2016-02-16 at 12:09 +0300, Denis Kirjanov wrote:

> On 2/16/16, Anshuman Khandual <khandual@linux.vnet.ibm.com> wrote:

> > This patch enables in transaction NT_PRFPREG ptrace requests.
> > The function fpr_get which gets the running value of all FPR
> > registers and the function fpr_set which sets the running
> > value of of all FPR registers work on the running set of FPR
> > registers whose location will be different if transaction is
> > active. This patch makes these functions adapt to situations
> > when the transaction is active.
> > 
> > Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> > ---
> >  arch/powerpc/kernel/ptrace.c | 93
> > ++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 89 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
> > index 30a03c0..547a979 100644
> > --- a/arch/powerpc/kernel/ptrace.c
> > +++ b/arch/powerpc/kernel/ptrace.c
> > @@ -358,6 +358,29 @@ static int gpr_set(struct task_struct *target, const
> > struct user_regset *regset,
> >  	return ret;
> >  }
> > 
> > +/*
> > + * When the transaction is active, 'transact_fp' holds the current running
> > + * value of all FPR registers and 'fp_state' holds the last checkpointed
> > + * value of all FPR registers for the current transaction. When transaction
> > + * is not active 'fp_state' holds the current running state of all the FPR
> > + * registers. So this function which returns the current running values of
> > + * all the FPR registers, needs to know whether any transaction is active
> > + * or not.
> > + *
> > + * Userspace interface buffer layout:
> > + *
> > + * struct data {
> > + *	u64	fpr[32];
> > + *	u64	fpscr;
> > + * };
> > + *
> > + * There are two config options CONFIG_VSX and CONFIG_PPC_TRANSACTIONAL_MEM
> > + * which determines the final code in this function. All the combinations
> > of
> > + * these two config options are possible except the one below as
> > transactional
> > + * memory config pulls in CONFIG_VSX automatically.
> > + *
> > + *	!defined(CONFIG_VSX) && defined(CONFIG_PPC_TRANSACTIONAL_MEM)
> > + */
> >  static int fpr_get(struct task_struct *target, const struct user_regset
> > *regset,
> >  		   unsigned int pos, unsigned int count,
> >  		   void *kbuf, void __user *ubuf)
> > @@ -368,14 +391,31 @@ static int fpr_get(struct task_struct *target, const
> > struct user_regset *regset,
> >  #endif
> >  	flush_fp_to_thread(target);
> > 
> > -#ifdef CONFIG_VSX
> > +#if defined(CONFIG_VSX) && defined(CONFIG_PPC_TRANSACTIONAL_MEM)
> > +	/* copy to local buffer then write that out */
> > +	if (MSR_TM_ACTIVE(target->thread.regs->msr)) {
> > +		flush_altivec_to_thread(target);
> > +		flush_tmregs_to_thread(target);
> > +		for (i = 0; i < 32 ; i++)

> use ELF_NFPREG

> > +			buf[i] = target->thread.TS_TRANS_FPR(i);
> > +		buf[32] = target->thread.transact_fp.fpscr;

#define ELF_NFPREG	33	/* includes fpscr */

So it's not what he wants here. Unless you mean that he should use i < ELF_NFPREG - 1; ?

We already have several loops over the 32 fprs, I don't think hiding the "32"
behind a macro really buys us anything.

cheers
