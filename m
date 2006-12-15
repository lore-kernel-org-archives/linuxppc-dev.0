Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 12/14] Spidernet Avoid possible RX chain corruption
From: Michael Ellerman <michael@ellerman.id.au>
To: Linas Vepstas <linas@austin.ibm.com>
In-Reply-To: <20061214171511.GT4329@austin.ibm.com>
References: <20061213210010.GR4329@austin.ibm.com>
	<20061213212301.GL1915@austin.ibm.com>
	<1166055763.6838.5.camel@concordia.ozlabs.ibm.com>
	<20061214171511.GT4329@austin.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-6wRvw9DS1UPIr2XkGRdN"
Date: Fri, 15 Dec 2006 12:48:27 +1100
Message-Id: <1166147307.4892.16.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, Arnd Bergmann <arnd@arndb.de>,
	netdev@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
	linuxppc-dev@ozlabs.org, Jens Osterkamp <Jens.Osterkamp@gmx.de>,
	jgarzik@pobox.com, James K Lewis <jim@jklewis.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-6wRvw9DS1UPIr2XkGRdN
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-12-14 at 11:15 -0600, Linas Vepstas wrote:
> On Thu, Dec 14, 2006 at 11:22:43AM +1100, Michael Ellerman wrote:
> > >  	spider_net_refill_rx_chain(card);
> > > -	spider_net_enable_rxchtails(card);
> > >  	spider_net_enable_rxdmac(card);
> > >  	return 0;
> >=20
> > Didn't you just add that line?
>=20
> Dagnabbit. The earlier pach was moving around existing code.
> Or, more precisely, trying to maintain the general function
> of the old code even while moving things around.
>=20
> Later on, when I started looking at what the danged function=20
> actually did, and the context it was in, I realized that it=20
> was a bad idea to call the thing.  So then I removed it. :-/
>=20
> How should I handle this proceedurally? Resend the patch sequence?=20
> Let it slide?

If it was my code I'd redo the series, it's confusing and it's going to
look confused in the git history IMHO.

Currently the driver calls spider_net_enable_rxchtails() from
spider_net_enable_card() and spider_net_handle_rxram_full().

Your patch 3/14 removes spider_net_handle_rxram_full() entirely, leaving
spider_net_enable_card() as the only caller of
spider_net_enable_rxchtails().

Patch 10/14 adds a call to spider_net_enable_rxchtails() in
spider_net_alloc_rx_skbs(), and nothing else (except comment changes).

Patch 12/14 removes the call to spider_net_enable_rxchtails() in
spider_net_alloc_rx_skbs(), and nothing else.

So as far as I can tell you should just drop 10/14 and 12/14.=20

My worry is that amongst all that rearranging of code, it's not clear
what the semantic change is. Admittedly I don't know the driver that
well, but that's kind of the point - if you and Jim get moved onto a new
project, someone needs to be able to pick up the driver and maintain it.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-6wRvw9DS1UPIr2XkGRdN
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFgf7rdSjSd0sB4dIRAu+gAJ9Iiz1jO7Iz+z8WMUNZa8KwACR03gCfVmhm
CIy4bLCBuoGDO2/h6G7QOCs=
=U3b6
-----END PGP SIGNATURE-----

--=-6wRvw9DS1UPIr2XkGRdN--
