Return-Path: <markn@au1.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7967EB7D68
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 May 2010 20:40:23 +1000 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp04.au.ibm.com (8.14.3/8.13.1) with ESMTP id o4JAaDBo028920
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 May 2010 20:36:13 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o4JAX5AH1708204
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 May 2010 20:33:05 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o4JAeGob024536
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 May 2010 20:40:16 +1000
From: Mark Nelson <markn@au1.ibm.com>
To: Sonny Rao <sonnyrao@us.ibm.com>
Subject: Re: [PATCH] powerpc/pseries: Add support for IO Event interrupt
	drivers
Date: Wed, 19 May 2010 20:44:25 +1000
References: <20100519042744.GA26215@us.ibm.com>
In-Reply-To: <20100519042744.GA26215@us.ibm.com>
MIME-Version: 1.0
Message-Id: <201005192044.25422.markn@au1.ibm.com>
Content-Type: Text/Plain;
  charset="iso-8859-1"
Cc: linuxppc-dev@lists.ozlabs.org, miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday 19 May 2010 14:27:44 Sonny Rao wrote:
> On Tue, 18 May 2010 23:37:31 +1000, Michael Ellerman wrote:
> > 
> > On Mon, 2010-05-17 at 22:53 +1000, Mark Nelson wrote:
> > > This patch adds support for handling IO Event interrupts which come
> > > through at the /event-sources/ibm,io-events device tree node.
> > 
> > Hi Mark,
> > 
> > You'll have to explain to me offline sometime how it is we ran out of
> > interrupts and started needing to multiplex them ..
> 
> Firmware has decided to multiplex all i/o error reporting through a single
> interrupt for reasons unknown, that is the primary reason for this patch.
> 
> One question is, we already register a few RAS interrupts which call
> RTAS using check-exception for getting error information.  Those live
> in platforms/pseries/ras.c -- should we combine the two into a common
> implementation somehow?

I developed in ras.c but then moved it out just for functional
separation but you could be right in that they should live together.
I'll have another look at it when I've fixed it up.

> 
> > > There is one ibm,io-events interrupt, but this interrupt might be used
> > > for multiple I/O devices, each with their own separate driver. So, we
> > > create a platform interrupt handler that will do the RTAS check-exception
> > > call and then call the appropriate driver's interrupt handler (the one(s)
> > > that registered with a scope that matches the scope of the incoming
> > > interrupt).
> > > 
> > > So, a driver for a device that uses IO Event interrupts will register
> > > it's interrupt service routine (or interrupt handler) with the platform
> > > code using ioei_register_isr(). This register function takes a function
> > > pointer to the driver's handler and the scope that the driver is
> > > interested in (scopes defined in arch/powerpc/include/asm/io_events.h).
> > > The driver's handler must take a pointer to a struct io_events_section
> > > and must not return anything.
> > > 
> > > The platform code registers io_event_interrupt() as the interrupt handler
> > > for the ibm,io-events interrupt. Upon receiving an IO Event interrupt, it
> > > checks the scope of the incoming interrupt and only calls those drivers'
> > > handlers that have registered as being interested in that scope.
> > 
> > The "checks the scope" requires an RTAS call, which takes a global lock
> > (and you add another) - these aren't going to be used for anything
> > performance critical I hope?
> 
> Nope it shouldn't be performance critical, but it does raise the point
> that the current RTAS implementation in Linux *always* uses the global
> lock.  There is a set of calls which are not required to be serialized
> against each other.  This would be a totally different patchset to fix that
> problem.  The "check-exception" call is one that doesn't require the global
> RTAS lock.  I might work on that someday :-)
> 
> <snip>
> 
> > > +	/* check to see if we've already registered this function with
> > > +	 * this scope. If we have, don't register it again
> > > +	 */
> > > +	iter = ioei_isr_list;
> > > +	while (iter) {
> > > +		if (iter->ioei_isr == isr && iter->scope == scope)
> > > +			break;
> > > +		iter = iter->next;
> > > +	}
> > > +
> > > +	if (iter) {
> > > +		ret = -EEXIST;
> > > +		goto out;
> > > +	}
> > > +
> > > +	cons = kmalloc(sizeof(struct ioei_consumer), GFP_KERNEL);
> > 
> > But you don't want to kmalloc while holding the lock and with interrupts
> > off.
> 
> Well, he could use GFP_ATOMIC but that's the wrong approach.  You should
> allocate the buffer (using GFP_KERNEL) before taking the spin lock.
> 

And then free it before returning in the case that we've got a
duplicate, right?

> <snip>
> 
> > > +#define EXT_INT_VECTOR_OFFSET	0x500
> > > +#define RTAS_TYPE_IO_EVENT	0xE1
> 
> These defines should probably go in <asm/rtas.h>
> 
> I noticed the code in ras.c has it's own define too RAS_VECTOR_OFFSET
> for 0x500 and asm/rtas.h actually has RTAS_TYPE_IO for 0xE1

I'm not sure how I missed RTAS_TYPE_IO in <asm/rtas.h> but I'll use
that and then add EXT_INT_VECTOR_OFFSET and update the RAS code to use
it too.

