Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 250A0B73B4
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Feb 2012 21:16:29 +1100 (EST)
References: <1329384365-4028-1-git-send-email-yu.liu@freescale.com>
In-Reply-To: <1329384365-4028-1-git-send-email-yu.liu@freescale.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Message-Id: <7418E135-E85B-43CB-B066-91D9C537F548@suse.de>
From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH v4 1/3] KVM: PPC: epapr: Factor out the epapr init
Date: Thu, 16 Feb 2012 11:17:05 +0100
To: Liu Yu <yu.liu@freescale.com>
Cc: "<linuxppc-dev@ozlabs.org>" <linuxppc-dev@ozlabs.org>,
 Liu Yu <yu.liu@freescale.com>, "<kvm@vger.kernel.org>" <kvm@vger.kernel.org>,
 "<kvm-ppc@vger.kernel.org>" <kvm-ppc@vger.kernel.org>,
 "<B07421@freescale.com>" <B07421@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 16.02.2012, at 10:26, Liu Yu <yu.liu@freescale.com> wrote:

> from the kvm guest paravirt init code.
>=20
> Signed-off-by: Liu Yu <yu.liu@freescale.com>
> ---
> v4:
> 1. code cleanup
> 2. move kvm_hypercall_start() to epapr_hypercall_start()
>=20
> arch/powerpc/Kconfig                    |    4 ++
> arch/powerpc/include/asm/epapr_hcalls.h |    2 +
> arch/powerpc/kernel/Makefile            |    1 +
> arch/powerpc/kernel/epapr.S             |   25 ++++++++++++++++
> arch/powerpc/kernel/epapr_para.c        |   49 +++++++++++++++++++++++++++=
++++
> arch/powerpc/kernel/kvm.c               |   28 ++----------------
> arch/powerpc/kernel/kvm_emul.S          |   10 ------
> arch/powerpc/kvm/Kconfig                |    1 +
> 8 files changed, 85 insertions(+), 35 deletions(-)
> create mode 100644 arch/powerpc/kernel/epapr.S
> create mode 100644 arch/powerpc/kernel/epapr_para.c
>=20
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 1919634..1262b43 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -202,6 +202,10 @@ config EPAPR_BOOT
>      Used to allow a board to specify it wants an ePAPR compliant wrapper.=

