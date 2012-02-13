Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9F506B6FC4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2012 03:22:34 +1100 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Fan Zhicheng-B32736 <B32736@freescale.com>
Subject: Re: [PATCH 1/2 v3] powerpc/85xx: Add Quicc Engine support for p1025rdb
Date: Mon, 13 Feb 2012 16:22:25 +0000
Message-ID: <CAOZdJXWJzBFqfK-b2Fk41zVitb+Gc5NEnnF9iMpUw6cENaAMrw@mail.gmail.com>
References: <1329111208-5320-1-git-send-email-B32736@freescale.com>
In-Reply-To: <1329111208-5320-1-git-send-email-B32736@freescale.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Feb 12, 2012 at 11:33 PM, Zhicheng Fan <B32736@freescale.com> wrote=
:
> From: Zhicheng Fan <b32736@freescale.com>
>
> Signed-off-by: Zhicheng Fan <b32736@freescale.com>
> ---
> =A0arch/powerpc/platforms/85xx/mpc85xx_rdb.c | =A0 78 +++++++++++++++++++=
+++++++++-
> =A01 files changed, 77 insertions(+), 1 deletions(-)
>
> diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c b/arch/powerpc/pla=
tforms/85xx/mpc85xx_rdb.c
> index e95aef7..c9dfdcc 100644
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
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: Could not find qe-ic node\n", _=
_func__);
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
> @@ -85,6 +104,63 @@ static void __init mpc85xx_rdb_setup_arch(void)
> =A0#endif
>
> =A0 =A0 =A0 =A0mpc85xx_smp_init();
> +
> +#ifdef CONFIG_QUICC_ENGINE
> + =A0 =A0 =A0 np =3D of_find_compatible_node(NULL, NULL, "fsl,qe");
> + =A0 =A0 =A0 if (!np) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: Could not find Quicc Engine nod=
e\n", __func__);
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
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct ccsr_guts_85xx __iomem *guts;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 np =3D of_find_node_by_name(NULL, "global-u=
tilities");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (np) {
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 guts =3D of_iomap(np, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!guts) {
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("mpc=
85xx-rdb: could not map global utilties register!\n");
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> +#if defined(CONFIG_UCC_GETH) || defined(CONFIG_SERIAL_QE)

This #if should be above the " if (machine_is(p1025_rdb)) {" line.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* P1025 has pins muxed for=
 QE and other functions. To
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * enable QE UEC mode, we ne=
ed to set bit QE0 for UCC1
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * in Eth mode, QE0 and QE3 =
for UCC5 in Eth mode, QE9
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * and QE12 for QE MII manag=
ement singals in PMUXCR
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * register.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 setbits32(&=
guts->pmuxcr, MPC85xx_PMUXCR_QE0 |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 MPC85xx_PMUXCR_QE3 |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 MPC85xx_PMUXCR_QE9 |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 MPC85xx_PMUXCR_QE12);
> +#endif
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 iounmap(guts);

Put the iounmap() call inside the "else" bracket:


                               setbits32(&guts->pmuxcr, MPC85xx_PMUXCR_QE0 =
|
                                               MPC85xx_PMUXCR_QE3 |
                                               MPC85xx_PMUXCR_QE9 |
                                               MPC85xx_PMUXCR_QE12);
                               iounmap(guts);
                       }

You're not really paying attention to the code that you're writing.
Please take a good look at your code before you paste it.

--=20
Timur Tabi
Linux kernel developer at Freescale=
