Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
In-Reply-To: <20090407082231.335327816@denx.de>
References: <20090407082052.477328750@denx.de>
	<20090407082231.335327816@denx.de>
Date: Tue, 7 Apr 2009 08:37:05 -0700
Message-ID: <fa686aa40904070837t553d781alc8a4bc6b0241db4d@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] i2c: i2c-mpc: use dev based printout function
From: Grant Likely <grant.likely@secretlab.ca>
To: Wolfgang Grandegger <wg@grandegger.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org,
	linux-i2c@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 7, 2009 at 1:20 AM, Wolfgang Grandegger <wg@grandegger.com> wro=
te:
> This patch used the dev_dbg, dev_err, etc. functions for debug
> and error output instead of printk and pr_debug.
>
> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
> =A0drivers/i2c/busses/i2c-mpc.c | =A0 31 +++++++++++++++++--------------
> =A01 file changed, 17 insertions(+), 14 deletions(-)
>
> Index: linux-2.6-galak/drivers/i2c/busses/i2c-mpc.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6-galak.orig/drivers/i2c/busses/i2c-mpc.c =A0 2009-04-07 10:0=
9:13.271719088 +0200
> +++ linux-2.6-galak/drivers/i2c/busses/i2c-mpc.c =A0 =A0 =A0 =A02009-04-0=
7 10:09:14.012720756 +0200
> @@ -50,6 +50,7 @@
> =A0#define CSR_RXAK 0x01
>
> =A0struct mpc_i2c {
> + =A0 =A0 =A0 struct device *dev;
> =A0 =A0 =A0 =A0void __iomem *base;
> =A0 =A0 =A0 =A0u32 interrupt;
> =A0 =A0 =A0 =A0wait_queue_head_t queue;
> @@ -104,7 +105,7 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0while (!(readb(i2c->base + MPC_I2C_SR) & C=
SR_MIF)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0schedule();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (time_after(jiffies, or=
ig_jiffies + timeout)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("I=
2C: timeout\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(i2c=
->dev, "timeout\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0writeccr(i=
2c, 0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0result =3D=
 -EIO;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> @@ -118,7 +119,7 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(i2c->interrupt & CSR_MIF)=
, timeout);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (unlikely(!(i2c->interrupt & CSR_MIF)))=
 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("I2C: wait timeout=
\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(i2c->dev, "wait tim=
eout\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0writeccr(i2c, 0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0result =3D -ETIMEDOUT;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> @@ -131,17 +132,17 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return result;
>
> =A0 =A0 =A0 =A0if (!(x & CSR_MCF)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("I2C: unfinished\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(i2c->dev, "unfinished\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EIO;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (x & CSR_MAL) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("I2C: MAL\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(i2c->dev, "MAL\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EIO;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (writing && (x & CSR_RXAK)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("I2C: No RXAK\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(i2c->dev, "No RXAK\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* generate stop */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0writeccr(i2c, CCR_MEN);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EIO;
> @@ -263,12 +264,12 @@
> =A0 =A0 =A0 =A0/* Allow bus up to 1s to become not busy */
> =A0 =A0 =A0 =A0while (readb(i2c->base + MPC_I2C_SR) & CSR_MBB) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (signal_pending(current)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("I2C: Interrupted\=
n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(i2c->dev, "Interrup=
ted\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0writeccr(i2c, 0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINTR;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (time_after(jiffies, orig_jiffies + HZ)=
) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("I2C: timeout\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(i2c->dev, "timeout\=
n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (readb(i2c->base + MPC_=
I2C_SR) =3D=3D
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(CSR_MCF | CSR_MBB=
 | CSR_RXAK))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mpc_i2c_fi=
xup(i2c);
> @@ -279,9 +280,10 @@
>
> =A0 =A0 =A0 =A0for (i =3D 0; ret >=3D 0 && i < num; i++) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pmsg =3D &msgs[i];
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("Doing %s %d bytes to 0x%02x - %d =
of %d messages\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pmsg->flags & I2C_M_RD ?=
 "read" : "write",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pmsg->len, pmsg->addr, i=
 + 1, num);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(i2c->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Doing %s %d bytes to 0x%02=
x - %d of %d messages\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pmsg->flags & I2C_M_RD ? "r=
ead" : "write",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pmsg->len, pmsg->addr, i + =
1, num);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (pmsg->flags & I2C_M_RD)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mpc_read(i2c, pmsg=
->addr, pmsg->buf, pmsg->len, i);
> @@ -320,6 +322,8 @@
> =A0 =A0 =A0 =A0if (!i2c)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENOMEM;
>
> + =A0 =A0 =A0 i2c->dev =3D &op->dev; /* for debug and error output */
> +
> =A0 =A0 =A0 =A0if (of_get_property(op->node, "dfsrr", NULL))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i2c->flags |=3D FSL_I2C_DEV_SEPARATE_DFSRR=
;
>
> @@ -331,7 +335,7 @@
>
> =A0 =A0 =A0 =A0i2c->base =3D of_iomap(op->node, 0);
> =A0 =A0 =A0 =A0if (!i2c->base) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "i2c-mpc - failed to map co=
ntroller\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(i2c->dev, "failed to map controller=
\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0result =3D -ENOMEM;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto fail_map;
> =A0 =A0 =A0 =A0}
> @@ -341,8 +345,7 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0result =3D request_irq(i2c->irq, mpc_i2c_i=
sr,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 I=
RQF_SHARED, "i2c-mpc", i2c);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (result < 0) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"i2c-mpc - f=
ailed to attach interrupt\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(i2c->dev, "failed t=
o attach interrupt\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto fail_request;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
> @@ -357,7 +360,7 @@
>
> =A0 =A0 =A0 =A0result =3D i2c_add_adapter(&i2c->adap);
> =A0 =A0 =A0 =A0if (result < 0) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "i2c-mpc - failed to add ad=
apter\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(i2c->dev, "failed to add adapter\n"=
);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto fail_add;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0of_register_i2c_devices(&i2c->adap, op->node);
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
