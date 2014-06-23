Return-Path: <mkl@pengutronix.de>
Received: from metis.ext.pengutronix.de (unknown
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 786F21A0150
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jun 2014 18:31:34 +1000 (EST)
Message-ID: <53A7E5D5.4070003@pengutronix.de>
Date: Mon, 23 Jun 2014 10:31:17 +0200
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
 <53A7D92E.4060708@pengutronix.de>
 <c0ae03364c7946bb8278bf20b03bab90@BLUPR03MB341.namprd03.prod.outlook.com>
In-Reply-To: <c0ae03364c7946bb8278bf20b03bab90@BLUPR03MB341.namprd03.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="HjSnKCvPjB2acmVa4BKHUjxSQEIfIrbcr"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HjSnKCvPjB2acmVa4BKHUjxSQEIfIrbcr
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 06/23/2014 10:15 AM, qiang.zhao@freescale.com wrote:
[...]
>>>>> +	reg_esr =3D flexcan_read(&regs->esr);
>>>>> +	reg_ctrl =3D flexcan_read(&regs->ctrl);
>>>>> +	if (reg_esr & FLEXCAN_ESR_TX_WRN) {
>>>>
>>>> When does the hardware trigger the interrupt?
>>>
>>> When there is no wire link between tx and rx, tx start transfer and
>> doesn=E2=80=99t get the ack.
>>
>> You are testing for the warning interrupt, not for the
>> FLEXCAN_ESR_ACK_ERR (which is triggered there isn't any ACK).
>>
>>>>> +		flexcan_write(reg_esr & ~FLEXCAN_ESR_TX_WRN, &regs->esr);
>>>>> +		flexcan_write(reg_ctrl & ~FLEXCAN_CTRL_ERR_MSK, &regs->ctrl);
>>>>> +		netif_stop_queue(dev);
>>>>
>>>> Why are you stopping the txqueue?
>>>
>>> There is no wire link, tx can't transfer successfully.
>>
>> You are testing for the warning interrupt, which is triggered if the
>> error counter increases from 95 to 96. And the error counter can incre=
ase
>> due to several reasons. No link is only one of them. If the CAN core
>> cannot transmit new packages any more the flow control in the driver w=
ill
>> take care.
>=20
> When Tx error counter increases from 95 to 96, there must be issue for =
tx,
> So why can't I stop the txqueue?=20

Why do you want to stop the queue? It's compliant with the CAN spec to
keep sending CAN frames if the error counter increases to 96. If there
isn't any problem with the CAN bus anymore, the TX error counters will
decrease with every successfully transmitted CAN frame.

> You said that there are several reasons, would you like to take some ex=
amples?

See CAN Error Confinement Rules in
http://www.can-wiki.info/doku.php?id=3Dcan_faq_erors

>> What about calling the normal interrupt if er err_irq occurs, as this
>> function will take care of both normal and error interrupts anyway?
>=20
> Calling the normal interrupt doesn't work.

Why?

flexcan_irq() if FLEXCAN_CTRL_TWRN_MSK is set and will schedule the NAPI
routine:

> 	if ((reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE) ||
> 	    (reg_esr & FLEXCAN_ESR_ERR_STATE) ||
> 	    flexcan_has_and_handle_berr(priv, reg_esr)) {
[...]
> 		napi_schedule(&priv->napi);
> 	}

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--HjSnKCvPjB2acmVa4BKHUjxSQEIfIrbcr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlOn5dUACgkQjTAFq1RaXHMdnwCcCC9//6eH7b7Qmb9aOKp/JSI7
BVUAoJS0zUsGgDAw1Cf8MnMRlKaPQZXa
=7FI6
-----END PGP SIGNATURE-----

--HjSnKCvPjB2acmVa4BKHUjxSQEIfIrbcr--
