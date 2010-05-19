Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH RT] ehea: make receive irq handler non-threaded
	(IRQF_NODELAY)
From: Michael Ellerman <michael@ellerman.id.au>
To: Darren Hart <dvhltc@us.ibm.com>
In-Reply-To: <4BF31322.5090206@us.ibm.com>
References: <4BF30793.5070300@us.ibm.com>
	<4BF30C32.1020403@linux.vnet.ibm.com>  <4BF31322.5090206@us.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-4lkiPNYo67gNjmCGq6H0"
Date: Wed, 19 May 2010 11:25:24 +1000
Message-ID: <1274232324.29980.9.camel@concordia>
Mime-Version: 1.0
Cc: Jan-Bernd Themann <themann@de.ibm.com>, dvhltc@linux.vnet.ibm.com,
	linux-kernel@vger.kernel.org, Will Schmidt <will_schmidt@vnet.ibm.com>,
	Brian King <brking@linux.vnet.ibm.com>, niv@linux.vnet.ibm.com,
	Thomas Gleixner <tglx@linutronix.de>, Doug Maxey <doug.maxey@us.ibm.com>,
	linuxppc-dev@lists.ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-4lkiPNYo67gNjmCGq6H0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2010-05-18 at 15:22 -0700, Darren Hart wrote:
> On 05/18/2010 02:52 PM, Brian King wrote:
> > Is IRQF_NODELAY something specific to the RT kernel? I don't see it in =
mainline...
>=20
> Yes, it basically says "don't make this handler threaded".

That is a good fix for EHEA, but the threaded handling is still broken
for anything else that is edge triggered isn't it?

The result of the discussion about two years ago on this was that we
needed a custom flow handler for XICS on RT.

Apart from the issue of loosing interrupts there is also the fact that
masking on the XICS requires an RTAS call which takes a global lock.

cheers



--=-4lkiPNYo67gNjmCGq6H0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkvzPgQACgkQdSjSd0sB4dJlNgCgsmZ8ujLaiur6wY9QHfb3QAMk
HA4An2SFFJuOSG6pUuRhYEQNLy3sCCy1
=uh9A
-----END PGP SIGNATURE-----

--=-4lkiPNYo67gNjmCGq6H0--
