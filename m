Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc/pseries: Add support for IO Event interrupt
	drivers
From: Michael Ellerman <michael@ellerman.id.au>
To: Mark Nelson <markn@au1.ibm.com>
In-Reply-To: <201005172253.29825.markn@au1.ibm.com>
References: <201005172253.29825.markn@au1.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-nk9ggeir1T63SAYrxFMD"
Date: Tue, 18 May 2010 23:37:31 +1000
Message-ID: <1274189851.26143.63.camel@concordia>
Mime-Version: 1.0
Cc: Tseng-hui Lin <tsenglin@us.ibm.com>, linuxppc-dev@lists.ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-nk9ggeir1T63SAYrxFMD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2010-05-17 at 22:53 +1000, Mark Nelson wrote:
> This patch adds support for handling IO Event interrupts which come
> through at the /event-sources/ibm,io-events device tree node.

Hi Mark,

You'll have to explain to me offline sometime how it is we ran out of
interrupts and started needing to multiplex them ..

> There is one ibm,io-events interrupt, but this interrupt might be used
> for multiple I/O devices, each with their own separate driver. So, we
> create a platform interrupt handler that will do the RTAS check-exception
> call and then call the appropriate driver's interrupt handler (the one(s)
> that registered with a scope that matches the scope of the incoming
> interrupt).
>=20
> So, a driver for a device that uses IO Event interrupts will register
> it's interrupt service routine (or interrupt handler) with the platform
> code using ioei_register_isr(). This register function takes a function
> pointer to the driver's handler and the scope that the driver is
> interested in (scopes defined in arch/powerpc/include/asm/io_events.h).
> The driver's handler must take a pointer to a struct io_events_section
> and must not return anything.
>=20
> The platform code registers io_event_interrupt() as the interrupt handler
> for the ibm,io-events interrupt. Upon receiving an IO Event interrupt, it
> checks the scope of the incoming interrupt and only calls those drivers'
> handlers that have registered as being interested in that scope.

The "checks the scope" requires an RTAS call, which takes a global lock
(and you add another) - these aren't going to be used for anything
performance critical I hope?

> It is possible for a single driver to register the same function pointer
> more than once with different scopes if it is interested in more than one
> type of IO Event interrupt. If a handler wants to be notified of all
> incoming IO Event interrupts it can register with IOEI_SCOPE_ANY.
>=20
> A driver can unregister to stop receiving the IO Event interrupts using
> ioei_unregister_isr(), passing it the same function pointer to the
> driver's handler and the scope the driver was registered with.
>=20
> Signed-off-by: Mark Nelson <markn@au1.ibm.com>
> ---
>  arch/powerpc/include/asm/io_events.h       |   40 +++++
>  arch/powerpc/platforms/pseries/Makefile    |    2=20
>  arch/powerpc/platforms/pseries/io_events.c |  205 ++++++++++++++++++++++=
+++++++
>  3 files changed, 246 insertions(+), 1 deletion(-)
>=20
> Index: upstream/arch/powerpc/include/asm/io_events.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- /dev/null
> +++ upstream/arch/powerpc/include/asm/io_events.h
> @@ -0,0 +1,40 @@
> +/*
> + * Copyright 2010 IBM Corporation, Mark Nelson

I usually have name, corp, but I'm not sure if it matters.

> + *  This program is free software; you can redistribute it and/or
> + *  modify it under the terms of the GNU General Public License
> + *  as published by the Free Software Foundation; either version
> + *  2 of the License, or (at your option) any later version.
> + */
> +
> +#ifndef _ASM_POWERPC_IOEVENTS_H
> +#define _ASM_POWERPC_IOEVENTS_H
> +
> +struct io_events_section {
> +	u16	id;			// Unique section identifier	x00-x01
> +	u16	length;			// Section length (bytes)	x02-x03
> +	u8	version;		// Section Version		x04-x04
> +	u8	sec_subtype;		// Section subtype		x05-x05
> +	u16	creator_id;		// Creator Component ID		x06-x07
> +	u8	event_type;		// IO-Event Type		x08-x08
> +	u8	rpc_field_len;		// PRC Field Length		x09-x09
> +	u8	scope;			// Error/Event Scope		x0A-x0A
> +	u8	event_subtype;		// I/O-Event Sub-Type		x0B-x0B
> +	u32	drc_index;		// DRC Index			x0C-x0F
> +	u32	rpc_data[];		// RPC Data (optional)		x10-...
> +};

I know it's idiomatic in that sort of code, but C++ comments?

> +#define IOEI_SCOPE_NOT_APP	0x00
> +#define IOEI_SCOPE_RIO_HUB	0x36
> +#define IOEI_SCOPE_RIO_BRIDGE	0x37
> +#define IOEI_SCOPE_PHB		0x38
> +#define IOEI_SCOPE_EADS_GLOBAL	0x39
> +#define IOEI_SCOPE_EADS_SLOT	0x3A
> +#define IOEI_SCOPE_TORRENT_HUB	0x3B
> +#define IOEI_SCOPE_SERVICE_PROC	0x51
> +#define IOEI_SCOPE_ANY		-1
> +
> +int ioei_register_isr(void (*isr)(struct io_events_section *), int scope=
);
> +int ioei_unregister_isr(void (*isr)(struct io_events_section *), int sco=
pe);

