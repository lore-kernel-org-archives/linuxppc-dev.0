Return-Path: <wsa@the-dreams.de>
Received: from pokefinder.org (sauhun.de [89.238.76.85])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 60DE82C00A1
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Jan 2014 02:09:52 +1100 (EST)
Date: Fri, 3 Jan 2014 16:09:48 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: jean-jacques hiblot <jjhiblot@traphandler.com>
Subject: Re: [PATCH v3 REPOST 3/4] i2c: i2c-ibm-iic: Implements transfer
 abortion
Message-ID: <20140103150948.GB7132@katana>
References: <1387552376-12986-1-git-send-email-jjhiblot@traphandler.com>
 <1387552376-12986-4-git-send-email-jjhiblot@traphandler.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="/WwmFnJnmDyWGHa4"
In-Reply-To: <1387552376-12986-4-git-send-email-jjhiblot@traphandler.com>
Cc: gregory.clement@free-electrons.com, linuxppc-dev@lists.ozlabs.org,
 linux-i2c@vger.kernel.org, jean-jacques hiblot <jjhiblot@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 20, 2013 at 04:12:55PM +0100, jean-jacques hiblot wrote:
> From: jean-jacques hiblot <jjhiblot@gmail.com>
>=20
> Clean-up properly when a transfer fails for whatever reason.
> Cancel the transfer when the process is signaled.

Please describe what you do a little. I wonder how you can remove so
much code while keeping the functionality?

>=20
> Signed-off-by: jean-jacques hiblot <jjhiblot@traphandler.com>

> -	out_8(&iic->cntl, CNTL_HMT);
> +	DBG(dev, "aborting transfer\n");
> +	/* transfer should be aborted within 10ms */
> +	end =3D jiffies + 10;

Eeks, msecs_to_jiffies() macro please!

And please consider running checkpatch and sparse over your code. Sparse
gives, for example:

drivers/i2c/busses/i2c-ibm_iic.c:418:24: warning: incorrect type in argumen=
t 1 (different address spaces)
drivers/i2c/busses/i2c-ibm_iic.c:418:24:    expected unsigned char const vo=
latile [noderef] [usertype] <asn:2>*addr
drivers/i2c/busses/i2c-ibm_iic.c:418:24:    got unsigned char *<noident>

(This probably due to patch 1 or 2, I'd guess)


--/WwmFnJnmDyWGHa4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSxtK7AAoJEBQN5MwUoCm2J1IP+gPkpDEWsHziU/ItdOWM7Yr0
OeYoSiKU4pYjND9rsS0oCi/gyQ/pEYDQVUq8K+M+Igj2OBdfZZaDn3BlGikYfB2s
yuqV/hA9QysQiKqo0lv/SmJALdd7fAjlpLmbdEXFUwhAlcOw3U/sVpqh9cVlQsZl
KCxRoai5Det/9S9x290xg0LeXQZnL9iPoQXzXH2oR8K2Crp0L17st/EPBP/vNEQI
3tfmzMQSe9IqaujZryP6d//S8HTqqE3bLqaTBKWKAHepuVBO9U6qQ3FEWsSWDCjn
KBG3ZylK6a01j3oOAcgz7CLAUEF1eKfzGe9dxXhxDHR8OEFtPocJwFb6TulCYV2c
qHnuoPZ/IQHVI2DGi6iYsswJMa1TegYijK3yjHsZElraICNPMrgyWZVlp7509A1W
3kWgI/z2oMnb70KUDUvTFP2r2iCm10Gsgy4XLo6ZezJt2Opxz75dGFqBqtyguVE/
0Wv1JXuGXfufTANXzNyeHUjQKGMqS/81KyG4BsIU+ECsT72vALc6X3VGtwC9mrZq
qiiNGx8R0SaAj9dfuAaMnmO6twlS4szKIr4TeIpoVCVTxgLr5ggRPYV7CIbZqbsA
AQPdGKZ3yfrQR/OTED09+JQzLckdNEZ9WTStVkvqz/4kQcEKJZ0zeHEbcOA0htJ3
hQACLqildJ4gVcAN9qyP
=EI+K
-----END PGP SIGNATURE-----

--/WwmFnJnmDyWGHa4--