>    default n
>=20
> +config EPAPR_PARAVIRT
> +    bool
> +    default n
> +
> config DEFAULT_UIMAGE
>    bool
>    help
> diff --git a/arch/powerpc/include/asm/epapr_hcalls.h b/arch/powerpc/includ=
e/asm/epapr_hcalls.h
> index f3b0c2c..0ff3f24 100644
> --- a/arch/powerpc/include/asm/epapr_hcalls.h
> +++ b/arch/powerpc/include/asm/epapr_hcalls.h
> @@ -148,6 +148,8 @@
> #define EV_HCALL_CLOBBERS2 EV_HCALL_CLOBBERS3, "r5"
> #define EV_HCALL_CLOBBERS1 EV_HCALL_CLOBBERS2, "r4"
>=20
> +extern bool epapr_para_enabled;
> +extern u32 epapr_hypercall_start[];
>=20
> /*
>  * We use "uintptr_t" to define a register because it's guaranteed to be a=

> diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
> index ee728e4..9e807f3 100644
> --- a/arch/powerpc/kernel/Makefile
> +++ b/arch/powerpc/kernel/Makefile
> @@ -136,6 +136,7 @@ ifneq ($(CONFIG_XMON)$(CONFIG_KEXEC),)
> obj-y                +=3D ppc_save_regs.o
> endif
>=20
> +obj-$(CONFIG_EPAPR_PARAVIRT)    +=3D epapr_para.o epapr.o
> obj-$(CONFIG_KVM_GUEST)        +=3D kvm.o kvm_emul.o
>=20
> # Disable GCOV in odd or sensitive code
> diff --git a/arch/powerpc/kernel/epapr.S b/arch/powerpc/kernel/epapr.S
> new file mode 100644
> index 0000000..697b390
> --- /dev/null
> +++ b/arch/powerpc/kernel/epapr.S
> @@ -0,0 +1,25 @@
> +/*
> + * Copyright (C) 2012 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +
> +#include <linux/threads.h>
> +#include <asm/reg.h>
> +#include <asm/page.h>
> +#include <asm/cputable.h>
> +#include <asm/thread_info.h>
> +#include <asm/ppc_asm.h>
> +#include <asm/asm-offsets.h>
> +
> +/* Hypercall entry point. Will be patched with device tree instructions. *=
/
> +.global epapr_hypercall_start
> +epapr_hypercall_start:
> +    li    r3, -1
> +    nop
> +    nop
> +    nop
> +    blr
> diff --git a/arch/powerpc/kernel/epapr_para.c b/arch/powerpc/kernel/epapr_=
para.c
> new file mode 100644
> index 0000000..ea13cac
> --- /dev/null
> +++ b/arch/powerpc/kernel/epapr_para.c
> @@ -0,0 +1,49 @@
> +/*
> + * ePAPR para-virtualization support.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License, version 2, as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, U=
SA.
> + *
> + * Copyright (C) 2012 Freescale Semiconductor, Inc.
> + */
> +
> +#include <linux/of.h>
> +#include <asm/epapr_hcalls.h>
> +#include <asm/cacheflush.h>
> +
> +bool epapr_para_enabled =3D false;
> +
> +static int __init epapr_para_init(void)
> +{
> +    struct device_node *hyper_node;
> +    const u32 *insts;
> +    int len, i;
> +
> +    hyper_node =3D of_find_node_by_path("/hypervisor");
> +    if (!hyper_node)
> +        return -ENODEV;
> +
> +    insts =3D of_get_property(hyper_node, "hcall-instructions", &len);
> +    if (!(len % 4) && (len >=3D (4 * 4))) {
> +        for (i =3D 0; i < (len / 4); i++)

So if the dt passes in less than 4 ops, you bail out, and for more you overw=
rite the buffer? Not good :)

> +            epapr_hypercall_start[i] =3D insts[i];
> +        flush_icache_range((ulong)epapr_hypercall_start,
> +                           (ulong)epapr_hypercall_start + len);
> +
> +        epapr_para_enabled =3D true;
> +    }
> +
> +    return 0;
> +}
> +
> +early_initcall(epapr_para_init);
> diff --git a/arch/powerpc/kernel/kvm.c b/arch/powerpc/kernel/kvm.c
> index 62bdf23..9dfc24a 100644
> --- a/arch/powerpc/kernel/kvm.c
> +++ b/arch/powerpc/kernel/kvm.c
> @@ -31,6 +31,7 @@
> #include <asm/cacheflush.h>
> #include <asm/disassemble.h>
> #include <asm/ppc-opcode.h>
> +#include <asm/epapr_hcalls.h>
>=20
> #define KVM_MAGIC_PAGE        (-4096L)
> #define magic_var(x) KVM_MAGIC_PAGE + offsetof(struct kvm_vcpu_arch_shared=
, x)
> @@ -726,7 +727,7 @@ unsigned long kvm_hypercall(unsigned long *in,
>    unsigned long register r11 asm("r11") =3D nr;
>    unsigned long register r12 asm("r12");
>=20
> -    asm volatile("bl    kvm_hypercall_start"
> +    asm volatile("bl    epapr_hypercall_start"
>             : "=3Dr"(r0), "=3Dr"(r3), "=3Dr"(r4), "=3Dr"(r5), "=3Dr"(r6),
>               "=3Dr"(r7), "=3Dr"(r8), "=3Dr"(r9), "=3Dr"(r10), "=3Dr"(r11)=
,
>               "=3Dr"(r12)
> @@ -747,29 +748,6 @@ unsigned long kvm_hypercall(unsigned long *in,
> }
> EXPORT_SYMBOL_GPL(kvm_hypercall);
>=20
> -static int kvm_para_setup(void)
> -{
> -    extern u32 kvm_hypercall_start;
> -    struct device_node *hyper_node;
> -    u32 *insts;
> -    int len, i;
> -
> -    hyper_node =3D of_find_node_by_path("/hypervisor");
> -    if (!hyper_node)
> -        return -1;
> -
> -    insts =3D (u32*)of_get_property(hyper_node, "hcall-instructions", &le=
n);
> -    if (len % 4)
> -        return -1;
> -    if (len > (4 * 4))

As you can see, the previous code allowed for less than 4 instructions, but n=
ot more.

Alex

> -        return -1;
> -
> -    for (i =3D 0; i < (len / 4); i++)
> -        kvm_patch_ins(&(&kvm_hypercall_start)[i], insts[i]);
> -
> -    return 0;
> -}
> -
> static __init void kvm_free_tmp(void)
> {
>    unsigned long start, end;
> @@ -791,7 +769,7 @@ static int __init kvm_guest_init(void)
>    if (!kvm_para_available())
>        goto free_tmp;
>=20
> -    if (kvm_para_setup())
> +    if (!epapr_para_enabled)
>        goto free_tmp;
>=20
>    if (kvm_para_has_feature(KVM_FEATURE_MAGIC_PAGE))
> diff --git a/arch/powerpc/kernel/kvm_emul.S b/arch/powerpc/kernel/kvm_emul=
.S
> index e291cf3..62ceb2a 100644
> --- a/arch/powerpc/kernel/kvm_emul.S
> +++ b/arch/powerpc/kernel/kvm_emul.S
> @@ -24,16 +24,6 @@
> #include <asm/page.h>
> #include <asm/asm-offsets.h>
>=20
> -/* Hypercall entry point. Will be patched with device tree instructions. *=
/
> -
> -.global kvm_hypercall_start
> -kvm_hypercall_start:
> -    li    r3, -1
> -    nop
> -    nop
> -    nop
> -    blr
> -
> #define KVM_MAGIC_PAGE        (-4096)
>=20
> #ifdef CONFIG_64BIT
> diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
> index 8f64709..9bb9d18 100644
> --- a/arch/powerpc/kvm/Kconfig
> +++ b/arch/powerpc/kvm/Kconfig
> @@ -20,6 +20,7 @@ config KVM
>    bool
>    select PREEMPT_NOTIFIERS
>    select ANON_INODES
> +    select EPAPR_PARAVIRT
>=20
> config KVM_BOOK3S_HANDLER
>    bool
> --=20
> 1.7.0.4
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
