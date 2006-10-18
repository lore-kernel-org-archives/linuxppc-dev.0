Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 1/2] Add support for stopping spus from xmon
From: Michael Ellerman <michael@ellerman.id.au>
To: Haren Myneni <haren@us.ibm.com>
In-Reply-To: <452F03AB.7030505@us.ibm.com>
References: <20061012120310.6B5A967BD5@ozlabs.org>
	<452F03AB.7030505@us.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-7vXhKxOwSFwg9z838oWG"
Date: Wed, 18 Oct 2006 17:16:33 +1000
Message-Id: <1161155793.7906.21.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>,
	cbe-oss-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-7vXhKxOwSFwg9z838oWG
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-10-12 at 20:10 -0700, Haren Myneni wrote:
> Michael Ellerman wrote:
>=20
> >This patch adds support for stopping, and restarting, spus
> >from xmon. We use the spu master runcntl bit to stop execution,
> >this is apparently the "right" way to control spu execution and
> >spufs will be changed in the future to use this bit.
> >
> >Testing has shown that to restart execution we have to turn the
> >master runcntl bit on and also rewrite the spu runcntl bit, even
> >if it is already set to 1 (running).
> >
> >Stopping spus is triggered by the xmon command 'ss' - "spus stop"
> >perhaps. Restarting them is triggered via 'sr'. Restart doesn't
> >start execution on spus unless they were running prior to being
> >stopped by xmon.
> >
> >Walking the spu->full_list in xmon after a panic, would mean
> >corruption of any spu struct would make all the others
> >inaccessible. To avoid this, and also to make the next patch
> >easier, we cache pointers to all spus during boot.
> >
> >We attempt to catch and recover from errors while stopping and
> >restarting the spus, but as with most xmon functionality there are
> >no guarantees that performing these operations won't crash xmon
> >itself.
> >
> > =20
> >
> I think, kdump also need stop_spus() functionality when the dump support=20
> is included on cell. If so, how about both stop_spus() and start_spus()=20
> in platforms/cell/.

Good point. We haven't got that far with kdump on cell so I hadn't
thought of it. We won't need start_spus(), but we will need something to
stop spus for kdump. I'll leave it for now, but keep it in mind for when
we get kdump going on cell.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-7vXhKxOwSFwg9z838oWG
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBFNdTRdSjSd0sB4dIRAu3FAKC6yTh1pw1nUVpm/XyK6egcqbWbHwCgq5we
BJIhMQFWWcoti6Q57KLuDbE=
=aq6k
-----END PGP SIGNATURE-----

--=-7vXhKxOwSFwg9z838oWG--
