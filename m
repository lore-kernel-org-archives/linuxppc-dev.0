Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] kexec, ppc64:  Wait for online/possible CPUs only.
From: Michael Ellerman <michael@ellerman.id.au>
To: Matt Evans <matt@ozlabs.org>
In-Reply-To: <4C0DF36A.3080401@ozlabs.org>
References: <4C0DF36A.3080401@ozlabs.org>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-KxNLyB8Mjv7qip1R+Pg1"
Date: Wed, 09 Jun 2010 01:48:40 +1000
Message-ID: <1276012120.32509.26.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, kexec@lists.infradead.org,
	Milton Miller <miltonm@bga.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-KxNLyB8Mjv7qip1R+Pg1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2010-06-08 at 17:38 +1000, Matt Evans wrote:
> kexec_perpare_cpus_wait() iterates i through NR_CPUS to check
> paca[i].kexec_state of each to make sure they have quiesced.
> However now we have dynamic PACA allocation, paca[NR_CPUS] is not necessa=
rily
> valid and we overrun the array;  spurious "cpu is not possible, ignoring"
> errors result.  This patch iterates for_each_online_cpu so stays
> within the bounds of paca[] -- and every CPU is now 'possible'.
>=20
> Signed-off-by: Matt Evans <matt@ozlabs.org>

Looks good ..

Cautiously-acked-by: Michael Ellerman <michael@ellerman.id.au>

> -			if (!cpu_online(i)) {
> -				/* Fixme: this can be spinning in
> -				 * pSeries_secondary_wait with a paca
> -				 * waiting for it to go online.
> -				 */
> -				printk("kexec: cpu %d hw_cpu_id %d is not"
> -						" online, ignoring\n",
> -						i, paca[i].hw_cpu_id);
> -				break;
> -			}

I don't see how the state in the Fixme could ever happen, but maybe
Milton can seeing I think he wrote it?

cheers


--=-KxNLyB8Mjv7qip1R+Pg1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkwOZlEACgkQdSjSd0sB4dIZIwCfRrnX1Px5GqEWtsfT7b7s31dc
bs0AniJbGiQK3IOSHsKPTLekh1JgKo6C
=l83F
-----END PGP SIGNATURE-----

--=-KxNLyB8Mjv7qip1R+Pg1--
