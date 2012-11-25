Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 954EE2C03BB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2012 00:21:51 +1100 (EST)
Subject: Re: [PATCH] i2c-cpm: Fix to takeback i2c bus master-ship after a
 collision
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=iso-8859-1
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <CABCb4NUJ0uJA5Z9vdgLndvpLrnK=m5xaeiHZxAwHKFU2DroaFw@mail.gmail.com>
Date: Sun, 25 Nov 2012 07:21:46 -0600
Message-Id: <B8BB551F-BD07-41A9-BCA6-7451C3D12CAA@kernel.crashing.org>
References: <CABCb4NUJ0uJA5Z9vdgLndvpLrnK=m5xaeiHZxAwHKFU2DroaFw@mail.gmail.com>
To: sachin surendran <sachin.surendran@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 30, 2012, at 10:00 PM, sachin surendran wrote:

> In case of collision on i2c bus the controller which lost bus =
mastership stays as a slave
> for all subsequent transfers. This results in the i2c controller never =
writing to the bus=20
> for future transactions, resulting in i2c transfer timeouts.
>   This fix checks for a collision on last I2C transaction and sets the =
I2COM_MASTER=20
> bit for the new transaction.
>=20
> Signed-off-by: Sachin Surendran <sachin.surendran@alliedtelesis.co.nz>
> ---
>  drivers/i2c/busses/i2c-cpm.c |    8 ++++++++
>  1 file changed, 8 insertions(+)

patch doesn't apply, please resend properly.

- k

>=20
> diff --git a/drivers/i2c/busses/i2c-cpm.c =
b/drivers/i2c/busses/i2c-cpm.c
> index c1e1096..bb94c6d 100644
> --- a/drivers/i2c/busses/i2c-cpm.c
> +++ b/drivers/i2c/busses/i2c-cpm.c
> @@ -338,6 +338,14 @@ static int cpm_i2c_xfer(struct i2c_adapter *adap, =
struct i2c_msg *msgs, int num)
>         tptr =3D 0;
>         rptr =3D 0;
> =20
> +       /*
> +        * If there was a collision in the last i2c transaction,
> +        * Set I2COM_MASTER as it was cleared during collision.
> +        */
> +       if (in_be16(&tbdf->cbd_sc) & BD_SC_CL) {
> +               out_8(&cpm->i2c_reg->i2com, I2COM_MASTER);
> +       }
> +
>         while (tptr < num) {
>                 pmsg =3D &msgs[tptr];
>                 dev_dbg(&adap->dev, "R: %d T: %d\n", rptr, tptr);
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
