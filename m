Return-Path: <mkl@pengutronix.de>
Received: from metis.ext.pengutronix.de (unknown
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D95B31A0009
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Jul 2014 17:04:36 +1000 (EST)
Message-ID: <53B3AEEC.4060507@pengutronix.de>
Date: Wed, 02 Jul 2014 09:04:12 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
MIME-Version: 1.0
To: "qiang.zhao@freescale.com" <qiang.zhao@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "wg@grandegger.com" <wg@grandegger.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
 Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v4] flexcan: add err_irq handler for flexcan
References: <1404201809-7010-1-git-send-email-B45475@freescale.com>
 <53B287A6.10707@pengutronix.de>
 <a77a3b25e46f45c4951e0ec517904460@BLUPR03MB341.namprd03.prod.outlook.com>
In-Reply-To: <a77a3b25e46f45c4951e0ec517904460@BLUPR03MB341.namprd03.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="GGLLxhCXX9LpIxgRqFM11pHcgSSPBxR7B"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GGLLxhCXX9LpIxgRqFM11pHcgSSPBxR7B
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/02/2014 04:00 AM, qiang.zhao@freescale.com wrote:
>>> +static irqreturn_t flexcan_err_irq(int irq, void *dev_id) {
>>> +	struct net_device *dev =3D dev_id;
>>> +	struct flexcan_priv *priv =3D netdev_priv(dev);
>>> +	struct flexcan_regs __iomem *regs =3D priv->base;
>>> +	u32 reg_ctrl, reg_esr;
>>> +
>>> +	reg_esr =3D flexcan_read(&regs->esr);
>>> +	reg_ctrl =3D flexcan_read(&regs->ctrl);
>>> +
>>> +	if (reg_esr & FLEXCAN_ESR_ALL_INT) {
>>> +		if (reg_esr & FLEXCAN_ESR_ERR_INT)
>>> +			flexcan_write(reg_ctrl & ~FLEXCAN_CTRL_ERR_MSK,
>>> +				      &regs->ctrl);
>>> +		flexcan_irq(irq, dev);
>>
>> I still don't understand why you need a special flexcan_err_irq()
>> function. Why don't you just call:
>>
>> request_irq(priv->err_irq, flexcan_irq, IRQF_SHARED, dev->name, dev);
>>
>> instead?
>=20
> Flexcan_irq is for flexcan normal interrupt(such as Message Buffer, Wak=
e up and so on).
> And it will return IRQ_HANDLED if flexcan_irq is triggered.
> But err_irq is shared with other devices, it should return IRQ_HANDLED =
when the interrupt=20
> is triggered by flexcan device, if not return IRQ_NONE.

What about fixing flexcan_irq() first and the make use of it?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--GGLLxhCXX9LpIxgRqFM11pHcgSSPBxR7B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlOzruwACgkQjTAFq1RaXHNIoQCfevQDasjs+wezjMLO3mgwpRGU
4K4AnApL43vz1N7MPuFIkn25fgKGjvmf
=YSao
-----END PGP SIGNATURE-----

--GGLLxhCXX9LpIxgRqFM11pHcgSSPBxR7B--
