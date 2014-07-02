Return-Path: <mkl@pengutronix.de>
Received: from metis.ext.pengutronix.de (unknown
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C13291A001C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Jul 2014 19:02:34 +1000 (EST)
Message-ID: <53B3CA95.9070600@pengutronix.de>
Date: Wed, 02 Jul 2014 11:02:13 +0200
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
 <53B3AEEC.4060507@pengutronix.de>
 <175067a435ce4d5c9a194a459e950544@BLUPR03MB341.namprd03.prod.outlook.com>
In-Reply-To: <175067a435ce4d5c9a194a459e950544@BLUPR03MB341.namprd03.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="M7eqBoRG4wHQGaTrVAbUkRl54FOMLr7bx"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--M7eqBoRG4wHQGaTrVAbUkRl54FOMLr7bx
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/02/2014 10:32 AM, qiang.zhao@freescale.com wrote:
> On 07/02/2014 03:04 PM, Marc Kleine-Budde wrote:
>> -----Original Message-----
>> From: Marc Kleine-Budde [mailto:mkl@pengutronix.de]
>> Sent: Wednesday, July 02, 2014 3:04 PM
>> To: Zhao Qiang-B45475; linuxppc-dev@lists.ozlabs.org; wg@grandegger.co=
m;
>> linux-can@vger.kernel.org; Wood Scott-B07421
>> Subject: Re: [PATCH v4] flexcan: add err_irq handler for flexcan
>>
>> On 07/02/2014 04:00 AM, qiang.zhao@freescale.com wrote:
>>>>> +static irqreturn_t flexcan_err_irq(int irq, void *dev_id) {
>>>>> +	struct net_device *dev =3D dev_id;
>>>>> +	struct flexcan_priv *priv =3D netdev_priv(dev);
>>>>> +	struct flexcan_regs __iomem *regs =3D priv->base;
>>>>> +	u32 reg_ctrl, reg_esr;
>>>>> +
>>>>> +	reg_esr =3D flexcan_read(&regs->esr);
>>>>> +	reg_ctrl =3D flexcan_read(&regs->ctrl);
>>>>> +
>>>>> +	if (reg_esr & FLEXCAN_ESR_ALL_INT) {
>>>>> +		if (reg_esr & FLEXCAN_ESR_ERR_INT)
>>>>> +			flexcan_write(reg_ctrl & ~FLEXCAN_CTRL_ERR_MSK,
>>>>> +				      &regs->ctrl);
>>>>> +		flexcan_irq(irq, dev);
>>>>
>>>> I still don't understand why you need a special flexcan_err_irq()
>>>> function. Why don't you just call:
>>>>
>>>> request_irq(priv->err_irq, flexcan_irq, IRQF_SHARED, dev->name, dev)=
;
>>>>
>>>> instead?
>>>
>>> Flexcan_irq is for flexcan normal interrupt(such as Message Buffer,
>> Wake up and so on).
>>> And it will return IRQ_HANDLED if flexcan_irq is triggered.
>>> But err_irq is shared with other devices, it should return IRQ_HANDLE=
D
>>> when the interrupt is triggered by flexcan device, if not return
>> IRQ_NONE.
>>
>> What about fixing flexcan_irq() first and the make use of it?
>=20
> Err_irq is a shared interrupt with other device,=20
> I hope that its handler is independent.
> However, if you persist in your opinion, I will do it as you said.

There is another option, you can move all of the error interrupt
handling code from flexcan_irq() to flexcan_irq_err(). To keep the ARM
SoCs supported, you need to call flexcan_irq_err() form the
flexcan_irq() handler.

What I don't want is a) code duplication and b) no fishy wrapper
functions around flexcan_irq() that work around flexcan_irq() returning
IRQ_HANDLED unconditionally.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--M7eqBoRG4wHQGaTrVAbUkRl54FOMLr7bx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlOzypUACgkQjTAFq1RaXHNHWQCfezS9fm3zxRVGrjNA6dGpFo0g
XAIAn1o42qwmYDP1Dv543eNhjgkP6a0f
=rAyT
-----END PGP SIGNATURE-----

--M7eqBoRG4wHQGaTrVAbUkRl54FOMLr7bx--
