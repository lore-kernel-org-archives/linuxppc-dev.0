Return-Path: <dahi@linux.vnet.ibm.com>
Received: from e06smtp17.uk.ibm.com (e06smtp17.uk.ibm.com [195.75.94.113])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5613F1A0994
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Nov 2014 02:19:16 +1100 (AEDT)
Received: from /spool/local
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <dahi@linux.vnet.ibm.com>;
 Thu, 27 Nov 2014 15:19:12 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id C160A1B08061
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Nov 2014 15:19:23 +0000 (GMT)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
 [9.149.37.252])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sARFJ8wT14549058
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Nov 2014 15:19:08 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sARFJ79u024184
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Nov 2014 08:19:08 -0700
Date: Thu, 27 Nov 2014 16:19:05 +0100
From: David Hildenbrand <dahi@linux.vnet.ibm.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC 0/2] Reenable might_sleep() checks for might_fault() when
 atomic
Message-ID: <20141127161905.7c6220ee@thinkpad-w530>
In-Reply-To: <alpine.DEB.2.11.1411271602320.3961@nanos>
References: <20141126151729.GB9612@redhat.com>
 <20141126152334.GA9648@redhat.com>
 <20141126163207.63810fcb@thinkpad-w530>
 <20141126154717.GB10568@redhat.com> <5475FAB1.1000802@de.ibm.com>
 <20141126163216.GB10850@redhat.com> <547604FC.4030300@de.ibm.com>
 <20141126170447.GC11202@redhat.com> <20141127070919.GA4390@osiris>
 <20141127090301.3ddc3077@thinkpad-w530>
 <20141127120441.GB4390@osiris>
 <alpine.DEB.2.11.1411271602320.3961@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

> OTOH, there is no reason why we need to disable preemption over that
> page_fault_disabled() region. There are code pathes which really do
> not require to disable preemption for that.
> 
> We have that seperated in preempt-rt for obvious reasons and IIRC
> Peter Zijlstra tried to distangle it in mainline some time ago. I
> forgot why that never got merged.
> 

Of course, we can completely separate that in our page fault code by doing
pagefault_disabled() checks instead of in_atomic() checks (even in add on
patches later).

> We tie way too much stuff on the preemption count already, which is a
> mightmare because we have no clear distinction of protection
> scopes. 

Although it might not be optimal, but keeping a separate counter for
pagefault_disable() as part of the preemption counter seems to be the only
doable thing right now. I am not sure if a completely separated counter is even
possible, increasing the size of thread_info.

I am working on a prototype right now.

Thanks!

> 
> Thanks,
> 
> 	tglx
> 
