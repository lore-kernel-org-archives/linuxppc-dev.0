Date: Wed, 27 Jun 2001 11:25:42 -0500
From: Stephen R Marenka <stephen@marenka.net>
To: Takashi Oe <toe@unlserve.unl.edu>
Cc: Tom Rini <trini@kernel.crashing.org>, benh@kernel.crashing.org,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Crash on BenH's latest rsync (2.4.6-pre3)
Message-ID: <20010627112542.A486@marenka.net>
References: <20010626121003.D31231@opus.bloom.county> <20010626205147.26310@smtp.wanadoo.fr> <20010626162913.3dc483d8.toe@unlserve.unl.edu> <20010626151346.F31231@opus.bloom.county> <20010626173123.13f2b3bf.toe@unlserve.unl.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
In-Reply-To: <20010626173123.13f2b3bf.toe@unlserve.unl.edu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 26, 2001 at 05:31:23PM -0500, Takashi Oe wrote:
>=20
> On Tue, 26 Jun 2001 15:13:46 -0700, Tom Rini wrote:
>=20
> > On Tue, Jun 26, 2001 at 04:29:13PM -0500, Takashi Oe wrote:
> >
> > > BootX support on your rsync tree and linuxppc_2_4_devel tree is
> > > broken.  I guess no one with BootX bothered to try
> > > linuxppc_2_4_devel..
> >
> > Does this work as well?
>=20
> It sure does, though we might as well do:
>=20
> 	if (boot_infos) {
> 		_machine =3D _MACH_Pmac;
> 		relocate_nodes();
> 	}
>=20
> or similar as calling intuit_machine_type() is silly on BootX ;)

If I understand correctly, this failed for me because this causes=20
relocate_nodes to get called again if have_of.

The following does work for me.

 	if (boot_infos) {
 		_machine =3D _MACH_Pmac;
                if ( !have_of )
 		    relocate_nodes();
 	}

Thanks,

Stephen

--=20
Stephen R. Marenka     If life's not fun, you're not doing it right!
<stephen@marenka.net>

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature
Content-Disposition: inline


--mP3DRpeJDSE+ciuQ--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
