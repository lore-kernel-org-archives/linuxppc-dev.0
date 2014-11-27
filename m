Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 967551A0156
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Nov 2014 02:07:15 +1100 (AEDT)
Date: Thu, 27 Nov 2014 16:07:02 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [RFC 0/2] Reenable might_sleep() checks for might_fault() when
 atomic
In-Reply-To: <20141127120441.GB4390@osiris>
Message-ID: <alpine.DEB.2.11.1411271602320.3961@nanos>
References: <20141126151729.GB9612@redhat.com>
 <20141126152334.GA9648@redhat.com> <20141126163207.63810fcb@thinkpad-w530>
 <20141126154717.GB10568@redhat.com> <5475FAB1.1000802@de.ibm.com>
 <20141126163216.GB10850@redhat.com> <547604FC.4030300@de.ibm.com>
 <20141126170447.GC11202@redhat.com> <20141127070919.GA4390@osiris>
 <20141127090301.3ddc3077@thinkpad-w530> <20141127120441.GB4390@osiris>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-arch@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 David Hildenbrand <dahi@linux.vnet.ibm.com>, paulus@samba.org,
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

On Thu, 27 Nov 2014, Heiko Carstens wrote:
> On Thu, Nov 27, 2014 at 09:03:01AM +0100, David Hildenbrand wrote:
> > > Code like
> > > 	spin_lock(&lock);
> > > 	if (copy_to_user(...))
> > > 		rc = ...
> > > 	spin_unlock(&lock);
> > > really *should* generate warnings like it did before.
> > > 
> > > And *only* code like
> > > 	spin_lock(&lock);
> > 
> > Is only code like this valid or also with the spin_lock() dropped?
> > (e.g. the access in patch1 if I remember correctly)
> > 
> > So should page_fault_disable() increment the pagefault counter and the preempt
> > counter or only the first one?
> 
> Given that a sequence like
> 
> 	page_fault_disable();
>  	if (copy_to_user(...))
>  		rc = ...
>  	page_fault_enable();
> 
> is correct code right now I think page_fault_disable() should increase both.
> No need for surprising semantic changes.

OTOH, there is no reason why we need to disable preemption over that
page_fault_disabled() region. There are code pathes which really do
not require to disable preemption for that.

We have that seperated in preempt-rt for obvious reasons and IIRC
Peter Zijlstra tried to distangle it in mainline some time ago. I
forgot why that never got merged.

We tie way too much stuff on the preemption count already, which is a
mightmare because we have no clear distinction of protection
scopes. 

Thanks,

	tglx
