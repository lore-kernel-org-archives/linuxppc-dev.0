Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 1/8] pseries: phyp dump: Docmentation
From: Michael Ellerman <michael@ellerman.id.au>
To: linasvepstas@gmail.com
In-Reply-To: <3ae3aa420801091847l189df8dwb2348624f0267af@mail.gmail.com>
References: <4782B985.2090508@austin.ibm.com>
	<4782C026.8080302@austin.ibm.com> <20080109042911.GT14201@localdomain>
	<3ae3aa420801090731r2e25e42awcae385b448e20b16@mail.gmail.com>
	<20080109184437.GU14201@localdomain>
	<1199919545.7880.11.camel@concordia>
	<3ae3aa420801091847l189df8dwb2348624f0267af@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-l3v6gO9fcFW0k6BQA2On"
Date: Thu, 10 Jan 2008 14:55:50 +1100
Message-Id: <1199937350.7880.30.camel@concordia>
Mime-Version: 1.0
Cc: mahuja@us.ibm.com, linuxppc-dev@ozlabs.org, lkessler@us.ibm.com,
	Nathan Lynch <ntl@pobox.com>, strosake@us.ibm.com
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-l3v6gO9fcFW0k6BQA2On
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2008-01-09 at 20:47 -0600, Linas Vepstas wrote:
> On 09/01/2008, Michael Ellerman <michael@ellerman.id.au> wrote:
> >
> > > > Only if you can get at rtas, but you can't get at rtas at that poin=
t.
> >
> > AFAICT you don't need to get at RTAS, you just need to look at the
> > device tree to see if the property is present, and that is trivial.
> >
> > You probably just need to add a check in early_init_dt_scan_rtas() whic=
h
> > sets a flag for the PHYP dump stuff, or add your own scan routine if yo=
u
> > need.
>=20
> I no longer remember the details. I do remember spending a lot of time
> trying to figure out how to do this. I know I didn't want to write my own=
 scan
> routine; maybe that's what stopped me.  As it happens, we also did most
> of the development on a broken phyp which simply did not even have
> this property, no matter what, and so that may have brain-damaged me.

Sure, the API docs for the kernel are a little lacking ;)

> I went for the "most elegant" solution, where "most elegant" is defined
> as "fewest lines of code", "least effort", etc.
>=20
> Manish may need some hands-on help to extract this token during
> early boot.  Hopefully, he'll let us know.

It would just be something like:

--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -901,6 +901,11 @@ int __init early_init_dt_scan_rtas(unsigned long node,
                rtas.size =3D *sizep;
        }
=20
+#ifdef CONFIG_PHYP_DUMP
+       if (of_get_flat_dt_prop(node, "ibm,dump-kernel", NULL))
+               phyp_dump_is_active++;
+#endif
+
 #ifdef CONFIG_UDBG_RTAS_CONSOLE
        basep =3D of_get_flat_dt_prop(node, "put-term-char", NULL);
        if (basep)


Or to do your own scan routine:


diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index acc0d24..442134e 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -1022,6 +1022,7 @@ void __init early_init_devtree(void *params)
        /* Some machines might need RTAS info for debugging, grab it now. *=
/
        of_scan_flat_dt(early_init_dt_scan_rtas, NULL);
 #endif
+       of_scan_flat_dt(early_init_dt_scan_phyp_dump, NULL);
=20
        /* Retrieve various informations from the /chosen node of the
         * device-tree, including the platform type, initrd location and
diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index 52e95c2..af2b6e8 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -883,6 +883,19 @@ void __init rtas_initialize(void)
 #endif
 }
=20
+int __init early_init_dt_scan_phyp_dump(unsigned long node,
+               const char *uname, int depth, void *data)
+{
+#ifdef CONFIG_PHYP_DUMP
+       if (depth !=3D 1 || strcmp(uname, "rtas") !=3D 0)
+               return 0;
+
+       if (of_get_flat_dt_prop(node, "ibm,dump-kernel", NULL))
+               phyp_dump_is_active++;
+#endif
+       return 1;
+}
+
 int __init early_init_dt_scan_rtas(unsigned long node,
                const char *uname, int depth, void *data)
 {


cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-l3v6gO9fcFW0k6BQA2On
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD4DBQBHhZdGdSjSd0sB4dIRAuSWAKCmU2NeGl0YxcCa+YhL3VPfI4yWqwCYzoI+
Hlak+3t2lPd4402kBkSJHQ==
=RPu3
-----END PGP SIGNATURE-----

--=-l3v6gO9fcFW0k6BQA2On--