> 
> > > +
> > > +static irqreturn_t io_event_interrupt(int irq, void *dev_id)
> > > +{
> > > +	struct rtas_error_log *rtas_elog;
> > > +	struct io_events_section *ioei_sec;
> > > +	char *ch_ptr;
> > > +	int status;
> > > +	u16 *sec_len;
> > > +
> > > +	spin_lock(&ioei_log_buf_lock);
> > > +
> > > +	status = rtas_call(ioei_check_exception_token, 6, 1, NULL,
> > > +			   EXT_INT_VECTOR_OFFSET,
> > > +			   irq_map[irq].hwirq,
> > 
> > This is going to be  slow anyway, you may as well use virq_to_hw().
> > 
> > > +			   RTAS_IO_EVENTS, 1 /*Time Critical */,
> > 
> > Missing space before the T                      ^
> > 
> > > +			   __pa(&ioei_log_buf),
> > 
> > Does the buffer need to be aligned, and/or inside the RMO? I'd guess
> > yes.
> 
> The docs for check-exception don't particularly specify alignment
> requirements, but RTAS in generally going to want it in the RMO
> 
> Also, if we're going to go ahead and use rtas_call() which locks
> it's own buffer which meets the requirements, why do we even need
> a separate buffer?  Really, we should make this call, then copy
> the content of the buffer before handing it over to the drivers.

That sounds like a good idea, I'll update it to do the copy.

> 
> 
> > > +				rtas_get_error_log_max());
> 
> Here, we're passing back what RTAS told us what it's max is
> which doesn't necessarily equal the static buffer size we
> allocated which can cause a buffer overflow.  So this
> argument should be the static size of the buffer.

Excellent pickup. Thanks!

> 
> > > +
> > > +	rtas_elog = (struct rtas_error_log *)ioei_log_buf;
> > > +
> > > +	if (status != 0)
> > > +		goto out;
> > > +
> > > +	/* We assume that we will only ever get called for io-event
> > > +	 * interrupts. But if we get called with something else
> > > +	 * make some noise about it.
> > > +	 */
> > 
> > That would mean we'd requested the wrong interrupt wouldn't it? I'd
> > almost BUG, but benh always bitches that I do that too often so .. :)
> > 
> > > +	if (rtas_elog->type != RTAS_TYPE_IO_EVENT) {
> > > +		pr_warning("IO Events: We got called with an event type of %d"
> > > +			   " rather than %d!\n", rtas_elog->type,
> > > +			   RTAS_TYPE_IO_EVENT);
> > > +		WARN_ON(1);
> > > +		goto out;
> > > +	}
> 
> Should we try to process this instead of just warning?  
> The type we get might be one of the the ones we recognize in
> ras.c; so this is an argument for combining ras.c with this code
> or at least report this in the same manner we report any other
> RTAS error log.

I don't think we would every actually get this case occurring but I'll
definitely have a look at the combining idea.

> 
> > > +
> > > +	/* there are 24 bytes of event log data before the first section
> > > +	 * (Main-A) begins
> > > +	 */
> > > +	ch_ptr = (char *)ioei_log_buf + 24;
> > 
> > Any reason you're casting from unsigned char to char?
> > 
> > > +	/* loop through all the sections until we get to the IO Events
> > > +	 * Section, with section ID "IE"
> > > +	 */
> > > +	while (*ch_ptr != 'I' && *(ch_ptr + 1) != 'E') {
> > > +		sec_len = (u16 *)(ch_ptr + 2);
> > > +		ch_ptr += *sec_len;
> > > +	}
> > 
> > This would be neater if you cast to io_events_section and used the
> > fields I think.
> > 
> > And even better if you know the length will be a multiple of the
> > section_header size, you can do the arithmetic in those terms.
> > 
> > > +	ioei_sec = (struct io_events_section *)ch_ptr;
> > > +
> > > +	ioei_call_consumers(ioei_sec->scope, ioei_sec);
> > 
> > Guaranteed to be only one section returned to us per call?
> > 
> > We /could/ copy the ioei_sec and drop the buf lock, which would allow
> > another interrupt to come in and start doing the RTAS call (on another
> > cpu, and iff there are actually multiple interrupts). But we probably
> > don't care.
> 
> I think we *have* to copy it because we don't want our lock held when we
> call random handlers.

That's a very good point.

> 
> > > +out:
> > > +	spin_unlock(&ioei_log_buf_lock);
> > > +
> > > +	return IRQ_HANDLED;
> > > +}
> > > +
> > > +static int __init init_ioei_IRQ(void)
> > 
> > Never understood why IRQ always (sometimes) gets caps ..
> > 
> > > +{
> > > +	struct device_node *np;
> > > +
> > > +	ioei_check_exception_token = rtas_token("check-exception");
> > 
> > Meep, need to check if it actually exists.
> > 
> > > +	np = of_find_node_by_path("/event-sources/ibm,io-events");
> > > +	if (np != NULL) {
> > 
> > if (np) would usually do it
> > 
> > > +		request_event_sources_irqs(np, io_event_interrupt, "IO_EVENT");
> > > +		of_node_put(np);
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +device_initcall(init_ioei_IRQ);
> > 
> > Should probably be a machine_initcall().
> > 
> > > Index: upstream/arch/powerpc/platforms/pseries/Makefile
> > > ===================================================================
> > > --- upstream.orig/arch/powerpc/platforms/pseries/Makefile
> > > +++ upstream/arch/powerpc/platforms/pseries/Makefile
> > > @@ -8,7 +8,7 @@ endif
> > >  
> > >  obj-y			:= lpar.o hvCall.o nvram.o reconfig.o \
> > >  			   setup.o iommu.o event_sources.o ras.o \
> > > -			   firmware.o power.o dlpar.o
> > > +			   firmware.o power.o dlpar.o io_events.o
> > 
> > The BML guys might appreciate an option to turn it off?
> 
> Or, we might subvert it for our own evil purposes ;-)

Would an option that gets selected by PPC_PSERIES help?

Thanks for checking over this!
Mark
