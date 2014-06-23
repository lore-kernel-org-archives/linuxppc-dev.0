Return-Path: <mkl@pengutronix.de>
Received: from metis.ext.pengutronix.de (unknown
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E666C1A0351
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jun 2014 17:37:35 +1000 (EST)
Message-ID: <53A7D92E.4060708@pengutronix.de>
Date: Mon, 23 Jun 2014 09:37:18 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
MIME-Version: 1.0
To: "qiang.zhao@freescale.com" <qiang.zhao@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
 "wg@grandegger.com" <wg@grandegger.com>,
 Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v3 1/2] flexcan: add err_irq handler for flexcan
References: <1403507484-46547-1-git-send-email-B45475@freescale.com>
 <53A7D497.7080806@pengutronix.de>
 <d7e8cae0bc584530bedc8febf5476fcf@BLUPR03MB341.namprd03.prod.outlook.com>
In-Reply-To: <d7e8cae0bc584530bedc8febf5476fcf@BLUPR03MB341.namprd03.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="FtQmtj7FT19Ktb18XjeNbudQ5wcqEE0mv"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FtQmtj7FT19Ktb18XjeNbudQ5wcqEE0mv
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 06/23/2014 09:26 AM, qiang.zhao@freescale.com wrote:
>=20
> On 06/23/2014 03:18 PM, Marc Kleine-Budde wrote:
>=20
>>
>> On 06/23/2014 09:11 AM, Zhao Qiang wrote:
>>> when flexcan is not physically linked, command 'cantest' will trigger=

>>> an err_irq, add err_irq handler for it.
>>>
>>> Signed-off-by: Zhao Qiang <B45475@freescale.com>
>>> ---
>>> Changes for v2:
>>> 	- use a space instead of tab
>>> 	- use flexcan_poll_state instead of print Changes for v3:
>>> 	- return IRQ_HANDLED if err is triggered
>>> 	- stop transmitted packets when there is an err_interrupt
>>>
>>>  drivers/net/can/flexcan.c | 35 ++++++++++++++++++++++++++++++++++-
>>>  1 file changed, 34 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
>>> index f425ec2..6802a25 100644
>>> --- a/drivers/net/can/flexcan.c
>>> +++ b/drivers/net/can/flexcan.c
>>> @@ -208,6 +208,7 @@ struct flexcan_priv {
>>>  	void __iomem *base;
>>>  	u32 reg_esr;
>>>  	u32 reg_ctrl_default;
>>> +	unsigned int err_irq;
>>>
>>>  	struct clk *clk_ipg;
>>>  	struct clk *clk_per;
>>> @@ -744,6 +745,24 @@ static irqreturn_t flexcan_irq(int irq, void
>> *dev_id)
>>>  	return IRQ_HANDLED;
>>>  }
>>>
>>> +static irqreturn_t flexcan_err_irq(int irq, void *dev_id) {
>>> +	struct net_device *dev =3D dev_id;
>>> +	struct flexcan_priv *priv =3D netdev_priv(dev);
>>> +	struct flexcan_regs __iomem *regs =3D priv->base;
>>> +	u32 reg_ctrl, reg_esr;
>>> +
>>> +	reg_esr =3D flexcan_read(&regs->esr);
>>> +	reg_ctrl =3D flexcan_read(&regs->ctrl);
>>> +	if (reg_esr & FLEXCAN_ESR_TX_WRN) {
>>
>> When does the hardware trigger the interrupt?
>=20
> When there is no wire link between tx and rx, tx start transfer and doe=
sn=E2=80=99t get the ack.

You are testing for the warning interrupt, not for the
FLEXCAN_ESR_ACK_ERR (which is triggered there isn't any ACK).

>>> +		flexcan_write(reg_esr & ~FLEXCAN_ESR_TX_WRN, &regs->esr);
>>> +		flexcan_write(reg_ctrl & ~FLEXCAN_CTRL_ERR_MSK, &regs->ctrl);
>>> +		netif_stop_queue(dev);
>>
>> Why are you stopping the txqueue?
>=20
> There is no wire link, tx can't transfer successfully.=20

You are testing for the warning interrupt, which is triggered if the
error counter increases from 95 to 96. And the error counter can
increase due to several reasons. No link is only one of them. If the CAN
core cannot transmit new packages any more the flow control in the
driver will take care.

What about calling the normal interrupt if er err_irq occurs, as this
function will take care of both normal and error interrupts anyway?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--FtQmtj7FT19Ktb18XjeNbudQ5wcqEE0mv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlOn2S4ACgkQjTAFq1RaXHPTmQCfcQDcpXO1pAKj+oiM53B7FGvX
E4wAn06axydfZnKAH+1ml9BooZbj/9t7
=326+
-----END PGP SIGNATURE-----

--FtQmtj7FT19Ktb18XjeNbudQ5wcqEE0mv--
