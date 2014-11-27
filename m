Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6F0AA1A09F3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Nov 2014 08:52:20 +1100 (AEDT)
Date: Thu, 27 Nov 2014 22:52:08 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: David Hildenbrand <dahi@linux.vnet.ibm.com>
Subject: Re: [RFC 0/2] Reenable might_sleep() checks for might_fault() when
 atomic
In-Reply-To: <20141127161905.7c6220ee@thinkpad-w530>
Message-ID: <alpine.DEB.2.11.1411272246110.3961@nanos>
References: <20141126151729.GB9612@redhat.com>
 <20141126152334.GA9648@redhat.com> <20141126163207.63810fcb@thinkpad-w530>
 <20141126154717.GB10568@redhat.com> <5475FAB1.1000802@de.ibm.com>
 <20141126163216.GB10850@redhat.com> <547604FC.4030300@de.ibm.com>
 <20141126170447.GC11202@redhat.com> <20141127070919.GA4390@osiris>
 <20141127090301.3ddc3077@thinkpad-w530> <20141127120441.GB4390@osiris>
 <alpine.DEB.2.11.1411271602320.3961@nanos>
 <20141127161905.7c6220ee@thinkpad-w530>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-arch@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org,
 Christian Borntraeger <borntraeger@de.ibm.com>, paulus@samba.org,
 schwidefsky@de.ibm.com, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, mingo@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 27 Nov 2014, David Hildenbrand wrote:
> > OTOH, there is no reason why we need to disable preemption over that
> > page_fault_disabled() region. There are code pathes which really do
> > not require to disable preemption for that.
> > 
> > We have that seperated in preempt-rt for obvious reasons and IIRC
> > Peter Zijlstra tried to distangle it in mainline some time ago. I
> > forgot why that never got merged.
> > 
> 
> Of course, we can completely separate that in our page fault code by doing
> pagefault_disabled() checks instead of in_atomic() checks (even in add on
> patches later).
> 
> > We tie way too much stuff on the preemption count already, which is a
> > mightmare because we have no clear distinction of protection
> > scopes. 
> 
> Although it might not be optimal, but keeping a separate counter for
> pagefault_disable() as part of the preemption counter seems to be the only
> doable thing right now.

It needs to be seperate, if it should be useful. Otherwise we just
have a extra accounting in preempt_count() which does exactly the same
thing as we have now: disabling preemption.

Now you might say, that we could mask out that part when checking
preempt_count, but that wont work on x86 as x86 has the preempt
counter as a per cpu variable and not as a per thread one.

But if you want to distangle pagefault disable from preempt disable
then you must move it to the thread, because it is a property of the
thread. preempt count is very much a per cpu counter as you can only
go through schedule when it becomes 0.

Btw, I find the x86 representation way more clear, because it
documents that preempt count is a per cpu BKL and not a magic thread
property. And sadly that is how preempt count is used ...

> I am not sure if a completely separated counter is even possible,
> increasing the size of thread_info.

And adding a ulong to thread_info is going to create exactly which
problem?

Thanks,

	tglx
