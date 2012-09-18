Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DEA072C007E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Sep 2012 15:10:09 +1000 (EST)
Message-ID: <1347944998.2386.44.camel@pasglop>
Subject: Re: [v5][PATCH 2/3] powerpc/kprobe: complete kprobe and migrate
 exception frame
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tiejun Chen <tiejun.chen@windriver.com>
Date: Tue, 18 Sep 2012 15:09:58 +1000
In-Reply-To: <1347944755.2386.43.camel@pasglop>
References: <1347875671-15838-1-git-send-email-tiejun.chen@windriver.com>
 <1347875671-15838-2-git-send-email-tiejun.chen@windriver.com>
 <1347944755.2386.43.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2012-09-18 at 15:05 +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2012-09-17 at 17:54 +0800, Tiejun Chen wrote:
> > -#ifdef CONFIG_PREEMPT
> >  	b	restore
> >  
> >  /* N.B. the only way to get here is from the beq following ret_from_except. */
> >  resume_kernel:
> > -	/* check current_thread_info->preempt_count */
> > +	/* check current_thread_info, _TIF_EMULATE_STACK_STORE */
> >  	CURRENT_THREAD_INFO(r9, r1)
> > +	lwz	r8,TI_FLAGS(r9)
> > +	andis.	r8,r8,_TIF_EMULATE_STACK_STORE@h
> > +	beq+	1f
> > +
> > +	addi	r8,r1,INT_FRAME_SIZE	/* Get the kprobed function entry */
> > +
> > +	lwz	r3,GPR1(r1)
> > +	subi	r3,r3,INT_FRAME_SIZE	/* dst: Allocate a trampoline exception frame */
> > +	mr	r4,r1			/* src:  current exception frame */
> > +	li	r5,INT_FRAME_SIZE	/* size: INT_FRAME_SIZE */
> > +	li	r6,0			/* start offset: 0 */
> > +	mr	r1,r3			/* Reroute the trampoline frame to r1 */
> > +
> > +	/* Copy from the original to the trampoline. */
> > +	li	r6,0
> 
> You just did that li r6,0 2 lines above :-) I'll fix it up manually
> while applying.

In fact the srwi can be dropped completely, we can just load r5 with the
divided value. Committed, will push later today, please test.

Cheers,
Ben.
 
