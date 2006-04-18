Return-Path: <michael@ellerman.id.au>
Subject: Re: [patch][rfc]flattened device tree: Passing a dtb (blob) to Linux.
From: Michael Ellerman <michael@ellerman.id.au>
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <1145378886.5314.57.camel@cashmere.sps.mot.com>
References: <5148225C-AE27-4365-A1C2-40C46491AF0D@watson.ibm.com>
	<9B2C87C5-0B69-46E7-B48B-9CDB882836B2@watson.ibm.com>
	<20060413053614.2648467DE3@ozlabs.org>
	<C67D530F-2629-4D6B-986B-0FC7CFE525BF@watson.ibm.com>
	<1144926434.7777.5.camel@localhost.localdomain>
	<2A70CBD7-4A52-4599-8BEF-6AC633F62C83@watson.ibm.com>
	<1144938844.7777.16.camel@localhost.localdomain>
	<1145378886.5314.57.camel@cashmere.sps.mot.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-/BIaRc12a78S3s+EsHMj"
Date: Tue, 18 Apr 2006 20:04:11 +0200
Message-Id: <1145383451.20176.9.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Michael Neuling <mikey@neuling.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-/BIaRc12a78S3s+EsHMj
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-04-18 at 11:48 -0500, Jon Loeliger wrote:
> On Thu, 2006-04-13 at 09:34, Michael Ellerman wrote:
> > On Thu, 2006-04-13 at 09:19 -0400, Jimi Xenidis wrote:
> > > Actually, is this even an issue? can the LMB handle repeated =20
> > > reservations?
> >=20
> > It can, but we were thinking about adding code to check and warn if
> > reservations overlap, because it usually indicates a bug. Although
> > that's probably ok in this case, as long as dtc gets fixed eventually.
> > Another option would be to not warn for identical reservations.
>=20
> > > >>>>> NOTE: that the dtc must also not generate the blob reservation
> > > >>>>> entry.
>=20
> > > >> looking passed my own world I see:
> > > >>    - iSeries: not reserving the blob at all
> > > >
> > > > That sounds right. I think having the kernel do it is definitely th=
e
> > > > right option.
>=20
>=20
> OK, I'm back to reading the list and beginning to catch
> up some here...
>=20
> Let me see if I understand the consensus and direction:
>=20
>     1) DTC should NOT reserve its own blob space in the
>        memory map, as it does for generated ASM code now,
>=20
>     2) Kernel should reserve the blob space early so as
>        not to step on itself later,
>=20
>     3a) Kernel LMB handling should be modified to warn
>         for overlapping LMB reservations,
>=20
> Except that Ben says:
>=20
>     3b) We should make lmb_reserve() of redudant/overlapping
>         entries become harmless I think. We need to be
>         backward compatible with earlier blobs that do
>         contain themselves in the reserve map.
>=20
> I think we should interpret "harmless" to be "warn" and not
> cause an error at this point in time.
>=20
> I do not think we should have the blob generate its own
> reservation because it is possible that some post-processing
> (like U-Boot) can modify and extend it.  Only after that can
> the blob's true size be determined.  (Sure, it could update
> on the fly too... but double blah).
>=20
> In all of this, I'm on deck for step 1) above.

Nice summary :)
I'm up for 3a, we should make redundant/overlapping reserves "harmless",
by which I mean "not an error", but there should definitely be a warning
in the dmesg - as it will _usually_ indicate a bug.

cheers

--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-/BIaRc12a78S3s+EsHMj
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBERSoadSjSd0sB4dIRAp6lAKDNK077XflU/xQTruldPyi5wZ6M2wCePpgB
xR+RZncrpPAcQHjVd8GnaWo=
=Dzan
-----END PGP SIGNATURE-----

--=-/BIaRc12a78S3s+EsHMj--
