Return-Path: <dahi@linux.vnet.ibm.com>
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 727E41A099F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Nov 2014 02:46:10 +1100 (AEDT)
Received: from /spool/local
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <dahi@linux.vnet.ibm.com>;
 Thu, 27 Nov 2014 15:46:07 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id E33CC2190056
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Nov 2014 15:45:35 +0000 (GMT)
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
 [9.149.37.228])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sARFk3lM16056390
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Nov 2014 15:46:03 GMT
Received: from d06av02.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av02.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sARFjx77010771
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Nov 2014 08:46:02 -0700
Date: Thu, 27 Nov 2014 16:45:55 +0100
From: David Hildenbrand <dahi@linux.vnet.ibm.com>
To: David Laight <David.Laight@ACULAB.COM>
Subject: Re: [RFC 0/2] Reenable might_sleep() checks for might_fault() when
 atomic
Message-ID: <20141127164555.4bcebfe8@thinkpad-w530>
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D1C9FDD6A@AcuExch.aculab.com>
References: <20141126151729.GB9612@redhat.com>
 <20141126152334.GA9648@redhat.com>
 <20141126163207.63810fcb@thinkpad-w530>
 <20141126154717.GB10568@redhat.com> <5475FAB1.1000802@de.ibm.com>
 <20141126163216.GB10850@redhat.com> <547604FC.4030300@de.ibm.com>
 <20141126170447.GC11202@redhat.com> <20141127070919.GA4390@osiris>
 <20141127090301.3ddc3077@thinkpad-w530>
 <20141127120441.GB4390@osiris>
 <alpine.DEB.2.11.1411271602320.3961@nanos>
 <20141127161905.7c6220ee@thinkpad-w530>
 <063D6719AE5E284EB5DD2968C1650D6D1C9FDD6A@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "mingo@kernel.org" <mingo@kernel.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 "paulus@samba.org" <paulus@samba.org>,
 "schwidefsky@de.ibm.com" <schwidefsky@de.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> From: David Hildenbrand
> ...
> > Although it might not be optimal, but keeping a separate counter for
> > pagefault_disable() as part of the preemption counter seems to be the only
> > doable thing right now. I am not sure if a completely separated counter is even
> > possible, increasing the size of thread_info.
> 
> What about adding (say) 0x10000 for the more restrictive test?
> 
> 	David
> 

You mean as part of the preempt counter?

The current layout (on my branch) is

 * PREEMPT_MASK:        0x000000ff
 * SOFTIRQ_MASK:        0x0000ff00
 * HARDIRQ_MASK:        0x000f0000
 *     NMI_MASK:        0x00100000
 * PREEMPT_ACTIVE:      0x00200000

I would have added
 * PAGEFAULT_MASK:      0x03C00000

So 4 bit == 16 levels (tbd)

By implementing scope checks in the debug case like done for the regular
preempt_count_inc() preempt_count_dec(), we could catch over/underflows.

Thanks,

David
