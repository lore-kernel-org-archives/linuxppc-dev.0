Return-Path: <cyrilbur@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sJ8s42ftFzDrJy
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Aug 2016 09:28:40 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id hh10so8827830pac.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 16:28:40 -0700 (PDT)
Message-ID: <1471908513.758.12.camel@gmail.com>
Subject: Re: [PATCH] powerpc: signals: Discard transaction state from signal
 frames
From: Cyril Bur <cyrilbur@gmail.com>
To: Simon Guo <wei.guo.simon@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org,
 mpe@ellerman.id.au,  mikey@neuling.org, Laurent Dufour
 <ldufour@linux.vnet.ibm.com>
Date: Tue, 23 Aug 2016 09:28:33 +1000
In-Reply-To: <20160820100307.GA6731@simonLocalRHEL7.x64>
References: <20160822073206.1342-1-cyrilbur@gmail.com>
 <20160820100307.GA6731@simonLocalRHEL7.x64>
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

On Sat, 2016-08-20 at 18:03 +0800, Simon Guo wrote:
> Hi Cyril,
> On Mon, Aug 22, 2016 at 05:32:06PM +1000, Cyril Bur wrote:
> > 
> > diff --git a/arch/powerpc/kernel/signal_32.c
> > b/arch/powerpc/kernel/signal_32.c
> > index b6aa378..31e4e15 100644
> > --- a/arch/powerpc/kernel/signal_32.c
> > +++ b/arch/powerpc/kernel/signal_32.c
> > @@ -1226,7 +1226,19 @@ long sys_rt_sigreturn(int r3, int r4, int
> > r5, int r6, int r7, int r8,
> >  		(regs->gpr[1] + __SIGNAL_FRAMESIZE + 16);
> >  	if (!access_ok(VERIFY_READ, rt_sf, sizeof(*rt_sf)))
> >  		goto bad;
> > +
> >  #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> > +	/*
> > +	 * If there is a transactional/suspended state then throw
> > it away.
> > +	 * The purpose of a sigreturn is to destroy all traces of
> > the
> > +	 * signal frame, this includes any transactional state
> > created
> > +	 * within in.
> > +	 * The cause is not important as there will never be a
> > +	 * recheckpoint so it's not user visible.
> > +	 */
> > +	if (MSR_TM_ACTIVE(mfmsr()))
> > +		tm_reclaim_current(0);
> > +
> Maybe a little picky here:
> Per my understanding, the TRANSACTIONAL state will be failed in
> system
> call common entry. The only expected state to prevent here is
> SUSPEND 
> state.

That is the case yes.

> Should we use MSR_TM_SUSPENDED(mfmsr()) here and BUG_ON
> MSR_TM_TRANSACTIONAL(mfmsr())?  -- If it is transactional state,
> something
>  is wrong with kernel. 
> 

I'm happy to change it to MSR_TM_SUSPENDED.

We should decide what the result of getting here with TRANSACTIONAL is.
I see two posibilities:
1. the reclaim will solve the problem and we can continue, there is
obviously a bug somewhere else but we think it doesn't affect us here
and we *hope* it will be contained elsewhere.
2. We think seeing TRANSACTIONAL here means we have a problem that is
going to lead to corruption of state such that bad data will propage,
in which case I think a BUG_ON() is a good idea.

I'm more in favour of 1, there doesn't seem to be any other way to get
here but through syscall entry, this kind of bug should probably be
caught more generally. In that case I would say that checking ACTIVE is
good since we know that we WILL blow up if ACTIVE and we don't do a
reclaim.

Maybe now that I'm thinking about it, change it to SUSPENDED but no
BUG_ON(), as I just said, we'll do a Bad Thing anyway, which will
reveal the problem.

I have to send another version anyway as it doesn't seem to be working
for 32bit.

> Others looks good to me.
> 
> Thanks,
> - Simon
