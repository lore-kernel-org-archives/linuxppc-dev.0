Return-Path: <markn@au1.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp09.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4BB59B7D5E
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 May 2010 20:19:59 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp09.au.ibm.com (8.14.3/8.13.1) with ESMTP id o4JAJubX003735
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 May 2010 20:19:56 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o4JAJwIk1851516
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 May 2010 20:19:59 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o4JAJwmL020904
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 May 2010 20:19:58 +1000
From: Mark Nelson <markn@au1.ibm.com>
To: michael@ellerman.id.au
Subject: Re: [PATCH] powerpc/pseries: Add support for IO Event interrupt
	drivers
Date: Wed, 19 May 2010 20:24:02 +1000
References: <201005172253.29825.markn@au1.ibm.com>
	<1274189851.26143.63.camel@concordia>
In-Reply-To: <1274189851.26143.63.camel@concordia>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201005192024.02780.markn@au1.ibm.com>
Cc: Tseng-hui Lin <tsenglin@us.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday 18 May 2010 23:37:31 Michael Ellerman wrote:
> On Mon, 2010-05-17 at 22:53 +1000, Mark Nelson wrote:
> > This patch adds support for handling IO Event interrupts which come
> > through at the /event-sources/ibm,io-events device tree node.
> 
> Hi Mark,
> 
> You'll have to explain to me offline sometime how it is we ran out of
> interrupts and started needing to multiplex them ..
> 
> > There is one ibm,io-events interrupt, but this interrupt might be used
> > for multiple I/O devices, each with their own separate driver. So, we
> > create a platform interrupt handler that will do the RTAS check-exception
> > call and then call the appropriate driver's interrupt handler (the one(s)
> > that registered with a scope that matches the scope of the incoming
> > interrupt).
> > 
> > So, a driver for a device that uses IO Event interrupts will register
> > it's interrupt service routine (or interrupt handler) with the platform
> > code using ioei_register_isr(). This register function takes a function
> > pointer to the driver's handler and the scope that the driver is
> > interested in (scopes defined in arch/powerpc/include/asm/io_events.h).
> > The driver's handler must take a pointer to a struct io_events_section
> > and must not return anything.
> > 
> > The platform code registers io_event_interrupt() as the interrupt handler
> > for the ibm,io-events interrupt. Upon receiving an IO Event interrupt, it
> > checks the scope of the incoming interrupt and only calls those drivers'
> > handlers that have registered as being interested in that scope.
> 
> The "checks the scope" requires an RTAS call, which takes a global lock
> (and you add another) - these aren't going to be used for anything
> performance critical I hope?

I've been told they're not performance critical but I'll have to go
back and have a closer look at the locking again - I probably am being
a bit overzealous.

> 
> > It is possible for a single driver to register the same function pointer
> > more than once with different scopes if it is interested in more than one
> > type of IO Event interrupt. If a handler wants to be notified of all
> > incoming IO Event interrupts it can register with IOEI_SCOPE_ANY.
> > 
> > A driver can unregister to stop receiving the IO Event interrupts using
> > ioei_unregister_isr(), passing it the same function pointer to the
> > driver's handler and the scope the driver was registered with.
> > 
> > Signed-off-by: Mark Nelson <markn@au1.ibm.com>
> > ---
> >  arch/powerpc/include/asm/io_events.h       |   40 +++++
> >  arch/powerpc/platforms/pseries/Makefile    |    2 
> >  arch/powerpc/platforms/pseries/io_events.c |  205 +++++++++++++++++++++++++++++
> >  3 files changed, 246 insertions(+), 1 deletion(-)
> > 
> > Index: upstream/arch/powerpc/include/asm/io_events.h
> > ===================================================================
> > --- /dev/null
> > +++ upstream/arch/powerpc/include/asm/io_events.h
> > @@ -0,0 +1,40 @@
> > +/*
> > + * Copyright 2010 IBM Corporation, Mark Nelson
> 
> I usually have name, corp, but I'm not sure if it matters.

I'll find out what the officially sanctioned way is :)

> 
> > + *  This program is free software; you can redistribute it and/or
> > + *  modify it under the terms of the GNU General Public License
> > + *  as published by the Free Software Foundation; either version
> > + *  2 of the License, or (at your option) any later version.
> > + */
> > +
> > +#ifndef _ASM_POWERPC_IOEVENTS_H
> > +#define _ASM_POWERPC_IOEVENTS_H
> > +
> > +struct io_events_section {
> > +	u16	id;			// Unique section identifier	x00-x01
> > +	u16	length;			// Section length (bytes)	x02-x03
> > +	u8	version;		// Section Version		x04-x04
> > +	u8	sec_subtype;		// Section subtype		x05-x05
> > +	u16	creator_id;		// Creator Component ID		x06-x07
> > +	u8	event_type;		// IO-Event Type		x08-x08
> > +	u8	rpc_field_len;		// PRC Field Length		x09-x09
> > +	u8	scope;			// Error/Event Scope		x0A-x0A
> > +	u8	event_subtype;		// I/O-Event Sub-Type		x0B-x0B
> > +	u32	drc_index;		// DRC Index			x0C-x0F
> > +	u32	rpc_data[];		// RPC Data (optional)		x10-...
> > +};
> 
> I know it's idiomatic in that sort of code, but C++ comments?

