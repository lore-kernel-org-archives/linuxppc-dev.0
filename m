Return-Path: <chenhui.zhao@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0141.outbound.protection.outlook.com [157.56.110.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9FA6F1A03D6
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Apr 2015 21:33:33 +1100 (AEDT)
From: "chenhui.zhao@freescale.com" <chenhui.zhao@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [2/4] powerpc/rcpm: add RCPM driver
Date: Thu, 2 Apr 2015 10:33:24 +0000
Message-ID: <1427970805609.21194@freescale.com>
References: <1427365095-26396-2-git-send-email-chenhui.zhao@freescale.com>,
 <20150331013057.GB5667@home.buserror.net>
In-Reply-To: <20150331013057.GB5667@home.buserror.net>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Jason.Jin@freescale.com" <Jason.Jin@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



________________________________________
From: Wood Scott-B07421
Sent: Tuesday, March 31, 2015 9:30
To: Zhao Chenhui-B35336
Cc: linuxppc-dev@lists.ozlabs.org; devicetree@vger.kernel.org; linux-kernel=
@vger.kernel.org; Jin Zhengxiong-R64188
Subject: Re: [2/4] powerpc/rcpm: add RCPM driver

On Thu, Mar 26, 2015 at 06:18:13PM +0800, chenhui zhao wrote:
> There is a RCPM (Run Control/Power Management) in Freescale QorIQ
> series processors. The device performs tasks associated with device
> run control and power management.
>
> The driver implements some features: mask/unmask irq, enter/exit low
> power states, freeze time base, etc.
>
> Signed-off-by: Chenhui Zhao <chenhui.zhao@freescale.com>
> ---
>  Documentation/devicetree/bindings/soc/fsl/rcpm.txt |  23 ++
>  arch/powerpc/include/asm/fsl_guts.h                | 105 ++++++
>  arch/powerpc/include/asm/fsl_pm.h                  |  49 +++
>  arch/powerpc/platforms/85xx/Kconfig                |   1 +
>  arch/powerpc/sysdev/Kconfig                        |   5 +
>  arch/powerpc/sysdev/Makefile                       |   1 +
>  arch/powerpc/sysdev/fsl_rcpm.c                     | 353 +++++++++++++++=
++++++
>  7 files changed, 537 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/fsl/rcpm.txt
>  create mode 100644 arch/powerpc/include/asm/fsl_pm.h
>  create mode 100644 arch/powerpc/sysdev/fsl_rcpm.c
>
> diff --git a/Documentation/devicetree/bindings/soc/fsl/rcpm.txt b/Documen=
tation/devicetree/bindings/soc/fsl/rcpm.txt
> new file mode 100644
> index 0000000..8c21b6c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
> @@ -0,0 +1,23 @@
> +* Run Control and Power Management
> +
> +The RCPM performs all device-level tasks associated with device run cont=
rol
> +and power management.
> +
> +Required properites:
> +  - reg : Offset and length of the register set of RCPM block.
> +  - compatible : Specifies the compatibility list for the RCPM. The type
> +    should be string, such as "fsl,qoriq-rcpm-1.0", "fsl,qoriq-rcpm-2.0"=
.
> +
> +Example:
> +The RCPM node for T4240:
> +     rcpm: global-utilities@e2000 {
> +             compatible =3D "fsl,t4240-rcpm", "fsl,qoriq-rcpm-2.0";
> +             reg =3D <0xe2000 0x1000>;
> +     };
> +
> +The RCPM node for P4080:
> +     rcpm: global-utilities@e2000 {
> +             compatible =3D "fsl,qoriq-rcpm-1.0";
> +             reg =3D <0xe2000 0x1000>;
> +             #sleep-cells =3D <1>;
> +     };

Where is #sleep-cells documented?  It's copy-and-paste from something
that was never finished from many years ago.

[chenhui] Will get rid of them.

> diff --git a/arch/powerpc/include/asm/fsl_pm.h b/arch/powerpc/include/asm=
/fsl_pm.h
> new file mode 100644
> index 0000000..bbe6089
> --- /dev/null
> +++ b/arch/powerpc/include/asm/fsl_pm.h
> @@ -0,0 +1,49 @@
> +/*
> + * Support Power Management
> + *
> + * Copyright 2014-2015 Freescale Semiconductor Inc.
> + *
> + * This program is free software; you can redistribute  it and/or modify=
 it
> + * under  the terms of  the GNU General  Public License as published by =
the
> + * Free Software Foundation;  either version 2 of the  License, or (at y=
our
> + * option) any later version.
> + */
> +#ifndef __PPC_FSL_PM_H
> +#define __PPC_FSL_PM_H
> +#ifdef       __KERNEL__

Put a space after #ifdef, not a tab.

[Chenhui] Will change it.

> +#define E500_PM_PH10 1
> +#define E500_PM_PH15 2
> +#define E500_PM_PH20 3
> +#define E500_PM_PH30 4
> +#define E500_PM_DOZE E500_PM_PH10
> +#define E500_PM_NAP  E500_PM_PH15
> +
> +#define PLAT_PM_SLEEP        20
> +#define PLAT_PM_LPM20        30
> +
> +#define FSL_PM_SLEEP         (1 << 0)
> +#define FSL_PM_DEEP_SLEEP    (1 << 1)
> +
> +struct fsl_pm_ops {
> +     /* mask pending interrupts to the RCPM from MPIC */
> +     void (*irq_mask)(int cpu);
> +     /* unmask pending interrupts to the RCPM from MPIC */
> +     void (*irq_unmask)(int cpu);
> +     /* place the CPU in the specified state */
> +     void (*cpu_enter_state)(int cpu, int state);
> +     /* exit the CPU from the specified state */
> +     void (*cpu_exit_state)(int cpu, int state);
> +     /* place the platform in the sleep state */
> +     int (*plat_enter_sleep)(void);
> +     /* freeze the time base */
> +     void (*freeze_time_base)(int freeze);
> +     /* keep the power of IP blocks during sleep/deep sleep */
> +     void (*set_ip_power)(int enable, u32 *mask);
> +     /* get platform supported power management modes */
> +     unsigned int (*get_pm_modes)(void);
> +};

Drop the comments that are basically just a restatement of the function
name.  Where there are comments, it'd be easier to read with a blank line
between a function and the next comment.

s/int enable/bool enable/
s/int freeze/bool freeze/

[chenhui] Yes, you are right.

> +#endif       /* __KERNEL__ */
> +#endif  /* __PPC_FSL_PM_H */

Please be consistent with whitespace.

> +     default:
> +             pr_err("%s: Unknown cpu PM state (%d)\n", __func__, state);

WARN?

> +static int rcpm_v2_plat_enter_state(int state)
> +{
> +     u32 *pmcsr_reg =3D &rcpm_v2_regs->powmgtcsr;
> +     int ret =3D 0;
> +     int result;
> +
> +     switch (state) {
> +     case PLAT_PM_LPM20:
> +             /* clear previous LPM20 status */
> +             setbits32(pmcsr_reg, RCPM_POWMGTCSR_P_LPM20_ST);

How would the bit be set when you enter here, given that you wait for it
to clear when leaving?

[chenhui] Actually, the bit is not used by software. Just follow the instru=
ction in RM.

> +             /* enter LPM20 status */
> +             setbits32(pmcsr_reg, RCPM_POWMGTCSR_LPM20_RQ);
> +
> +             /* At this point, the device is in LPM20 status. */
> +
> +             /* resume ... */
> +             result =3D spin_event_timeout(
> +               !(in_be32(pmcsr_reg) & RCPM_POWMGTCSR_LPM20_ST), 10000, 1=
0);
> +             if (!result) {
> +                     pr_err("%s: timeout waiting for LPM20 bit to be cle=
ared\n",
> +                            __func__);
> +                     ret =3D -ETIMEDOUT;
> +             }
> +             break;

"At this point" is a bit misleading.  I think it's clear enough if you
just drop that comment.

> +     default:
> +             pr_err("%s: Unknown platform PM state (%d)\n",
> +                    __func__, state);
> +             ret =3D -EINVAL;
> +     }

WARN?

> +static const struct of_device_id rcpm_matches[] =3D {
> +     {
> +             .compatible =3D "fsl,qoriq-rcpm-1.0",
> +             .data =3D (void *)RCPM_V1,
> +     },
> +     {
> +             .compatible =3D "fsl,qoriq-rcpm-2.0",
> +             .data =3D (void *)RCPM_V2,
> +     },

Why not point .data directly at the ops?

[chenhui] I agree.

> +     switch ((unsigned long)match->data) {
> +     case RCPM_V1:
> +             rcpm_v1_regs =3D base;
> +             qoriq_pm_ops =3D &qoriq_rcpm_v1_ops;
> +             break;
> +
> +     case RCPM_V2:
> +             rcpm_v2_regs =3D base;
> +             qoriq_pm_ops =3D &qoriq_rcpm_v2_ops;
> +             break;
> +
> +     default:
> +             break;
> +     }

default: break; is unnecessary (and impossible to hit -- if you really
want default: it should probably WARN).

-Scott

[chenhui] Will get rid of them.
