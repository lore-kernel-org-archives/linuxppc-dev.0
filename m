Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound5-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 404D6DE00C
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 10:56:43 +1100 (EST)
Message-ID: <45B943B4.5090204@am.sony.com>
Date: Thu, 25 Jan 2007 15:56:36 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH 9/14] ps3: add interrupt alloc for outlets
References: <45B8188E.7020602@am.sony.com>
	<1169697334.24996.54.camel@localhost.localdomain>
	<Pine.LNX.4.62.0701251433330.31896@pademelon.sonytel.be>
In-Reply-To: <Pine.LNX.4.62.0701251433330.31896@pademelon.sonytel.be>
Content-Type: text/plain; charset=UTF-8
Cc: paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geert Uytterhoeven wrote:
> On Thu, 25 Jan 2007, Benjamin Herrenschmidt wrote:
>> > +int ps3_alloc_irq(enum ps3_cpu_binding cpu, unsigned long outlet,
>> > +	unsigned int *virq)
>> > +{
>> > +	return ps3_connect_irq(cpu, outlet, virq);
>> > +}
>> > +
>> > +int ps3_free_irq(unsigned int virq)
>> > +{
>> > +	ps3_disconnect_irq(virq);
>> > +	return 0;
>> > +}
>> > +
>> >  #define PS3_INVALID_OUTLET ((irq_hw_number_t)-1)
>> >  #define PS3_PLUG_MAX 63
>> 
>> I'm not too fan of this... those 2 functions do strictly -nothing- other
>> than export the ones they call (not even changing arguments).
>> 
>> So why not export ps3_connect_irq / ps3_disconnect_irq directly ?
> 
> You're right. Originally they were all but trivial wrappers, but the recent
> interrupt improvements have changed this.
> 
> Do you have a preference which names to keep?
> 
>  1. ps3_connect_irq() and ps3_disconnect_irq() resemble the LV1 calls they
>     make,
>  2. ps3_alloc_irq() and ps3_free_irq() resemble the other
>     ps3_{alloc,free}_*_irq() names.

I think ps3_connect_irq() and ps3_disconnect_irq() are not consistent with
the existing routines, so I would perfer not to use those.  I'll post a new
patch that makes this change.

-Geoff 
