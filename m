Date: Thu, 6 Jul 2000 13:14:09 -0400
From: Josh Huber <huber@mclinux.com>
To: "Peter R. Wood" <pwood@gordon.edu>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: GAIM compile error
Message-ID: <20000706131409.C820@mclx.com>
References: <Pine.LNX.4.21.0007061254230.8579-100000@dyn-133-196.gordon.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="d01dLTUuW90fS44H"
In-Reply-To: <Pine.LNX.4.21.0007061254230.8579-100000@dyn-133-196.gordon.edu>; from pwood@gordon.edu on Thu, Jul 06, 2000 at 01:01:20PM -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--d01dLTUuW90fS44H
Content-Type: multipart/mixed; boundary="eRtJSFbw+EEWtPj3"
Content-Disposition: inline


--eRtJSFbw+EEWtPj3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 06, 2000 at 01:01:20PM -0400, Peter R. Wood wrote:
>=20
> Hello,
>=20
> I've contacted the authors of GAIM regarding this problem, but they don't
> seem to have a clue about it so I thought I'd submit it here. I'm trying
> to compile GAIM, the AOL instant messenger clone, from its CVS source.  I
> get this error during the compile:
[snip]

grr, more va_arg errors :)

Attached is a patch that I'll forward onto the maintainer.

--=20
Josh
6B21489A | GnuPG ID/Fingerprint | huber@mclx.com |
61F0 6138 BE7B FEBF A223  E9D1 BFE1 2065 6B21 489A

--eRtJSFbw+EEWtPj3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="gaim.diff"
Content-Transfer-Encoding: quoted-printable

--- oscar.c	Thu Jul  6 13:12:42 2000
+++ oscar.c.orig	Thu Jul  6 13:11:09 2000
@@ -534,8 +534,8 @@
 		userinfo  =3D va_arg(ap, struct aim_userinfo_s *);
 		msg       =3D va_arg(ap, char *);
 		icbmflags =3D va_arg(ap, u_int);
-		flag1     =3D (u_short)va_arg(ap, u_int);
-		flag2     =3D (u_short)va_arg(ap, u_int);
+		flag1     =3D va_arg(ap, u_short);
+		flag2     =3D va_arg(ap, u_short);
 		va_end(ap);
=20
 		serv_got_im(userinfo->sn, msg, icbmflags & AIM_IMFLAGS_AWAY);
@@ -624,7 +624,7 @@
 	info =3D va_arg(ap, struct aim_userinfo_s *);
 	prof_enc =3D va_arg(ap, char *);
 	prof =3D va_arg(ap, char *);
-	infotype =3D (u_short)va_arg(ap, u_int);
+	infotype =3D va_arg(ap, u_short);
 	va_end(ap);
=20
 	if (prof =3D=3D NULL || !strlen(prof)) {
@@ -655,7 +655,7 @@
 	va_list ap;
=20
 	va_start(ap, command);
-	id  =3D (u_short)va_arg(ap, u_int);
+	id  =3D va_arg(ap, u_short);
 	msg =3D va_arg(ap, char *);
 	va_end(ap);
=20
@@ -674,7 +674,7 @@
 	u_short type;
=20
 	va_start(ap, command);
-	type =3D (u_short)va_arg(ap, u_int);
+	type =3D va_arg(ap, u_short);
=20
 	switch(type) {
 		case 0x0002: {

--eRtJSFbw+EEWtPj3--

--d01dLTUuW90fS44H
Content-Type: application/pgp-signature
Content-Disposition: inline


--d01dLTUuW90fS44H--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
