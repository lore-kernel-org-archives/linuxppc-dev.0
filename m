Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.30])
	by ozlabs.org (Postfix) with ESMTP id 51E04DDFAE
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Mar 2009 00:31:07 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so19165yxg.39
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Mar 2009 06:31:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1237975701-23201-2-git-send-email-wg@grandegger.com>
References: <1237975701-23201-1-git-send-email-wg@grandegger.com>
	<1237975701-23201-2-git-send-email-wg@grandegger.com>
Date: Wed, 25 Mar 2009 07:31:06 -0600
Message-ID: <fa686aa40903250631w6a0cc8b9p3b2e3c1348e0acee@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] NAND: FSL-UPM: add multi chip support
From: Grant Likely <grant.likely@secretlab.ca>
To: Wolfgang Grandegger <wg@grandegger.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 25, 2009 at 4:08 AM, Wolfgang Grandegger <wg@grandegger.com> wr=
ote:
> This patch adds support for multi-chip NAND devices to the FSL-UPM
> driver. This requires support for multiple GPIOs for the RNB pins.
> The NAND chips are selected through address lines defined by the
> FDT property "chip-offset".
>
> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>

Hi Wolfgang,

Can you please send a sample device tree snippit for this and add
documentation updates to your patch for the extended binding?

Thanks,
g.

