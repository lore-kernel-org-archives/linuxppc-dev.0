Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vkSBs0bBgzDq8f
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 23:16:53 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id y17so5927133pgh.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 05:16:52 -0700 (PDT)
Date: Thu, 16 Mar 2017 22:16:28 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Vaidyanathan Srinivasan
 <svaidy@linux.vnet.ibm.com>
Subject: Re: [PATCH 5/8] powerpc/64s: use PACA_THREAD_IDLE_STATE only in POWER8
Message-ID: <20170316221628.6645d0d1@roar.ozlabs.ibm.com>
In-Reply-To: <20170316115403.GC16462@in.ibm.com>
References: <20170314092349.10981-1-npiggin@gmail.com>
 <20170314092349.10981-6-npiggin@gmail.com>
 <20170316115403.GC16462@in.ibm.com>
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

On Thu, 16 Mar 2017 17:24:03 +0530
Gautham R Shenoy <ego@linux.vnet.ibm.com> wrote:

> Hi Nick,
> 
> On Tue, Mar 14, 2017 at 07:23:46PM +1000, Nicholas Piggin wrote:
> > POWER9 does not use this field, so it should be moved into the POWER8
> > code. Update the documentation in the paca struct too.
> > 
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >  arch/powerpc/include/asm/paca.h   | 12 ++++++++++--
> >  arch/powerpc/kernel/idle_book3s.S | 13 +++++++------
> >  2 files changed, 17 insertions(+), 8 deletions(-)
> > 
> > diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
> > index 708c3e592eeb..bbb59e226a9f 100644
> > --- a/arch/powerpc/include/asm/paca.h
> > +++ b/arch/powerpc/include/asm/paca.h
> > @@ -165,11 +165,19 @@ struct paca_struct {
> >  #endif
> > 
> >  #ifdef CONFIG_PPC_POWERNV
> > -	/* Per-core mask tracking idle threads and a lock bit-[L][TTTTTTTT] */
> > +	/* CPU idle fields */
> > +
> > +	/*
> > +	 * Per-core word used to synchronize between threads. See
> > +	 * asm/cpuidle.h, PNV_CORE_IDLE_*
> > +	 */
> >  	u32 *core_idle_state_ptr;
> > -	u8 thread_idle_state;		/* PNV_THREAD_RUNNING/NAP/SLEEP	*/
> >  	/* Mask to indicate thread id in core */
> >  	u8 thread_mask;
> > +
> > +	/* POWER8 specific fields */
> > +	/* PNV_THREAD_RUNNING/NAP/SLEEP	*/
> > +	u8 thread_idle_state;  
> 
> I am planning to use this in POWER9 DD1 to distinguish between a
> SRESET received when the thread was running vs when it was in stop.
> Unfortunately the SRR1[46:47] are not cleared in the former case. So
> we need a way in software to distinguish between the two.

Okay, we can skip this for now. It was not a critical part of my
patches, just a tidy up.

Thanks,
Nick
