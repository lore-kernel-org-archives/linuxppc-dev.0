Return-Path: <pku.leo@gmail.com>
Received: from mail-gg0-f179.google.com (mail-gg0-f179.google.com
 [209.85.161.179]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4E15EB6FAC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 May 2012 17:30:53 +1000 (EST)
Received: by ggnk3 with SMTP id k3so2320860ggn.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 May 2012 00:30:49 -0700 (PDT)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <1336737235-15370-1-git-send-email-chenhui.zhao@freescale.com>
References: <1336737235-15370-1-git-send-email-chenhui.zhao@freescale.com>
Date: Tue, 29 May 2012 15:30:49 +0800
Message-ID: <CADRPPNRL7s6adxJyotCRJ6_KmXnxrqKdcj-Hrg8MXoAAYR7Txg@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] powerpc/85xx: implement hardware timebase sync
From: Li Yang <leoli@freescale.com>
To: Zhao Chenhui <chenhui.zhao@freescale.com>
Content-Type: text/plain; charset=UTF-8
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Scott,

Thanks for the valuable comment raised before and we have updated the
patches accordingly.  Please review the updated patch set and ACK if
they are good to you.  We hope it can be applied in this window.

Leo

On Fri, May 11, 2012 at 7:53 PM, Zhao Chenhui
<chenhui.zhao@freescale.com> wrote:
> Do hardware timebase sync. Firstly, stop all timebases, and transfer
> the timebase value of the boot core to the other core. Finally,
> start all timebases.
>
> Only apply to dual-core chips, such as MPC8572, P2020, etc.
>
> Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> =C2=A0arch/powerpc/include/asm/fsl_guts.h | =C2=A0 =C2=A02 +
> =C2=A0arch/powerpc/platforms/85xx/smp.c =C2=A0 | =C2=A0 93 ++++++++++++++=
+++++++++++++++++++--
> =C2=A02 files changed, 91 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/fsl_guts.h b/arch/powerpc/include/a=
sm/fsl_guts.h
> index aa4c488..dd5ba2c 100644
> --- a/arch/powerpc/include/asm/fsl_guts.h
> +++ b/arch/powerpc/include/asm/fsl_guts.h
> @@ -48,6 +48,8 @@ struct ccsr_guts {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 __be32 =C2=A0dmuxcr; =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* 0x.0068 - DMA Mux Control Register */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 =C2=A0 =C2=A0 res06c[0x70 - 0x6c];
> =C2=A0 =C2=A0 =C2=A0 =C2=A0__be32 =C2=A0devdisr; =C2=A0 =C2=A0 =C2=A0 =C2=
=A0/* 0x.0070 - Device Disable Control */
> +#define CCSR_GUTS_DEVDISR_TB1 =C2=A00x00001000
> +#define CCSR_GUTS_DEVDISR_TB0 =C2=A00x00004000
> =C2=A0 =C2=A0 =C2=A0 =C2=A0__be32 =C2=A0devdisr2; =C2=A0 =C2=A0 =C2=A0 /*=
 0x.0074 - Device Disable Control 2 */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0u8 =C2=A0 =C2=A0 =C2=A0res078[0x7c - 0x78];
> =C2=A0 =C2=A0 =C2=A0 =C2=A0__be32 =C2=A0pmjcr; =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* 0x.007c - 4 Power Management Jog Control Register */
> diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/8=
5xx/smp.c
> index ff42490..6862dda 100644
> --- a/arch/powerpc/platforms/85xx/smp.c
> +++ b/arch/powerpc/platforms/85xx/smp.c
> @@ -24,6 +24,7 @@
> =C2=A0#include <asm/mpic.h>
> =C2=A0#include <asm/cacheflush.h>
> =C2=A0#include <asm/dbell.h>
> +#include <asm/fsl_guts.h>
>
> =C2=A0#include <sysdev/fsl_soc.h>
> =C2=A0#include <sysdev/mpic.h>
> @@ -115,13 +116,70 @@ smp_85xx_kick_cpu(int nr)
>
> =C2=A0struct smp_ops_t smp_85xx_ops =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.kick_cpu =3D smp_85xx_kick_cpu,
> -#ifdef CONFIG_KEXEC
> - =C2=A0 =C2=A0 =C2=A0 .give_timebase =C2=A0=3D smp_generic_give_timebase=
,
> - =C2=A0 =C2=A0 =C2=A0 .take_timebase =C2=A0=3D smp_generic_take_timebase=
,
> -#endif
> =C2=A0};
>
> =C2=A0#ifdef CONFIG_KEXEC
> +static struct ccsr_guts __iomem *guts;
> +static u64 timebase;
> +static int tb_req;
> +static int tb_valid;
> +
> +static void mpc85xx_timebase_freeze(int freeze)
> +{
> + =C2=A0 =C2=A0 =C2=A0 unsigned int mask;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (!guts)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> +
> + =C2=A0 =C2=A0 =C2=A0 mask =3D CCSR_GUTS_DEVDISR_TB0 | CCSR_GUTS_DEVDISR=
_TB1;
> + =C2=A0 =C2=A0 =C2=A0 if (freeze)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 setbits32(&guts->devdi=
sr, mask);
> + =C2=A0 =C2=A0 =C2=A0 else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clrbits32(&guts->devdi=
sr, mask);
> +
> + =C2=A0 =C2=A0 =C2=A0 in_be32(&guts->devdisr);
> +}
> +
> +static void mpc85xx_give_timebase(void)
> +{
> + =C2=A0 =C2=A0 =C2=A0 unsigned long flags;
> +
> + =C2=A0 =C2=A0 =C2=A0 local_irq_save(flags);
> +
> + =C2=A0 =C2=A0 =C2=A0 while (!tb_req)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 barrier();
> + =C2=A0 =C2=A0 =C2=A0 tb_req =3D 0;
> +
> + =C2=A0 =C2=A0 =C2=A0 mpc85xx_timebase_freeze(1);
> + =C2=A0 =C2=A0 =C2=A0 timebase =3D get_tb();
> + =C2=A0 =C2=A0 =C2=A0 mb();
> + =C2=A0 =C2=A0 =C2=A0 tb_valid =3D 1;
> +
> + =C2=A0 =C2=A0 =C2=A0 while (tb_valid)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 barrier();
> +
> + =C2=A0 =C2=A0 =C2=A0 mpc85xx_timebase_freeze(0);
> +
> + =C2=A0 =C2=A0 =C2=A0 local_irq_restore(flags);
> +}
> +
> +static void mpc85xx_take_timebase(void)
> +{
> + =C2=A0 =C2=A0 =C2=A0 unsigned long flags;
> +
> + =C2=A0 =C2=A0 =C2=A0 local_irq_save(flags);
> +
> + =C2=A0 =C2=A0 =C2=A0 tb_req =3D 1;
> + =C2=A0 =C2=A0 =C2=A0 while (!tb_valid)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 barrier();
> +
> + =C2=A0 =C2=A0 =C2=A0 set_tb(timebase >> 32, timebase & 0xffffffff);
> + =C2=A0 =C2=A0 =C2=A0 mb();
> + =C2=A0 =C2=A0 =C2=A0 tb_valid =3D 0;
> +
> + =C2=A0 =C2=A0 =C2=A0 local_irq_restore(flags);
> +}
> +
> =C2=A0atomic_t kexec_down_cpus =3D ATOMIC_INIT(0);
>
> =C2=A0void mpc85xx_smp_kexec_cpu_down(int crash_shutdown, int secondary)
> @@ -228,6 +286,20 @@ smp_85xx_setup_cpu(int cpu_nr)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0doorbell_setup_thi=
s_cpu();
> =C2=A0}
>
> +#ifdef CONFIG_KEXEC
> +static const struct of_device_id guts_ids[] =3D {
> + =C2=A0 =C2=A0 =C2=A0 { .compatible =3D "fsl,mpc8572-guts", },
> + =C2=A0 =C2=A0 =C2=A0 { .compatible =3D "fsl,mpc8560-guts", },
> + =C2=A0 =C2=A0 =C2=A0 { .compatible =3D "fsl,mpc8536-guts", },
> + =C2=A0 =C2=A0 =C2=A0 { .compatible =3D "fsl,p1020-guts", },
> + =C2=A0 =C2=A0 =C2=A0 { .compatible =3D "fsl,p1021-guts", },
> + =C2=A0 =C2=A0 =C2=A0 { .compatible =3D "fsl,p1022-guts", },
> + =C2=A0 =C2=A0 =C2=A0 { .compatible =3D "fsl,p1023-guts", },
> + =C2=A0 =C2=A0 =C2=A0 { .compatible =3D "fsl,p2020-guts", },
> + =C2=A0 =C2=A0 =C2=A0 {},
> +};
> +#endif
> +
> =C2=A0void __init mpc85xx_smp_init(void)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct device_node *np;
> @@ -249,6 +321,19 @@ void __init mpc85xx_smp_init(void)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smp_85xx_ops.cause=
_ipi =3D doorbell_cause_ipi;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> +#ifdef CONFIG_KEXEC
> + =C2=A0 =C2=A0 =C2=A0 np =3D of_find_matching_node(NULL, guts_ids);
> + =C2=A0 =C2=A0 =C2=A0 if (np) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 guts =3D of_iomap(np, =
0);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 smp_85xx_ops.give_time=
base =3D mpc85xx_give_timebase;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 smp_85xx_ops.take_time=
base =3D mpc85xx_take_timebase;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 of_node_put(np);
> + =C2=A0 =C2=A0 =C2=A0 } else {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 smp_85xx_ops.give_time=
base =3D smp_generic_give_timebase;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 smp_85xx_ops.take_time=
base =3D smp_generic_take_timebase;
> + =C2=A0 =C2=A0 =C2=A0 }
> +#endif
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0smp_ops =3D &smp_85xx_ops;
>
> =C2=A0#ifdef CONFIG_KEXEC
> --
> 1.6.4.1
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =C2=A0http://www.tux.org/lkml/



--=20
- Leo
