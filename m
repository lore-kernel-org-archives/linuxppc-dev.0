Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id A559AB6FA5
 for <linuxppc-dev@ozlabs.org>; Tue, 10 Jan 2012 00:50:20 +1100 (EST)
Subject: Re: [PATCH 1/3] KVM: PPC: epapr: Factor out the epapr init
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1325754412-29963-1-git-send-email-yu.liu@freescale.com>
Date: Mon, 9 Jan 2012 14:50:12 +0100
Message-Id: <83E67B5B-C09A-4EB6-9DD6-79B3D20FC59F@suse.de>
References: <1325754412-29963-1-git-send-email-yu.liu@freescale.com>
To: Liu Yu <yu.liu@freescale.com>
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@ozlabs.org,
 scottwood@freescale.com, timur@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 05.01.2012, at 10:06, Liu Yu wrote:

> from the kvm guest paravirt init code.

Your patch description could be slightly more ... verbose :)

>=20
> Signed-off-by: Liu Yu <yu.liu@freescale.com>
> ---
> arch/powerpc/include/asm/epapr_hcalls.h |    8 +++++
> arch/powerpc/kernel/Makefile            |    1 +
> arch/powerpc/kernel/epapr_para.c        |   45 =
+++++++++++++++++++++++++++++++
> arch/powerpc/kernel/kvm.c               |    9 +++++-
> 4 files changed, 62 insertions(+), 1 deletions(-)
> create mode 100644 arch/powerpc/kernel/epapr_para.c
>=20
> diff --git a/arch/powerpc/include/asm/epapr_hcalls.h =
b/arch/powerpc/include/asm/epapr_hcalls.h
> index f3b0c2c..c4b86e4 100644
> --- a/arch/powerpc/include/asm/epapr_hcalls.h
> +++ b/arch/powerpc/include/asm/epapr_hcalls.h
> @@ -148,6 +148,14 @@
> #define EV_HCALL_CLOBBERS2 EV_HCALL_CLOBBERS3, "r5"
> #define EV_HCALL_CLOBBERS1 EV_HCALL_CLOBBERS2, "r4"
>=20
> +extern u32 *epapr_hcall_insts;
> +extern int epapr_hcall_insts_len;
> +
> +static inline void epapr_get_hcall_insts(u32 **instp, int *lenp)
> +{
> +	*instp =3D epapr_hcall_insts;
> +	*lenp =3D epapr_hcall_insts_len;

Why do we need this? Can't we just directly access the variables?

> +}
>=20
> /*
>  * We use "uintptr_t" to define a register because it's guaranteed to =
be a
> diff --git a/arch/powerpc/kernel/Makefile =
b/arch/powerpc/kernel/Makefile
> index ce4f7f1..1052bbc 100644
> --- a/arch/powerpc/kernel/Makefile
> +++ b/arch/powerpc/kernel/Makefile
> @@ -134,6 +134,7 @@ ifneq ($(CONFIG_XMON)$(CONFIG_KEXEC),)
> obj-y				+=3D ppc_save_regs.o
> endif
>=20
> +obj-$(CONFIG_BOOKE)		+=3D epapr_para.o
> obj-$(CONFIG_KVM_GUEST)		+=3D kvm.o kvm_emul.o
>=20
> # Disable GCOV in odd or sensitive code
> diff --git a/arch/powerpc/kernel/epapr_para.c =
b/arch/powerpc/kernel/epapr_para.c
> new file mode 100644
> index 0000000..714dcb3
> --- /dev/null
> +++ b/arch/powerpc/kernel/epapr_para.c
> @@ -0,0 +1,45 @@
> +/*
> + * ePAPR para-virtualization support.
> + *
> + * This program is free software; you can redistribute it and/or =
modify
> + * it under the terms of the GNU General Public License, version 2, =
as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  =
02110-1301, USA.
> + *
> + * Copyright (C) 2012 Freescale Semiconductor, Inc.
> + */
> +
> +#include <linux/of.h>
> +#include <asm/epapr_hcalls.h>
> +
> +u32 *epapr_hcall_insts;
> +int epapr_hcall_insts_len;
> +
> +static int __init epapr_para_init(void)
> +{
> +	struct device_node *hyper_node;
> +	u32 *insts;
> +	int len;
> +
> +	hyper_node =3D of_find_node_by_path("/hypervisor");
> +	if (!hyper_node)
> +		return -ENODEV;
> +
> +	insts =3D (u32*)of_get_property(hyper_node, =
"hcall-instructions", &len);
> +	if (!(len % 4) && (len >=3D (4 * 4))) {
> +		epapr_hcall_insts =3D insts;
> +		epapr_hcall_insts_len =3D len;
> +	}

else error()?

> +
> +	return 0;
> +}
> +
> +early_initcall(epapr_para_init);
> diff --git a/arch/powerpc/kernel/kvm.c b/arch/powerpc/kernel/kvm.c
> index b06bdae..82a9137 100644
> --- a/arch/powerpc/kernel/kvm.c
> +++ b/arch/powerpc/kernel/kvm.c
> @@ -28,6 +28,7 @@
> #include <asm/sections.h>
> #include <asm/cacheflush.h>
> #include <asm/disassemble.h>
> +#include <asm/epapr_hcalls.h>
>=20
> #define KVM_MAGIC_PAGE		(-4096L)
> #define magic_var(x) KVM_MAGIC_PAGE + offsetof(struct =
kvm_vcpu_arch_shared, x)
> @@ -535,9 +536,10 @@ EXPORT_SYMBOL_GPL(kvm_hypercall);
> static int kvm_para_setup(void)
> {
> 	extern u32 kvm_hypercall_start;
> -	struct device_node *hyper_node;
> 	u32 *insts;
> 	int len, i;
> +#ifndef CONFIG_BOOKE

Ugh - now you're duplicating even more code. Why not completely unify it =
and always call epapr_get_hcall_insts() on all ppc platforms?


> +	struct device_node *hyper_node;
>=20
> 	hyper_node =3D of_find_node_by_path("/hypervisor");
> 	if (!hyper_node)
> @@ -548,6 +550,11 @@ static int kvm_para_setup(void)
> 		return -1;
> 	if (len > (4 * 4))
> 		return -1;
> +#else
> +	epapr_get_hcall_insts(&insts, &len);
> +	if (insts =3D=3D NULL)
> +		return -1;
> +#endif	/* !BOOKE */
>=20
> 	for (i =3D 0; i < (len / 4); i++)
> 		kvm_patch_ins(&(&kvm_hypercall_start)[i], insts[i]);
> --=20
> 1.6.4
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe kvm-ppc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
