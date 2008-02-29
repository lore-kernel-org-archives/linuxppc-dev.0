Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 3/3] ppc64-specific memory notifier support
From: Michael Ellerman <michael@ellerman.id.au>
To: Nathan Lynch <ntl@pobox.com>
In-Reply-To: <20080229003906.GP16241@localdomain>
References: <1204217028.28696.10.camel@dyn9047017100.beaverton.ibm.com>
	<1204217166.28696.15.camel@dyn9047017100.beaverton.ibm.com>
	<1204243875.7729.3.camel@concordia.ozlabs.ibm.com>
	<20080229003906.GP16241@localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-DVk/HNNQ/fNHg0za3Cyb"
Date: Fri, 29 Feb 2008 12:03:22 +1100
Message-Id: <1204247002.7729.11.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Badari Pulavarty <pbadari@us.ibm.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-DVk/HNNQ/fNHg0za3Cyb
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2008-02-28 at 18:39 -0600, Nathan Lynch wrote:
> Michael Ellerman wrote:
> > On Thu, 2008-02-28 at 08:46 -0800, Badari Pulavarty wrote:
> > > Hotplug memory notifier for ppc64. This gets invoked by writing
> > > the device-node that needs to be removed to /proc/ppc64/ofdt.
> > > We need to adjust the sections and remove sysfs entries by
> > > calling __remove_pages(). Then call arch specific code to
> > > get rid of htab mappings for the section of memory.
> > >=20
> > > Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>
> > > ---
> > >  arch/powerpc/platforms/pseries/Makefile         |    1=20
> > >  arch/powerpc/platforms/pseries/hotplug-memory.c |   98 +++++++++++++=
+++++++++++
> > >  2 files changed, 99 insertions(+)
> > >=20
> > > Index: linux-2.6.25-rc2/arch/powerpc/platforms/pseries/hotplug-memory=
.c
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> > > +++ linux-2.6.25-rc2/arch/powerpc/platforms/pseries/hotplug-memory.c	=
2008-02-28 08:20:14.000000000 -0800
> >=20
> > > +
> > > +static struct notifier_block pseries_smp_nb =3D {
> > > +	.notifier_call =3D pseries_memory_notifier,
> > > +};
> > > +
> > > +static int __init pseries_memory_hotplug_init(void)
> > > +{
> > > +	if (firmware_has_feature(FW_FEATURE_LPAR))
> > > +		pSeries_reconfig_notifier_register(&pseries_smp_nb);
> > > +
> > > +	return 0;
> > > +}
> > > +arch_initcall(pseries_memory_hotplug_init);
> >=20
> > This is going to fire on non-pseries LPAR platforms, like iSeries and
> > PS3. Which is not what you want I think.
>=20
> Well, the notifier will be registered, yes, but it will never be
> called because that path is reachable only from a write to
> /proc/ppc64/ofdt, which is not created on non-pseries.

Sure. Still seems better not to register it in the first place.

> Maybe it should be
>=20
> machine_device_initcall(pseries, pseries_memory_hotplug_init);

I think so.

> (and pseries_cpu_hotplug_init in hotplug-cpu.c should be changed to
> machine_arch_initcall)

Yeah I noticed that was not guarded as well, and I think I'm culpable
for that :)

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-DVk/HNNQ/fNHg0za3Cyb
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHx1nadSjSd0sB4dIRAgfjAJ91kt4A2JwSE+5R/breesd+Jx23cACfVhva
IOcDg7uKLW78qYWR+6SEubc=
=mLMt
-----END PGP SIGNATURE-----

--=-DVk/HNNQ/fNHg0za3Cyb--
