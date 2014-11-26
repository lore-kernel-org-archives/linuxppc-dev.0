Return-Path: <mst@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 24B411A0027
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Nov 2014 03:32:38 +1100 (AEDT)
Date: Wed, 26 Nov 2014 18:32:16 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [RFC 0/2] Reenable might_sleep() checks for might_fault() when
 atomic
Message-ID: <20141126163216.GB10850@redhat.com>
References: <1416915806-24757-1-git-send-email-dahi@linux.vnet.ibm.com>
 <20141126070258.GA25523@redhat.com>
 <20141126110504.511b733a@thinkpad-w530>
 <20141126151729.GB9612@redhat.com>
 <20141126152334.GA9648@redhat.com>
 <20141126163207.63810fcb@thinkpad-w530>
 <20141126154717.GB10568@redhat.com> <5475FAB1.1000802@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5475FAB1.1000802@de.ibm.com>
Cc: linux-arch@vger.kernel.org, heiko.carstens@de.ibm.com,
 linux-kernel@vger.kernel.org, David Hildenbrand <dahi@linux.vnet.ibm.com>,
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

On Wed, Nov 26, 2014 at 05:07:13PM +0100, Christian Borntraeger wrote:
> Am 26.11.2014 um 16:47 schrieb Michael S. Tsirkin:
> > On Wed, Nov 26, 2014 at 04:32:07PM +0100, David Hildenbrand wrote:
> >>> On Wed, Nov 26, 2014 at 05:17:29PM +0200, Michael S. Tsirkin wrote:
> >>>> On Wed, Nov 26, 2014 at 11:05:04AM +0100, David Hildenbrand wrote:
> >>>>>> What's the path you are trying to debug?
> >>>>>
> >>>>> Well, we had a problem where we held a spin_lock and called
> >>>>> copy_(from|to)_user(). We experienced very random deadlocks that took some guy
> >>>>> almost a week to debug. The simple might_sleep() check would have showed this
> >>>>> error immediately.
> >>>>
> >>>> This must have been a very old kernel.
> >>>> A modern kernel will return an error from copy_to_user.
> >>>> Which is really the point of the patch you are trying to revert.
> >>>
> >>> That's assuming you disabled preemption. If you didn't, and take
> >>> a spinlock, you have deadlocks even without userspace access.
> >>>
> >>
> >> (Thanks for your resent, my first email was sent directly to you ... grml)
> >>
> >> This is what happened on our side (very recent kernel):
> >>
> >> spin_lock(&lock)
> >> copy_to_user(...)
> >> spin_unlock(&lock)
> > 
> > That's a deadlock even without copy_to_user - it's
> > enough for the thread to be preempted and another one
> > to try taking the lock.
> 
> Huh? With CONFIG_PREEMPT spin_lock will disable preemption. (we had preempt = server anyway).

Are you sure? Can you point me where it does this please?

> But please: One step back. The problem is not the good path. The problem is that we lost a debugging aid for a known to be broken case. In other words: Our code had a bug. Older kernels detected that kind of bug. With your change we no longer saw the sleeping while atomic. Thats it. See my other mail.
> 
> Christian

You want to add more debugging tools, fine. But this one was
giving users in field false positives.

The point is that *_user is safe with preempt off.
It returns an error gracefully.
It does not sleep.
It does not trigger the scheduler in that context.


David's patch makes it say it does, so it's wrong.



-- 
MST
