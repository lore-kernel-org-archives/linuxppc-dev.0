Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 251CF1A029C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Mar 2016 10:25:34 +1100 (AEDT)
Date: Wed, 2 Mar 2016 10:26:01 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: paulus@samba.org, benh@kernel.crashing.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [4/4] powerpc/mm: Split hash page table sizing heuristic into a
 helper
Message-ID: <20160301232601.GL5427@voom.redhat.com>
References: <1454988763-5580-5-git-send-email-david@gibson.dropbear.id.au>
 <20160301222119.D4717140326@ozlabs.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="lR6P3/j+HGelbRkf"
In-Reply-To: <20160301222119.D4717140326@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--lR6P3/j+HGelbRkf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 02, 2016 at 09:21:19AM +1100, Michael Ellerman wrote:
> On Tue, 2016-09-02 at 03:32:43 UTC, David Gibson wrote:
> > htab_get_table_size() either retrieve the size of the hash page table (=
HPT)
> > from the device tree - if the HPT size is determined by firmware - or
> > uses a heuristic to determine a good size based on RAM size if the kern=
el
> > is responsible for allocating the HPT.
> >=20
> > To support a PAPR extension allowing resizing of the HPT, we're going to
> > want the memory size -> HPT size logic elsewhere, so split it out into a
> > helper function.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>=20
> Applied to powerpc next, thanks.
>=20
> https://git.kernel.org/powerpc/c/5c3c7ede2bdcb85fa2fd51c814
>=20
> I reworded one comment a little, from:
>=20
> 	/* 2^11 PTEGS / 2^18 bytes is the minimum htab size permitted
> 	 * by the architecture */
>=20
> to:
> 	/*
> 	 * 2^11 PTEGS of 128 bytes each, ie. 2^18 bytes is the minimum htab
> 	 * size permitted by the architecture.
> 	 */
>=20
> To avoid any confusion about the "/" referring to division.

Good call, thanks.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--lR6P3/j+HGelbRkf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW1iUJAAoJEGw4ysog2bOSTlYP/2z4zukzOD1pzku81VC9p5VF
8dMbRe1ETTQADXf1fwZtnM7UJxkWrbUwYkfdVIy4gBnQ/aSfxKSbega4gUW0O/CQ
MmjnlEDbd9Tu0M4PArFv4xU/qNltGgQeQ/tPw6vlL5RIXiQKUe5cWoY7WKBCcT2f
aPfVGjj3219mmhuO4LHnmfnS2lwe2WxH23uE2saWw7llSzEF3KEDBExsn+nruMYX
+g5PNwfZvN3W6yDHAn5Hk4R0X61H/ZGH0BIdN3+WSYZ6Pulo5g7WYFrE7/drQQRp
1eeFSx6S0UA/q5uvUqvXoK6eNH8iggOQRKtN62oCub2uRCmaB+J3v2E1RZ7hu/s5
OHcOGBnMJL7P6dCl2rDVOdyei37SaLgTeSRl+aXrJ3Q7ItA6Fc3oCErb+azA3XpY
apn/at8HAvhKcq/DQRZ5e+YYR7BMIzo3uqa/vYpruAoF/vX2mGIl0MehcX7L2ObZ
46hnROxyStitNlM4ajArrHHzRqHrJjKUNfQGalTFDqFijzJeWXrpjAlYYV08qBhj
HlDsxtj3RswDXikHda5VV7zytyj47fSlDwf9ihVZb421F2PZIlh9qA6WgEzgga3d
atlBzAeRze14ZmX3gD0FlclTI/kaTTLVR/ygPn19uhJBx0hUOztF1RB/Qs6BsUsE
ZCBdLyQmWjO+QvKiIaO1
=WkSZ
-----END PGP SIGNATURE-----

--lR6P3/j+HGelbRkf--
