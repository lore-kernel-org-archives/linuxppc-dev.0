Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 112A22C00B8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 23:47:00 +1000 (EST)
Subject: Re: [PATCH V6] powerpc/85xx: Add machine check handler to fix PCIe
 erratum on mpc85xx
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1365669382-18534-1-git-send-email-hongtao.jia@freescale.com>
Date: Thu, 11 Apr 2013 08:46:55 -0500
Message-Id: <A11571AB-BF5B-4943-A4DB-62C33D814165@kernel.crashing.org>
References: <1365669382-18534-1-git-send-email-hongtao.jia@freescale.com>
To: Jia Hongtao <hongtao.jia@freescale.com>
Cc: B07421@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 11, 2013, at 3:36 AM, Jia Hongtao wrote:

> A PCIe erratum of mpc85xx may causes a core hang when a link of PCIe
> goes down. when the link goes down, Non-posted transactions issued
> via the ATMU requiring completion result in an instruction stall.
> At the same time a machine-check exception is generated to the core
> to allow further processing by the handler. We implements the handler
> which skips the instruction caused the stall.
>=20
> This patch depends on patch:
> powerpc/85xx: Add platform_device declaration to fsl_pci.h
>=20
> Signed-off-by: Zhao Chenhui <b35336@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> Signed-off-by: Liu Shuo <soniccat.liu@gmail.com>
> Signed-off-by: Jia Hongtao <hongtao.jia@freescale.com>
> ---
> V5:
> * Move OP and XOP defines to a new header file: asm/ppc-disassemble.h
> * Add X UX BRX variant of load instruction emulation
> * Remove A variant of load instruction emulation
>=20
> V4:
> * Fill rd with all-Fs if the skipped instruction is load and emulate =
the
>  instruction.
> * Let KVM/QEMU deal with the exception if the machine check comes from =
KVM.
>=20
> arch/powerpc/include/asm/ppc-disassemble.h |  31 +++++++
> arch/powerpc/kernel/cpu_setup_fsl_booke.S  |   2 +-
> arch/powerpc/kernel/traps.c                |   3 +
> arch/powerpc/sysdev/fsl_pci.c              | 140 =
+++++++++++++++++++++++++++++
> arch/powerpc/sysdev/fsl_pci.h              |   6 ++
> 5 files changed, 181 insertions(+), 1 deletion(-)
> create mode 100644 arch/powerpc/include/asm/ppc-disassemble.h
>=20
> diff --git a/arch/powerpc/include/asm/ppc-disassemble.h =
b/arch/powerpc/include/asm/ppc-disassemble.h
> new file mode 100644
> index 0000000..f9782b8
> --- /dev/null
> +++ b/arch/powerpc/include/asm/ppc-disassemble.h
> @@ -0,0 +1,31 @@
> +/*
> + * Copyright 2012-2013 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + *
> + * provides opcode and xopcode images for use by emulating
> + * instructions
> + */
> +#ifndef _ASM_POWERPC_PPC_DISASSEMBLE_H
> +#define _ASM_POWERPC_PPC_DISASSEMBLE_H
> +

This should really just be in asm/ppc-opcode.h

> +#define OP_LWZ  32
> +#define OP_LWZU 33
> +#define OP_LBZ  34
> +#define OP_LBZU 35
> +#define OP_LHZ  40
> +#define OP_LHZU 41
> +
> +#define OP_31_XOP_LWZX      23
> +#define OP_31_XOP_LWZUX     55
> +#define OP_31_XOP_LBZX      87
> +#define OP_31_XOP_LBZUX     119
> +#define OP_31_XOP_LHZX      279
> +#define OP_31_XOP_LHZUX     311
> +#define OP_31_XOP_LWBRX     534
> +#define OP_31_XOP_LHBRX     790
> +

Also, submit a patch to extract these from existing code so we stop =
duplicating them everywhere.

