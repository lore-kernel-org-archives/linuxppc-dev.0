Return-Path: <jbglaw@lug-owl.de>
Received: from lug-owl.de (lug-owl.de [195.71.106.12])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 40D8BDDF41
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Mar 2007 03:57:51 +1100 (EST)
Date: Fri, 9 Mar 2007 17:38:05 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH] Complain about missing system calls.
Message-ID: <20070309163805.GV18564@lug-owl.de>
References: <1173394873.3461.510.camel@pmac.infradead.org>
	<p737itqbdnl.fsf@bingen.suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qa1NXTiqN6KSzHv0"
In-Reply-To: <p737itqbdnl.fsf@bingen.suse.de>
Cc: akpm@osdl.org, linux-arch@vger.kernel.org, sam@ravnborg.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	David Woodhouse <dwmw2@infradead.org>, rmk@arm.linux.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--qa1NXTiqN6KSzHv0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-03-09 17:11:10 +0100, Andi Kleen <andi@firstfloor.org> wrote:
> David Woodhouse <dwmw2@infradead.org> writes:
> > Most system calls seem to get added to i386 first. This patch
> > automatically generates a warning for any new system call which is
> > implemented on i386 but not the architecture currently being compiled.
> > On PowerPC at the moment, for example, it results in these warnings:
> > init/missing_syscalls.h:935:3: warning: #warning syscall sync_file_rang=
e not implemented
> > init/missing_syscalls.h:947:3: warning: #warning syscall getcpu not imp=
lemented
> > init/missing_syscalls.h:950:3: warning: #warning syscall epoll_pwait no=
t implemented
>=20
> I think a better solution would be to finally switch to auto generated
> system call tables for newer system calls. The original reason why the
> architectures have different system call numbers -- compatibility with
> another "native" Unix -- is completely obsolete now. This leaves only
> minor differences of compat stub vs non compat stub and a few
> architecture specific calls.
>=20
> Of course the existing syscall numbers can't be changed, but for all new=
=20
> calls one could just add automatically for everybody.
>=20
> A global table with two entries (compat and non compat) and a per arch=20
> override table should be sufficient.

Not everybody has a simple indexed list of pointers :)  For example,
for vax-linux, we use a struct per syscall with the expected number of
on-stack longwords for the call.

So if something "new" is coming up, please keep in mind that it should
be flexible enough to represent that. :)

MfG, JBG

--=20
      Jan-Benedict Glaw      jbglaw@lug-owl.de              +49-172-7608481
Signature of:         "really soon now":      an unspecified period of time=
, likly to
the second  :                                 be greater than any reasonabl=
e definition
                                              of "soon".

--qa1NXTiqN6KSzHv0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFF8Y1tHb1edYOZ4bsRAtTbAJ9pGP5OP+CAJDhS2ToKtazUmhEdAACfWTh8
7TLIUGzDrO/z2z3buGDL3uI=
=R054
-----END PGP SIGNATURE-----

--qa1NXTiqN6KSzHv0--