Given these are exported to the whole kernel I'd vote for
pseries_ioei_register_isr(), if I get to vote that is.

> Index: upstream/arch/powerpc/platforms/pseries/io_events.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- /dev/null
> +++ upstream/arch/powerpc/platforms/pseries/io_events.c
> @@ -0,0 +1,205 @@
> +/*
> + * Copyright 2010 IBM Corporation, Mark Nelson
> + *
> + *  This program is free software; you can redistribute it and/or
> + *  modify it under the terms of the GNU General Public License
> + *  as published by the Free Software Foundation; either version
> + *  2 of the License, or (at your option) any later version.
> + */
> +
> +#include <linux/errno.h>
> +#include <linux/spinlock.h>
> +#include <linux/slab.h>
> +#include <linux/module.h>
> +#include <linux/irq.h>
> +#include <linux/interrupt.h>
> +#include <linux/of.h>
> +
> +#include <asm/io_events.h>
> +#include <asm/rtas.h>
> +#include <asm/irq.h>
> +
> +#include "event_sources.h"
> +
> +struct ioei_consumer {
> +	void (*ioei_isr)(struct io_events_section *);

Function pointers is one case where a typedef can make the code easier
to read, if you like.

> +	int scope;
> +	struct ioei_consumer *next;
> +};

You forgot the fourth commandment:
        Thou shalt not write thine own linked list implementation when
        there already exist several perfectly good ones in the kernel!
       =20
Or is there some good reason for it I'm missing? :)

You could even use a hlist to save a void * in your list head.