> +#endif
> diff --git a/arch/powerpc/kernel/cpu_setup_fsl_booke.S =
b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
> index dcd8819..f1bde90 100644
> --- a/arch/powerpc/kernel/cpu_setup_fsl_booke.S
> +++ b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
> @@ -66,7 +66,7 @@ _GLOBAL(__setup_cpu_e500v2)
> 	bl	__e500_icache_setup
> 	bl	__e500_dcache_setup
> 	bl	__setup_e500_ivors
> -#ifdef CONFIG_FSL_RIO
> +#if defined(CONFIG_FSL_RIO) || defined(CONFIG_FSL_PCI)
> 	/* Ensure that RFXE is set */
> 	mfspr	r3,SPRN_HID1
> 	oris	r3,r3,HID1_RFXE@h
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index a008cf5..dd275a4 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -59,6 +59,7 @@
> #include <asm/fadump.h>
> #include <asm/switch_to.h>
> #include <asm/debug.h>
> +#include <sysdev/fsl_pci.h>
>=20
> #if defined(CONFIG_DEBUGGER) || defined(CONFIG_KEXEC)
> int (*__debugger)(struct pt_regs *regs) __read_mostly;
> @@ -556,6 +557,8 @@ int machine_check_e500(struct pt_regs *regs)
> 	if (reason & MCSR_BUS_RBERR) {
> 		if (fsl_rio_mcheck_exception(regs))
> 			return 1;
> +		if (fsl_pci_mcheck_exception(regs))
> +			return 1;
> 	}
>=20
> 	printk("Machine check in kernel mode.\n");
> diff --git a/arch/powerpc/sysdev/fsl_pci.c =
b/arch/powerpc/sysdev/fsl_pci.c
> index 682084d..aaa54c5 100644
> --- a/arch/powerpc/sysdev/fsl_pci.c
> +++ b/arch/powerpc/sysdev/fsl_pci.c
> @@ -26,11 +26,15 @@
> #include <linux/memblock.h>
> #include <linux/log2.h>
> #include <linux/slab.h>
> +#include <linux/uaccess.h>
>=20
> #include <asm/io.h>
> #include <asm/prom.h>
> #include <asm/pci-bridge.h>
> +#include <asm/ppc-pci.h>

what are you pulling in from ppc-pci.h?

