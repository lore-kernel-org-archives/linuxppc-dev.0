Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wmxbs3pclzDqL5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 14:28:57 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5D4SaDe046893
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 00:28:54 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b1xphstkp-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 00:28:54 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Mon, 12 Jun 2017 22:28:53 -0600
Date: Tue, 13 Jun 2017 09:58:49 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Gautham R Shenoy <ego@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH 01/14] powerpc/64s: idle move soft interrupt mask logic
 into C code
Reply-To: ego@linux.vnet.ibm.com
References: <20170611235835.7400-1-npiggin@gmail.com>
 <20170611235835.7400-2-npiggin@gmail.com>
 <20170612083727.GA10921@in.ibm.com>
 <20170613004602.2451e44e@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170613004602.2451e44e@roar.ozlabs.ibm.com>
Message-Id: <20170613042849.GI10921@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 13, 2017 at 12:46:02AM +1000, Nicholas Piggin wrote:
> Hi Gautham,
> 
> Thanks for the reviews.
> 
> On Mon, 12 Jun 2017 14:07:27 +0530
> Gautham R Shenoy <ego@linux.vnet.ibm.com> wrote:
> 
> > Hi Nick,
> > 
> > (Added Paul Mackerass to the Cc)
> > On Mon, Jun 12, 2017 at 09:58:22AM +1000, Nicholas Piggin wrote:
> > > This simplifies the asm and fixes irq-off tracing over sleep
> > > instructions.
> > > 
> > > Also move powersave_nap check for POWER8 into C code, and move
> > > PSSCR register value calculation for POWER9 into C.
> > >  
> > 
> > Thanks for doing this. Only one minor comment.
> > 
> > > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > > ---
> > > index 98a6d07ecb5c..35cf5bb7daed 100644
> > > --- a/arch/powerpc/kernel/idle_book3s.S
> > > +++ b/arch/powerpc/kernel/idle_book3s.S  
> > 
> > [..snip..]
> > 
> > > @@ -109,13 +109,9 @@ core_idle_lock_held:
> > >  /*
> > >   * Pass requested state in r3:
> > >   *	r3 - PNV_THREAD_NAP/SLEEP/WINKLE in POWER8
> > > - *	   - Requested STOP state in POWER9
> > > + *	   - Requested PSSCR value in POWER9
> > >   *
> > > - * To check IRQ_HAPPENED in r4
> > > - * 	0 - don't check
> > > - * 	1 - check
> > > - *
> > > - * Address to 'rfid' to in r5
> > > + * Address of idle handler to 'rfid' to in r4
> > >   */
> > >  pnv_powersave_common:
> > >  	/* Use r3 to pass state nap/sleep/winkle */
> > > @@ -131,30 +127,7 @@ pnv_powersave_common:
> > >  	std	r0,_LINK(r1)
> > >  	std	r0,_NIP(r1)
> > > 
> > > -	/* Hard disable interrupts */
> > > -	mfmsr	r9
> > > -	rldicl	r9,r9,48,1
> > > -	rotldi	r9,r9,16
> > > -	mtmsrd	r9,1			/* hard-disable interrupts */
> > > -
> > > -	/* Check if something happened while soft-disabled */
> > > -	lbz	r0,PACAIRQHAPPENED(r13)
> > > -	andi.	r0,r0,~PACA_IRQ_HARD_DIS@l
> > > -	beq	1f
> > > -	cmpwi	cr0,r4,0  
> > 
> > There were callers to power7_nap() in the dynamic-core-split/unsplit
> > which wanted nap to be forced irrespective of whether an irq was
> > pending or not. With this new patch, there won't be a way to enforce
> > that on POWER8.
> 
> Actually there are two APIs to sleep now, the low level one which
> does not check lazy irq or nap disable is power7_idle_insn(). The
> one which sets up the lazy irq state is power7_idle_type(). The
> dynamic core split calls the former, so AFAIKS it should be
> equivalent.

Ah, I see. Yes, my bad. I didn't check which one we are calling in the
dynamic split case.

Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

> 
> Not the best names perhaps. Open to better suggestions.
> 
> Thanks,
> Nick
> 

--
Thanks and Regards
gautham.
