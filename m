Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: disable MSI using new interface if possible
From: Michael Ellerman <michael@ellerman.id.au>
To: Nishanth Aravamudan <nacc@us.ibm.com>
In-Reply-To: <20110308053413.GA26971@us.ibm.com>
References: <1299200729.3630.52.camel@concordia>
	<1299202862-10682-1-git-send-email-nacc@us.ibm.com>
	<1299207684.3630.76.camel@concordia> <20110304072444.GA2080@us.ibm.com>
	<20110308053413.GA26971@us.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-3k+1kq9pNO+WubYKV7nv"
Date: Thu, 10 Mar 2011 09:54:06 +1100
Message-ID: <1299711246.6272.4.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org, miltonm@bga.com
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-3k+1kq9pNO+WubYKV7nv
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2011-03-07 at 21:34 -0800, Nishanth Aravamudan wrote:
> On 03.03.2011 [23:24:44 -0800], Nishanth Aravamudan wrote:
> > On 04.03.2011 [14:01:24 +1100], Michael Ellerman wrote:
> > > Looking closer at your patch, now I don't understand :)
> > >=20
> > > +       /*
> > > +        * disabling MSI with the explicit interface also disables MS=
I-X
> > > +        */
> > > +       if (rtas_change_msi(pdn, RTAS_CHANGE_MSI_FN, 0) !=3D 0) {
> > >=20
> > >=20
> > > So we first disable using function 3, which should:
> > >=20
> > >         3: Request to set to a new number of MSI interrupts (includin=
g set to 0)
> > >=20
> > > Which does not mention MSI-X at all, implying it has no effect on the=
m.
> > > Which contradicts what you see, and the comment in the code?
> >=20
> > Thanks for the thorough review!
> >=20
> > Per PAPR 2.4 from Power.org, look at the page before that table, page
> > 169:
> >=20
> > "Specifying Function 3 (MSI) also disables MSI-X for the specified IOA
> > function, and likewise specifying Function 4 (MSI-X) disables MSI for
> > the IOA function....Specifying the Requested Number of Interrupts to
> > zero for either Function 3 or 4 removes all MSI & MSI-X interrupts from
> > the IOA function."
> >=20
> > So I'm relying on this aspect of PAPR being enforced by the firmware,
> > which I think it is in my testing.
>=20
> Given all that, do I have your Ack? :)

Indeed. Thanks for clarifying it.

Acked-by: Michael Ellerman <michael@ellerman.id.au>

cheers

--=-3k+1kq9pNO+WubYKV7nv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk14BQsACgkQdSjSd0sB4dKO1wCgik+T7eFAkXySL6416ziUmjjj
I6IAn1DI0OTgghy+YHQMiubk61yxdXrk
=DJxq
-----END PGP SIGNATURE-----

--=-3k+1kq9pNO+WubYKV7nv--
