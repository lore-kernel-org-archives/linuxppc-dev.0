Return-Path: <dgibson@ozlabs.org>
Date: Thu, 20 Sep 2007 09:40:16 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: "S. Fricke" <silvio.fricke@gmail.com>
Subject: Re: Configuration-Problem ext-interrupt on mpc52xx
Message-ID: <20070919234016.GA14404@localhost.localdomain>
References: <20070919115952.GF5682@sfrouter>
	<fa686aa40709190809v284618d4r65674a1409ab0b57@mail.gmail.com>
	<20070919190146.GI5682@sfrouter>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
In-Reply-To: <20070919190146.GI5682@sfrouter>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 19, 2007 at 09:01:46PM +0200, S. Fricke wrote:
> Hello,
>=20
> > On 9/19/07, S. Fricke <silvio.fricke@googlemail.com> wrote:
> > > Hi,
> > >
> > > how can i configure an "ext interrupt" to high-level? I want a interr=
uption on
> > > IRQ2, but I checked with an oscilloscope that the pin has a low state=
 and I
> > > needs a high state.
> > >
> > > I have tried, after I got the irq (with irq_of_parse_and_map), set it=
 with
> > >
> > >     set_irq_type(irq, IRQ_TYPE_LEVEL_HIGH);
> > >
> > > But I think it is a system-configuration (irq_desc) and no
> > > device-configuration.
> >=20
> > You shouldn't need to do this.  You set your sense level in the device =
tree.
> >=20
> > From your previous email, your device node looks like this:
> > >             intpin@0 {
> > >                 interrupt-parent =3D <500>;
> > >                 interrupts =3D <1 2 2>;
> > >             };
> >=20
> > Which is IRQ2, EDGE_FALLING.
> >=20
> > If you change your interrupts property to <1 2 0>, then your sense is
> > set to LEVEL_HIGH.  (Seriously, you need to read the interrupts
> > section of Documentation/powerpc/mpc52xx-device-tree-bindings.txt.)
>=20
> I have read it! But another driver on Boot-time pulled my interrupt

Erm.. if the interrupt is shared with something else which expects a
different trigger/polarity, you're kind of stuffed....

> to low, I can't do anything except for looking at the oscilloscope
>=20
> I'm going to disable all unneeded drivers tomorrow morning.
>=20
> TIA:
> Silvio Fricke
>=20



> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG8bNgaILKxv3ab8YRAsN3AJwIUiwbDq6NQt+Wc/8MDAhEP+mwuwCeOY+s
0qA8+r5W7yUggJAcvJSTUiw=
=bmDo
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