> #include <asm/machdep.h>
> +#include <asm/disassemble.h>
> +#include <asm/ppc-disassemble.h>
> #include <sysdev/fsl_soc.h>
> #include <sysdev/fsl_pci.h>
>=20
> @@ -826,6 +830,142 @@ u64 fsl_pci_immrbar_base(struct pci_controller =
*hose)
> 	return 0;
> }
>=20
> +#ifdef CONFIG_E500
> +static int mcheck_handle_load(struct pt_regs *regs, u32 inst)
> +{
> +	unsigned int rd, ra, rb, d;
> +
> +	rd =3D get_rt(inst);
> +	ra =3D get_ra(inst);
> +	rb =3D get_rb(inst);
> +	d =3D get_d(inst);
> +
> +	switch (get_op(inst)) {
> +	case 31:

What about 64-bit loads (LD...)?

> +		switch (get_xop(inst)) {
> +		case OP_31_XOP_LWZX:
> +		case OP_31_XOP_LWBRX:
> +			regs->gpr[rd] =3D 0xffffffff;
> +			break;
> +
> +		case OP_31_XOP_LWZUX:
> +			regs->gpr[rd] =3D 0xffffffff;
> +			regs->gpr[ra] +=3D regs->gpr[rb];
> +			break;
> +
> +		case OP_31_XOP_LBZX:
> +			regs->gpr[rd] =3D 0xff;
> +			break;
> +
> +		case OP_31_XOP_LBZUX:
> +			regs->gpr[rd] =3D 0xff;
> +			regs->gpr[ra] +=3D regs->gpr[rb];
> +			break;
> +
> +		case OP_31_XOP_LHZX:
> +		case OP_31_XOP_LHBRX:
> +			regs->gpr[rd] =3D 0xffff;
> +			break;
> +
> +		case OP_31_XOP_LHZUX:
> +			regs->gpr[rd] =3D 0xffff;
> +			regs->gpr[ra] +=3D regs->gpr[rb];
> +			break;
> +
> +		default:
> +			return 0;
> +		}
> +		break;
> +
> +	case OP_LWZ:
> +		regs->gpr[rd] =3D 0xffffffff;
> +		break;
> +
> +	case OP_LWZU:
> +		regs->gpr[rd] =3D 0xffffffff;
> +		regs->gpr[ra] +=3D (s16)d;
> +		break;
> +
> +	case OP_LBZ:
> +		regs->gpr[rd] =3D 0xff;
> +		break;
> +
> +	case OP_LBZU:
> +		regs->gpr[rd] =3D 0xff;
> +		regs->gpr[ra] +=3D (s16)d;
> +		break;
> +
> +	case OP_LHZ:
> +		regs->gpr[rd] =3D 0xffff;
> +		break;
> +
> +	case OP_LHZU:
> +		regs->gpr[rd] =3D 0xffff;
> +		regs->gpr[ra] +=3D (s16)d;
> +		break;
> +
> +	default:
> +		return 0;
> +	}
> +
> +	return 1;
> +}
> +
> +static int is_in_pci_mem_space(phys_addr_t addr)
> +{
> +	struct pci_controller *hose;
> +	struct resource *res;
> +	int i;
> +
> +	list_for_each_entry(hose, &hose_list, list_node) {
> +		if (!early_find_capability(hose, 0, 0, PCI_CAP_ID_EXP))
> +			continue;
> +
> +		for (i =3D 0; i < 3; i++) {
> +			res =3D &hose->mem_resources[i];
> +			if ((res->flags & IORESOURCE_MEM) &&
> +				addr >=3D res->start && addr <=3D =
res->end)
> +				return 1;
> +		}
> +	}
> +	return 0;
> +}
> +
> +int fsl_pci_mcheck_exception(struct pt_regs *regs)
> +{
> +	u32 inst;
> +	int ret;
> +	phys_addr_t addr =3D 0;
> +
> +	/* Let KVM/QEMU deal with the exception */
> +	if (regs->msr & MSR_GS)
> +		return 0;
> +
> +#ifdef CONFIG_PHYS_64BIT
> +	addr =3D mfspr(SPRN_MCARU);
> +	addr <<=3D 32;
> +#endif
> +	addr +=3D mfspr(SPRN_MCAR);
> +
> +	if (is_in_pci_mem_space(addr)) {
> +		if (user_mode(regs)) {
> +			pagefault_disable();
> +			ret =3D get_user(regs->nip, &inst);
> +			pagefault_enable();
> +		} else {
> +			ret =3D probe_kernel_address(regs->nip, inst);
> +		}
> +
> +		if (mcheck_handle_load(regs, inst)) {
> +			regs->nip +=3D 4;
> +			return 1;
> +		}
> +	}
> +
> +	return 0;
> +}
> +#endif
> +
> #if defined(CONFIG_FSL_SOC_BOOKE) || defined(CONFIG_PPC_86xx)
> static const struct of_device_id pci_ids[] =3D {
> 	{ .compatible =3D "fsl,mpc8540-pci", },
> diff --git a/arch/powerpc/sysdev/fsl_pci.h =
b/arch/powerpc/sysdev/fsl_pci.h
> index 851dd56..b0d01ea 100644
> --- a/arch/powerpc/sysdev/fsl_pci.h
> +++ b/arch/powerpc/sysdev/fsl_pci.h
> @@ -115,5 +115,11 @@ static inline int mpc85xx_pci_err_probe(struct =
platform_device *op)
> }
> #endif
>=20
> +#ifdef CONFIG_FSL_PCI
> +extern int fsl_pci_mcheck_exception(struct pt_regs *);
> +#else
> +static inline int fsl_pci_mcheck_exception(struct pt_regs *regs) =
{return 0; }
> +#endif
> +
> #endif /* __POWERPC_FSL_PCI_H */
> #endif /* __KERNEL__ */
> --=20
> 1.8.0
>=20
