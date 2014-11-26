Return-Path: <mst@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D86411A010D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Nov 2014 04:22:01 +1100 (AEDT)
Date: Wed, 26 Nov 2014 19:21:39 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [RFC 0/2] Reenable might_sleep() checks for might_fault() when
 atomic
Message-ID: <20141126172139.GA11746@redhat.com>
References: <20141126070258.GA25523@redhat.com>
 <20141126110504.511b733a@thinkpad-w530>
 <20141126151729.GB9612@redhat.com>
 <20141126152334.GA9648@redhat.com>
 <20141126163207.63810fcb@thinkpad-w530>
 <20141126154717.GB10568@redhat.com> <5475FAB1.1000802@de.ibm.com>
 <20141126163216.GB10850@redhat.com> <547604FC.4030300@de.ibm.com>
 <20141126170447.GC11202@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141126170447.GC11202@redhat.com>
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

On Wed, Nov 26, 2014 at 07:04:47PM +0200, Michael S. Tsirkin wrote:
> On Wed, Nov 26, 2014 at 05:51:08PM +0100, Christian Borntraeger wrote:
> > > But this one was > giving users in field false positives.
> > 
> > So lets try to fix those, ok? If we cant, then tough luck.
> 
> Sure.
> I think the simplest way might be to make spinlock disable
> premption when CONFIG_DEBUG_ATOMIC_SLEEP is enabled.

Specifically maybe DEBUG_ATOMIC_SLEEP should select PREEMPT_COUNT?


> As a result, userspace access will fail and caller will
> get a nice error.
> 
> 
> 
> > But coming up with wrong statements is not helpful.
> 
> True. Sorry that I did that.
> 
> > > 
> > > The point is that *_user is safe with preempt off.
> > > It returns an error gracefully.
> > > It does not sleep.
> > > It does not trigger the scheduler in that context.
> > 
> > There are special cases where your statement is true. But its not in general.
> > copy_to_user might fault and that fault might sleep and reschedule.
> 
> Yes. But not if called inatomic.
> 
> 
> 
> > For example handle_mm_fault might go down to pud_alloc, pmd_alloc etc and all these functions could do an GFP_KERNEL allocation. Which might sleep. Which will schedule.
> > 
> > 
> > > 
> > > 
> > > David's patch makes it say it does, so it's wrong.
> > > 
> > > 
> > > 
> 
> Absolutely.
> I think you can already debug your case easily, by enabling CONFIG_PREEMPT.
> This seems counter-intuitive, and distro debug kernels don't seem to do this.
> 
> -- 
> MST
