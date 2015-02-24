Return-Path: <wsa@the-dreams.de>
Received: from pokefinder.org (sauhun.de [89.238.76.85])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 994E81A126F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Feb 2015 01:25:30 +1100 (AEDT)
Date: Tue, 24 Feb 2015 15:25:24 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC 02/11] i2c: add quirk checks to core
Message-ID: <20150224142524.GB18301@katana>
References: <1420824103-24169-1-git-send-email-wsa@the-dreams.de>
 <1420824103-24169-3-git-send-email-wsa@the-dreams.de>
 <20150112120814.GE12302@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
In-Reply-To: <20150112120814.GE12302@n2100.arm.linux.org.uk>
Cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
 Ludovic Desroches <ludovic.desroches@atmel.com>, linux-i2c@vger.kernel.org,
 Yingjoe Chen <yingjoe.chen@mediatek.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2015 at 12:08:14PM +0000, Russell King - ARM Linux wrote:
> On Fri, Jan 09, 2015 at 06:21:32PM +0100, Wolfram Sang wrote:
> > +static int i2c_quirk_error(struct i2c_adapter *adap, struct i2c_msg *m=
sg, char *err_msg)
> > +{
> > +	dev_err(&adap->dev, "quirk: %s (addr 0x%04x, size %u)\n", err_msg, ms=
g->addr, msg->len);
> > +	return -EOPNOTSUPP;
> > +}
>=20
> So, what happens if I open an I2C adapter, find a message which causes
> i2c_quirk_error() to be called, and then spin repeatedly calling that...
> Shouldn't there be some rate limiting to this?

Can be argued. Changed to dev_err_ratelimited(). Thanks!


--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU7InUAAoJEBQN5MwUoCm2FyMP/396wTJ79mIvC6SMKh0qHIIy
lfoEi7z+j7FXG1auWe/Jg0Zl8AdNVlmXuwo6XX/BHWyuj2ZUTSU6I0VikqzbyoRQ
CX9TDFWvPIKxw72LUNSIQjWuflc1xUL57vRHjnamEuASwPp97url6/qMFSQiRZhy
4REikDaClN3m/HlSH86r+EH/UbXdLA182nOinmuzzt4wED0EMNN8pGlj/kY2Mlgr
F1EJL71+lWetbWvwGD+OQlJyGwf/spro+5d/pJ9onbg98lKRV72HBkqx3idxfZEM
t1UDwJVCl3tUwpFY26GTenUBmnGjxjRxgiSJMPBhdaW+L5GqFh1rbmfVfT41o7Yf
dE32o1O4UO9L8IkRMw/+nKJ0xfQza1Gihskq2Q0n8rkNpg9G8lH+KGqhYK+dzTlT
W5MzoLnyzv6QvP5RB7LXdUA6g4vciaeoNOynd21r4otmNLAPR00m6OkY2FZTtsqt
M40if2xDZlY56y9Shy7oXiglC/Dw4PsjmKPuy7gV7F1K99nsXM1gNzhwjnanOyBL
FDWif4e9gEBrCONre9IRMZ3351GZEtkDGPnTWHAwF8ncgILzA/nGr4gkQDBVt00w
K5Pdo1CHdZqxzXeh8/S8u4kxOVQYyx81FJ+6mnQFhbn4TtV8Q5qQL2oh3W71eehh
5BkNrvM/ikWNOgDBUAAi
=Er7l
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--
