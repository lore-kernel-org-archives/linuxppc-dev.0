Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [IPv6:2a01:4f8:130:2201::3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.scram.de", Issuer "GeoTrust DV SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9AFE12C00B2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2012 20:58:33 +1100 (EST)
Message-ID: <5090F4F9.8050208@scram.de>
Date: Wed, 31 Oct 2012 10:52:57 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: sachin surendran <sachin.surendran@gmail.com>
Subject: Re: [PATCH] i2c-cpm: Fix to takeback i2c bus master-ship after a
 collision
References: <CABCb4NUJ0uJA5Z9vdgLndvpLrnK=m5xaeiHZxAwHKFU2DroaFw@mail.gmail.com>
In-Reply-To: <CABCb4NUJ0uJA5Z9vdgLndvpLrnK=m5xaeiHZxAwHKFU2DroaFw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Sachin,

looks good to me.

Acked-By: Jochen Friedrich <jochen@scram.de>

> Signed-off-by: Sachin Surendran <sachin.surendran@alliedtelesis.co.nz
> <mailto:sachin.surendran@alliedtelesis.co.nz>>
> ---
>   drivers/i2c/busses/i2c-cpm.c |    8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/drivers/i2c/busses/i2c-cpm.c b/drivers/i2c/busses/i2c-cpm.c
> index c1e1096..bb94c6d 100644
> --- a/drivers/i2c/busses/i2c-cpm.c
> +++ b/drivers/i2c/busses/i2c-cpm.c
> @@ -338,6 +338,14 @@ static int cpm_i2c_xfer(struct i2c_adapter *adap,
> struct i2c_msg *msgs, int num)
>          tptr = 0;
>          rptr = 0;
> +       /*
> +        * If there was a collision in the last i2c transaction,
> +        * Set I2COM_MASTER as it was cleared during collision.
> +        */
> +       if (in_be16(&tbdf->cbd_sc) & BD_SC_CL) {
> +               out_8(&cpm->i2c_reg->i2com, I2COM_MASTER);
> +       }
> +
>          while (tptr < num) {
>                  pmsg = &msgs[tptr];
>                  dev_dbg(&adap->dev, "R: %d T: %d\n", rptr, tptr);
>

Thanks, Jochen
