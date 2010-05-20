Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH RT] ehea: make receive irq handler non-threaded
	(IRQF_NODELAY)
From: Michael Ellerman <michael@ellerman.id.au>
To: Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <alpine.LFD.2.00.1005192244430.3368@localhost.localdomain>
References: <4BF30793.5070300@us.ibm.com>
	<4BF30C32.1020403@linux.vnet.ibm.com>  <4BF31322.5090206@us.ibm.com>
	<1274232324.29980.9.camel@concordia> <4BF3F2DB.7030701@us.ibm.com>
	<alpine.LFD.2.00.1005191620350.3368@localhost.localdomain>
	<alpine.LFD.2.00.1005192244430.3368@localhost.localdomain>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-aiq25ZM3gW5ZVbBYYhS/"
Date: Thu, 20 May 2010 11:34:08 +1000
Message-ID: <1274319248.22892.40.camel@concordia>
Mime-Version: 1.0
Cc: Darren Hart <dvhltc@us.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	dvhltc@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
	Will Schmidt <will_schmidt@vnet.ibm.com>,
	Brian King <brking@linux.vnet.ibm.com>, niv@linux.vnet.ibm.com,
	Doug Maxey <doug.maxey@us.ibm.com>, linuxppc-dev@lists.ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-aiq25ZM3gW5ZVbBYYhS/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2010-05-19 at 23:08 +0200, Thomas Gleixner wrote:
> On Wed, 19 May 2010, Thomas Gleixner wrote:
> > > I'm still not clear on why the ultimate solution wasn't to have XICS =
report
> > > edge triggered as edge triggered. Probably some complexity of the ent=
ire power
> > > stack that I am ignorant of.
> > >=20
> > > > Apart from the issue of loosing interrupts there is also the fact t=
hat
> > > > masking on the XICS requires an RTAS call which takes a global lock=
.
> >=20
> > Right, I'd love to avoid that but with real level interrupts we'd run
> > into an interrupt storm. Though another solution would be to issue the
> > EOI after the threaded handler finished, that'd work as well, but
> > needs testing.
>=20
> Thought more about that. The case at hand (ehea) is nasty:
>=20
> The driver does _NOT_ disable the rx interrupt in the card in the rx
> interrupt handler - for whatever reason.

Yeah I saw that, but I don't know why it's written that way. Perhaps
Jan-Bernd or Doug will chime in and enlighten us? :)

cheers



--=-aiq25ZM3gW5ZVbBYYhS/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkv0kZAACgkQdSjSd0sB4dIFugCgjix5AnNDseOZh2iuTLfFEzMy
4SMAn0qUvgVBUVw7mrFFEzN1/4aSzJnZ
=9YxJ
-----END PGP SIGNATURE-----

--=-aiq25ZM3gW5ZVbBYYhS/--
