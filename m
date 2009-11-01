Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f199.google.com (mail-yw0-f199.google.com
	[209.85.211.199]) by ozlabs.org (Postfix) with ESMTP id BFBF61007D2
	for <linuxppc-dev@ozlabs.org>; Sun,  1 Nov 2009 12:04:17 +1100 (EST)
Received: by ywh37 with SMTP id 37so4155958ywh.17
	for <linuxppc-dev@ozlabs.org>; Sat, 31 Oct 2009 18:04:16 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1256931852-13255-1-git-send-email-w.sang@pengutronix.de>
References: <1256931852-13255-1-git-send-email-w.sang@pengutronix.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sat, 31 Oct 2009 19:03:55 -0600
Message-ID: <fa686aa40910311803m43504167s1ad802aecd2b4344@mail.gmail.com>
Subject: Re: [PATCH] mpc52xx-psc-spi: refactor probe and remove to make use of
	of_register_spi_devices()
To: Wolfram Sang <w.sang@pengutronix.de>
Content-Type: multipart/mixed; boundary=000e0cd598da0a5ba0047744d716
Cc: =?ISO-8859-1?B?S+FyaSBEYXbt8HNzb24=?= <kari.davidsson@marel.com>,
	spi-devel-general@lists.sourceforge.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--000e0cd598da0a5ba0047744d716
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Wolfram,

Thanks for this work. Comments below.

On Fri, Oct 30, 2009 at 1:44 PM, Wolfram Sang <w.sang@pengutronix.de> wrote=
:
> This driver has a generic part for the probe/remove routines which probab=
ly
> used to be called from a platform driver and an of_platform driver. Meanw=
hile,
> the driver is of_platform only, so there is no need for the generic part
> anymore. Unifying probe/remove finally enables us to call
> of_register_spi_devices(), so spi-device nodes from the device tree will =
be
> parsed. This was also mentioned by:
> http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-June/073273.html

I haven't really been happy with any of the patches that added the
of_register_spi_devices() call, but I never got around to dealing with
it properly, or even replying.  I found Jon's patch too invasive, and
the patch referenced above is a little ugly.  Adding the call should
be really simple.  I've drafted a patch to do only that step and
attached it to this mail.  If this one works for you, then I'll merge
it immediately into -next.

> On the way, some patterns have been changed to current best practices (li=
ke
> using '!ptr' and 'struct resource'). Also, an older, yet uncommented, pat=
ch
> from me has been incorporated to improve the checks if the selected PSC i=
s
> valid:
>
> http://patchwork.ozlabs.org/patch/36780/

There are at least 3 discrete changes here.  I prefer for each to be
provided as a separate patch so I can cherry pick the ones that are
ready.  I'll go back and comment on the patch you referenced above
patch right now.

Also, I'm resistant to changing the probe layout on this driver at
this time.  With the work being done to generalize the OF support
code, there is a strong possibility that of_platform will be
deprecated in favor of going back to using the platform bus directly
(just like how OF support works for i2c, spi, etc).  I'd rather not
refactor the driver until I'm certain of the direction that things are
going to go.

Cheers,
g.

