Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xSZs32zWlzDqrP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Aug 2017 14:28:55 +1000 (AEST)
Date: Thu, 10 Aug 2017 14:28:49 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 02/10] powerpc/xive: guest exploitation of the XIVE
 interrupt controller
Message-ID: <20170810042849.GU13670@umbus.fritz.box>
References: <1502182579-990-1-git-send-email-clg@kaod.org>
 <1502182579-990-3-git-send-email-clg@kaod.org>
 <20170809035306.GC13670@umbus.fritz.box>
 <f82c1111-3dd3-f378-0ff6-222bffc07a35@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="rW45g2D1DgwV0HVw"
In-Reply-To: <f82c1111-3dd3-f378-0ff6-222bffc07a35@kaod.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--rW45g2D1DgwV0HVw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 09, 2017 at 10:48:48AM +0200, C=E9dric Le Goater wrote:
> On 08/09/2017 05:53 AM, David Gibson wrote:
> > On Tue, Aug 08, 2017 at 10:56:12AM +0200, C=E9dric Le Goater wrote:
> >> This is the framework for using XIVE in a PowerVM guest. The support
> >> is very similar to the native one in a much simpler form.
> >>
> >> Instead of OPAL calls, a set of Hypervisors call are used to configure
> >> the interrupt sources and the event/notification queues of the guest:
> >>
> >>  - H_INT_GET_SOURCE_INFO
> >>
> >>    used to obtain the address of the MMIO page of the Event State
> >>    Buffer (PQ bits) entry associated with the source.
> >>
> >>  - H_INT_SET_SOURCE_CONFIG
> >>
> >>    assigns a source to a "target".
> >>
> >>  - H_INT_GET_SOURCE_CONFIG
> >>
> >>    determines to which "target" and "priority" is assigned to a source
> >>
> >>  - H_INT_GET_QUEUE_INFO
> >>
> >>    returns the address of the notification management page associated
> >>    with the specified "target" and "priority".
> >>
> >>  - H_INT_SET_QUEUE_CONFIG
> >>
> >>    sets or resets the event queue for a given "target" and "priority".
> >>    It is also used to set the notification config associated with the
> >>    queue, only unconditional notification for the moment.  Reset is
> >>    performed with a queue size of 0 and queueing is disabled in that
> >>    case.
> >>
> >>  - H_INT_GET_QUEUE_CONFIG
> >>
> >>    returns the queue settings for a given "target" and "priority".
> >>
> >>  - H_INT_RESET
> >>
> >>    resets all of the partition's interrupt exploitation structures to
> >>    their initial state, losing all configuration set via the hcalls
> >>    H_INT_SET_SOURCE_CONFIG and H_INT_SET_QUEUE_CONFIG.
> >>
> >>  - H_INT_SYNC
> >>
> >>    issue a synchronisation on a source to make sure sure all
> >>    notifications have reached their queue.
> >>
> >> As for XICS, the XIVE interface for the guest is described in the
> >> device tree under the interrupt controller node. A couple of new
> >> properties are specific to XIVE :
> >>
> >>  - "reg"
> >>
> >>    contains the base address and size of the thread interrupt
> >>    managnement areas (TIMA) for the user level for the OS level. Only
> >>    the OS level is taken into account.
> >>
> >>  - "ibm,xive-eq-sizes"
> >>
> >>    the size of the event queues.
> >>
> >>  - "ibm,xive-lisn-ranges"
> >>
> >>    the interrupt numbers ranges assigned to the guest. These are
> >>    allocated using a simple bitmap.
> >>
> >> Tested with a QEMU XIVE model for pseries and with the Power
> >> hypervisor
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >=20
> > I don't know XIVE well enough to review in detail, but I've made some
> > comments based on general knowledge.
>=20
> Thanks for taking a look.

np

