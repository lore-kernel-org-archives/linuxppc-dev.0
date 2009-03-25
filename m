Return-Path: <vimalsingh@ti.com>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 445B7DDD01
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Mar 2009 21:52:04 +1100 (EST)
From: "Singh, Vimal" <vimalsingh@ti.com>
To: Wolfgang Grandegger <wg@grandegger.com>, "linux-mtd@lists.infradead.org"
	<linux-mtd@lists.infradead.org>, "linuxppc-dev@ozlabs.org"
	<linuxppc-dev@ozlabs.org>
Date: Wed, 25 Mar 2009 16:13:38 +0530
Subject: RE: [PATCH v3 1/4] NAND: FSL-UPM: add multi chip support
Message-ID: <19F8576C6E063C45BE387C64729E73940427A869E0@dbde02.ent.ti.com>
References: <1237975701-23201-1-git-send-email-wg@grandegger.com>,
	<1237975701-23201-2-git-send-email-wg@grandegger.com>
In-Reply-To: <1237975701-23201-2-git-send-email-wg@grandegger.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +static void fun_select_chip(struct mtd_info *mtd, int chip_nr)
> +{
> +       struct nand_chip *chip =3D mtd->priv;
> +       struct fsl_upm_nand *fun =3D to_fsl_upm_nand(mtd);
> +
> +       if (chip_nr =3D=3D -1) {
> +               chip->cmd_ctrl(mtd, NAND_CMD_NONE, 0 |=20
> NAND_CTRL_CHANGE);
> +       } else if (chip_nr >=3D 0) {
> +               fun->chip_number =3D chip_nr;
> +               chip->IO_ADDR_R =3D chip->IO_ADDR_W =3D
> +                       fun->io_base + chip_nr * fun->chip_offset;
> +       } else {
> +               BUG();
> +       }
braces are not required here...


> +       prop =3D of_get_property(ofdev->node, "num-chips", &size);
> +       if (prop && size =3D=3D sizeof(uint32_t)) {
> +               fun->num_chips =3D *prop;
> +               if (fun->num_chips >=3D NAND_MAX_CHIPS) {
> +                       dev_err(&ofdev->dev, "too much chips");
> +                       ret =3D -EINVAL;
> +                       goto err1;
> +               }
> +       } else {
> +               fun->num_chips =3D 1;
> +       }
ditto...=
