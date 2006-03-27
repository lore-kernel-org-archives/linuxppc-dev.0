Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] kdump: Fix for machine checkstop on DMA fault
From: Michael Ellerman <michael@ellerman.id.au>
To: Olof Johansson <olof@lixom.net>, Haren Myneni <hbabu@us.ibm.com>
In-Reply-To: <20060323201258.GA5538@pb15.lixom.net>
References: <44222462.2030103@us.ibm.com>
	<20060323053854.GA17693@pb15.lixom.net>
	<200603231706.35508.michael@ellerman.id.au>
	<20060323061904.GA22439@pb15.lixom.net>
	<20060323201258.GA5538@pb15.lixom.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-qmiRywNNeOZE8OFPZ4/a"
Date: Mon, 27 Mar 2006 16:04:58 +1100
Message-Id: <1143435899.28580.7.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Milton Miller <miltonm@bga.com>, Olaf Hering <olh@suse.de>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-qmiRywNNeOZE8OFPZ4/a
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-03-23 at 14:12 -0600, Olof Johansson wrote:
> On Thu, Mar 23, 2006 at 12:19:04AM -0600, Olof Johansson wrote:
>=20
> > The crash kernel needs to be even more careful, and instead read out
> > the entries that are mapped and reserve them. This would require a bit
> > more plumbing since there's no way to read an entry right now, but it'd
> > remove that hole.
>=20
> Actually, what's probably easier is to allocate some entries when the
> purgatory is set up, and make the crash kernel only use those by modifyin=
g
> the device tree accordingly. Sort of how regular memory is handled right
> now. That'd be a cleaner solution with less changes needed.
>=20
> The trick will be to get a decent size contiguous allocation, but the
> same applies for the memory reserve.

I disagree. In most cases the kdump kernel will be loaded by the boot
scripts, so reserving TCE space then is ~=3D reserving it for the life of
the first kernel. Given that TCE space is a scarce commodity I don't
think reserving it in the first kernel is a viable option.

What we should do is modify the second kernel so that instead of
clearing the TCE tables it instead walks the tables and detects existing
mappings, and then marks those as reserved so they're not overwritten.

This should give us 100% safety from the second kernel reusing a mapping
and copping a rogue DMA, and doesn't inflict any penalty on the first
kernel. It does fall down if there's no TCE space left for a device when
the second kernel comes up, but I think that's the best trade off.

cheers

--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-qmiRywNNeOZE8OFPZ4/a
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEJ3J5dSjSd0sB4dIRAqUjAJ9tJzC8T3sh9W7rPpNgfrg+TDljRgCeJyPP
63qdJePepotZJPhFxNcQDoM=
=WdQ3
-----END PGP SIGNATURE-----

--=-qmiRywNNeOZE8OFPZ4/a--