>
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: K=E1ri Dav=ED=F0sson <kari.davidsson@marel.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> ---
> =A0drivers/spi/mpc52xx_psc_spi.c | =A0110 +++++++++++++++++++------------=
---------
> =A01 files changed, 52 insertions(+), 58 deletions(-)
>
> diff --git a/drivers/spi/mpc52xx_psc_spi.c b/drivers/spi/mpc52xx_psc_spi.=
c
> index 1b74d5c..3fa8c78 100644
> --- a/drivers/spi/mpc52xx_psc_spi.c
> +++ b/drivers/spi/mpc52xx_psc_spi.c
> @@ -17,6 +17,7 @@
> =A0#include <linux/errno.h>
> =A0#include <linux/interrupt.h>
> =A0#include <linux/of_platform.h>
> +#include <linux/of_spi.h>
> =A0#include <linux/workqueue.h>
> =A0#include <linux/completion.h>
> =A0#include <linux/io.h>
> @@ -27,6 +28,7 @@
> =A0#include <asm/mpc52xx.h>
> =A0#include <asm/mpc52xx_psc.h>
>
> +#define DRIVER_NAME "mpc52xx-psc-spi"
> =A0#define MCLK 20000000 /* PSC port MClk in hz */
>
> =A0struct mpc52xx_psc_spi {
> @@ -358,32 +360,54 @@ static irqreturn_t mpc52xx_psc_spi_isr(int irq, voi=
d *dev_id)
> =A0 =A0 =A0 =A0return IRQ_NONE;
> =A0}
>
> -/* bus_num is used only for the case dev->platform_data =3D=3D NULL */
> -static int __init mpc52xx_psc_spi_do_probe(struct device *dev, u32 regad=
dr,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 size, u=
nsigned int irq, s16 bus_num)
> +static int __init mpc52xx_psc_spi_of_probe(struct of_device *op,
> + =A0 =A0 =A0 const struct of_device_id *match)
> =A0{
> - =A0 =A0 =A0 struct fsl_spi_platform_data *pdata =3D dev->platform_data;
> + =A0 =A0 =A0 struct fsl_spi_platform_data *pdata =3D op->dev.platform_da=
ta;
> =A0 =A0 =A0 =A0struct mpc52xx_psc_spi *mps;
> =A0 =A0 =A0 =A0struct spi_master *master;
> + =A0 =A0 =A0 struct resource mem;
> + =A0 =A0 =A0 s16 id =3D -1;
> =A0 =A0 =A0 =A0int ret;
>
> - =A0 =A0 =A0 master =3D spi_alloc_master(dev, sizeof *mps);
> - =A0 =A0 =A0 if (master =3D=3D NULL)
> + =A0 =A0 =A0 /* get PSC id (only 1,2,3,6 can do SPI) */
> + =A0 =A0 =A0 if (!pdata) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 const u32 *psc_nump;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psc_nump =3D of_get_property(op->node, "cel=
l-index", NULL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!psc_nump || (*psc_nump > 2 && *psc_num=
p !=3D 5)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&op->dev, "PSC can'=
t do SPI\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 id =3D *psc_nump + 1;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 ret =3D of_address_to_resource(op->node, 0, &mem);
> + =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> +
> + =A0 =A0 =A0 master =3D spi_alloc_master(&op->dev, sizeof *mps);
> + =A0 =A0 =A0 if (!master)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENOMEM;
>
> - =A0 =A0 =A0 dev_set_drvdata(dev, master);
> + =A0 =A0 =A0 if (!request_mem_region(mem.start, resource_size(&mem), DRI=
VER_NAME)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto free_master;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 dev_set_drvdata(&op->dev, master);
> =A0 =A0 =A0 =A0mps =3D spi_master_get_devdata(master);
>
> =A0 =A0 =A0 =A0/* the spi->mode bits understood by this driver: */
> =A0 =A0 =A0 =A0master->mode_bits =3D SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | =
SPI_LSB_FIRST;
>
> - =A0 =A0 =A0 mps->irq =3D irq;
> - =A0 =A0 =A0 if (pdata =3D=3D NULL) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(dev, "probe called without platfor=
m data, no "
> + =A0 =A0 =A0 mps->irq =3D irq_of_parse_and_map(op->node, 0);
> + =A0 =A0 =A0 if (!pdata) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(&op->dev, "probe called without pl=
atform data, no "
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"cs_contro=
l function will be called\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mps->cs_control =3D NULL;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mps->sysclk =3D 0;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 master->bus_num =3D bus_num;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 master->bus_num =3D id;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0master->num_chipselect =3D 255;
> =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mps->cs_control =3D pdata->cs_control;
> @@ -395,19 +419,18 @@ static int __init mpc52xx_psc_spi_do_probe(struct d=
evice *dev, u32 regaddr,
> =A0 =A0 =A0 =A0master->transfer =3D mpc52xx_psc_spi_transfer;
> =A0 =A0 =A0 =A0master->cleanup =3D mpc52xx_psc_spi_cleanup;
>
> - =A0 =A0 =A0 mps->psc =3D ioremap(regaddr, size);
> + =A0 =A0 =A0 mps->psc =3D ioremap(mem.start, resource_size(&mem));
> =A0 =A0 =A0 =A0if (!mps->psc) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "could not ioremap I/O port ra=
nge\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&op->dev, "could not ioremap I/O po=
rt range\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D -EFAULT;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto free_master;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto free_unmap;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0/* On the 5200, fifo regs are immediately ajacent to the p=
sc regs */
> =A0 =A0 =A0 =A0mps->fifo =3D ((void __iomem *)mps->psc) + sizeof(struct m=
pc52xx_psc);
>
> - =A0 =A0 =A0 ret =3D request_irq(mps->irq, mpc52xx_psc_spi_isr, 0, "mpc5=
2xx-psc-spi",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mps);
> + =A0 =A0 =A0 ret =3D request_irq(mps->irq, mpc52xx_psc_spi_isr, 0, DRIVE=
R_NAME, mps);
> =A0 =A0 =A0 =A0if (ret)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto free_master;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto free_unmap;
>
> =A0 =A0 =A0 =A0ret =3D mpc52xx_psc_spi_port_config(master->bus_num, mps);
> =A0 =A0 =A0 =A0if (ret < 0)
> @@ -429,24 +452,29 @@ static int __init mpc52xx_psc_spi_do_probe(struct d=
evice *dev, u32 regaddr,
> =A0 =A0 =A0 =A0if (ret < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto unreg_master;
>
> + =A0 =A0 =A0 of_register_spi_devices(master, op->node);
> +
> =A0 =A0 =A0 =A0return ret;
>
> =A0unreg_master:
> =A0 =A0 =A0 =A0destroy_workqueue(mps->workqueue);
> =A0free_irq:
> =A0 =A0 =A0 =A0free_irq(mps->irq, mps);
> -free_master:
> +free_unmap:
> =A0 =A0 =A0 =A0if (mps->psc)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0iounmap(mps->psc);
> + =A0 =A0 =A0 release_mem_region(mem.start, resource_size(&mem));
> +free_master:
> =A0 =A0 =A0 =A0spi_master_put(master);
>
> =A0 =A0 =A0 =A0return ret;
> =A0}
>
> -static int __exit mpc52xx_psc_spi_do_remove(struct device *dev)
> +static int __exit mpc52xx_psc_spi_of_remove(struct of_device *op)
> =A0{
> - =A0 =A0 =A0 struct spi_master *master =3D dev_get_drvdata(dev);
> + =A0 =A0 =A0 struct spi_master *master =3D dev_get_drvdata(&op->dev);
> =A0 =A0 =A0 =A0struct mpc52xx_psc_spi *mps =3D spi_master_get_devdata(mas=
ter);
> + =A0 =A0 =A0 struct resource mem;
>
> =A0 =A0 =A0 =A0flush_workqueue(mps->workqueue);
> =A0 =A0 =A0 =A0destroy_workqueue(mps->workqueue);
> @@ -454,46 +482,12 @@ static int __exit mpc52xx_psc_spi_do_remove(struct =
device *dev)
> =A0 =A0 =A0 =A0free_irq(mps->irq, mps);
> =A0 =A0 =A0 =A0if (mps->psc)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0iounmap(mps->psc);
> + =A0 =A0 =A0 if (of_address_to_resource(op->node, 0, &mem) =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 release_mem_region(mem.start, resource_size=
(&mem));
>
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> -static int __init mpc52xx_psc_spi_of_probe(struct of_device *op,
> - =A0 =A0 =A0 const struct of_device_id *match)
> -{
> - =A0 =A0 =A0 const u32 *regaddr_p;
> - =A0 =A0 =A0 u64 regaddr64, size64;
> - =A0 =A0 =A0 s16 id =3D -1;
> -
> - =A0 =A0 =A0 regaddr_p =3D of_get_address(op->node, 0, &size64, NULL);
> - =A0 =A0 =A0 if (!regaddr_p) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Invalid PSC address\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> - =A0 =A0 =A0 }
> - =A0 =A0 =A0 regaddr64 =3D of_translate_address(op->node, regaddr_p);
> -
> - =A0 =A0 =A0 /* get PSC id (1..6, used by port_config) */
> - =A0 =A0 =A0 if (op->dev.platform_data =3D=3D NULL) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 const u32 *psc_nump;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 psc_nump =3D of_get_property(op->node, "cel=
l-index", NULL);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!psc_nump || *psc_nump > 5) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "mpc52xx_ps=
c_spi: Device node %s has invalid "
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 "cell-index property\n", op->node->full_name);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 id =3D *psc_nump + 1;
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 return mpc52xx_psc_spi_do_probe(&op->dev, (u32)regaddr64, (=
u32)size64,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 irq_of_parse_and_map(op->node, 0), id);
> -}
> -
> -static int __exit mpc52xx_psc_spi_of_remove(struct of_device *op)
> -{
> - =A0 =A0 =A0 return mpc52xx_psc_spi_do_remove(&op->dev);
> -}
> -
> =A0static struct of_device_id mpc52xx_psc_spi_of_match[] =3D {
> =A0 =A0 =A0 =A0{ .compatible =3D "fsl,mpc5200-psc-spi", },
> =A0 =A0 =A0 =A0{ .compatible =3D "mpc5200-psc-spi", }, /* old */
> @@ -504,12 +498,12 @@ MODULE_DEVICE_TABLE(of, mpc52xx_psc_spi_of_match);
>
> =A0static struct of_platform_driver mpc52xx_psc_spi_of_driver =3D {
> =A0 =A0 =A0 =A0.owner =3D THIS_MODULE,
> - =A0 =A0 =A0 .name =3D "mpc52xx-psc-spi",
> + =A0 =A0 =A0 .name =3D DRIVER_NAME,
> =A0 =A0 =A0 =A0.match_table =3D mpc52xx_psc_spi_of_match,
> =A0 =A0 =A0 =A0.probe =3D mpc52xx_psc_spi_of_probe,
> =A0 =A0 =A0 =A0.remove =3D __exit_p(mpc52xx_psc_spi_of_remove),
> =A0 =A0 =A0 =A0.driver =3D {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "mpc52xx-psc-spi",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D DRIVER_NAME,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.owner =3D THIS_MODULE,
> =A0 =A0 =A0 =A0},
> =A0};
> --
> 1.6.3.3
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

--000e0cd598da0a5ba0047744d716
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-spi-mpc5200-Register-SPI-devices-described-in-device.patch"
Content-Disposition: attachment;
	filename="0001-spi-mpc5200-Register-SPI-devices-described-in-device.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g1h3ej6a0

RnJvbSA3NjI5ZDQwZGMzNDNmZjIxNmI3NTJkNWM2ODY1NGRjOWQzMGYwYzkxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBHcmFudCBMaWtlbHkgPGdyYW50Lmxpa2VseUBzZWNyZXRsYWIu
Y2E+CkRhdGU6IFNhdCwgMzEgT2N0IDIwMDkgMTc6NDk6MzggLTA2MDAKU3ViamVjdDogW1BBVENI
XSBzcGkvbXBjNTIwMDogUmVnaXN0ZXIgU1BJIGRldmljZXMgZGVzY3JpYmVkIGluIGRldmljZSB0
cmVlCgpBZGQgY2FsbCB0byBvZl9yZWdpc3Rlcl9zcGlfZGV2aWNlcygpIHRvIHJlZ2lzdGVyIFNQ
SSBkZXZpY2VzIGRlc2NyaWJlZAppbiB0aGUgT0YgZGV2aWNlIHRyZWUuCgpTaWduZWQtb2ZmLWJ5
OiBHcmFudCBMaWtlbHkgPGdyYW50Lmxpa2VseUBzZWNyZXRsYWIuY2E+Ci0tLQogZHJpdmVycy9z
cGkvbXBjNTJ4eF9wc2Nfc3BpLmMgfCAgICA4ICsrKysrKystCiAxIGZpbGVzIGNoYW5nZWQsIDcg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3NwaS9t
cGM1Mnh4X3BzY19zcGkuYyBiL2RyaXZlcnMvc3BpL21wYzUyeHhfcHNjX3NwaS5jCmluZGV4IDFi
NzRkNWMuLmI0NDU0NjQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvc3BpL21wYzUyeHhfcHNjX3NwaS5j
CisrKyBiL2RyaXZlcnMvc3BpL21wYzUyeHhfcHNjX3NwaS5jCkBAIC0xNyw2ICsxNyw3IEBACiAj
aW5jbHVkZSA8bGludXgvZXJybm8uaD4KICNpbmNsdWRlIDxsaW51eC9pbnRlcnJ1cHQuaD4KICNp
bmNsdWRlIDxsaW51eC9vZl9wbGF0Zm9ybS5oPgorI2luY2x1ZGUgPGxpbnV4L29mX3NwaS5oPgog
I2luY2x1ZGUgPGxpbnV4L3dvcmtxdWV1ZS5oPgogI2luY2x1ZGUgPGxpbnV4L2NvbXBsZXRpb24u
aD4KICNpbmNsdWRlIDxsaW51eC9pby5oPgpAQCAtNDY0LDYgKzQ2NSw3IEBAIHN0YXRpYyBpbnQg
X19pbml0IG1wYzUyeHhfcHNjX3NwaV9vZl9wcm9iZShzdHJ1Y3Qgb2ZfZGV2aWNlICpvcCwKIAlj
b25zdCB1MzIgKnJlZ2FkZHJfcDsKIAl1NjQgcmVnYWRkcjY0LCBzaXplNjQ7CiAJczE2IGlkID0g
LTE7CisJaW50IHJjOwogCiAJcmVnYWRkcl9wID0gb2ZfZ2V0X2FkZHJlc3Mob3AtPm5vZGUsIDAs
ICZzaXplNjQsIE5VTEwpOwogCWlmICghcmVnYWRkcl9wKSB7CkBAIC00ODUsOCArNDg3LDEyIEBA
IHN0YXRpYyBpbnQgX19pbml0IG1wYzUyeHhfcHNjX3NwaV9vZl9wcm9iZShzdHJ1Y3Qgb2ZfZGV2
aWNlICpvcCwKIAkJaWQgPSAqcHNjX251bXAgKyAxOwogCX0KIAotCXJldHVybiBtcGM1Mnh4X3Bz
Y19zcGlfZG9fcHJvYmUoJm9wLT5kZXYsICh1MzIpcmVnYWRkcjY0LCAodTMyKXNpemU2NCwKKwly
YyA9IG1wYzUyeHhfcHNjX3NwaV9kb19wcm9iZSgmb3AtPmRldiwgKHUzMilyZWdhZGRyNjQsICh1
MzIpc2l6ZTY0LAogCQkJCQlpcnFfb2ZfcGFyc2VfYW5kX21hcChvcC0+bm9kZSwgMCksIGlkKTsK
KwlpZiAoIXJjKQorCQlvZl9yZWdpc3Rlcl9zcGlfZGV2aWNlcyhkZXZfZ2V0X2RydmRhdGEoJm9w
LT5kZXYpLCBvcC0+bm9kZSk7CisKKwlyZXR1cm4gcmM7CiB9CiAKIHN0YXRpYyBpbnQgX19leGl0
IG1wYzUyeHhfcHNjX3NwaV9vZl9yZW1vdmUoc3RydWN0IG9mX2RldmljZSAqb3ApCi0tIAoxLjYu
My4zCgo=
--000e0cd598da0a5ba0047744d716--
