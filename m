Return-Path: <B04825@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1D8AEB7006
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Jun 2012 01:39:33 +1000 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Zhao Chenhui-B35336 <B35336@freescale.com>
Subject: Re: [PATCH v6 1/5] powerpc/85xx: implement hardware timebase sync
Date: Fri, 29 Jun 2012 15:39:24 +0000
Message-ID: <CAOZdJXWiGOCtP1iJYR2S48XwR2Wpry8+VswctctdVfY9Z+QTiQ@mail.gmail.com>
References: <1340706359-9455-1-git-send-email-chenhui.zhao@freescale.com>
In-Reply-To: <1340706359-9455-1-git-send-email-chenhui.zhao@freescale.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Li Yang-R58472 <r58472@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 26, 2012 at 5:25 AM, Zhao Chenhui
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
> Changes for v6:
> =A0* added 85xx_TB_SYNC
> =A0* added isync() after set_tb()
> =A0* removed extra entries from mpc85xx_smp_guts_ids
>
> =A0arch/powerpc/include/asm/fsl_guts.h | =A0 =A02 +
> =A0arch/powerpc/platforms/85xx/Kconfig | =A0 =A05 ++
> =A0arch/powerpc/platforms/85xx/smp.c =A0 | =A0 84 +++++++++++++++++++++++=
++++++++++++
> =A03 files changed, 91 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/fsl_guts.h b/arch/powerpc/include/a=
sm/fsl_guts.h
> index aa4c488..dd5ba2c 100644
> --- a/arch/powerpc/include/asm/fsl_guts.h
> +++ b/arch/powerpc/include/asm/fsl_guts.h
> @@ -48,6 +48,8 @@ struct ccsr_guts {
> =A0 =A0 =A0 =A0 __be32 =A0dmuxcr; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* 0x.00=
68 - DMA Mux Control Register */
> =A0 =A0 =A0 =A0 u8 =A0 =A0 res06c[0x70 - 0x6c];
> =A0 =A0 =A0 =A0__be32 =A0devdisr; =A0 =A0 =A0 =A0/* 0x.0070 - Device Disa=
ble Control */
> +#define CCSR_GUTS_DEVDISR_TB1 =A00x00001000
> +#define CCSR_GUTS_DEVDISR_TB0 =A00x00004000
> =A0 =A0 =A0 =A0__be32 =A0devdisr2; =A0 =A0 =A0 /* 0x.0074 - Device Disabl=
e Control 2 */
> =A0 =A0 =A0 =A0u8 =A0 =A0 =A0res078[0x7c - 0x78];
> =A0 =A0 =A0 =A0__be32 =A0pmjcr; =A0 =A0 =A0 =A0 =A0/* 0x.007c - 4 Power M=
anagement Jog Control Register */
> diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms=
/85xx/Kconfig
> index f000d81..8dd7147 100644
> --- a/arch/powerpc/platforms/85xx/Kconfig
> +++ b/arch/powerpc/platforms/85xx/Kconfig
> @@ -8,6 +8,7 @@ menuconfig FSL_SOC_BOOKE
> =A0 =A0 =A0 =A0select FSL_PCI if PCI
> =A0 =A0 =A0 =A0select SERIAL_8250_EXTENDED if SERIAL_8250
> =A0 =A0 =A0 =A0select SERIAL_8250_SHARE_IRQ if SERIAL_8250
> + =A0 =A0 =A0 select 85xx_TB_SYNC if KEXEC
> =A0 =A0 =A0 =A0default y
>
> =A0if FSL_SOC_BOOKE
> @@ -267,3 +268,7 @@ endif # FSL_SOC_BOOKE
>
> =A0config TQM85xx
> =A0 =A0 =A0 =A0bool
> +
> +config 85xx_TB_SYNC
> + =A0 =A0 =A0 bool
> + =A0 =A0 =A0 default n
> diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/8=
5xx/smp.c
> index ff42490..edb0cad 100644
> --- a/arch/powerpc/platforms/85xx/smp.c
> +++ b/arch/powerpc/platforms/85xx/smp.c
> @@ -24,6 +24,7 @@
> =A0#include <asm/mpic.h>
> =A0#include <asm/cacheflush.h>
> =A0#include <asm/dbell.h>
> +#include <asm/fsl_guts.h>
>
> =A0#include <sysdev/fsl_soc.h>
> =A0#include <sysdev/mpic.h>
> @@ -42,6 +43,69 @@ extern void __early_start(void);
> =A0#define NUM_BOOT_ENTRY =A0 =A0 =A0 =A0 8
> =A0#define SIZE_BOOT_ENTRY =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(NUM_BOOT_ENTRY=
 * sizeof(u32))
