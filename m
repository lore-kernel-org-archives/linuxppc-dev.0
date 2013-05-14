Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.pcug.org.au [203.10.76.10])
 by ozlabs.org (Postfix) with ESMTP id 68CE82C00A5
 for <linuxppc-dev@ozlabs.org>; Tue, 14 May 2013 11:09:32 +1000 (EST)
Date: Tue, 14 May 2013 11:09:24 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] powerpc: provide __bswapdi2
Message-Id: <20130514110924.091b7177d22d69e19478a134@canb.auug.org.au>
In-Reply-To: <9813.1368428999@ale.ozlabs.ibm.com>
References: <1368220707.3378.57.camel@shinybook.infradead.org>
 <9813.1368428999@ale.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Tue__14_May_2013_11_09_24_+1000_+IqJP=hLnDPol+ai"
Cc: linuxppc-dev@ozlabs.org, David Woodhouse <dwmw2@infradead.org>,
 viro@zeniv.linux.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Tue__14_May_2013_11_09_24_+1000_+IqJP=hLnDPol+ai
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mikey,

On Mon, 13 May 2013 17:09:59 +1000 Michael Neuling <mikey@neuling.org> wrot=
e:
>
> This doesn't work for me but the below does:
>=20
> _GLOBAL(__bswapdi2)
> 	rotlwi  r9,r4,8
> 	rotlwi  r10,r3,8
> 	rlwimi  r9,r4,24,0,7
> 	rlwimi  r10,r3,24,0,7
> 	rlwimi  r9,r4,24,16,23
> 	rlwimi  r10,r3,24,16,23
> 	mr      r4,r10
> 	mr      r3,r9
> 	blr
>=20
> stolen from GCC -02 output of:
>   unsigned long long __bswapdi2(unsigned long long x)
>   {
> 	 return ((x & 0x00000000000000ffULL) << 56) |
> 		((x & 0x000000000000ff00ULL) << 40) |
> 		((x & 0x0000000000ff0000ULL) << 24) |
> 		((x & 0x00000000ff000000ULL) <<  8) |
> 		((x & 0x000000ff00000000ULL) >>  8) |
> 		((x & 0x0000ff0000000000ULL) >> 24) |
> 		((x & 0x00ff000000000000ULL) >> 40) |
> 		((x & 0xff00000000000000ULL) >> 56);
>   }

So, if we are just stealing the output of gcc, why not just use the C
version (at least for 32 bit)?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Tue__14_May_2013_11_09_24_+1000_+IqJP=hLnDPol+ai
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJRkY7EAAoJEECxmPOUX5FENQQP/0EEIm9kqWXiskauhNko36Ir
KZRaTPEIzdLVlcEwOfuPYmJENBXpP5HOGYWfVJGUgrJ0ynRiAC1UUKXW60DVlSxP
D6Pf/UvnZxRUfhmZT6jWuUU0nGuMXO0RqwyFkJ37XdoXPre3F07cbUVoex2vapmo
tMX+PavCq5KXrRMMQDXU7oZKvepfiRpuwHuiPr3uE0pdDp1KaebsKK6LSQY/8GVj
ktU/LON5AtLyTMjYqxv7RK00QKmfD7x8qGITbLEHn3YKPGwV4fTlwWg6Nt+zc/lV
TwtBmAFkcaZWVkk1U6KImZMHXz9/Twu79vLE77oc2GU7Fo7JviO+ftYgandItcLH
2MDkY1Jy9sNedSkHjuQAhWgTsAleNmnpB4T9C8GkhOrNTG1WO54PFK/Z9r8Pu+Db
/a4Ba3X3TIGUPGcu5mlzSTHlV0q6tDlkU2FQ1F1YODcL3PD5xEBXh+Qjbca/8xOn
q90K9snIraOBxV1TPjFMS4uNWZUPVJ8EdZxvoVUEMQ5wsAzoXaPBZEMKZ6xxQx1g
tQFWBanlGYzexoaejClG+FBM0mlUPWdYaU14WkqzlNLOBRb0x4/PGGMGxBGwReCp
aIK6BPW+4d3EJA12xBdU1ZTpZYymibJCicN90hoFZ04hGoORCr/4EWz8lA8Qqb/r
278t+BZfDUxN5cCvwola
=RY/a
-----END PGP SIGNATURE-----

--Signature=_Tue__14_May_2013_11_09_24_+1000_+IqJP=hLnDPol+ai--
