Return-Path: <markn@au1.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C2B57B7D1F
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 May 2010 16:31:39 +1000 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp04.au.ibm.com (8.14.3/8.13.1) with ESMTP id o4J6RaVP017911
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 May 2010 16:27:36 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o4J6OQ561687658
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 May 2010 16:24:28 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o4J6VaHg002687
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 May 2010 16:31:37 +1000
From: Mark Nelson <markn@au1.ibm.com>
To: michael@ellerman.id.au
Subject: Re: [PATCH] powerpc/pseries: Make request_ras_irqs() available to
	other pseries code
Date: Wed, 19 May 2010 16:35:43 +1000
References: <201005172233.01183.markn@au1.ibm.com>
	<1274186451.26143.8.camel@concordia>
In-Reply-To: <1274186451.26143.8.camel@concordia>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201005191635.43544.markn@au1.ibm.com>
Cc: Tseng-hui Lin <tsenglin@us.ibm.com>, engebret@us.ibm.com,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

Thanks for looking over these patches!

On Tuesday 18 May 2010 22:40:51 Michael Ellerman wrote:
> On Mon, 2010-05-17 at 22:33 +1000, Mark Nelson wrote:
> > At the moment only the RAS code uses event-sources interrupts (for EPOW
> > events and internal errors) so request_ras_irqs() (which actually requests
> > the event-sources interrupts) is found in ras.c and is static.
> 
> Hi Mark,
> 
> Just a few niggles,
> 
> ...
> 
> > +
> > +void request_event_sources_irqs(struct device_node *np,
> > +				irq_handler_t handler,
> > +				const char *name)
> > +{
> > +	int i, index, count = 0;
> > +	struct of_irq oirq;
> > +	const u32 *opicprop;
> > +	unsigned int opicplen;
> > +	unsigned int virqs[16];
> > +
> > +	/* Check for obsolete "open-pic-interrupt" property. If present, then
> > +	 * map those interrupts using the default interrupt host and default
> > +	 * trigger
> > +	 */
> > +	opicprop = of_get_property(np, "open-pic-interrupt", &opicplen);
> > +	if (opicprop) {
> > +		opicplen /= sizeof(u32);
> > +		for (i = 0; i < opicplen; i++) {
> > +			if (count > 15)
> > +				break;
> > +			virqs[count] = irq_create_mapping(NULL, *(opicprop++));
> > +			if (virqs[count] == NO_IRQ)
> > +				printk(KERN_ERR "Unable to allocate interrupt "
> > +				       "number for %s\n", np->full_name);
> > +			else
> > +				count++;
> > +
> > +		}
> > +	}
> > +	/* Else use normal interrupt tree parsing */
> > +	else {
> > +		/* First try to do a proper OF tree parsing */
> > +		for (index = 0; of_irq_map_one(np, index, &oirq) == 0;
> > +		     index++) {
> > +			if (count > 15)
> > +				break;
> > +			virqs[count] = irq_create_of_mapping(oirq.controller,
> > +							    oirq.specifier,
> > +							    oirq.size);
> > +			if (virqs[count] == NO_IRQ)
> > +				printk(KERN_ERR "Unable to allocate interrupt "
> > +				       "number for %s\n", np->full_name);
> > +			else
> > +				count++;
> > +		}
> > +	}
> > +
> > +	/* Now request them */
> > +	for (i = 0; i < count; i++) {
> > +		if (request_irq(virqs[i], handler, 0, name, NULL)) {
> > +			printk(KERN_ERR "Unable to request interrupt %d for "
> > +			       "%s\n", virqs[i], np->full_name);
> > +			return;
> > +		}
> > +	}
> 
> Existing code I know, but the error handling in here is a little lax,
> what's not going to work if we miss some or all of the interrupts?

That's a good point. For the existing code, if we miss an EPOW event
it just means that the event won't be logged (as that's all we do with
those events at the moment, although there is a comment saying
that it should be fixed to take appropriate action depending upon the
type of power failure); but it's a bigger problem if we miss one of the
RAS errors because then we could miss a fatal event that we should halt
the machine on. And for the upcoming IO events it's even worse as we'd
miss an interrupt from the device...

I would do it in a follow-on patch rather than this one, but what would
be a good course of action if we can't request the interrupt?

> 
> > Index: upstream/arch/powerpc/platforms/pseries/event_sources.h
> > ===================================================================
> > --- /dev/null
> > +++ upstream/arch/powerpc/platforms/pseries/event_sources.h
> > @@ -0,0 +1,29 @@
> > +/*
> > + * Copyright (C) 2001 Dave Engebretsen IBM Corporation
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program; if not, write to the Free Software
> > + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
> > + */
> > +
> > +#ifndef _POWERPC_EVENT_SOURCES_H
> > +#define _POWERPC_EVENT_SOURCES_H
> > +
> > +#include <linux/interrupt.h>
> > +
> > +struct device_node;
> > +
> > +extern void request_event_sources_irqs(struct device_node *np,
> > +				       irq_handler_t handler, const char *name);
> 
> This could just go in platforms/pseries/pseries.h

That's true - it is only one function. I'll move it.

> 
> > Index: upstream/arch/powerpc/platforms/pseries/ras.c
> > ===================================================================
> > --- upstream.orig/arch/powerpc/platforms/pseries/ras.c
> > +++ upstream/arch/powerpc/platforms/pseries/ras.c
> > @@ -50,6 +50,7 @@
> >  #include <asm/firmware.h>
> >  
> >  #include "pseries.h"
> > +#include "event_sources.h"
> 
> :)
> 

Thanks!
Mark