>
> +#ifdef CONFIG_85xx_TB_SYNC
> +static struct ccsr_guts __iomem *guts;
> +static u64 timebase;
> +static int tb_req;
> +static int tb_valid;
> +
> +static void mpc85xx_timebase_freeze(int freeze)
> +{
> + =A0 =A0 =A0 unsigned int mask;

'mask' should be uint32_t

> +
> + =A0 =A0 =A0 if (!guts)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;

This function should never be called if guts is NULL, so this check
should be unnecessary.

> +
> + =A0 =A0 =A0 mask =3D CCSR_GUTS_DEVDISR_TB0 | CCSR_GUTS_DEVDISR_TB1;
> + =A0 =A0 =A0 if (freeze)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 setbits32(&guts->devdisr, mask);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clrbits32(&guts->devdisr, mask);
> +
> + =A0 =A0 =A0 in_be32(&guts->devdisr);
> +}
> +
> +static void mpc85xx_give_timebase(void)
> +{
> + =A0 =A0 =A0 unsigned long flags;
> +
> + =A0 =A0 =A0 local_irq_save(flags);
> +
> + =A0 =A0 =A0 while (!tb_req)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 barrier();

I think tb_req and tb_valid need to be 'volatile'.

> + =A0 =A0 =A0 tb_req =3D 0;
> +
> + =A0 =A0 =A0 mpc85xx_timebase_freeze(1);
> + =A0 =A0 =A0 timebase =3D get_tb();
> + =A0 =A0 =A0 mb();
> + =A0 =A0 =A0 tb_valid =3D 1;
> +
> + =A0 =A0 =A0 while (tb_valid)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 barrier();
> +
> + =A0 =A0 =A0 mpc85xx_timebase_freeze(0);
> +
> + =A0 =A0 =A0 local_irq_restore(flags);
> +}
> +
> +static void mpc85xx_take_timebase(void)
> +{
> + =A0 =A0 =A0 unsigned long flags;
> +
> + =A0 =A0 =A0 local_irq_save(flags);
> +
> + =A0 =A0 =A0 tb_req =3D 1;
> + =A0 =A0 =A0 while (!tb_valid)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 barrier();
> +
> + =A0 =A0 =A0 set_tb(timebase >> 32, timebase & 0xffffffff);
> + =A0 =A0 =A0 isync();
> + =A0 =A0 =A0 tb_valid =3D 0;
> +
> + =A0 =A0 =A0 local_irq_restore(flags);
> +}
> +#endif
> +
> =A0static int __init
> =A0smp_85xx_kick_cpu(int nr)
> =A0{
> @@ -228,6 +292,16 @@ smp_85xx_setup_cpu(int cpu_nr)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0doorbell_setup_this_cpu();
> =A0}
>
> +static const struct of_device_id mpc85xx_smp_guts_ids[] =3D {
> + =A0 =A0 =A0 { .compatible =3D "fsl,mpc8572-guts", },
> + =A0 =A0 =A0 { .compatible =3D "fsl,p1020-guts", },
> + =A0 =A0 =A0 { .compatible =3D "fsl,p1021-guts", },
> + =A0 =A0 =A0 { .compatible =3D "fsl,p1022-guts", },
> + =A0 =A0 =A0 { .compatible =3D "fsl,p1023-guts", },
> + =A0 =A0 =A0 { .compatible =3D "fsl,p2020-guts", },
> + =A0 =A0 =A0 {},
> +};

I wonder if it's possible to dynamically generate the compatible
string by using the SOC name?

> +
> =A0void __init mpc85xx_smp_init(void)
> =A0{
> =A0 =A0 =A0 =A0struct device_node *np;
> @@ -249,6 +323,16 @@ void __init mpc85xx_smp_init(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0smp_85xx_ops.cause_ipi =3D doorbell_cause_=
ipi;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 np =3D of_find_matching_node(NULL, mpc85xx_smp_guts_ids);
> + =A0 =A0 =A0 if (np) {
> +#ifdef CONFIG_85xx_TB_SYNC
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 guts =3D of_iomap(np, 0);

You need to test the return value of of_iomap().  smp_85xx_ops should
be set only if guts is not NULL.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 smp_85xx_ops.give_timebase =3D mpc85xx_give=
_timebase;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 smp_85xx_ops.take_timebase =3D mpc85xx_take=
_timebase;
> +#endif
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_node_put(np);
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0smp_ops =3D &smp_85xx_ops;
>
> =A0#ifdef CONFIG_KEXEC
> --
> 1.6.4.1
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/



--=20
Timur Tabi
Linux kernel developer at Freescale=