> +static int ioei_check_exception_token;
> +
> +static unsigned char ioei_log_buf[RTAS_ERROR_LOG_MAX];
> +static DEFINE_SPINLOCK(ioei_log_buf_lock);
> +
> +static struct ioei_consumer *ioei_isr_list;
> +static DEFINE_SPINLOCK(ioei_isr_list_lock);
> +
> +int ioei_register_isr(void (*isr)(struct io_events_section *), int scope=
)
> +{
> +	struct ioei_consumer *iter;
> +	struct ioei_consumer *cons;
> +	int ret =3D 0;
> +
> +	spin_lock(&ioei_isr_list_lock);

Here and unregister you should be using spin_lock_irq(), because you
need to protect against an interrupt and you know you're not being
called from an irq handler (so you don't need save/restore - though you
could use it anyway to be lazy :D).

> +	/* check to see if we've already registered this function with
> +	 * this scope. If we have, don't register it again
> +	 */
> +	iter =3D ioei_isr_list;
> +	while (iter) {
> +		if (iter->ioei_isr =3D=3D isr && iter->scope =3D=3D scope)
> +			break;
> +		iter =3D iter->next;
> +	}
> +
> +	if (iter) {
> +		ret =3D -EEXIST;
> +		goto out;
> +	}
> +
> +	cons =3D kmalloc(sizeof(struct ioei_consumer), GFP_KERNEL);

But you don't want to kmalloc while holding the lock and with interrupts
off.

> +	if (!cons) {
> +		ret =3D -ENOMEM;
> +		goto out;
> +	}
> +
> +	cons->ioei_isr =3D isr;
> +	cons->scope =3D scope;
> +
> +	cons->next =3D ioei_isr_list;
> +	ioei_isr_list =3D cons;
> +
> +out:
> +	spin_unlock(&ioei_isr_list_lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(ioei_register_isr);
> +
> +int ioei_unregister_isr(void (*isr)(struct io_events_section *), int sco=
pe)
> +{
> +	struct ioei_consumer *iter;
> +	struct ioei_consumer *prev =3D NULL;
> +	int ret =3D 0;
> +
> +	spin_lock(&ioei_isr_list_lock);
> +	iter =3D ioei_isr_list;
> +	while (iter) {
> +		if (iter->ioei_isr =3D=3D isr && iter->scope =3D=3D scope)
> +			break;
> +		prev =3D iter;
> +		iter =3D iter->next;
> +	}
> +
> +	if (!iter) {
> +		ret =3D -ENOENT;
> +		goto out;
> +	}
> +
> +	if (prev)
> +		prev->next =3D iter->next;
> +	else
> +		ioei_isr_list =3D iter->next;
> +
> +	kfree(iter);
> +
> +out:
> +	spin_unlock(&ioei_isr_list_lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(ioei_unregister_isr);
> +
> +static void ioei_call_consumers(int scope, struct io_events_section *sec=
)
> +{
> +	struct ioei_consumer *iter;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&ioei_isr_list_lock, flags);

You don't need to disable interrupts, because you're being called from
the interrupt handler, and it won't be called again until you're
finished.

> +	iter =3D ioei_isr_list;
> +	while (iter) {
> +		if (iter->scope =3D=3D scope || iter->scope =3D=3D IOEI_SCOPE_ANY)
> +			iter->ioei_isr(sec);
> +		iter =3D iter->next;
> +	}
> +
> +	spin_unlock_irqrestore(&ioei_isr_list_lock, flags);
> +}
> +
> +#define EXT_INT_VECTOR_OFFSET	0x500
> +#define RTAS_TYPE_IO_EVENT	0xE1
> +
> +static irqreturn_t io_event_interrupt(int irq, void *dev_id)
> +{
> +	struct rtas_error_log *rtas_elog;
> +	struct io_events_section *ioei_sec;
> +	char *ch_ptr;
> +	int status;
> +	u16 *sec_len;
> +
> +	spin_lock(&ioei_log_buf_lock);
> +
> +	status =3D rtas_call(ioei_check_exception_token, 6, 1, NULL,
> +			   EXT_INT_VECTOR_OFFSET,
> +			   irq_map[irq].hwirq,

This is going to be  slow anyway, you may as well use virq_to_hw().

> +			   RTAS_IO_EVENTS, 1 /*Time Critical */,

Missing space before the T                      ^

> +			   __pa(&ioei_log_buf),

Does the buffer need to be aligned, and/or inside the RMO? I'd guess
yes.

> +				rtas_get_error_log_max());
> +
> +	rtas_elog =3D (struct rtas_error_log *)ioei_log_buf;
> +
> +	if (status !=3D 0)
> +		goto out;
> +
> +	/* We assume that we will only ever get called for io-event
> +	 * interrupts. But if we get called with something else
> +	 * make some noise about it.
> +	 */

That would mean we'd requested the wrong interrupt wouldn't it? I'd
almost BUG, but benh always bitches that I do that too often so .. :)

> +	if (rtas_elog->type !=3D RTAS_TYPE_IO_EVENT) {
> +		pr_warning("IO Events: We got called with an event type of %d"
> +			   " rather than %d!\n", rtas_elog->type,
> +			   RTAS_TYPE_IO_EVENT);
> +		WARN_ON(1);
> +		goto out;
> +	}
> +
> +	/* there are 24 bytes of event log data before the first section
> +	 * (Main-A) begins
> +	 */
> +	ch_ptr =3D (char *)ioei_log_buf + 24;

Any reason you're casting from unsigned char to char?

> +	/* loop through all the sections until we get to the IO Events
> +	 * Section, with section ID "IE"
> +	 */
> +	while (*ch_ptr !=3D 'I' && *(ch_ptr + 1) !=3D 'E') {
> +		sec_len =3D (u16 *)(ch_ptr + 2);
> +		ch_ptr +=3D *sec_len;
> +	}

This would be neater if you cast to io_events_section and used the
fields I think.

And even better if you know the length will be a multiple of the
section_header size, you can do the arithmetic in those terms.

> +	ioei_sec =3D (struct io_events_section *)ch_ptr;
> +
> +	ioei_call_consumers(ioei_sec->scope, ioei_sec);

Guaranteed to be only one section returned to us per call?

We /could/ copy the ioei_sec and drop the buf lock, which would allow
another interrupt to come in and start doing the RTAS call (on another
cpu, and iff there are actually multiple interrupts). But we probably
don't care.

> +out:
> +	spin_unlock(&ioei_log_buf_lock);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int __init init_ioei_IRQ(void)

Never understood why IRQ always (sometimes) gets caps ..

> +{
> +	struct device_node *np;
> +
> +	ioei_check_exception_token =3D rtas_token("check-exception");

Meep, need to check if it actually exists.

> +	np =3D of_find_node_by_path("/event-sources/ibm,io-events");
> +	if (np !=3D NULL) {

if (np) would usually do it

> +		request_event_sources_irqs(np, io_event_interrupt, "IO_EVENT");
> +		of_node_put(np);
> +	}
> +
> +	return 0;
> +}
> +device_initcall(init_ioei_IRQ);

Should probably be a machine_initcall().

> Index: upstream/arch/powerpc/platforms/pseries/Makefile
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- upstream.orig/arch/powerpc/platforms/pseries/Makefile
> +++ upstream/arch/powerpc/platforms/pseries/Makefile
> @@ -8,7 +8,7 @@ endif
> =20
>  obj-y			:=3D lpar.o hvCall.o nvram.o reconfig.o \
>  			   setup.o iommu.o event_sources.o ras.o \
> -			   firmware.o power.o dlpar.o
> +			   firmware.o power.o dlpar.o io_events.o

The BML guys might appreciate an option to turn it off?

cheers


--=-nk9ggeir1T63SAYrxFMD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkvymBsACgkQdSjSd0sB4dKxJACePdqT0cKdo32kpP5LD4y4hupG
2ngAnAxzsc6sq80WzHv69YnmHlkCEFED
=2YzX
-----END PGP SIGNATURE-----

--=-nk9ggeir1T63SAYrxFMD--
