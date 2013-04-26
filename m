Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id DFA7A2C011D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2013 13:01:47 +1000 (EST)
Date: Fri, 26 Apr 2013 13:01:40 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 2/13] Correct buffer parsing in update_dt_node()
Message-Id: <20130426130140.bcde757c4321d198e578cda9@canb.auug.org.au>
In-Reply-To: <5177FF10.4000508@linux.vnet.ibm.com>
References: <5177FB74.2050709@linux.vnet.ibm.com>
 <5177FF10.4000508@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Fri__26_Apr_2013_13_01_40_+1000_5dndtg=9bGz.4/C_"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Fri__26_Apr_2013_13_01_40_+1000_5dndtg=9bGz.4/C_
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Nathan,


On Wed, 24 Apr 2013 10:49:36 -0500 Nathan Fontenot <nfont@linux.vnet.ibm.co=
m> wrote:
>
> @@ -134,6 +134,7 @@
>  	char *prop_data;
>  	char *rtas_buf;
>  	int update_properties_token;
> +	u32 vd;
> =20
>  	update_properties_token =3D rtas_token("ibm,update-properties");
>  	if (update_properties_token =3D=3D RTAS_UNKNOWN_SERVICE)
> @@ -160,13 +161,24 @@
> =20
>  		prop_data =3D rtas_buf + sizeof(*upwa);
> =20
> -		for (i =3D 0; i < upwa->nprops; i++) {
> +		/* The first element of the buffer is the path of the node
> +		 * being updated in the form of a 8 byte string length
                                                    ^^^^
"bit" ?

> +		 * followed by the string. Skip past this to get to the
> +		 * properties being updated.
> +		 */
> +		vd =3D *prop_data++;
> +		prop_data +=3D vd;
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Fri__26_Apr_2013_13_01_40_+1000_5dndtg=9bGz.4/C_
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJRee4UAAoJEECxmPOUX5FE1Q0P/AhSLKJsEXYkgwgavMVZr0cr
JuHqhrc/sySCep+GYWKQPi/7E4OahOLVfEKCZTy1HD6h6bKPACLgonDNsiNk5XFt
tDRF6Q1buaBG9HkB5w9NZkvcd/tH2AplrEGN7tE0oT0Gu42qZmiFgA4eawFCPfoK
z60dtkOpGrjFDdsRXKy2geA6Vf6CkvwP7Z5QJ1x4O+DyKGOMLWNRgp8fmpxxOg/T
7FWg6lJRbMh5ZpxVXIucBoFmQ9dcUOalTfi7vQU74NDxbaQ83cGr/cgqZ0UMsQnA
j/zkTRON6CC2ztYDDYC95khnC17QcsPCyOmt6ynIx7TCQRFqcVhNGRyy7DrnKOtS
RZ84U3v8e0Sq7OAOKGl5lbrPIqLQ8DSPMu7Zydr+YKziJDKpmLDcOEruNsyt3M+i
UGaAfSAaed+0Dhcz8BdbWxUbZbTlHrm02JlOq0mxbTQf5YV9Dw7RACQfQbZYGWBY
U2DbUXcLBMfENDC+P373rPsQgYvE5U5ULqlH+n9gQBBugOLu9Ib7pDDFMrHNcnqd
ItUzm4K+QoeIIYHV7LFt4qc9BOgbLDEw0j48+c6omsj/Uo/SRlEsuFpC22PHzsz4
+Bxy7n2Yx7rPXt7S9O2cdKpXgcinMlO0XeDdVtYNtyJKCJFVXobcNOONAHdaXkbt
6OJaoqeN4TkoY7YtIl9Q
=+SCc
-----END PGP SIGNATURE-----

--Signature=_Fri__26_Apr_2013_13_01_40_+1000_5dndtg=9bGz.4/C_--
