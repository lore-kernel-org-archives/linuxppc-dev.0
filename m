Return-Path: <mst@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9A1AF1A09BD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Nov 2014 18:40:36 +1100 (AEDT)
Date: Thu, 27 Nov 2014 09:40:11 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [RFC 0/2] Reenable might_sleep() checks for might_fault() when
 atomic
Message-ID: <20141127074011.GB8644@redhat.com>
References: <20141126110504.511b733a@thinkpad-w530>
 <20141126151729.GB9612@redhat.com>
 <20141126152334.GA9648@redhat.com>
 <20141126163207.63810fcb@thinkpad-w530>
 <20141126154717.GB10568@redhat.com> <5475FAB1.1000802@de.ibm.com>
 <20141126163216.GB10850@redhat.com> <547604FC.4030300@de.ibm.com>
 <20141126170447.GC11202@redhat.com> <20141127070919.GA4390@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141127070919.GA4390@osiris>
Cc: linux-arch@vger.kernel.org, David Hildenbrand <dahi@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>,
 paulus@samba.org, schwidefsky@de.ibm.com, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, mingo@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 27, 2014 at 08:09:19AM +0100, Heiko Carstens wrote:
> On Wed, Nov 26, 2014 at 07:04:47PM +0200, Michael S. Tsirkin wrote:
> > On Wed, Nov 26, 2014 at 05:51:08PM +0100, Christian Borntraeger wrote:
> > > > But this one was > giving users in field false positives.
> > > 
> > > So lets try to fix those, ok? If we cant, then tough luck.
> > 
> > Sure.
> > I think the simplest way might be to make spinlock disable
> > premption when CONFIG_DEBUG_ATOMIC_SLEEP is enabled.
> > 
> > As a result, userspace access will fail and caller will
> > get a nice error.
> 
> Yes, _userspace_ now sees unpredictable behaviour, instead of that the
> kernel emits a big loud warning to the console.

So I don't object to adding more debugging at all.
Sure, would be nice.

But the fix is not an unconditional might_sleep
within might_fault, this would trigger false positives.

Rather, detect that you took a spinlock
without disabling preemption.


> Please consider this simple example:
> 
> int bar(char __user *ptr)
> {
> 	...
> 	if (copy_to_user(ptr, ...)
> 		return -EFAULT;
> 	...
> }
> 
> SYSCALL_DEFINE1(foo, char __user *, ptr)
> {
> 	int rc;
> 
> 	...
> 	rc = bar(ptr);
> 	if (rc)
> 		goto out;
> 	...
> out:
> 	return rc;	
> }
> 
> The above simple system call just works fine, with and without your change,
> however if somebody (incorrectly) changes sys_foo() to the code below:
> 
> 	spin_lock(&lock);
> 	rc = bar(ptr);
> 	if (rc)
> 		goto out;
> out:
> 	spin_unlock(&lock);
> 	return rc;	
> 
> Broken code like above used to generate warnings. With your change we won't
> see any warnings anymore. Instead we get random and bad behaviour:
> 
> For !CONFIG_PREEMPT if the page at ptr is not mapped, the kernel will see
> a fault, potentially schedule and potentially deadlock on &lock.
> Without _any_ warning anymore.
> 
> For CONFIG_PREEMPT if the page at ptr is mapped, everthing works. However if
> the page is not mapped, userspace now all of the sudden will see an invalid(!)
> -EFAULT return code, instead of that the kernel resolved the page fault.
> Yes, the kernel can't resolve the fault since we hold a spinlock. But the
> above bogus code did give warnings to give you an idea that something probably
> is not correct.
> 
> Who on earth is supposed to debug crap like this???
> 
> What we really want is:
> 
> Code like
> 	spin_lock(&lock);
> 	if (copy_to_user(...))
> 		rc = ...
> 	spin_unlock(&lock);
> really *should* generate warnings like it did before.
> 
> And *only* code like
> 	spin_lock(&lock);
> 	page_fault_disable();
> 	if (copy_to_user(...))
> 		rc = ...
> 	page_fault_enable();
> 	spin_unlock(&lock);
> should not generate warnings, since the author hopefully knew what he did.
> 
> We could achieve that by e.g. adding a couple of pagefault disabled bits
> within current_thread_info()->preempt_count, which would allow
> pagefault_disable() and pagefault_enable() to modify a different part of
> preempt_count than it does now, so there is a way to tell if pagefaults have
> been explicitly disabled or are just a side effect of preemption being
> disabled.
> This would allow might_fault() to restore its old sane behaviour for the
> !page_fault_disabled() case.

Exactly. I agree, that would be a useful debugging tool.

In fact this comment in mm/memory.c hints at this:
         * it would be nicer only to annotate paths which are not under
         * pagefault_disable,

it further says
	 * however that requires a larger audit and
         * providing helpers like get_user_atomic.

but I think that what you outline is a better way to do this.

-- 
MST
