Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vkT3V4YQYzDqYg
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 23:55:34 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id x63so5626178pfx.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 05:55:34 -0700 (PDT)
Date: Thu, 16 Mar 2017 22:55:11 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Vaidyanathan Srinivasan
 <svaidy@linux.vnet.ibm.com>
Subject: Re: [PATCH 7/8] powerpc/64s: idle do not hold reservation longer
 than required
Message-ID: <20170316225511.6bbe19a8@roar.ozlabs.ibm.com>
In-Reply-To: <20170316124328.GE16462@in.ibm.com>
References: <20170314092349.10981-1-npiggin@gmail.com>
 <20170314092349.10981-8-npiggin@gmail.com>
 <20170316124328.GE16462@in.ibm.com>
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

On Thu, 16 Mar 2017 18:13:28 +0530
Gautham R Shenoy <ego@linux.vnet.ibm.com> wrote:

> Hi Nick,
> 
> On Tue, Mar 14, 2017 at 07:23:48PM +1000, Nicholas Piggin wrote:
> > When taking the core idle state lock, grab it immediately like a
> > regular lock, rather than adding more tests in there. Holding the lock
> > keeps it stable, so there is no need to do it whole holding the
> > reservation.  
> 
> I agree with this patch. Just a minor query
> 
> > 
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >  arch/powerpc/kernel/idle_book3s.S | 20 +++++++++++---------
> >  1 file changed, 11 insertions(+), 9 deletions(-)
> > 
> > diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
> > index 1c91dc35c559..3cb75907c5c5 100644
> > --- a/arch/powerpc/kernel/idle_book3s.S
> > +++ b/arch/powerpc/kernel/idle_book3s.S
> > @@ -488,12 +488,12 @@ BEGIN_FTR_SECTION
> >  	CHECK_HMI_INTERRUPT
> >  END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
> > 
> > -	lbz	r7,PACA_THREAD_MASK(r13)
> >  	ld	r14,PACA_CORE_IDLE_STATE_PTR(r13)
> > -lwarx_loop2:
> > -	lwarx	r15,0,r14
> > -	andis.	r9,r15,PNV_CORE_IDLE_LOCK_BIT@h
> > +	lbz	r7,PACA_THREAD_MASK(r13)  
> 
> Is reversing the order of loads into r7 and r14 intentional?

Oh, yes I guess it is because we use r14 result first. I should have
mentioned it but I forgot about it. Probably they decode together,
but you might get them in different cycles.

Thanks for the review!

Thanks,
Nick
