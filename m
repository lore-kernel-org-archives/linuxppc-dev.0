Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 1F1C3DDE16
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jan 2008 10:41:36 +1100 (EST)
Date: Thu, 3 Jan 2008 10:41:21 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCHv2] i2c: adds support for i2c bus on Frescale CPM1/CPM2
	controllers
Message-Id: <20080103104121.58697148.sfr@canb.auug.org.au>
In-Reply-To: <477BEB60.4070703@scram.de>
References: <477BEB60.4070703@scram.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__3_Jan_2008_10_41_21_+1100_SkN8.jo6R1F/9AQQ"
Cc: Jean Delvare <khali@linux-fr.org>, linuxppc-dev@ozlabs.org,
	Scott Wood <scottwood@freescale.com>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__3_Jan_2008_10_41_21_+1100_SkN8.jo6R1F/9AQQ
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jochen,

Just a few trivial things.

On Wed, 02 Jan 2008 20:52:00 +0100 Jochen Friedrich <jochen@scram.de> wrote:
>
> +++ b/drivers/i2c/busses/i2c-cpm.c
> +
> +static irqreturn_t cpm_i2c_interrupt(int irq, void *dev_id)
> +{
> +	struct i2c_adapter *adap;
> +	struct cpm_i2c *cpm;
> +	struct i2c_reg __iomem *i2c_reg;
> +	int i;
> +
> +	adap =3D (struct i2c_adapter *) dev_id;

This cast is unnecessary. In fact, you could just pass dev_id to the
following call to i2c_get_adapdata() and eliminate adap completely.

> +	/* Get 'me going again.
> +	 */

For short comments, just make them one line.  Similarly later as well.

> +	/* This chip can't do zero length writes. However, the i2c core uses
> +	   them to scan for devices. The best we can do is to convert them
> +	   into 1 byte reads */

For multiline comments, we normally do
/*
 * blah ...
 * more blah
 */

> +static int cpm_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, =
int num)
> +{
> +
> +	while (tptr < num) {
> +		/* Check for outstanding messages */
> +		dev_dbg(&adap->dev, "test ready.\n");
> +		if (!(tbdf[tptr].cbd_sc & BD_SC_READY)) {
> +			dev_dbg(&adap->dev, "ready.\n");
> +			rmsg =3D &msgs[tptr];
> +			ret =3D cpm_i2c_check_message(adap, rmsg, tptr, rptr);
> +			tptr++;
> +			if (rmsg->flags & I2C_M_RD)
> +				rptr++;
> +			if (ret) {
> +				cpm_i2c_force_close(adap);
> +				mutex_unlock(&cpm->i2c_mutex);
> +				return ret;
> +			}
> +		} else {
> +			dev_dbg(&adap->dev, "not ready.\n");
> +			ret =3D wait_event_interruptible_timeout(cpm->i2c_wait,
> +				!(tbdf[tptr].cbd_sc & BD_SC_READY), 1 * HZ);
> +			if (ret =3D=3D 0) {
> +				cpm_i2c_force_close(adap);
> +				dev_dbg(&adap->dev, "I2C read: timeout!\n");
> +				mutex_unlock(&cpm->i2c_mutex);
> +				return -EREMOTEIO;
> +			}

You might want to consolidate the two error paths above using gotos to an
error return section below.

> +static void of_register_i2c_devices(struct i2c_adapter *adap,
> +				    struct device_node *adap_node)
> +{
> +	struct device_node *node =3D NULL;
> +
> +	while ((node =3D of_get_next_child(adap_node, node))) {

Use
	for_each_child_of_node(adap_node, node) {
instead and you don't need to initialise "node" above.

> +static struct of_device_id cpm_i2c_match[] =3D {

const?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__3_Jan_2008_10_41_21_+1100_SkN8.jo6R1F/9AQQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHfCEnTgG2atn1QN8RAp7VAJ4k/Ifbxw+graKKsteTNun7k7wmLgCgga9t
9mJ0EjQ5KdFXogPKDKL84UQ=
=G5X1
-----END PGP SIGNATURE-----

--Signature=_Thu__3_Jan_2008_10_41_21_+1100_SkN8.jo6R1F/9AQQ--
