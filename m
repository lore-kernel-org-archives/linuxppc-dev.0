Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
In-Reply-To: <20090407082231.177941706@denx.de>
References: <20090407082052.477328750@denx.de>
	<20090407082231.177941706@denx.de>
Date: Tue, 7 Apr 2009 08:36:29 -0700
Message-ID: <fa686aa40904070836o85d967en84bf09baaee8b843@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] i2c: i2c-mpc: various coding style fixes
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
> Fix errors reported by checkpatch (indention, long lines, trailing
> white space, etc.).
>
> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
> =A0drivers/i2c/busses/i2c-mpc.c | =A0 35 ++++++++++++++++++--------------=
---
> =A01 file changed, 18 insertions(+), 17 deletions(-)
>
> Index: linux-2.6-galak/drivers/i2c/busses/i2c-mpc.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6-galak.orig/drivers/i2c/busses/i2c-mpc.c =A0 2009-04-07 10:0=
9:09.400719216 +0200
> +++ linux-2.6-galak/drivers/i2c/busses/i2c-mpc.c =A0 =A0 =A0 =A02009-04-0=
7 10:09:13.271719088 +0200
> @@ -20,7 +20,7 @@
> =A0#include <linux/of_platform.h>
> =A0#include <linux/of_i2c.h>
>
> -#include <asm/io.h>
> +#include <linux/io.h>
> =A0#include <linux/fsl_devices.h>
> =A0#include <linux/i2c.h>
> =A0#include <linux/interrupt.h>
> @@ -28,10 +28,10 @@
>
> =A0#define DRV_NAME "mpc-i2c"
>
> -#define MPC_I2C_FDR =A0 =A00x04
> -#define MPC_I2C_CR =A0 =A0 0x08
> -#define MPC_I2C_SR =A0 =A0 0x0c
> -#define MPC_I2C_DR =A0 =A0 0x10
> +#define MPC_I2C_FDR =A0 0x04
> +#define MPC_I2C_CR =A0 =A00x08
> +#define MPC_I2C_SR =A0 =A00x0c
> +#define MPC_I2C_DR =A0 =A00x10
> =A0#define MPC_I2C_DFSRR 0x14
>
> =A0#define CCR_MEN =A00x80
> @@ -58,7 +58,7 @@
> =A0 =A0 =A0 =A0u32 flags;
> =A0};
>
> -static __inline__ void writeccr(struct mpc_i2c *i2c, u32 x)
> +static inline void writeccr(struct mpc_i2c *i2c, u32 x)
> =A0{
> =A0 =A0 =A0 =A0writeb(x, i2c->base + MPC_I2C_CR);
> =A0}
> @@ -100,8 +100,7 @@
> =A0 =A0 =A0 =A0u32 x;
> =A0 =A0 =A0 =A0int result =3D 0;
>
> - =A0 =A0 =A0 if (i2c->irq =3D=3D NO_IRQ)
> - =A0 =A0 =A0 {
> + =A0 =A0 =A0 if (i2c->irq =3D=3D NO_IRQ) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0while (!(readb(i2c->base + MPC_I2C_SR) & C=
SR_MIF)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0schedule();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (time_after(jiffies, or=
ig_jiffies + timeout)) {
> @@ -176,7 +175,7 @@
> =A0}
>
> =A0static int mpc_write(struct mpc_i2c *i2c, int target,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const u8 * data, int length, int=
 restart)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const u8 *data, int length, int =
restart)
> =A0{
> =A0 =A0 =A0 =A0int i, result;
> =A0 =A0 =A0 =A0unsigned timeout =3D i2c->adap.timeout;
> @@ -207,7 +206,7 @@
> =A0}
>
> =A0static int mpc_read(struct mpc_i2c *i2c, int target,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u8 * data, int length, int restart)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u8 *data, int length, int restart)
> =A0{
> =A0 =A0 =A0 =A0unsigned timeout =3D i2c->adap.timeout;
> =A0 =A0 =A0 =A0int i, result;
> @@ -311,7 +310,8 @@
> =A0 =A0 =A0 =A0.timeout =3D HZ,
> =A0};
>
> -static int __devinit fsl_i2c_probe(struct of_device *op, const struct of=
_device_id *match)
> +static int __devinit fsl_i2c_probe(struct of_device *op,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cons=
t struct of_device_id *match)
> =A0{
> =A0 =A0 =A0 =A0int result =3D 0;
> =A0 =A0 =A0 =A0struct mpc_i2c *i2c;
> @@ -341,11 +341,12 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0result =3D request_irq(i2c->irq, mpc_i2c_i=
sr,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 I=
RQF_SHARED, "i2c-mpc", i2c);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (result < 0) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "i2c-mpc - =
failed to attach interrupt\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"i2c-mpc - f=
ailed to attach interrupt\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto fail_request;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
> -
> +
> =A0 =A0 =A0 =A0mpc_i2c_setclock(i2c);
>
> =A0 =A0 =A0 =A0dev_set_drvdata(&op->dev, i2c);
> @@ -368,7 +369,7 @@
> =A0 =A0 =A0 =A0free_irq(i2c->irq, i2c);
> =A0fail_request:
> =A0 =A0 =A0 =A0irq_dispose_mapping(i2c->irq);
> - =A0 =A0 =A0 iounmap(i2c->base);
> + =A0 =A0 =A0 iounmap(i2c->base);
> =A0fail_map:
> =A0 =A0 =A0 =A0kfree(i2c);
> =A0 =A0 =A0 =A0return result;
> @@ -414,7 +415,7 @@
>
> =A0 =A0 =A0 =A0rv =3D of_register_platform_driver(&mpc_i2c_driver);
> =A0 =A0 =A0 =A0if (rv)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR DRV_NAME
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR DRV_NAME
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " of_register_platform_driver=
 failed (%i)\n", rv);
> =A0 =A0 =A0 =A0return rv;
> =A0}
> @@ -428,6 +429,6 @@
> =A0module_exit(fsl_i2c_exit);
>
> =A0MODULE_AUTHOR("Adrian Cox <adrian@humboldt.co.uk>");
> -MODULE_DESCRIPTION
> - =A0 =A0("I2C-Bus adapter for MPC107 bridge and MPC824x/85xx/52xx proces=
sors");
> +MODULE_DESCRIPTION("I2C-Bus adapter for MPC107 bridge and "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"MPC824x/85xx/52xx processors");
> =A0MODULE_LICENSE("GPL");
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
