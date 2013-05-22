Return-Path: <mst@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 0B2E22C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 May 2013 06:37:59 +1000 (EST)
Date: Wed, 22 May 2013 23:36:45 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 10/10] kernel: might_fault does not imply might_sleep
Message-ID: <20130522203645.GA28296@redhat.com>
References: <cover.1368702323.git.mst@redhat.com>
 <1f85dc8e6a0149677563a2dfb4cef9a9c7eaa391.1368702323.git.mst@redhat.com>
 <20130516184041.GP19669@dyad.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130516184041.GP19669@dyad.programming.kicks-ass.net>
Cc: linux-m32r-ja@ml.linux-m32r.org, kvm@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 David Howells <dhowells@redhat.com>, linux-mm@kvack.org,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 linux-arch@vger.kernel.org, linux-am33-list@redhat.com,
 Hirokazu Takata <takata@linux-m32r.org>, x86@kernel.org,
 Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
 microblaze-uclinux@itee.uq.edu.au, Chris Metcalf <cmetcalf@tilera.com>,
 rostedt@goodmis.org, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>,
 linux-m32r@ml.linux-m32r.org, linux-kernel@vger.kernel.org,
 Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 16, 2013 at 08:40:41PM +0200, Peter Zijlstra wrote:
> On Thu, May 16, 2013 at 02:16:10PM +0300, Michael S. Tsirkin wrote:
> > There are several ways to make sure might_fault
> > calling function does not sleep.
> > One is to use it on kernel or otherwise locked memory - apparently
> > nfs/sunrpc does this. As noted by Ingo, this is handled by the
> > migh_fault() implementation in mm/memory.c but not the one in
> > linux/kernel.h so in the current code might_fault() schedules
> > differently depending on CONFIG_PROVE_LOCKING, which is an undesired
> > semantical side effect.
> > 
> > Another is to call pagefault_disable: in this case the page fault
> > handler will go to fixups processing and we get an error instead of
> > sleeping, so the might_sleep annotation is a false positive.
> > vhost driver wants to do this now in order to reuse socket ops
> > under a spinlock (and fall back on slower thread handler
> > on error).
> 
> Are you using the assumption that spin_lock() implies preempt_disable() implies
> pagefault_disable()? Note that this assumption isn't valid for -rt where the
> spinlock becomes preemptible but we'll not disable pagefaults.
> 
> > Address both issues by:
> > 	- dropping the unconditional call to might_sleep
> > 	  from the fast might_fault code in linux/kernel.h
> > 	- checking for pagefault_disable() in the
> > 	  CONFIG_PROVE_LOCKING implementation
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  include/linux/kernel.h |  1 -
> >  mm/memory.c            | 14 +++++++++-----
> >  2 files changed, 9 insertions(+), 6 deletions(-)
> > 
> > diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> > index e96329c..322b065 100644
> > --- a/include/linux/kernel.h
> > +++ b/include/linux/kernel.h
> > @@ -198,7 +198,6 @@ void might_fault(void);
> >  #else
> >  static inline void might_fault(void)
> >  {
> > -	might_sleep();
> 
> This removes potential resched points for PREEMPT_VOLUNTARY -- was that
> intentional?

OK so I'm thinking of going back to this idea:
it has the advantage of being very simple,
and just might make some workloads faster
if they do lots of copy_XX_user in a loop.

Will have to be tested of course - anyone
has objections?

> >  }
> >  #endif
> >  
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 6dc1882..1b8327b 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -4222,13 +4222,17 @@ void might_fault(void)
> >  	if (segment_eq(get_fs(), KERNEL_DS))
> >  		return;
> >  
> > -	might_sleep();
> >  	/*
> > -	 * it would be nicer only to annotate paths which are not under
> > -	 * pagefault_disable, however that requires a larger audit and
> > -	 * providing helpers like get_user_atomic.
> > +	 * It would be nicer to annotate paths which are under preempt_disable
> > +	 * but not under pagefault_disable, however that requires a new flag
> > +	 * for differentiating between the two.
> 
> -rt has this, pagefault_disable() doesn't change the preempt count but pokes
> at task_struct::pagefault_disable.
> 
> >  	 */
> > -	if (!in_atomic() && current->mm)
> > +	if (in_atomic())
> > +		return;
> > +
> > +	might_sleep();
> > +
> > +	if (current->mm)
> >  		might_lock_read(&current->mm->mmap_sem);
> >  }
> >  EXPORT_SYMBOL(might_fault);
> > -- 
> > MST
