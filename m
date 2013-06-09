Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/5] powerpc/tm: Fix 32 bit non-rt signals
In-reply-to: <1370762745.14883.11.camel@pasglop>
References: <1370601390-29065-1-git-send-email-mikey@neuling.org>
 <1370601390-29065-2-git-send-email-mikey@neuling.org>
 <1370762745.14883.11.camel@pasglop>
Date: Sun, 09 Jun 2013 20:12:29 +1000
Message-ID: <24241.1370772749@ale.ozlabs.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Matt Evans <matt@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Fri, 2013-06-07 at 20:36 +1000, Michael Neuling wrote:
> > Currently sys_sigreturn() is TM unaware.  Therefore, if we take a 32 bit signal
> > without SIGINFO (non RT) inside a transaction, on signal return we don't
> > restore the signal frame correctly.
> > 
> > This checks if the signal frame being restoring is an active transaction, and
> > if so, it copies the additional state to ptregs so it can be restored.
> > 
> > Signed-off-by: Michael Neuling <mikey@neuling.org>
> > ---
> 
>  .../...
> 
> > +#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> > +	mcp = (struct mcontext __user *)&sf->mctx;
> > +	tm_mcp = (struct mcontext __user *)&sf->mctx_transact;
> > +	if (__get_user(msr_hi, &tm_mcp->mc_gregs[PT_MSR]))
> >  		goto badframe;
> > +	if MSR_TM_ACTIVE(msr_hi<<32) {
> 
> Mising ( and ). I'll apply that fix locally.
> 
> Appart from that, I suppose it's ok. I don't see any exposure
> coming from users "cooking" the tm_frame and calling sigreturn,
> so as long as we are confident userspace generally only uses
> sigreturn with frames it got from an actual signal, and doesn't
> try to "generate" frames by hand, we should be ok.

We should add a has_cpu_feature(TM) here also in case someone cooks up
an sig frame with MSR TM active, but on a non TM CPU.  This could possibly
result in a trecheckpoint on a non TM CPU hence an illegal in the
kernel.  

I'll repost.

Thanks,
Mikey