Yeah, I'm not too phased - I was just copying what lppaca.h did...

> 
> > +#define IOEI_SCOPE_NOT_APP	0x00
> > +#define IOEI_SCOPE_RIO_HUB	0x36
> > +#define IOEI_SCOPE_RIO_BRIDGE	0x37
> > +#define IOEI_SCOPE_PHB		0x38
> > +#define IOEI_SCOPE_EADS_GLOBAL	0x39
> > +#define IOEI_SCOPE_EADS_SLOT	0x3A
> > +#define IOEI_SCOPE_TORRENT_HUB	0x3B
> > +#define IOEI_SCOPE_SERVICE_PROC	0x51
> > +#define IOEI_SCOPE_ANY		-1
> > +
> > +int ioei_register_isr(void (*isr)(struct io_events_section *), int scope);
> > +int ioei_unregister_isr(void (*isr)(struct io_events_section *), int scope);
> 
> Given these are exported to the whole kernel I'd vote for
> pseries_ioei_register_isr(), if I get to vote that is.

That's a very good point - I'll change that.

> 
> > Index: upstream/arch/powerpc/platforms/pseries/io_events.c
> > ===================================================================
> > --- /dev/null
> > +++ upstream/arch/powerpc/platforms/pseries/io_events.c
> > @@ -0,0 +1,205 @@
> > +/*
> > + * Copyright 2010 IBM Corporation, Mark Nelson
> > + *
> > + *  This program is free software; you can redistribute it and/or
> > + *  modify it under the terms of the GNU General Public License
> > + *  as published by the Free Software Foundation; either version
> > + *  2 of the License, or (at your option) any later version.
> > + */
> > +
> > +#include <linux/errno.h>
> > +#include <linux/spinlock.h>
> > +#include <linux/slab.h>
> > +#include <linux/module.h>
> > +#include <linux/irq.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/of.h>
> > +
> > +#include <asm/io_events.h>
> > +#include <asm/rtas.h>
> > +#include <asm/irq.h>
> > +
> > +#include "event_sources.h"
> > +
> > +struct ioei_consumer {
> > +	void (*ioei_isr)(struct io_events_section *);
> 
> Function pointers is one case where a typedef can make the code easier
> to read, if you like.
> 
> > +	int scope;
> > +	struct ioei_consumer *next;
> > +};
> 
> You forgot the fourth commandment:
>         Thou shalt not write thine own linked list implementation when
>         there already exist several perfectly good ones in the kernel!
>         
> Or is there some good reason for it I'm missing? :)

No, there was no good reason at all here and I do feel stupid as in a
previous patch I fought to use the in kernel implementation. I'll use
a struct list_head for the next version.

