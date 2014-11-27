Return-Path: <mst@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7E4B01A089E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Nov 2014 04:32:41 +1100 (AEDT)
Date: Thu, 27 Nov 2014 19:32:18 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <dahi@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC 2/2] mm, sched: trigger might_sleep() in
 might_fault() when pagefaults are disabled
Message-ID: <20141127173218.GA30419@redhat.com>
References: <1416915806-24757-1-git-send-email-dahi@linux.vnet.ibm.com>
 <1417108217-42687-1-git-send-email-dahi@linux.vnet.ibm.com>
 <1417108217-42687-3-git-send-email-dahi@linux.vnet.ibm.com>
 <20141127172449.GA30380@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141127172449.GA30380@redhat.com>
Cc: linux-arch@vger.kernel.org, heiko.carstens@de.ibm.com,
 linux-kernel@vger.kernel.org, borntraeger@de.ibm.com, David.Laight@ACULAB.COM,
 paulus@samba.org, schwidefsky@de.ibm.com, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, tglx@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 27, 2014 at 07:24:49PM +0200, Michael S. Tsirkin wrote:
> On Thu, Nov 27, 2014 at 06:10:17PM +0100, David Hildenbrand wrote:
> > Commit 662bbcb2747c2422cf98d3d97619509379eee466 removed might_sleep() checks
> > for all user access code (that uses might_fault()).
> > 
> > The reason was to disable wrong "sleep in atomic" warnings in the following
> > scenario:
> > 	pagefault_disable();
> > 	rc = copy_to_user(...);
> > 	pagefault_enable();
> > 
> > Which is valid, as pagefault_disable() increments the preempt counter and
> > therefore disables the pagefault handler. copy_to_user() will not sleep and return
> > an invalid return code if a page is not available.
> > 
> > However, as all might_sleep() checks are removed, CONFIG_DEBUG_ATOMIC_SLEEP
> > would no longer detect the following scenario:
> > 	spin_lock(&lock);
> > 	rc = copy_to_user(...);
> > 	spin_unlock(&lock);
> > 
> > If the kernel is compiled with preemption turned on, the preempt counter would
> > be incremented and copy_to_user() would never sleep. However, with preemption
> > turned off, the preempt counter will not be touched, we will therefore sleep in
> > atomic context. We really want to enable CONFIG_DEBUG_ATOMIC_SLEEP checks for
> > user access functions again, otherwise horrible deadlocks might be hard to debug.
> > 
> > Root of all evil is that pagefault_disable() acted almost as preempt_disable(),
> > depending on preemption being turned on/off.
> > 
> > As we now have a fixed pagefault_disable() implementation in place, that uses
> > own bits in the preempt counter, we can reenable might_sleep() checks.
> > 
> > This patch reverts commit 662bbcb2747c2422cf98d3d97619509379eee466 taking care
> > of the !MMU optimization and the new pagefault_disabled() check.
> > 
> > Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
> > ---
> >  include/linux/kernel.h |  9 +++++++--
> >  mm/memory.c            | 15 ++++-----------
> >  2 files changed, 11 insertions(+), 13 deletions(-)
> > 
> > diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> > index 3d770f55..64b5f93 100644
> > --- a/include/linux/kernel.h
> > +++ b/include/linux/kernel.h
> > @@ -225,9 +225,14 @@ static inline u32 reciprocal_scale(u32 val, u32 ep_ro)
> >  	return (u32)(((u64) val * ep_ro) >> 32);
> >  }
> >  
> > -#if defined(CONFIG_MMU) && \
> > -	(defined(CONFIG_PROVE_LOCKING) || defined(CONFIG_DEBUG_ATOMIC_SLEEP))
> > +#if defined(CONFIG_MMU) && defined(CONFIG_PROVE_LOCKING)
> >  void might_fault(void);
> > +#elif defined(CONFIG_MMU) && defined(CONFIG_DEBUG_ATOMIC_SLEEP)
> > +static inline void might_fault(void)
> > +{
> > +	if (unlikely(!pagefault_disabled()))
> > +		__might_sleep(__FILE__, __LINE__, 0);
> 
> This __FILE__/__FILE__ will always point at kernel.h
> 
> You want a macro to wrap this up.
> 
> > +}
> >  #else
> >  static inline void might_fault(void) { }
> >  #endif
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 3e50383..0e59db9 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -3699,7 +3699,7 @@ void print_vma_addr(char *prefix, unsigned long ip)
> >  	up_read(&mm->mmap_sem);
> >  }
> >  
> > -#if defined(CONFIG_PROVE_LOCKING) || defined(CONFIG_DEBUG_ATOMIC_SLEEP)
> > +#ifdef CONFIG_PROVE_LOCKING
> >  void might_fault(void)
> >  {
> >  	/*
> > @@ -3711,17 +3711,10 @@ void might_fault(void)
> >  	if (segment_eq(get_fs(), KERNEL_DS))
> >  		return;
> >  
> > -	/*
> > -	 * it would be nicer only to annotate paths which are not under
> > -	 * pagefault_disable, however that requires a larger audit and
> > -	 * providing helpers like get_user_atomic.
> > -	 */
> > -	if (in_atomic())
> > -		return;
> > -
> > -	__might_sleep(__FILE__, __LINE__, 0);
> > +	if (unlikely(!pagefault_disabled()))
> > +		__might_sleep(__FILE__, __LINE__, 0);
> >  

Same here: so maybe make might_fault a wrapper
around __might_fault as well.

> > -	if (current->mm)
> > +	if (!in_atomic() && current->mm)
> >  		might_lock_read(&current->mm->mmap_sem);
> >  }
> >  EXPORT_SYMBOL(might_fault);
> > -- 
> > 1.8.5.5