> ---
> =A0arch/powerpc/sysdev/fsl_lbc.c | =A0 =A02 +-
> =A0drivers/mtd/nand/fsl_upm.c =A0 =A0| =A0 95 +++++++++++++++++++++++++++=
++++---------
> =A02 files changed, 74 insertions(+), 23 deletions(-)
>
> diff --git a/arch/powerpc/sysdev/fsl_lbc.c b/arch/powerpc/sysdev/fsl_lbc.=
c
> index 0494ee5..dceb8d1 100644
> --- a/arch/powerpc/sysdev/fsl_lbc.c
> +++ b/arch/powerpc/sysdev/fsl_lbc.c
> @@ -150,7 +150,7 @@ int fsl_upm_run_pattern(struct fsl_upm *upm, void __i=
omem *io_base, u32 mar)
>
> =A0 =A0 =A0 =A0spin_lock_irqsave(&fsl_lbc_lock, flags);
>
> - =A0 =A0 =A0 out_be32(&fsl_lbc_regs->mar, mar << (32 - upm->width));
> + =A0 =A0 =A0 out_be32(&fsl_lbc_regs->mar, mar);
>
> =A0 =A0 =A0 =A0switch (upm->width) {
> =A0 =A0 =A0 =A0case 8:
> diff --git a/drivers/mtd/nand/fsl_upm.c b/drivers/mtd/nand/fsl_upm.c
> index 7815a40..9b314ce 100644
> --- a/drivers/mtd/nand/fsl_upm.c
> +++ b/drivers/mtd/nand/fsl_upm.c
> @@ -36,8 +36,11 @@ struct fsl_upm_nand {
> =A0 =A0 =A0 =A0uint8_t upm_addr_offset;
> =A0 =A0 =A0 =A0uint8_t upm_cmd_offset;
> =A0 =A0 =A0 =A0void __iomem *io_base;
> - =A0 =A0 =A0 int rnb_gpio;
> + =A0 =A0 =A0 int rnb_gpio[NAND_MAX_CHIPS];
> =A0 =A0 =A0 =A0int chip_delay;
> + =A0 =A0 =A0 uint32_t num_chips;
> + =A0 =A0 =A0 uint32_t chip_number;
> + =A0 =A0 =A0 uint32_t chip_offset;
> =A0};
>
> =A0#define to_fsl_upm_nand(mtd) container_of(mtd, struct fsl_upm_nand, mt=
d)
> @@ -46,7 +49,7 @@ static int fun_chip_ready(struct mtd_info *mtd)
> =A0{
> =A0 =A0 =A0 =A0struct fsl_upm_nand *fun =3D to_fsl_upm_nand(mtd);
>
> - =A0 =A0 =A0 if (gpio_get_value(fun->rnb_gpio))
> + =A0 =A0 =A0 if (gpio_get_value(fun->rnb_gpio[fun->chip_number]))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 1;
>
> =A0 =A0 =A0 =A0dev_vdbg(fun->dev, "busy\n");
> @@ -55,9 +58,9 @@ static int fun_chip_ready(struct mtd_info *mtd)
>
> =A0static void fun_wait_rnb(struct fsl_upm_nand *fun)
> =A0{
> - =A0 =A0 =A0 int cnt =3D 1000000;
>
> - =A0 =A0 =A0 if (fun->rnb_gpio >=3D 0) {
> + =A0 =A0 =A0 if (fun->rnb_gpio[fun->chip_number] >=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int cnt =3D 1000000;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0while (--cnt && !fun_chip_ready(&fun->mtd)=
)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpu_relax();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!cnt)
> @@ -69,7 +72,9 @@ static void fun_wait_rnb(struct fsl_upm_nand *fun)
>
> =A0static void fun_cmd_ctrl(struct mtd_info *mtd, int cmd, unsigned int c=
trl)
> =A0{
> + =A0 =A0 =A0 struct nand_chip *chip =3D mtd->priv;
> =A0 =A0 =A0 =A0struct fsl_upm_nand *fun =3D to_fsl_upm_nand(mtd);
> + =A0 =A0 =A0 u32 mar;
>
> =A0 =A0 =A0 =A0if (!(ctrl & fun->last_ctrl)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fsl_upm_end_pattern(&fun->upm);
> @@ -87,11 +92,30 @@ static void fun_cmd_ctrl(struct mtd_info *mtd, int cm=
d, unsigned int ctrl)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fsl_upm_start_pattern(&fun=
->upm, fun->upm_cmd_offset);
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 fsl_upm_run_pattern(&fun->upm, fun->io_base, cmd);
> + =A0 =A0 =A0 mar =3D cmd << (32 - fun->upm.width);
> + =A0 =A0 =A0 if (fun->chip_offset && fun->chip_number > 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mar |=3D fun->chip_number * fun->chip_offse=
t;
> + =A0 =A0 =A0 fsl_upm_run_pattern(&fun->upm, chip->IO_ADDR_R, mar);
>
> =A0 =A0 =A0 =A0fun_wait_rnb(fun);
> =A0}
>
> +static void fun_select_chip(struct mtd_info *mtd, int chip_nr)
> +{
> + =A0 =A0 =A0 struct nand_chip *chip =3D mtd->priv;
> + =A0 =A0 =A0 struct fsl_upm_nand *fun =3D to_fsl_upm_nand(mtd);
> +
> + =A0 =A0 =A0 if (chip_nr =3D=3D -1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 chip->cmd_ctrl(mtd, NAND_CMD_NONE, 0 | NAND=
_CTRL_CHANGE);
> + =A0 =A0 =A0 } else if (chip_nr >=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fun->chip_number =3D chip_nr;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 chip->IO_ADDR_R =3D chip->IO_ADDR_W =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fun->io_base + chip_nr * fu=
n->chip_offset;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 BUG();
> + =A0 =A0 =A0 }
> +}
> +
> =A0static uint8_t fun_read_byte(struct mtd_info *mtd)
> =A0{
> =A0 =A0 =A0 =A0struct fsl_upm_nand *fun =3D to_fsl_upm_nand(mtd);
> @@ -137,8 +161,10 @@ static int __devinit fun_chip_init(struct fsl_upm_na=
nd *fun,
> =A0 =A0 =A0 =A0fun->chip.read_buf =3D fun_read_buf;
> =A0 =A0 =A0 =A0fun->chip.write_buf =3D fun_write_buf;
> =A0 =A0 =A0 =A0fun->chip.ecc.mode =3D NAND_ECC_SOFT;
> + =A0 =A0 =A0 if (fun->num_chips > 1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fun->chip.select_chip =3D fun_select_chip;
>
> - =A0 =A0 =A0 if (fun->rnb_gpio >=3D 0)
> + =A0 =A0 =A0 if (fun->rnb_gpio[0] >=3D 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fun->chip.dev_ready =3D fun_chip_ready;
>
> =A0 =A0 =A0 =A0fun->mtd.priv =3D &fun->chip;
> @@ -155,7 +181,7 @@ static int __devinit fun_chip_init(struct fsl_upm_nan=
d *fun,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 ret =3D nand_scan(&fun->mtd, 1);
> + =A0 =A0 =A0 ret =3D nand_scan(&fun->mtd, fun->num_chips);
> =A0 =A0 =A0 =A0if (ret)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err;
>
> @@ -187,6 +213,7 @@ static int __devinit fun_probe(struct of_device *ofde=
v,
> =A0 =A0 =A0 =A0const uint32_t *prop;
> =A0 =A0 =A0 =A0int ret;
> =A0 =A0 =A0 =A0int size;
> + =A0 =A0 =A0 int i;
>
> =A0 =A0 =A0 =A0fun =3D kzalloc(sizeof(*fun), GFP_KERNEL);
> =A0 =A0 =A0 =A0if (!fun)
> @@ -208,7 +235,7 @@ static int __devinit fun_probe(struct of_device *ofde=
v,
> =A0 =A0 =A0 =A0if (!prop || size !=3D sizeof(uint32_t)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&ofdev->dev, "can't get UPM addres=
s offset\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D -EINVAL;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err1;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0fun->upm_addr_offset =3D *prop;
>
> @@ -216,21 +243,36 @@ static int __devinit fun_probe(struct of_device *of=
dev,
> =A0 =A0 =A0 =A0if (!prop || size !=3D sizeof(uint32_t)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&ofdev->dev, "can't get UPM comman=
d offset\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D -EINVAL;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err1;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0fun->upm_cmd_offset =3D *prop;
>
> - =A0 =A0 =A0 fun->rnb_gpio =3D of_get_gpio(ofdev->node, 0);
> - =A0 =A0 =A0 if (fun->rnb_gpio >=3D 0) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D gpio_request(fun->rnb_gpio, dev_nam=
e(&ofdev->dev));
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&ofdev->dev, "can't=
 request RNB gpio\n");
> + =A0 =A0 =A0 prop =3D of_get_property(ofdev->node, "num-chips", &size);
> + =A0 =A0 =A0 if (prop && size =3D=3D sizeof(uint32_t)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fun->num_chips =3D *prop;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (fun->num_chips >=3D NAND_MAX_CHIPS) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&ofdev->dev, "too m=
uch chips");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fun->num_chips =3D 1;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 for (i =3D 0; i < fun->num_chips; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fun->rnb_gpio[i] =3D of_get_gpio(ofdev->nod=
e, i);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (fun->rnb_gpio[i] >=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D gpio_request(fun->r=
nb_gpio[i],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0dev_name(&ofdev->dev));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&of=
dev->dev, "can't request RNB gpio\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_direction_input(fun->r=
nb_gpio[i]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (fun->rnb_gpio[i] =A0=3D=3D -EINV=
AL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&ofdev->dev, "speci=
fied RNB gpio is invalid\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err2;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_direction_input(fun->rnb_gpio);
> - =A0 =A0 =A0 } else if (fun->rnb_gpio =3D=3D -EINVAL) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&ofdev->dev, "specified RNB gpio is=
 invalid\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err2;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0prop =3D of_get_property(ofdev->node, "chip-delay", NULL);
> @@ -239,6 +281,10 @@ static int __devinit fun_probe(struct of_device *ofd=
ev,
> =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fun->chip_delay =3D 50;
>
> + =A0 =A0 =A0 prop =3D of_get_property(ofdev->node, "chip-offset", &size)=
;
> + =A0 =A0 =A0 if (prop && size =3D=3D sizeof(uint32_t))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fun->chip_offset =3D *prop;
> +
> =A0 =A0 =A0 =A0fun->io_base =3D devm_ioremap_nocache(&ofdev->dev, io_res.=
start,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0io_res.end - io_res.start + 1);
> =A0 =A0 =A0 =A0if (!fun->io_base) {
> @@ -257,8 +303,10 @@ static int __devinit fun_probe(struct of_device *ofd=
ev,
>
> =A0 =A0 =A0 =A0return 0;
> =A0err2:
> - =A0 =A0 =A0 if (fun->rnb_gpio >=3D 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_free(fun->rnb_gpio);
> + =A0 =A0 =A0 for (i =3D 0; i < fun->num_chips; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (fun->rnb_gpio[i] >=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_free(fun->rnb_gpio[i])=
;
> + =A0 =A0 =A0 }
> =A0err1:
> =A0 =A0 =A0 =A0kfree(fun);
>
> @@ -268,12 +316,15 @@ err1:
> =A0static int __devexit fun_remove(struct of_device *ofdev)
> =A0{
> =A0 =A0 =A0 =A0struct fsl_upm_nand *fun =3D dev_get_drvdata(&ofdev->dev);
> + =A0 =A0 =A0 int i;
>
> =A0 =A0 =A0 =A0nand_release(&fun->mtd);
> =A0 =A0 =A0 =A0kfree(fun->mtd.name);
>
> - =A0 =A0 =A0 if (fun->rnb_gpio >=3D 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_free(fun->rnb_gpio);
> + =A0 =A0 =A0 =A0for (i =3D 0; i < fun->num_chips; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (fun->rnb_gpio[i] >=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gpio_free(fun->rnb_gpio[=
i]);
> + =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0kfree(fun);
>
> --
> 1.6.0.6
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
