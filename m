Return-Path: <ppc@mindchasers.com>
Received: from resqmta-ch2-10v.sys.comcast.net
 (resqmta-ch2-10v.sys.comcast.net [69.252.207.42])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A20E71A06C7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jun 2015 04:00:15 +1000 (AEST)
Message-ID: <55806425.7020505@mindchasers.com>
Date: Tue, 16 Jun 2015 14:00:05 -0400
From: Bob Cochran <ppc@mindchasers.com>
MIME-Version: 1.0
To: Yuantian.Tang@freescale.com, b07421@freescale.com
CC: linuxppc-dev@lists.ozlabs.org, Chenhui Zhao <chenhui.zhao@freescale.com>
Subject: Re: [PATCH v3] powerpc/rcpm: add RCPM driver
References: <1434446808-31121-1-git-send-email-Yuantian.Tang@freescale.com>
In-Reply-To: <1434446808-31121-1-git-send-email-Yuantian.Tang@freescale.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/16/2015 05:26 AM, Yuantian.Tang@freescale.com wrote:
> From: Tang Yuantian <Yuantian.Tang@freescale.com>
>
> There is a RCPM (Run Control/Power Management) in Freescale QorIQ
> series processors. The device performs tasks associated with device
> run control and power management.
>
> The driver implements some features: mask/unmask irq, enter/exit low
> power states, freeze time base, etc.
>
> Signed-off-by: Chenhui Zhao <chenhui.zhao@freescale.com>
> Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
> ---
> v3:
> 	- added static and __init modifier to fsl_rcpm_init
> v2:
> 	- fix code style issues
> 	- refine compatible string match part
>
>   Documentation/devicetree/bindings/soc/fsl/rcpm.txt |  22 ++
>   arch/powerpc/include/asm/fsl_guts.h                | 105 +++++++
>   arch/powerpc/include/asm/fsl_pm.h                  |  48 +++
>   arch/powerpc/platforms/85xx/Kconfig                |   1 +
>   arch/powerpc/sysdev/Kconfig                        |   5 +
>   arch/powerpc/sysdev/Makefile                       |   1 +
>   arch/powerpc/sysdev/fsl_rcpm.c                     | 338 +++++++++++++++++++++
>   7 files changed, 520 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/soc/fsl/rcpm.txt
>   create mode 100644 arch/powerpc/include/asm/fsl_pm.h
>   create mode 100644 arch/powerpc/sysdev/fsl_rcpm.c
>
> diff --git a/Documentation/devicetree/bindings/soc/fsl/rcpm.txt b/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
> new file mode 100644
> index 0000000..5318999
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
> @@ -0,0 +1,22 @@
> +* Run Control and Power Management
> +
> +The RCPM performs all device-level tasks associated with device run control
> +and power management.
> +
> +Required properites:
> +  - reg : Offset and length of the register set of RCPM block.
> +  - compatible : Specifies the compatibility list for the RCPM. The type
> +    should be string, such as "fsl,qoriq-rcpm-1.0", "fsl,qoriq-rcpm-2.0".


I just checked both my T1040 RM and datasheet, and I didn't see mention 
of the RCPM version that's used ( I assume it's 2.0 ).  Is there a 
general rule for which SoCs have which version?  If so, perhaps you'll 
want to include it here along with your examples.



> +
> +Example:
> +The RCPM node for T4240:
> +	rcpm: global-utilities@e2000 {
> +		compatible = "fsl,t4240-rcpm", "fsl,qoriq-rcpm-2.0";
> +		reg = <0xe2000 0x1000>;
> +	};
> +
> +The RCPM node for P4080:
> +	rcpm: global-utilities@e2000 {
> +		compatible = "fsl,qoriq-rcpm-1.0";
> +		reg = <0xe2000 0x1000>;
> +	};

-- cut ---

> diff --git a/arch/powerpc/include/asm/fsl_pm.h b/arch/powerpc/include/asm/fsl_pm.h
> new file mode 100644
> index 0000000..4b09f09
> --- /dev/null
> +++ b/arch/powerpc/include/asm/fsl_pm.h
> @@ -0,0 +1,48 @@
> +/*
> + * Support Power Management
> + *
> + * Copyright 2014-2015 Freescale Semiconductor Inc.
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +#ifndef __PPC_FSL_PM_H
> +#define __PPC_FSL_PM_H
> +#ifdef __KERNEL__
> +
> +#define E500_PM_PH10	1
> +#define E500_PM_PH15	2
> +#define E500_PM_PH20	3
> +#define E500_PM_PH30	4
> +#define E500_PM_DOZE	E500_PM_PH10
> +#define E500_PM_NAP	E500_PM_PH15


Are you using "E500" in your labels for historical reasons? I can use 
this driver with E5500 and E6500 cores, right?  However, maybe I'm 
mistaken since some of your states don't seem to map to my E5500 / T1040 
(e.g., my RCPM doesn't seem to support PH20 or PH30, but I do have LPM10 
and LPM35, which I don't think your driver supports).  My RM states that 
LPM35 is a newer PM state, so maybe this is future work to be done?


> +
> +#define PLAT_PM_SLEEP	20
> +#define PLAT_PM_LPM20	30
> +
> +#define FSL_PM_SLEEP		(1 << 0)
> +#define FSL_PM_DEEP_SLEEP	(1 << 1)


I don't see where you use FSL_PM_DEEP_SLEEP, and I'm wondering if this 
was provisioned for LPM35, which is documented to be a deep sleep mode.


> +
> +struct fsl_pm_ops {
> +	/* mask pending interrupts to the RCPM from MPIC */
> +	void (*irq_mask)(int cpu);
> +
> +	/* unmask pending interrupts to the RCPM from MPIC */
> +	void (*irq_unmask)(int cpu);
> +	void (*cpu_enter_state)(int cpu, int state);
> +	void (*cpu_exit_state)(int cpu, int state);
> +	int (*plat_enter_sleep)(void);
> +	void (*freeze_time_base)(bool freeze);
> +
> +	/* keep the power of IP blocks during sleep/deep sleep */
> +	void (*set_ip_power)(bool enable, u32 *mask);
> +
> +	/* get platform supported power management modes */
> +	unsigned int (*get_pm_modes)(void);
> +};
> +
> +extern const struct fsl_pm_ops *qoriq_pm_ops;
> +#endif /* __KERNEL__ */
> +#endif /* __PPC_FSL_PM_H */

-- cut ---