> 
> You could even use a hlist to save a void * in your list head.
> 
> > +static int ioei_check_exception_token;
> > +
> > +static unsigned char ioei_log_buf[RTAS_ERROR_LOG_MAX];
> > +static DEFINE_SPINLOCK(ioei_log_buf_lock);
> > +
> > +static struct ioei_consumer *ioei_isr_list;
> > +static DEFINE_SPINLOCK(ioei_isr_list_lock);
> > +
> > +int ioei_register_isr(void (*isr)(struct io_events_section *), int scope)
> > +{
> > +	struct ioei_consumer *iter;
> > +	struct ioei_consumer *cons;
> > +	int ret = 0;
> > +
> > +	spin_lock(&ioei_isr_list_lock);
> 
> Here and unregister you should be using spin_lock_irq(), because you
> need to protect against an interrupt and you know you're not being
> called from an irq handler (so you don't need save/restore - though you
> could use it anyway to be lazy :D).

I actually had that right in an earlier version but I can't remember
what possessed me to change it... I'll fix it.

> 
> > +	/* check to see if we've already registered this function with
> > +	 * this scope. If we have, don't register it again
> > +	 */
> > +	iter = ioei_isr_list;
> > +	while (iter) {
> > +		if (iter->ioei_isr == isr && iter->scope == scope)
> > +			break;
> > +		iter = iter->next;
> > +	}
> > +
> > +	if (iter) {
> > +		ret = -EEXIST;
> > +		goto out;
> > +	}
> > +
> > +	cons = kmalloc(sizeof(struct ioei_consumer), GFP_KERNEL);
> 
> But you don't want to kmalloc while holding the lock and with interrupts
> off.

I could allocate above, before taking the lock, and then if we get the
case where it already exists in the list I could just free it before
returning. Would that work?

> 
> > +	if (!cons) {
> > +		ret = -ENOMEM;
> > +		goto out;
> > +	}
> > +
> > +	cons->ioei_isr = isr;
> > +	cons->scope = scope;
> > +
> > +	cons->next = ioei_isr_list;
> > +	ioei_isr_list = cons;
> > +
> > +out:
> > +	spin_unlock(&ioei_isr_list_lock);
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(ioei_register_isr);
> > +
> > +int ioei_unregister_isr(void (*isr)(struct io_events_section *), int scope)
> > +{
> > +	struct ioei_consumer *iter;
> > +	struct ioei_consumer *prev = NULL;
> > +	int ret = 0;
> > +
> > +	spin_lock(&ioei_isr_list_lock);
> > +	iter = ioei_isr_list;
> > +	while (iter) {
> > +		if (iter->ioei_isr == isr && iter->scope == scope)
> > +			break;
> > +		prev = iter;
> > +		iter = iter->next;
> > +	}
> > +
> > +	if (!iter) {
> > +		ret = -ENOENT;
> > +		goto out;
> > +	}
> > +
> > +	if (prev)
> > +		prev->next = iter->next;
> > +	else
> > +		ioei_isr_list = iter->next;
> > +
> > +	kfree(iter);
> > +
> > +out:
> > +	spin_unlock(&ioei_isr_list_lock);
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(ioei_unregister_isr);
> > +
> > +static void ioei_call_consumers(int scope, struct io_events_section *sec)
> > +{
> > +	struct ioei_consumer *iter;
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&ioei_isr_list_lock, flags);
> 
> You don't need to disable interrupts, because you're being called from
> the interrupt handler, and it won't be called again until you're
> finished.

You're right. Sorry, I think I mixed up the irq saving between the
register/unregister functions and this function. I'll fix it.

> 
> > +	iter = ioei_isr_list;
> > +	while (iter) {
> > +		if (iter->scope == scope || iter->scope == IOEI_SCOPE_ANY)
> > +			iter->ioei_isr(sec);
> > +		iter = iter->next;
> > +	}
> > +
> > +	spin_unlock_irqrestore(&ioei_isr_list_lock, flags);
> > +}
> > +
> > +#define EXT_INT_VECTOR_OFFSET	0x500
> > +#define RTAS_TYPE_IO_EVENT	0xE1
> > +
> > +static irqreturn_t io_event_interrupt(int irq, void *dev_id)
> > +{
> > +	struct rtas_error_log *rtas_elog;
> > +	struct io_events_section *ioei_sec;
> > +	char *ch_ptr;
> > +	int status;
> > +	u16 *sec_len;
> > +
> > +	spin_lock(&ioei_log_buf_lock);
> > +
> > +	status = rtas_call(ioei_check_exception_token, 6, 1, NULL,
> > +			   EXT_INT_VECTOR_OFFSET,
> > +			   irq_map[irq].hwirq,
> 
> This is going to be  slow anyway, you may as well use virq_to_hw().

Oh yeah, good idea

> 
> > +			   RTAS_IO_EVENTS, 1 /*Time Critical */,
> 
> Missing space before the T                      ^

Nice catch!

> 
> > +			   __pa(&ioei_log_buf),
> 
> Does the buffer need to be aligned, and/or inside the RMO? I'd guess
> yes.

Good question, I'll look into it

> 
> > +				rtas_get_error_log_max());
> > +
> > +	rtas_elog = (struct rtas_error_log *)ioei_log_buf;
> > +
> > +	if (status != 0)
> > +		goto out;
> > +
> > +	/* We assume that we will only ever get called for io-event
> > +	 * interrupts. But if we get called with something else
> > +	 * make some noise about it.
> > +	 */
> 
> That would mean we'd requested the wrong interrupt wouldn't it? I'd
> almost BUG, but benh always bitches that I do that too often so .. :)

Yeah, I don't think this would ever happen so I'm not sure exactly
what I'm protecting against here...

> 
> > +	if (rtas_elog->type != RTAS_TYPE_IO_EVENT) {
> > +		pr_warning("IO Events: We got called with an event type of %d"
> > +			   " rather than %d!\n", rtas_elog->type,
> > +			   RTAS_TYPE_IO_EVENT);
> > +		WARN_ON(1);
> > +		goto out;
> > +	}
> > +
> > +	/* there are 24 bytes of event log data before the first section
> > +	 * (Main-A) begins
> > +	 */
> > +	ch_ptr = (char *)ioei_log_buf + 24;
> 
> Any reason you're casting from unsigned char to char?

None that I can fathom now... Good catch :)

