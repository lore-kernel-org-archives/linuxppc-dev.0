Return-Path: <srs0=li5n=fx=axtens.net=dja@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zsD2q6G2czF1XF
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Mar 2018 11:34:27 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3zsD2q4Tbbz8t3C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Mar 2018 11:34:27 +1100 (AEDT)
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3zsD2p6CJDz9s3K
 for <linuxppc-dev@ozlabs.org>; Thu,  1 Mar 2018 11:34:25 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id g12so1630665pgs.0
 for <linuxppc-dev@ozlabs.org>; Wed, 28 Feb 2018 16:34:25 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Subject: Re: [RFC PATCH 1/6] powerpc: Add security feature flags for
 Spectre/Meltdown
In-Reply-To: <20180228145316.11347-1-mpe@ellerman.id.au>
References: <20180228145316.11347-1-mpe@ellerman.id.au>
Date: Thu, 01 Mar 2018 11:34:19 +1100
Message-ID: <87606geir8.fsf@linkitivity.dja.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:

> This commit adds security feature flags to reflect the settings we
> receive from firmware regarding Spectre/Meltdown mitigations.
>
> The feature names reflect the names we are given by firmware on bare
> metal machines. See the hostboot source for details.
>
> Arguably these could be firmware features, but that then requires them
> to be read early in boot so they're available prior to asm feature
> patching, but we don't actually want to use them for patching. We may
> also want to dynamically update them in future, which would be
> incompatible with the way firmware features work (at the moment at
> least). So for now just make them separate flags.
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/include/asm/security_features.h | 65 ++++++++++++++++++++++++++++
>  arch/powerpc/kernel/Makefile                 |  2 +-
>  arch/powerpc/kernel/security.c               | 14 ++++++
>  3 files changed, 80 insertions(+), 1 deletion(-)
>  create mode 100644 arch/powerpc/include/asm/security_features.h
>  create mode 100644 arch/powerpc/kernel/security.c
>
> diff --git a/arch/powerpc/include/asm/security_features.h b/arch/powerpc/include/asm/security_features.h
> new file mode 100644
> index 000000000000..3b690de8b0e8
> --- /dev/null
> +++ b/arch/powerpc/include/asm/security_features.h
> @@ -0,0 +1,65 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Security related feature bit definitions.
> + *
> + * Copyright 2018, Michael Ellerman, IBM Corporation.
> + */
> +
> +#ifndef _ASM_POWERPC_SECURITY_FEATURES_H
> +#define _ASM_POWERPC_SECURITY_FEATURES_H
> +
> +
> +extern unsigned long powerpc_security_features;
> +
> +static inline void security_ftr_set(unsigned long feature)
> +{
> +	powerpc_security_features |= feature;
> +}
> +
> +static inline void security_ftr_clear(unsigned long feature)
> +{
> +	powerpc_security_features &= ~feature;
> +}
> +
> +static inline bool security_ftr_enabled(unsigned long feature)
> +{
> +	return !!(powerpc_security_features & feature);
> +}
> +
> +
> +// Features indicating support for Spectre/Meltdown mitigations
> +
> +// The L1-D cache can be flushed with ori r30,r30,0
> +#define SEC_FTR_L1D_FLUSH_ORI30		0x0000000000000001ull
> +
> +// The L1-D cache can be flushed with mtspr 882,r0 (aka SPRN_TRIG2ull
This looks like some sort of search-replace gone wrong? ------------^^^^

> +#define SEC_FTR_L1D_FLUSH_TRIG2		0x0000000000000002ull

> +
> +// ori r31,r31,0 acts as a speculation barrier
> +#define SEC_FTR_SPEC_BAR_ORI31		0x0000000000000004ull
> +
> +// Speculation past bctr is disabled
> +#define SEC_FTR_BCCTRL_SERIALISED	0x0000000000000008ull
> +
> +// Entries in L1-D are private to a SMT thread
> +#define SEC_FTR_L1D_THREAD_PRIV		0x0000000000000010ull
> +
> +// Indirect branch prediction cache disabled
> +#define SEC_FTR_COUNT_CACHE_DISABLED	0x0000000000000020ull
> +
> +
> +// Features indicating need for Spectre/Meltdown mitigations
> +
> +// The L1-D cache should be flushed on MSR[HV] 1->0 transition (hypervisor to guest)
> +#define SEC_FTR_L1D_FLUSH_HV		0x0000000000000040ull
> +
> +// The L1-D cache should be flushed on MSR[PR] 0->1 transition (kernel to userspace)
> +#define SEC_FTR_L1D_FLUSH_PR		0x0000000000000080ull
> +
> +// A speculation barrier should be used for bounds checks (Spectre variant 1ull
Likewise here? ---------------------------------------------------------------^^^^

Regards,
Daniel

> +#define SEC_FTR_BNDS_CHK_SPEC_BAR	0x0000000000000100ull
> +
> +// Firmware configuration indicates user favours security over performance
> +#define SEC_FTR_FAVOUR_SECURITY		0x0000000000000200ull
> +
> +#endif /* _ASM_POWERPC_SECURITY_FEATURES_H */
> diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
> index 1b6bc7fba996..d458c45e5004 100644
> --- a/arch/powerpc/kernel/Makefile
> +++ b/arch/powerpc/kernel/Makefile
> @@ -42,7 +42,7 @@ obj-$(CONFIG_VDSO32)		+= vdso32/
>  obj-$(CONFIG_PPC_WATCHDOG)	+= watchdog.o
>  obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
>  obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_ppc970.o cpu_setup_pa6t.o
> -obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_power.o
> +obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_power.o security.o
>  obj-$(CONFIG_PPC_BOOK3S_64)	+= mce.o mce_power.o
>  obj-$(CONFIG_PPC_BOOK3E_64)	+= exceptions-64e.o idle_book3e.o
>  obj-$(CONFIG_PPC64)		+= vdso64/
> diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
> new file mode 100644
> index 000000000000..c62a5d7196e3
> --- /dev/null
> +++ b/arch/powerpc/kernel/security.c
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +//
> +// Security related flags and so on.
> +//
> +// Copyright 2018, Michael Ellerman, IBM Corporation.
> +
> +#include <asm/security_features.h>
> +
> +
> +unsigned long powerpc_security_features __read_mostly = \
> +	SEC_FTR_L1D_FLUSH_HV | \
> +	SEC_FTR_L1D_FLUSH_PR | \
> +	SEC_FTR_BNDS_CHK_SPEC_BAR | \
> +	SEC_FTR_FAVOUR_SECURITY;
> -- 
> 2.14.1
