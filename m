Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3scr6K4XdhzDsZ8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 12:52:57 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id 21so5087299pfy.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Sep 2016 19:52:57 -0700 (PDT)
Date: Mon, 19 Sep 2016 12:52:47 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: David Laight <David.Laight@ACULAB.COM>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "paulus@samba.org" <paulus@samba.org>, "anton@samba.org" <anton@samba.org>
Subject: Re: [PATCH 04/13] powerpc: Use soft_enabled_set api to update
 paca->soft_enabled
Message-ID: <20160919125247.378b7f31@roar.ozlabs.ibm.com>
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DB00FF847@AcuExch.aculab.com>
References: <1473944523-624-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1473944523-624-5-git-send-email-maddy@linux.vnet.ibm.com>
 <20160916195302.6b2f3320@roar.ozlabs.ibm.com>
 <063D6719AE5E284EB5DD2968C1650D6DB00FF817@AcuExch.aculab.com>
 <20160916215923.08c6aa2a@roar.ozlabs.ibm.com>
 <063D6719AE5E284EB5DD2968C1650D6DB00FF847@AcuExch.aculab.com>
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

On Fri, 16 Sep 2016 13:22:24 +0000
David Laight <David.Laight@ACULAB.COM> wrote:

> From: Nicholas Piggin
> > Sent: 16 September 2016 12:59
> > On Fri, 16 Sep 2016 11:43:13 +0000
> > David Laight <David.Laight@ACULAB.COM> wrote:
> >   
> > > From: Nicholas Piggin  
> > > > Sent: 16 September 2016 10:53
> > > > On Thu, 15 Sep 2016 18:31:54 +0530
> > > > Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:
> > > >  
> > > > > Force use of soft_enabled_set() wrapper to update paca-soft_enabled
> > > > > wherever possisble. Also add a new wrapper function, soft_enabled_set_return(),
> > > > > added to force the paca->soft_enabled updates.  
> > > ...  
> > > > > diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
> > > > > index 8fad8c24760b..f828b8f8df02 100644
> > > > > --- a/arch/powerpc/include/asm/hw_irq.h
> > > > > +++ b/arch/powerpc/include/asm/hw_irq.h
> > > > > @@ -53,6 +53,20 @@ static inline notrace void soft_enabled_set(unsigned long enable)
> > > > >  	: : "r" (enable), "i" (offsetof(struct paca_struct, soft_enabled)));
> > > > >  }
> > > > >
> > > > > +static inline notrace unsigned long soft_enabled_set_return(unsigned long enable)
> > > > > +{
> > > > > +	unsigned long flags;
> > > > > +
> > > > > +	asm volatile(
> > > > > +		"lbz %0,%1(13); stb %2,%1(13)"
> > > > > +		: "=r" (flags)
> > > > > +		: "i" (offsetof(struct paca_struct, soft_enabled)),\
> > > > > +		  "r" (enable)
> > > > > +		: "memory");
> > > > > +
> > > > > +	return flags;
> > > > > +}  
> > > >
> > > > Why do you have the "memory" clobber here while soft_enabled_set() does not?  
> > >
> > > I wondered about the missing memory clobber earlier.
> > >
> > > Any 'clobber' ought to be restricted to the referenced memory area.
> > > If the structure is only referenced by r13 through 'asm volatile' it isn't needed.  
> > 
> > Well a clobber (compiler barrier) at some point is needed in irq_disable and
> > irq_enable paths, so we correctly open and close the critical section vs interrupts.
> > I just wonder about these helpers. It might be better to take the clobbers out of
> > there and add barrier(); in callers, which would make it more obvious.  
> 
> If the memory clobber is needed to synchronise with the rest of the code
> rather than just ensuring the compiler doesn't reorder accesses via r13
> then I'd add an explicit barrier() somewhere - even if in these helpers.
> 
> Potentially the helper wants a memory clobber for the (r13) area
> and a separate barrier() to ensure the interrupts are masked for the
> right code.
> Even if both are together in the same helper.

Good point. Some of the existing modification helpers don't seem to have
clobbers for modifying the r13->soft_enabled memory itself, but they do
have the memory clobber where a critical section barrier is required.

The former may not be a problem if the helpers are used very carefully,
but probably should be commented at best, if not fixed. So after Madhi's
patches, we should make all accesses go via the helper functions, so a
clobber for the soft_enabled modification may not be required (this should
be commented). I think it may be cleaner to specify the location in the
constraints, but maybe that doesn't generate the best code -- something to
investigate.

Then, I'd like to see barrier()s for interrupt critical sections placed in
the callers of these helpers, which will make the code more obvious.

Thanks,
Nick