[snip]
> >> +/* Cause IPI as setup by the interrupt controller (xics or xive) */
> >> +static void (*ic_cause_ipi)(int cpu);
> >> +
> >>  static void smp_pseries_cause_ipi(int cpu)
> >>  {
> >> -	/* POWER9 should not use this handler */
> >>  	if (doorbell_try_core_ipi(cpu))
> >>  		return;
> >> =20
> >> -	icp_ops->cause_ipi(cpu);
> >> +	ic_cause_ipi(cpu);
> >=20
> > Wouldn't it make more sense to change smp_ops->cause_ipi, rather than
> > having a double indirection through smp_ops, then the ic_cause_ipi
> > global?
>=20
> we need to retain the original setting of smp_ops->cause_ipi=20
> somewhere as it can be set from xive_smp_probe() to :=20
>=20
> 	icp_ops->cause_ipi=20
>=20
> or from xics_smp_probe() to :
>=20
> 	xive_cause_ipi()
>=20
> I am not sure we can do any better ?=20

I don't see why not.  You basically have two bits of options xics vs
xive, and doorbell vs no doorbells.  At worst that gives you 4
different versions of ->cause_ipi, and you can work out the right one
in smp_probe().  If the number of combinations got too much larger you
might indeed need some more indirection.  But with 4 there's a little
code duplication, but small enough that I think it's preferable to an
extra global and an extra indirection.

Also, will POWER9 always have doorbells?  In which case you could
reduce it to 3 options.

[snip]
> >> +static void xive_spapr_update_pending(struct xive_cpu *xc)
> >> +{
> >> +	u8 nsr, cppr;
> >> +	u16 ack;
> >> +
> >> +	/* Perform the acknowledge hypervisor to register cycle */
> >> +	ack =3D be16_to_cpu(__raw_readw(xive_tima + TM_SPC_ACK_OS_REG));
> >=20
> > Why do you need the raw_readw() + be16_to_cpu + mb, rather than one of
> > the higher level IO helpers?
>=20
> This is one of the many ways to do MMIOs on the TIMA. This memory=20
> region defines a set of offsets and sizes for which loads and=20
> stores have different effects.=20
>=20
> See the arch/powerpc/include/asm/xive-regs.h file and=20
> arch/powerpc/kvm/book3s_xive_template.c for some more usage.

Sure, much like any IO region.  My point is, why do you want this kind
of complex combo, rather than say an in_be16() or readw_be().

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--rW45g2D1DgwV0HVw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmL4P8ACgkQbDjKyiDZ
s5Jurg//aHuSvyOlIEk46Gr11B6QqOSLGm9+hA1aZQrB+LO9oMQmzlRtklrVBRqL
O2fQaQOQwOBIKBo4bF1PHUXM0nLu6kDks1qGa5f6O0msk1xOJSGzqBw208dF6Uhc
UaXW7+FSMnT+3vINUVc4sDd99PsoF+BKZWz/HI5AwSNz7oMydP08YB+od9PnS+9e
IUeAR3KMYoP8UPe1mwEk6wQktPSt071Eif3VEwWgyOS9oVV8AZWv4ZTRFGh7vOkM
oAqYM4XNJ8OstK7y/z4aAfXojFA4vdQPmBNf1kaBxtNiJ5Uka624znnwArNcN9ik
7UHWvsuV90tWMWIAQzJQJPD1u0Lyws7cW250UU8Q+NpBcSQU4AeFYrkty9SiNuD1
cvuDvxRG3Tk9X250HLCzq+9I7uBXqVnVquNH3F4nk9gKx+gRrK8+FQt7CXa6RWnv
iMQCqCI+kFP5bgHtlc1ZlqkwWJCdQSI+AZQ3aeXO47MMEi8822asnmFJOGJ0xcSs
9n4N3slJbJ1SdDmUraAnCKs+rGfQAtutjua+iE5L6qbfcc5H+e9ygWCHxXZ4VfaQ
Kj18VBqFJSXvFnJW14mEP9i4inUWHyHYeKLwKP1MW4/AaO0H37I8UHvrrHIeCKrX
DMPyAHVKctlkL055K1c/h+xBW0xkab6IWGmtOOWN+aZBFwejafc=
=ePGb
-----END PGP SIGNATURE-----

--rW45g2D1DgwV0HVw--
