Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 92AC2DE0D0
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 00:41:42 +1100 (EST)
Date: Thu, 25 Jan 2007 14:41:40 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 9/14] ps3: add interrupt alloc for outlets
In-Reply-To: <1169697334.24996.54.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0701251433330.31896@pademelon.sonytel.be>
References: <45B8188E.7020602@am.sony.com>
	<1169697334.24996.54.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 25 Jan 2007, Benjamin Herrenschmidt wrote:
> > +int ps3_alloc_irq(enum ps3_cpu_binding cpu, unsigned long outlet,
> > +	unsigned int *virq)
> > +{
> > +	return ps3_connect_irq(cpu, outlet, virq);
> > +}
> > +
> > +int ps3_free_irq(unsigned int virq)
> > +{
> > +	ps3_disconnect_irq(virq);
> > +	return 0;
> > +}
> > +
> >  #define PS3_INVALID_OUTLET ((irq_hw_number_t)-1)
> >  #define PS3_PLUG_MAX 63
> 
> I'm not too fan of this... those 2 functions do strictly -nothing- other
> than export the ones they call (not even changing arguments).
> 
> So why not export ps3_connect_irq / ps3_disconnect_irq directly ?

You're right. Originally they were all but trivial wrappers, but the recent
interrupt improvements have changed this.

Do you have a preference which names to keep?

 1. ps3_connect_irq() and ps3_disconnect_irq() resemble the LV1 calls they
    make,
 2. ps3_alloc_irq() and ps3_free_irq() resemble the other
    ps3_{alloc,free}_*_irq() names.

Personally I favor the latter.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
