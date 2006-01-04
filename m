Return-Path: <stefan.eletzhofer@inquant.de>
From: Stefan Eletzhofer <stefan.eletzhofer@inquant.de>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20060103141725.08E8D3540BC@atlas.denx.de>
References: <20060103141725.08E8D3540BC@atlas.denx.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-EPWgNGLQ6m9clMA7PY1T"
Date: Wed, 04 Jan 2006 14:08:05 +0100
Message-Id: <1136380085.15908.15.camel@localhost>
Mime-Version: 1.0
Cc: Linuxppc-embedded@ozlabs.org
Subject: Re: "argument list too long"
Reply-To: stefan.eletzhofer@inquant.de
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--=-EPWgNGLQ6m9clMA7PY1T
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

Am Dienstag, den 03.01.2006, 15:17 +0100 schrieb Wolfgang Denk:
> In message <f8bc181b0601030606x3b29ee28q@mail.gmail.com> you wrote:
> >
> > After a few minutes of dependency creation, I get the following error
> > "argument list too long":
> >=20
> > scripts/mkdep -- `find
> > /usr/src/linuxppc_2_4_devel-2005-10-25-1440/include/asm
> > /usr/src/linuxppc_2_4
> > _devel-2005-10-25-1440/include/linux
> > /usr/src/linuxppc_2_4_devel-2005-10-25-1440/include/scsi /usr/s
> > rc/linuxppc_2_4_devel-2005-10-25-1440/include/net
> > /usr/src/linuxppc_2_4_devel-2005-10-25-1440/includ
> > e/math-emu \( -name SCCS -o -name .svn \) -prune -o -follow -name \*.h =
!
> > -name modversions.h -print`
> >  > .hdepend
> > scripts/mkdep: argument list too long
> > make: *** [dep-files] Error 2
> >=20
> > Can someone help me understand where that comes from?
>=20
> The error comes from the fact that the  find  command  (the  part  in
> `...`  above)  generates a long list of file names which exceeds some
> buffer in your shell.
>=20
> > Does it have something to do with the fact that I work under WinXP + Cy=
gwin?
>=20
> Yes.
>=20
> > No need to say that I am a newbie to the Linux world... help me, Wolfga=
ng
> > :-)
>=20
> I try. Find the statement in the Makefile and use xargs  to  avoid  a
> long argument list. Something like this might help:
>=20
> --- Makefile.ORIG	2006-01-03 15:15:48.000000000 +0100
> +++ Makefile	2006-01-03 15:16:55.000000000 +0100
> @@ -503,7 +503,7 @@
>  ifdef CONFIG_MODVERSIONS
>  	$(MAKE) update-modverfile
>  endif
> -	scripts/mkdep -- `find $(FINDHPATH) \( -name SCCS -o -name .svn \) -pru=
ne -o -follow -name \*.h ! -name modversions.h -print` > .hdepend
> +	find $(FINDHPATH) \( -name SCCS -o -name .svn \) -prune -o -follow -nam=
e \*.h ! -name modversions.h -print | xargs scripts/mkdep -- > .hdepend
>  	scripts/mkdep -- init/*.c > .depend

Would'nt this overwrite .depend if xargs executes mkdep more than once?
I'd suggest (beware, manually hacked diff ;):

--- Makefile.ORIG 2006-01-03 15:15:48.000000000 +0100
+++ Makefile	2006-01-03 15:16:55.000000000 +0100
@@ -503,7 +503,7 @@
 ifdef CONFIG_MODVERSIONS
 	$(MAKE) update-modverfile
 endif
-	scripts/mkdep -- `find $(FINDHPATH) \( -name SCCS -o -name .svn \) -prune=
 -o -follow -name \*.h ! -name modversions.h -print` > .hdepend
+	rm -f .depend && find $(FINDHPATH) \( -name SCCS -o -name .svn \) -prune =
-o -follow -name \*.h ! -name modversions.h -print | xargs scripts/mkdep --=
 > .hdepend
 	scripts/mkdep -- init/*.c >> .depend

> =20
>  ifdef CONFIG_MODVERSIONS
>=20
>=20
>=20
> Best regards,
>=20
> Wolfgang Denk
>=20
--=20
Stefan Eletzhofer
InQuant GmbH
Bahnhofstra=C3=9Fe 11
D-88214 Ravensburg
http://www.inquant.de
http://www.eletztrick.de
+49 (0) 751 35 44 112
+49 (0) 171 23 24 529 (Mobil)
+49 (0) 751 35 44 115 (FAX)

--=-EPWgNGLQ6m9clMA7PY1T
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDu8i120PMGlcwuNARAgHwAKCq2C6Y7R96MWke84E0XdE2Iejg6QCfS14E
w9x+Li7WUW60XQ2Xk20qWU4=
=ORnm
-----END PGP SIGNATURE-----

--=-EPWgNGLQ6m9clMA7PY1T--
