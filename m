Return-Path: <dahi@linux.vnet.ibm.com>
Received: from e06smtp17.uk.ibm.com (e06smtp17.uk.ibm.com [195.75.94.113])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 754D81A0969
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Nov 2014 03:49:53 +1100 (AEDT)
Received: from /spool/local
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <dahi@linux.vnet.ibm.com>;
 Thu, 27 Nov 2014 16:49:49 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id AEB261B0805F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Nov 2014 16:50:01 +0000 (GMT)
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
 [9.149.37.213])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sARGnkcq17367088
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Nov 2014 16:49:46 GMT
Received: from d06av03.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av03.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sARGnXU2025038
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Nov 2014 09:49:44 -0700
Date: Thu, 27 Nov 2014 17:49:25 +0100
From: David Hildenbrand <dahi@linux.vnet.ibm.com>
To: David Laight <David.Laight@ACULAB.COM>
Subject: Re: [RFC 0/2] Reenable might_sleep() checks for might_fault() when
 atomic
Message-ID: <20141127174925.53e9d7a6@thinkpad-w530>
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D1C9FDDD6@AcuExch.aculab.com>
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
 <20141127164555.4bcebfe8@thinkpad-w530>
 <063D6719AE5E284EB5DD2968C1650D6D1C9FDDD6@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Heiko
 Carstens <heiko.carstens@de.ibm.com>,
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

> From: David Hildenbrand [mailto:dahi@linux.vnet.ibm.com]
> > > From: David Hildenbrand
> > > ...
> > > > Although it might not be optimal, but keeping a separate counter for
> > > > pagefault_disable() as part of the preemption counter seems to be the only
> > > > doable thing right now. I am not sure if a completely separated counter is even
> > > > possible, increasing the size of thread_info.
> > >
> > > What about adding (say) 0x10000 for the more restrictive test?
> > >
> > > 	David
> > >
> > 
> > You mean as part of the preempt counter?
> > 
> > The current layout (on my branch) is
> > 
> >  * PREEMPT_MASK:        0x000000ff
> >  * SOFTIRQ_MASK:        0x0000ff00
> >  * HARDIRQ_MASK:        0x000f0000
> >  *     NMI_MASK:        0x00100000
> >  * PREEMPT_ACTIVE:      0x00200000
> > 
> > I would have added
> >  * PAGEFAULT_MASK:      0x03C00000
> 
> I'm not sure where you'd need to add the bits.
> 
> I think the above works because disabling 'HARDIRQ' implicitly
> disables 'SOFTIRQ' and 'PREEMPT' (etc), so if 256+ threads
> disable PREEMPT everything still works.

AFAIK 256+ levels of preempt will break the system :)

Therefore with CONFIG_DEBUG_PREEMPT we verify that we don't have any
over/underflows.

But such bugs can only be found with CONFIG_DEBUG_PREEMPT enabled.

> 
> So if disabling pagefaults implies that pre-emption is disabled
> (but SOFTIRQ is still allowed) then you need to insert your bit(s)
> between 0xff00 and 0x00ff.
> OTOH if disabling pre-emption implies that pagefaults are disabled
> then you'd need to use the lsb and change all the above values.
> 
> Which makes me think that 'PREEMPT_ACTIVE' isn't right at all.
> Two threads disabling NMIs (or 32  disabling HARDIRQ) won't DTRT.

With threads you mean levels? This is a per thread information.

> 
> OTOH I'm only guessing at how this is used.
> 
> 	David
> 
> 
> 
