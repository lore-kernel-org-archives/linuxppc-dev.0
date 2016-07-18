Return-Path: <cyrilbur@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rt5FL73LczDqDy
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jul 2016 11:29:42 +1000 (AEST)
Received: from mail-pf0-f193.google.com (mail-pf0-f193.google.com
 [209.85.192.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rt5FL1xd5z9s9d
 for <linuxppc-dev@ozlabs.org>; Mon, 18 Jul 2016 11:29:42 +1000 (AEST)
Received: by mail-pf0-f193.google.com with SMTP id h186so1939046pfg.2
 for <linuxppc-dev@ozlabs.org>; Sun, 17 Jul 2016 18:29:42 -0700 (PDT)
Date: Mon, 18 Jul 2016 11:28:30 +1000
From: Cyril Bur <cyrilbur@gmail.com>
To: Simon Guo <simonguo@linux.vnet.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@ozlabs.org, mikey@neuling.org, Anshuman
 Khandual <khandual@linux.vnet.ibm.com>, Simon Guo <wei.guo.simon@gmail.com>
Subject: Re: [PATCH 3/5] powerpc: tm: Always use fp_state and vr_state to
 store live registers
Message-ID: <20160718112830.71ee878c@camb691>
In-Reply-To: <20160717032543.GB3843@simonLocalRHEL7.x64>
References: <20160608040036.13064-1-cyrilbur@gmail.com>
 <20160608040036.13064-4-cyrilbur@gmail.com>
 <20160717032543.GB3843@simonLocalRHEL7.x64>
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

On Sun, 17 Jul 2016 11:25:43 +0800
Simon Guo <simonguo@linux.vnet.ibm.com> wrote:

> Hi Cyril,
> On Wed, Jun 08, 2016 at 02:00:34PM +1000, Cyril Bur wrote:
> > @@ -917,24 +907,10 @@ static inline void tm_recheckpoint_new_task(struct task_struct *new)
> >  		 "(new->msr 0x%lx, new->origmsr 0x%lx)\n",
> >  		 new->pid, new->thread.regs->msr, msr);
> >  
> > -	/* This loads the checkpointed FP/VEC state, if used */
> >  	tm_recheckpoint(&new->thread, msr);
> >  
> > -	/* This loads the speculative FP/VEC state, if used */
> > -	if (msr & MSR_FP) {
> > -		do_load_up_transact_fpu(&new->thread);
> > -		new->thread.regs->msr |=
> > -			(MSR_FP | new->thread.fpexc_mode);
> > -	}
> > -#ifdef CONFIG_ALTIVEC
> > -	if (msr & MSR_VEC) {
> > -		do_load_up_transact_altivec(&new->thread);
> > -		new->thread.regs->msr |= MSR_VEC;
> > -	}
> > -#endif
> > -	/* We may as well turn on VSX too since all the state is restored now */
> > -	if (msr & MSR_VSX)
> > -		new->thread.regs->msr |= MSR_VSX;
> > +	/* Won't restore math get called later? */
> > +	restore_math(new->thread.regs);  
> 
> I have some question for the "restore_math" in tm_recheckpoint_new_task().
> 

Please ask!

> Per my understanding, now after tm_recheckpoint, the fp_state content
> is obsolete.  However restore_math() will try to restore FP/Vec/VSX state 
> from fp_state, (orginally it is right, since fp_state was the valid
> checkpointed state and consistent with FP register ). Should we remove
> the restore_math() here?
> 

The aim of this patch is to ensure that pt_regs, fp_state and vr_state always
hold a threads 'live' registers. So, after a recheckpoint fp_state is where the
the state should be. tm_reclaim_thread() does a save_all() before doing the
reclaim.

This means that the call to restore_math() is a replacement for all deleted
lines above it.

I added it here because I'd prefer to be safe but I left that comment in
because I suspect restore_math() will be called later and we can get away with
not calling it here.

> And, should the thread's MSR now set FP bit in tm_recheckpoint(), to 
> indicate that FP register content is "fresh" in contrast to thread.fp_state?
> 

I'm not sure what you mean by 'fresh'. You do highlight that we'll have to be
sure that the MSR bits are off (so that restore_math() doesn't assume the
registers are already loaded) which makes me think that tm_reclaim_thread()
should be doing a giveup_all(), I'll fix that.

I hope that helps,

Cyril

> Please correct me if I am wrong.
> 
> Thanks,
> - Simon
> 
