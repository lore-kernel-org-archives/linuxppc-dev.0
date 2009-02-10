Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] Only disable/enable LSI interrupts in EEH
From: Michael Ellerman <michael@ellerman.id.au>
To: linasvepstas@gmail.com
In-Reply-To: <3ae3aa420902100914t572da49chf22b5fdda644033f@mail.gmail.com>
References: <4990EF8B.7060203@us.ibm.com>
	<3ae3aa420902100914t572da49chf22b5fdda644033f@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-aI87LJYd/URHoCpfC/G3"
Date: Wed, 11 Feb 2009 10:38:26 +1100
Message-Id: <1234309106.8323.11.camel@localhost>
Mime-Version: 1.0
Cc: paulus@samba.org, linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-aI87LJYd/URHoCpfC/G3
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2009-02-10 at 11:14 -0600, Linas Vepstas wrote:
> 2009/2/9 Mike Mason <mmlnx@us.ibm.com>:
> > The EEH code disables and enables interrupts during the
> > device recovery process.  This is unnecessary for MSI
> > and MSI-X interrupts because they are effectively disabled
> > by the DMA Stopped state when an EEH error occurs.  The current code is=
 also
> > incorrect for MSI-X interrupts.  It
> > doesn't take into account that MSI-X interrupts are tracked
> > in a different way than LSI/MSI interrupts.  This patch ensures only LS=
I
> > interrupts are disabled/enabled.
> >
> > The patch also includes a couple minor formatting fixes.
> >
> >
> > Signed-off-by: Mike Mason <mmlnx@us.ibm.com>
>=20
> Looks good to me.
> Acked-by: Linas Vepstas <linasvepstas@gmail.com>
>=20
> On a somewhat-related note: there was an issue (I forget
> the details) where the kernel needed to shadow some sort
> of MSI state so that it could be correctly, um, kept-track-of,
> after an EEH reset (it didn't need to be restored, because
> firmware did this(?)).  After some digging around and
> discussion, we concluded that some generic PPC MSI
> code needed to be altered to track this state, and/or
> the main kernel MSI code needed to be changed to
> (not?) track this state.  Mike Ellerman seemed to best
> grasp this area ... was this ever fixed?
>=20
> Or perhaps this is an alternate fix for that bug? It may
> well have been that calling the MSI disable triggered
> the problem, I don't remember now.

I'm pretty sure you're referring to this patch, which you acked :)

http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dcomm=
it;h=3D1db3e890aed3ac39cded30d6e94618bda086f7ce

I don't know of anything else that fits your description?

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-aI87LJYd/URHoCpfC/G3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkmSD/IACgkQdSjSd0sB4dJLBgCgtJ1lyH2XBCa3NtMAF7KUNCho
pWYAn3pk0kU0EMtoi5Z4HWrSMEwTK3/6
=0H2Z
-----END PGP SIGNATURE-----

--=-aI87LJYd/URHoCpfC/G3--
