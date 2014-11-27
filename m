Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by lists.ozlabs.org (Postfix) with SMTP id 0BAEB1A0969
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Nov 2014 03:29:07 +1100 (AEDT)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 08268-03 for <linuxppc-dev@lists.ozlabs.org>;
 Thu, 27 Nov 2014 16:29:04 +0000 (GMT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'David Hildenbrand' <dahi@linux.vnet.ibm.com>
Subject: RE: [RFC 0/2] Reenable might_sleep() checks for might_fault() when
 atomic
Date: Thu, 27 Nov 2014 16:27:50 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1C9FDDD6@AcuExch.aculab.com>
References: <20141126151729.GB9612@redhat.com>
 <20141126152334.GA9648@redhat.com>	<20141126163207.63810fcb@thinkpad-w530>
 <20141126154717.GB10568@redhat.com>	<5475FAB1.1000802@de.ibm.com>
 <20141126163216.GB10850@redhat.com>	<547604FC.4030300@de.ibm.com>
 <20141126170447.GC11202@redhat.com>	<20141127070919.GA4390@osiris>
 <20141127090301.3ddc3077@thinkpad-w530>	<20141127120441.GB4390@osiris>
 <alpine.DEB.2.11.1411271602320.3961@nanos>
 <20141127161905.7c6220ee@thinkpad-w530>
 <063D6719AE5E284EB5DD2968C1650D6D1C9FDD6A@AcuExch.aculab.com>
 <20141127164555.4bcebfe8@thinkpad-w530>
In-Reply-To: <20141127164555.4bcebfe8@thinkpad-w530>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
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

From: David Hildenbrand [mailto:dahi@linux.vnet.ibm.com]
> > From: David Hildenbrand
> > ...
> > > Although it might not be optimal, but keeping a separate counter for
> > > pagefault_disable() as part of the preemption counter seems to be the=
 only
> > > doable thing right now. I am not sure if a completely separated count=
er is even
> > > possible, increasing the size of thread_info.
> >
> > What about adding (say) 0x10000 for the more restrictive test?
> >
> > 	David
> >
>=20
> You mean as part of the preempt counter?
>=20
> The current layout (on my branch) is
>=20
>  * PREEMPT_MASK:        0x000000ff
>  * SOFTIRQ_MASK:        0x0000ff00
>  * HARDIRQ_MASK:        0x000f0000
>  *     NMI_MASK:        0x00100000
>  * PREEMPT_ACTIVE:      0x00200000
>=20
> I would have added
>  * PAGEFAULT_MASK:      0x03C00000

I'm not sure where you'd need to add the bits.

I think the above works because disabling 'HARDIRQ' implicitly
disables 'SOFTIRQ' and 'PREEMPT' (etc), so if 256+ threads
disable PREEMPT everything still works.

So if disabling pagefaults implies that pre-emption is disabled
(but SOFTIRQ is still allowed) then you need to insert your bit(s)
between 0xff00 and 0x00ff.
OTOH if disabling pre-emption implies that pagefaults are disabled
then you'd need to use the lsb and change all the above values.

Which makes me think that 'PREEMPT_ACTIVE' isn't right at all.
Two threads disabling NMIs (or 32  disabling HARDIRQ) won't DTRT.

OTOH I'm only guessing at how this is used.

	David
