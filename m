Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 95ABFDDEDF
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 21:12:00 +1100 (EST)
Date: Tue, 12 Feb 2008 21:11:54 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Manish Ahuja <ahuja@austin.ibm.com>
Subject: Re: [PATCH 4/8] pseries: phyp dump: register dump area.
Message-Id: <20080212211154.f641abac.sfr@canb.auug.org.au>
In-Reply-To: <47B14760.2030001@austin.ibm.com>
References: <4782B985.2090508@austin.ibm.com> <47B13D2E.1070001@austin.ibm.com>
	<47B14760.2030001@austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__12_Feb_2008_21_11_54_+1100_0jDHXk+DlE=v45P/"
Cc: mahuja@us.ibm.com, linuxppc-dev@ozlabs.org, linasvepstas@gmail.com,
	paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__12_Feb_2008_21_11_54_+1100_0jDHXk+DlE=v45P/
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Manish,

> -	/* Is there dump data waiting for us? */
> +	/* Is there dump data waiting for us? If there isn't,
> +	 * then register a new dump area, and release all of
> +	 * the rest of the reserved ram.
> +	 *
> +	 * The /rtas/ibm,kernel-dump rtas node is present only
> +	 * if there is dump data waiting for us.
> +	 */
>  	rtas =3D of_find_node_by_path("/rtas");
>  	dump_header =3D of_get_property(rtas, "ibm,kernel-dump", &header_len);
> +	of_node_put(rtas);

Oh, here is the of_node_put() - you should move that to patch 3.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__12_Feb_2008_21_11_54_+1100_0jDHXk+DlE=v45P/
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHsXDxTgG2atn1QN8RAiyNAJ9slNsm23OQJo5C5YTPvL7IArUCIgCeJhtY
HHp7oR4CwN4W1x16yvVQESk=
=WgWl
-----END PGP SIGNATURE-----

--Signature=_Tue__12_Feb_2008_21_11_54_+1100_0jDHXk+DlE=v45P/--
