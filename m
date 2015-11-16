Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AFD541A0191
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2015 20:51:09 +1100 (AEDT)
Message-ID: <1447667468.2191.8.camel@ellerman.id.au>
Subject: Re: [PATCH 5/5] powerpc/tm: Clarify get_tm_stackpointer() by
 renaming it
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michael Neuling <mikey@neuling.org>, benh@kernel.crashing.org
Cc: sam.bobroff@au1.ibm.com, linuxppc-dev@ozlabs.org, paulus@samba.org
Date: Mon, 16 Nov 2015 20:51:08 +1100
In-Reply-To: <1447390652-28355-5-git-send-email-mikey@neuling.org>
References: <1447390652-28355-1-git-send-email-mikey@neuling.org>
 <1447390652-28355-5-git-send-email-mikey@neuling.org>
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

On Fri, 2015-11-13 at 15:57 +1100, Michael Neuling wrote:
> get_tm_stackpointer() gets the userspace stack pointer which the
> signal frame will be written from pt_regs.  To do this it performs a
> tm_reclaim to access the checkpointed stack pointer.
> 
> Doing a tm_reclaim is an important operation which changes the machine
> state.  Doing this in the wrong state or an attempt to do it twice it can
> result in a TM Bad Thing exception.  Hence we should make it clearer
> that this function is making this change.
> 
> This patch renames this function to make it clearer what's happening
> when calling this function.  No functional change.

Urgh. It's really not very pretty.

> @@ -1001,7 +1001,8 @@ int handle_rt_signal32(struct ksignal *ksig, sigset_t *oldset,
>  
>  	/* Set up Signal Frame */
>  	/* Put a Real Time Context onto stack */
> -	rt_sf = get_sigframe(ksig, get_tm_stackpointer(regs), sizeof(*rt_sf), 1);
> +	rt_sf = get_sigframe(ksig, get_tm_stackpointer_and_reclaim(regs),
> +			     sizeof(*rt_sf), 1);
>  	addr = rt_sf;
>  	if (unlikely(rt_sf == NULL))
>  		goto badframe;

I think partly we just have the wrong abstraction here. We try to hide TM
inside get_tm_stackpointer(), but then we confused ourselves by hiding the
reclaim in there. And all three call sites then *also* have an #ifdef
CONFIG_PPC_TRANSACTIONAL_MEM block in the function, so we failed at hiding TM
anyway.


I wonder if we'd be better off relying more on the compiler to elide code
behind an always false boolean, something like:

int handle_rt_signal64(struct ksignal *ksig, sigset_t *set, struct pt_regs *regs)
{
	struct rt_sigframe __user *frame;
	unsigned long sp, newsp = 0;
	bool tm_active;
	long err = 0;

	tm_active = msr_tm_active(regs->msr);
	if (tm_active)
		sp = tm_reclaim_sp(regs);
	else
		sp = regs->gpr[1];

	frame = get_sigframe(ksig, sp, sizeof(*frame), 0);
	if (unlikely(frame == NULL))
		goto badframe;

	...

-#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-	if (MSR_TM_ACTIVE(regs->msr)) {
+	if (tm_active) {
		/* The ucontext_t passed to userland points to the second
		 * ucontext_t (for transactional state) with its uc_link ptr.
		 */
		err |= __put_user(&frame->uc_transact, &frame->uc.uc_link);
		err |= setup_tm_sigcontexts(&frame->uc.uc_mcontext,


We'd need to move more of the __put_user() logic into a helper, because
uc_transact doesn't exist when TM is disabled.

cheers
