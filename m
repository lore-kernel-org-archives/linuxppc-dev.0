Return-Path: <heiko.carstens@de.ibm.com>
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1253F1A09C8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Nov 2014 23:04:52 +1100 (AEDT)
Received: from /spool/local
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <heiko.carstens@de.ibm.com>;
 Thu, 27 Nov 2014 12:04:47 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 93E021B0804B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Nov 2014 12:05:00 +0000 (GMT)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
 [9.149.37.216])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sARC4jUC16187422
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Nov 2014 12:04:45 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sARC4feF003367
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Nov 2014 05:04:44 -0700
Date: Thu, 27 Nov 2014 13:04:41 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: David Hildenbrand <dahi@linux.vnet.ibm.com>
Subject: Re: [RFC 0/2] Reenable might_sleep() checks for might_fault() when
 atomic
Message-ID: <20141127120441.GB4390@osiris>
References: <20141126151729.GB9612@redhat.com>
 <20141126152334.GA9648@redhat.com>
 <20141126163207.63810fcb@thinkpad-w530>
 <20141126154717.GB10568@redhat.com> <5475FAB1.1000802@de.ibm.com>
 <20141126163216.GB10850@redhat.com> <547604FC.4030300@de.ibm.com>
 <20141126170447.GC11202@redhat.com> <20141127070919.GA4390@osiris>
 <20141127090301.3ddc3077@thinkpad-w530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141127090301.3ddc3077@thinkpad-w530>
Cc: linux-arch@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
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

On Thu, Nov 27, 2014 at 09:03:01AM +0100, David Hildenbrand wrote:
> > Code like
> > 	spin_lock(&lock);
> > 	if (copy_to_user(...))
> > 		rc = ...
> > 	spin_unlock(&lock);
> > really *should* generate warnings like it did before.
> > 
> > And *only* code like
> > 	spin_lock(&lock);
> 
> Is only code like this valid or also with the spin_lock() dropped?
> (e.g. the access in patch1 if I remember correctly)
> 
> So should page_fault_disable() increment the pagefault counter and the preempt
> counter or only the first one?

Given that a sequence like

	page_fault_disable();
 	if (copy_to_user(...))
 		rc = ...
 	page_fault_enable();

is correct code right now I think page_fault_disable() should increase both.
No need for surprising semantic changes.

> So we would have pagefault code rely on:
> 
> in_disabled_pagefault() ( pagefault_disabled() ... whatever ) instead of
> in_atomic().

No, let's be more defensive: the page fault handler should do nothing if
in_atomic() just like now. But it could have a quick check and emit a one
time warning if page faults aren't disabled in addition.
That might help debugging but keeps the system more likely alive.

might_fault() however should call might_sleep() if page faults aren't
disabled, but that's what you proposed anyway I think.
