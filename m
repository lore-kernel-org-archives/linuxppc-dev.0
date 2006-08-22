Return-Path: <michael@ellerman.id.au>
Subject: Re: Take 2: [RFC] Debugging with a HW probe.
From: Michael Ellerman <michael@ellerman.id.au>
To: Milton Miller <miltonm@bga.com>
In-Reply-To: <aa3478a76dd7fb5bff781350a7538fb0@bga.com>
References: <aa3478a76dd7fb5bff781350a7538fb0@bga.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-YOi9qGBLhgiRkxV5b+OD"
Date: Tue, 22 Aug 2006 17:13:28 +1000
Message-Id: <1156230808.13596.3.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-YOi9qGBLhgiRkxV5b+OD
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-08-22 at 01:04 -0500, Milton Miller wrote:
> On Aug 14, 2006, at 5:16 AM, Jimi Xenidis jimix at watson.ibm.com =20
> > @@ -693,6 +696,11 @@ #ifdef CONFIG_PPC64
> >         if (of_get_flat_dt_prop(node, "linux,iommu-force-on", NULL) !=
=3D=20
> > NULL)
> >                 iommu_force_on =3D 1;
> >  #endif
> > +#ifdef CONFIG_HW_PROBE_ENABLE
> > +       if (of_get_flat_dt_prop(node, "linux,hw-probe-enable", NULL)=20
> > !=3D NULL) {
> > +               hw_probe_enabled =3D 1;
> > +               DBG("HW Probe will be enabled\n");
> > +#endif
>=20
> No.  [see next comment]
>=20
> >
> >         /* mem=3Dx on the command line is the preferred mechanism */
> >         lprop =3D of_get_flat_dt_prop(node, "linux,memory-limit", NULL)=
;
> > diff --git a/arch/powerpc/kernel/prom_init.c=20
> > b/arch/powerpc/kernel/prom_init.c
> > index 90972ef..26428de 100644
> > --- a/arch/powerpc/kernel/prom_init.c
> > +++ b/arch/powerpc/kernel/prom_init.c
> > @@ -587,6 +587,14 @@ #ifdef CONFIG_PPC64
> >                         RELOC(iommu_force_on) =3D 1;
> >         }
> >  #endif
> > +#ifdef CONFIG_HW_PROBE_ENABLE
> > +       opt =3D strstr(RELOC(prom_cmd_line), RELOC("hwprobe"));
> > +       if (opt) {
> > +               prom_printf("WARNING! HW Probe will be activated!\n");
> > +               prom_setprop(_prom->chosen, "/chosen",
> > +                            "linux,hw-probe-enable", NULL, 0);
> > +       }
> > +#endif
> >  }
>=20
> Please, PLEASE do NOT do this.
>=20
> prom_init.c is only used by one of the many flat device tree generators,
> namely the open-firmware client.  Adding a property like this requires=20
> us
> to update all the other clients.
>=20
> And there is no reason to parse it this early.
>=20
> Instead, parse it from the command line like the other early parsing.
>=20
> I thing a generic early_param would be fine.  However, xmon_init is an
> early_parm in setup-common, so if you really require it before the first
> call, then you could parse it next to mem=3D at the bottom of
> early_init_dt_scan_chosen.

What Milton said, we learnt that the hard way with kexec :)

Except that we don't do mem=3D in early_init_dt_scan_chosen anymore (get a
newer kernel Milton!).

The early_param parsing is done very early, and the xmon=3D parsing does
not jump into xmon, it waits until a little later before doing it. So an
early_param should be fine, ie. it will be parsed before xmon ever runs.

cheers

--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-YOi9qGBLhgiRkxV5b+OD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBE6q6WdSjSd0sB4dIRAko7AKCplwQ1QqiMHJMmdso7SLvORA6ecACfYmdG
0QZK0RWIHog++FbBrND8KZE=
=+xub
-----END PGP SIGNATURE-----

--=-YOi9qGBLhgiRkxV5b+OD--
