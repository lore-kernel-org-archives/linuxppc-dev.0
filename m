Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wmbLd6bwHzDqL2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 00:46:17 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id y7so16654509pfd.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jun 2017 07:46:17 -0700 (PDT)
Date: Tue, 13 Jun 2017 00:46:02 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH 01/14] powerpc/64s: idle move soft interrupt mask logic
 into C code
Message-ID: <20170613004602.2451e44e@roar.ozlabs.ibm.com>
In-Reply-To: <20170612083727.GA10921@in.ibm.com>
References: <20170611235835.7400-1-npiggin@gmail.com>
 <20170611235835.7400-2-npiggin@gmail.com>
 <20170612083727.GA10921@in.ibm.com>
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

Hi Gautham,

Thanks for the reviews.

On Mon, 12 Jun 2017 14:07:27 +0530
Gautham R Shenoy <ego@linux.vnet.ibm.com> wrote:

> Hi Nick,
> 
> (Added Paul Mackerass to the Cc)
> On Mon, Jun 12, 2017 at 09:58:22AM +1000, Nicholas Piggin wrote:
> > This simplifies the asm and fixes irq-off tracing over sleep
> > instructions.
> > 
> > Also move powersave_nap check for POWER8 into C code, and move
> > PSSCR register value calculation for POWER9 into C.
> >  
> 
> Thanks for doing this. Only one minor comment.
> 
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> > index 98a6d07ecb5c..35cf5bb7daed 100644
> > --- a/arch/powerpc/kernel/idle_book3s.S
> > +++ b/arch/powerpc/kernel/idle_book3s.S  
> 
> [..snip..]
> 
> > @@ -109,13 +109,9 @@ core_idle_lock_held:
> >  /*
> >   * Pass requested state in r3:
> >   *	r3 - PNV_THREAD_NAP/SLEEP/WINKLE in POWER8
> > - *	   - Requested STOP state in POWER9
> > + *	   - Requested PSSCR value in POWER9
> >   *
> > - * To check IRQ_HAPPENED in r4
> > - * 	0 - don't check
> > - * 	1 - check
> > - *
> > - * Address to 'rfid' to in r5
> > + * Address of idle handler to 'rfid' to in r4
> >   */
> >  pnv_powersave_common:
> >  	/* Use r3 to pass state nap/sleep/winkle */
> > @@ -131,30 +127,7 @@ pnv_powersave_common:
> >  	std	r0,_LINK(r1)
> >  	std	r0,_NIP(r1)
> > 
> > -	/* Hard disable interrupts */
> > -	mfmsr	r9
> > -	rldicl	r9,r9,48,1
> > -	rotldi	r9,r9,16
> > -	mtmsrd	r9,1			/* hard-disable interrupts */
> > -
> > -	/* Check if something happened while soft-disabled */
> > -	lbz	r0,PACAIRQHAPPENED(r13)
> > -	andi.	r0,r0,~PACA_IRQ_HARD_DIS@l
> > -	beq	1f
> > -	cmpwi	cr0,r4,0  
> 
> There were callers to power7_nap() in the dynamic-core-split/unsplit
> which wanted nap to be forced irrespective of whether an irq was
> pending or not. With this new patch, there won't be a way to enforce
> that on POWER8.

Actually there are two APIs to sleep now, the low level one which
does not check lazy irq or nap disable is power7_idle_insn(). The
one which sets up the lazy irq state is power7_idle_type(). The
dynamic core split calls the former, so AFAIKS it should be equivalent.

Not the best names perhaps. Open to better suggestions.

Thanks,
Nick
