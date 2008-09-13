Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: add support for PAGE_SIZEs greater than 4KB for
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20080912034814.GE22288@yookeroo.seuss>
References: <1221083587-8091-1-git-send-email-yanok@emcraft.com>
	<1221083587-8091-2-git-send-email-yanok@emcraft.com>
	<20080912034814.GE22288@yookeroo.seuss>
Content-Type: text/plain
Date: Sat, 13 Sep 2008 10:46:50 -0700
Message-Id: <1221328010.7675.21.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, dzu@denx.de, wd@denx.de,
	Ilya Yanok <yanok@emcraft.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> [snip]
> > diff --git a/arch/powerpc/kernel/head_booke.h b/arch/powerpc/kernel/head_booke.h
> > index fce2df9..4f802df 100644
> > --- a/arch/powerpc/kernel/head_booke.h
> > +++ b/arch/powerpc/kernel/head_booke.h
> > @@ -20,7 +20,9 @@
> >  	beq	1f;							     \
> >  	mfspr	r1,SPRN_SPRG3;		/* if from user, start at top of   */\
> >  	lwz	r1,THREAD_INFO-THREAD(r1); /* this thread's kernel stack   */\
> > -	addi	r1,r1,THREAD_SIZE;					     \
> > +	lis	r11,THREAD_SIZE@h;					     \
> > +	ori	r11,r11,THREAD_SIZE@l;					     \
> > +	add	r1,r1,r11;
> > \
> 
> It would be nice if we could avoid the extra instruction here when the
> page sizes isn't big enough to require it.

As a matter of fact, I don't see why THREAD_SIZE should ever need that,
there is no reason to change the kernel stack size.

> >  1:	subi	r1,r1,INT_FRAME_SIZE;	/* Allocate an exception frame     */\
> >  	mr	r11,r1;							     \
> >  	stw	r10,_CCR(r11);          /* save various registers	   */\
> > @@ -112,7 +114,8 @@
> >  	andi.	r10,r10,MSR_PR;						     \
> >  	mfspr	r11,SPRN_SPRG3;		/* if from user, start at top of   */\
> >  	lwz	r11,THREAD_INFO-THREAD(r11); /* this thread's kernel stack */\
> > -	addi	r11,r11,EXC_LVL_FRAME_OVERHEAD;	/* allocate stack frame    */\
> > +	addis	r11,r11,EXC_LVL_FRAME_OVERHEAD@ha; /* allocate stack frame */\
> > +	addi	r11,r11,EXC_LVL_FRAME_OVERHEAD@l;  /* allocate stack frame */\
> 
> And here.

Same comment. That size doesn't need to change and can remain safely
below 32k

Ben.
