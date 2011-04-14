Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH v2] powerpc: align DTL buffer to AMS boundary
From: Michael Ellerman <michael@ellerman.id.au>
To: Nishanth Aravamudan <nacc@us.ibm.com>
In-Reply-To: <1302733988-23037-1-git-send-email-nacc@us.ibm.com>
References: <1302706373-11653-1-git-send-email-nacc@us.ibm.com>
	<1302733988-23037-1-git-send-email-nacc@us.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-9Vwauf00A/O/sjAwq3Qi"
Date: Thu, 14 Apr 2011 14:12:43 +1000
Message-ID: <1302754363.12513.89.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>,
	Paul Mackerras <paulus@samba.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-9Vwauf00A/O/sjAwq3Qi
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2011-04-13 at 15:33 -0700, Nishanth Aravamudan wrote:
> PAPR specifies that DTL buffers can not cross AMS environments (aka CMO
> in the PAPR) and can not cross a memory entitlement granule boundary
> (4k). This is found in section 14.11.3.2 H_REGISTER_VPA of the PAPR.
> kmalloc does not guarantee an alignment of the allocation, though,
> beyond 8 bytes (at least in my understanding). Over-allocate and align
> the resulting address.

You can specify alignment by creating your own kmem_cache, ie.
kmem_cache_create().

Obviously there will be some overhead to create the cache structure, but
I'd think it will be less than 4k * NR_CPUs.

cheers




--=-9Vwauf00A/O/sjAwq3Qi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk2mdDsACgkQdSjSd0sB4dLHygCfYxfZp7RbofC0yIN3AOJIcS5D
qAAAoLF5MtV9mA+grz5K4TD+DbRtnl7X
=xzML
-----END PGP SIGNATURE-----

--=-9Vwauf00A/O/sjAwq3Qi--