> 
> > +	/* loop through all the sections until we get to the IO Events
> > +	 * Section, with section ID "IE"
> > +	 */
> > +	while (*ch_ptr != 'I' && *(ch_ptr + 1) != 'E') {
> > +		sec_len = (u16 *)(ch_ptr + 2);
> > +		ch_ptr += *sec_len;
> > +	}
> 
> This would be neater if you cast to io_events_section and used the
> fields I think.

That's a good idea and would be a lot nicer than the code above.

> 
> And even better if you know the length will be a multiple of the
> section_header size, you can do the arithmetic in those terms.

I'll read the docs again and see if we can do that.

> 
> > +	ioei_sec = (struct io_events_section *)ch_ptr;
> > +
> > +	ioei_call_consumers(ioei_sec->scope, ioei_sec);
> 
> Guaranteed to be only one section returned to us per call?

My understanding is that there's only ever one, but I'll double check.

> 
> We /could/ copy the ioei_sec and drop the buf lock, which would allow
> another interrupt to come in and start doing the RTAS call (on another
> cpu, and iff there are actually multiple interrupts). But we probably
> don't care.

Good point - I'll update it so that we do the copy.

> 
> > +out:
> > +	spin_unlock(&ioei_log_buf_lock);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int __init init_ioei_IRQ(void)
> 
> Never understood why IRQ always (sometimes) gets caps ..

Hmmm... Just following the pattern from the RAS code...

> 
> > +{
> > +	struct device_node *np;
> > +
> > +	ioei_check_exception_token = rtas_token("check-exception");
> 
> Meep, need to check if it actually exists.

Good catch!

> 
> > +	np = of_find_node_by_path("/event-sources/ibm,io-events");
> > +	if (np != NULL) {
> 
> if (np) would usually do it

Definitely. I'll update.

> 
> > +		request_event_sources_irqs(np, io_event_interrupt, "IO_EVENT");
> > +		of_node_put(np);
> > +	}
> > +
> > +	return 0;
> > +}
> > +device_initcall(init_ioei_IRQ);
> 
> Should probably be a machine_initcall().

I'll change it to machine_device_initcall?

> 
> > Index: upstream/arch/powerpc/platforms/pseries/Makefile
> > ===================================================================
> > --- upstream.orig/arch/powerpc/platforms/pseries/Makefile
> > +++ upstream/arch/powerpc/platforms/pseries/Makefile
> > @@ -8,7 +8,7 @@ endif
> >  
> >  obj-y			:= lpar.o hvCall.o nvram.o reconfig.o \
> >  			   setup.o iommu.o event_sources.o ras.o \
> > -			   firmware.o power.o dlpar.o
> > +			   firmware.o power.o dlpar.o io_events.o
> 
> The BML guys might appreciate an option to turn it off?

I initially had an option that gets selected by PPC_PSERIES, how about
that?

Thanks for going through this!
Mark
