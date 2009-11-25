Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.210.179]) by ozlabs.org (Postfix) with ESMTP id AB0CBB6EE9
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 25 Nov 2009 11:34:19 +1100 (EST)
Received: by yxe9 with SMTP id 9so7013599yxe.26
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 24 Nov 2009 16:34:17 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <200911211708.47253.to-fleischer@t-online.de>
References: <200911161742.46663.to-fleischer@t-online.de>
	<20091118232920.GA24307@oksana.dev.rtsoft.ru>
	<fa686aa40911210045v4be84e8dg8ef490472e06017b@mail.gmail.com>
	<200911211708.47253.to-fleischer@t-online.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 24 Nov 2009 17:33:57 -0700
Message-ID: <fa686aa40911241633q38dc0cf8x8b23038fe2fdf10d@mail.gmail.com>
Subject: Re: spi_mpc8xxx.c: chip select polarity problem
To: Torsten Fleischer <to-fleischer@t-online.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks.  However, there needs to be a proper description of what this
patch does to go in the commit header.  Can you please write one?

Thanks,
g.

On Sat, Nov 21, 2009 at 9:08 AM, Torsten Fleischer
<to-fleischer@t-online.de> wrote:
> On Sat, Nov 21, 2009 at 09:45:50 Grant Likely wrote:
> [...]
>> Hey Torsten, =A0do you have an updated version of this change to address
>> the comments? =A0I'm collecting the last few things for some linux-next
>> exposure now.
>
> Hey Grant,
>
> here is the updated version of the patch containing the recommended
> changes.
>
> Best Regards
> Torsten
>
>
> Signed-off-by: Torsten Fleischer <to-fleischer@t-online.de>
> ---
>
> diff -u -r -N linux-2.6.31.6_orig//drivers/spi/spi_mpc8xxx.c linux-2.6.31=
.6/drivers/spi/spi_mpc8xxx.c
> --- linux-2.6.31.6_orig//drivers/spi/spi_mpc8xxx.c =A0 =A0 =A02009-11-10 =
01:32:31.000000000 +0100
> +++ linux-2.6.31.6/drivers/spi/spi_mpc8xxx.c =A0 =A02009-11-19 08:15:33.0=
00000000 +0100
> @@ -114,6 +114,7 @@
> =A0 =A0 =A0 =A0u32 rx_shift; =A0 =A0 =A0 =A0 =A0 /* RX data reg shift whe=
n in qe mode */
> =A0 =A0 =A0 =A0u32 tx_shift; =A0 =A0 =A0 =A0 =A0 /* TX data reg shift whe=
n in qe mode */
> =A0 =A0 =A0 =A0u32 hw_mode; =A0 =A0 =A0 =A0 =A0 =A0/* Holds HW mode regis=
ter settings */
> + =A0 =A0 =A0 int initialized;
> =A0};
>
> =A0static inline void mpc8xxx_spi_write_reg(__be32 __iomem *reg, u32 val)
> @@ -503,15 +504,52 @@
>
> =A0 =A0 =A0 =A0return ret;
> =A0}
> +
> +
> +struct mpc8xxx_spi_probe_info {
> + =A0 =A0 =A0 struct fsl_spi_platform_data pdata;
> + =A0 =A0 =A0 int *gpios;
> + =A0 =A0 =A0 bool *alow_flags;
> +};
> +
> +static struct mpc8xxx_spi_probe_info *
> +to_of_pinfo(struct fsl_spi_platform_data *pdata)
> +{
> + =A0 =A0 =A0 return container_of(pdata, struct mpc8xxx_spi_probe_info, p=
data);
> +}
> +
> +static int mpc8xxx_spi_cs_init(struct spi_device *spi)
> +{
> + =A0 =A0 =A0 struct device *dev =3D spi->dev.parent;
> + =A0 =A0 =A0 struct mpc8xxx_spi_probe_info *pinfo =3D to_of_pinfo(dev->p=
latform_data);
> + =A0 =A0 =A0 u16 cs =3D spi->chip_select;
> + =A0 =A0 =A0 int gpio =3D pinfo->gpios[cs];
> + =A0 =A0 =A0 bool on =3D pinfo->alow_flags[cs] ^ !(spi->mode & SPI_CS_HI=
GH);
> +
> + =A0 =A0 =A0 return gpio_direction_output(gpio, on);
> +}
> +
> =A0static int mpc8xxx_spi_transfer(struct spi_device *spi,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct spi=
_message *m)
> =A0{
> =A0 =A0 =A0 =A0struct mpc8xxx_spi *mpc8xxx_spi =3D spi_master_get_devdata=
(spi->master);
> + =A0 =A0 =A0 struct spi_mpc8xxx_cs *cs =3D spi->controller_state;
> =A0 =A0 =A0 =A0unsigned long flags;
>
> =A0 =A0 =A0 =A0m->actual_length =3D 0;
> =A0 =A0 =A0 =A0m->status =3D -EINPROGRESS;
>
> + =A0 =A0 =A0 if (cs && !cs->initialized) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D mpc8xxx_spi_cs_init(spi);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&spi->dev, "cs_init=
 failed: %d\n", ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cs->initialized =3D 1;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0spin_lock_irqsave(&mpc8xxx_spi->lock, flags);
> =A0 =A0 =A0 =A0list_add_tail(&m->queue, &mpc8xxx_spi->queue);
> =A0 =A0 =A0 =A0queue_work(mpc8xxx_spi->workqueue, &mpc8xxx_spi->work);
> @@ -648,18 +686,6 @@
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> -struct mpc8xxx_spi_probe_info {
> - =A0 =A0 =A0 struct fsl_spi_platform_data pdata;
> - =A0 =A0 =A0 int *gpios;
> - =A0 =A0 =A0 bool *alow_flags;
> -};
> -
> -static struct mpc8xxx_spi_probe_info *
> -to_of_pinfo(struct fsl_spi_platform_data *pdata)
> -{
> - =A0 =A0 =A0 return container_of(pdata, struct mpc8xxx_spi_probe_info, p=
data);
> -}
> -
> =A0static void mpc8xxx_spi_cs_control(struct spi_device *spi, bool on)
> =A0{
> =A0 =A0 =A0 =A0struct device *dev =3D spi->dev.parent;
> @@ -720,14 +746,6 @@
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pinfo->gpios[i] =3D gpio;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pinfo->alow_flags[i] =3D flags & OF_GPIO_A=
CTIVE_LOW;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D gpio_direction_output(pinfo->gpios[=
i],
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 pinfo->alow_flags[i]);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "can't set out=
put direction for gpio "
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "#%d: %d\n"=
, i, ret);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_loop;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0pdata->max_chipselect =3D ngpios;
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
