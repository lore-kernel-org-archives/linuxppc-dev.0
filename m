Return-Path: <B04825@freescale.com>
Received: from TX2EHSOBE002.bigfish.com (tx2ehsobe001.messaging.microsoft.com
 [65.55.88.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3C86F1007D1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Jan 2012 07:50:24 +1100 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Fan Zhicheng-B32736 <B32736@freescale.com>
Subject: Re: [PATCH 1/2] P1025RDB: add Quicc Engine support
Date: Fri, 20 Jan 2012 20:50:15 +0000
Message-ID: <CAOZdJXUCfAcwej9LQNboXQs6FeB9+V0GPqDa7_zPNhpQRHHisw@mail.gmail.com>
References: <1327035611-22794-1-git-send-email-B32736@freescale.com>
In-Reply-To: <1327035611-22794-1-git-send-email-B32736@freescale.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Fanzc <b32736@freeescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 19, 2012 at 11:00 PM, Zhicheng Fan <B32736@freescale.com> wrote=
:
> From: Fanzc <b32736@freeescale.com>
>
> Signed-off-by: Fanzc <b32736@freeescale.com>

Please use your full name (first and last name)

> ---
> =A0arch/powerpc/platforms/85xx/mpc85xx_rdb.c | =A0 79 +++++++++++++++++++=
+++++++++-
> =A01 files changed, 78 insertions(+), 1 deletions(-)
>
> diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c b/arch/powerpc/pla=
tforms/85xx/mpc85xx_rdb.c
> index 1950076..1ba67aa 100644
> --- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
> +++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
> @@ -26,6 +26,9 @@
> =A0#include <asm/prom.h>
> =A0#include <asm/udbg.h>
> =A0#include <asm/mpic.h>
> +#include <asm/qe.h>
> +#include <asm/qe_ic.h>
> +#include <asm/fsl_guts.h>
>
> =A0#include <sysdev/fsl_soc.h>
> =A0#include <sysdev/fsl_pci.h>
> @@ -47,6 +50,10 @@ void __init mpc85xx_rdb_pic_init(void)
> =A0 =A0 =A0 =A0struct mpic *mpic;
> =A0 =A0 =A0 =A0unsigned long root =3D of_get_flat_dt_root();
>
> +#ifdef CONFIG_QUICC_ENGINE
> + =A0 =A0 =A0 struct device_node *np;
> +#endif
> +
> =A0 =A0 =A0 =A0if (of_flat_dt_is_compatible(root, "fsl,MPC85XXRDB-CAMP"))=
 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mpic =3D mpic_alloc(NULL, 0,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MPIC_BIG_ENDIAN | MPIC_BRO=
KEN_FRR_NIRQS |
> @@ -62,6 +69,18 @@ void __init mpc85xx_rdb_pic_init(void)
>
> =A0 =A0 =A0 =A0BUG_ON(mpic =3D=3D NULL);
> =A0 =A0 =A0 =A0mpic_init(mpic);
> +
> +#ifdef CONFIG_QUICC_ENGINE
> + =A0 =A0 =A0 np =3D of_find_compatible_node(NULL, NULL, "fsl,qe-ic");
> + =A0 =A0 =A0 if (np) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 qe_ic_init(np, 0, qe_ic_cascade_low_mpic,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 qe_ic_casca=
de_high_mpic);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_node_put(np);
> +
> + =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Could not find qe-ic node\=
n");

Use pr_err instead of printk(KERN_ERR

> +#endif
> +
> =A0}
>
> =A0/*
> @@ -69,7 +88,7 @@ void __init mpc85xx_rdb_pic_init(void)
> =A0*/
> =A0static void __init mpc85xx_rdb_setup_arch(void)
> =A0{
> -#ifdef CONFIG_PCI
> +#if defined(CONFIG_PCI) || defined(CONFIG_QUICC_ENGINE)
> =A0 =A0 =A0 =A0struct device_node *np;
> =A0#endif
>
> @@ -85,6 +104,64 @@ static void __init mpc85xx_rdb_setup_arch(void)
> =A0#endif
>
> =A0 =A0 =A0 =A0mpc85xx_smp_init();
> +
> +#ifdef CONFIG_QUICC_ENGINE
> + =A0 =A0 =A0 np =3D of_find_compatible_node(NULL, NULL, "fsl,qe");
> + =A0 =A0 =A0 if (!np) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Could not find Quicc Engin=
e node\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto qe_fail;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 qe_reset();
> + =A0 =A0 =A0 of_node_put(np);
> +
> + =A0 =A0 =A0 np =3D of_find_node_by_name(NULL, "par_io");
> + =A0 =A0 =A0 if (np) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_node *ucc;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 par_io_init(np);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_node_put(np);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for_each_node_by_name(ucc, "ucc")
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 par_io_of_config(ucc);
> +
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (machine_is(p1025_rdb)) {
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __be32 __iomem *pmuxcr;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 np =3D of_find_node_by_name(NULL, "global-u=
tilities");
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (np) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pmuxcr =3D of_iomap(np, 0) =
+ MPC85xx_PMUXCR_OFFSET;

You're missing the iounmap().

--=20
Timur Tabi
Linux kernel developer at Freescale=
