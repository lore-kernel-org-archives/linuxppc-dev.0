Return-Path: <michael@ellerman.id.au>
Subject: Re: "event-scan failed" logflood
From: Michael Ellerman <michael@ellerman.id.au>
To: nello martuscielli <ppc.addon@gmail.com>
In-Reply-To: <loom.20100517T145602-17@post.gmane.org>
References: <20100513111603.3352.qmail@kosh.dhis.org>
	<1273786104.21352.190.camel@pasglop>
	<loom.20100517T145602-17@post.gmane.org>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-gn4EI4cw+9UilXriRF45"
Date: Tue, 18 May 2010 22:33:11 +1000
Message-ID: <1274185991.26143.1.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-gn4EI4cw+9UilXriRF45
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2010-05-17 at 12:58 +0000, nello martuscielli wrote:
> Benjamin Herrenschmidt <benh <at> kernel.crashing.org> writes:
>=20
> _omissis__
> >=20
> > Ok, that gives us a good thing to use to not do the scanning then. If
> > that's 0 then we assume it's a bogus OF and we disable the scan
> > completely. I'll do a patch later today, though feel free to beat me to
> > it.
> >=20
> > Cheers,
> > Ben.
> >=20
>=20
> hi, is there available that patch?
> With the fresh new 2.6.34 the logflood problem is still present.

You could try this, completely untested:

diff --git a/arch/powerpc/kernel/rtasd.c b/arch/powerpc/kernel/rtasd.c
index 4190eae..fd68bed 100644
--- a/arch/powerpc/kernel/rtasd.c
+++ b/arch/powerpc/kernel/rtasd.c
@@ -490,6 +490,12 @@ static int __init rtas_init(void)
                return -ENODEV;
        }
=20
+       if (!rtas_event_scan_rate) {
+               /* Broken firmware: take a rate of zero to mean don't scan =
*/
+               printk(KERN_DEBUG "rtasd: scan rate is 0, not scanning\n");
+               return 0;
+       }
+
        /* Make room for the sequence number */
        rtas_error_log_max =3D rtas_get_error_log_max();
        rtas_error_log_buffer_max =3D rtas_error_log_max + sizeof(int);


cheers


--=-gn4EI4cw+9UilXriRF45
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkvyiQcACgkQdSjSd0sB4dIxOQCffIAPqhGO6jn9XyLMhie7vHPE
w/cAn2hhC3HSxFQ7NptgKDG/xcY8vVcp
=KV4T
-----END PGP SIGNATURE-----

--=-gn4EI4cw+9UilXriRF45--
