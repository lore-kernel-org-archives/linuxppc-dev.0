Return-Path: <dahi@linux.vnet.ibm.com>
Received: from e06smtp17.uk.ibm.com (e06smtp17.uk.ibm.com [195.75.94.113])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 95D3E1A0969
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Nov 2014 19:03:13 +1100 (AEDT)
Received: from /spool/local
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <dahi@linux.vnet.ibm.com>;
 Thu, 27 Nov 2014 08:03:09 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 4AE1117D8059
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Nov 2014 08:03:23 +0000 (GMT)
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
 [9.149.37.213])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAR837rf10551484
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Nov 2014 08:03:07 GMT
Received: from d06av03.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av03.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAR834Db006502
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Nov 2014 01:03:06 -0700
Date: Thu, 27 Nov 2014 09:03:01 +0100
From: David Hildenbrand <dahi@linux.vnet.ibm.com>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [RFC 0/2] Reenable might_sleep() checks for might_fault() when
 atomic
Message-ID: <20141127090301.3ddc3077@thinkpad-w530>
In-Reply-To: <20141127070919.GA4390@osiris>
References: <20141126070258.GA25523@redhat.com>
 <20141126110504.511b733a@thinkpad-w530>
 <20141126151729.GB9612@redhat.com>
 <20141126152334.GA9648@redhat.com>
 <20141126163207.63810fcb@thinkpad-w530>
 <20141126154717.GB10568@redhat.com> <5475FAB1.1000802@de.ibm.com>
 <20141126163216.GB10850@redhat.com> <547604FC.4030300@de.ibm.com>
 <20141126170447.GC11202@redhat.com> <20141127070919.GA4390@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

> Code like
> 	spin_lock(&lock);
> 	if (copy_to_user(...))
> 		rc = ...
> 	spin_unlock(&lock);
> really *should* generate warnings like it did before.
> 
> And *only* code like
> 	spin_lock(&lock);

Is only code like this valid or also with the spin_lock() dropped?
(e.g. the access in patch1 if I remember correctly)


So should page_fault_disable() increment the pagefault counter and the preempt
counter or only the first one?

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

So we would have pagefault code rely on:

in_disabled_pagefault() ( pagefault_disabled() ... whatever ) instead of
in_atomic().

I agree with this approach, as this is basically what I suggested in one of my
previous mails.
