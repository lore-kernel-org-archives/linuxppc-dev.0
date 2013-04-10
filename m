Return-Path: <B38951@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0FF592C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2013 12:27:45 +1000 (EST)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH V5] powerpc/85xx: Add machine check handler to fix PCIe
 erratum on mpc85xx
Date: Wed, 10 Apr 2013 02:27:32 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5D01C35532@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1365409614-2634-1-git-send-email-hongtao.jia@freescale.com>
In-Reply-To: <1365409614-2634-1-git-send-email-hongtao.jia@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Jia Hongtao-B38951 <B38951@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Scott,

I added load instruction handler for the skipped instruction.
For now most common load instructions are handled in this patch.

Any advice for this?

Thanks.
-Hongtao.

> -----Original Message-----
> From: Jia Hongtao-B38951
> Sent: Monday, April 08, 2013 4:27 PM
> To: linuxppc-dev@lists.ozlabs.org; galak@kernel.crashing.org
> Cc: Wood Scott-B07421; Li Yang-R58472; Jia Hongtao-B38951
> Subject: [PATCH V5] powerpc/85xx: Add machine check handler to fix PCIe
> erratum on mpc85xx
>=20
> A PCIe erratum of mpc85xx may causes a core hang when a link of PCIe goes
> down. when the link goes down, Non-posted transactions issued via the
> ATMU requiring completion result in an instruction stall.
> At the same time a machine-check exception is generated to the core to
> allow further processing by the handler. We implements the handler which
> skips the instruction caused the stall.
>=20
> This patch depends on patch:
> powerpc/85xx: Add platform_device declaration to fsl_pci.h
>=20
> Signed-off-by: Zhao Chenhui <b35336@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> Signed-off-by: Liu Shuo <soniccat.liu@gmail.com>
> Signed-off-by: Jia Hongtao <hongtao.jia@freescale.com>
> ---
> Changes for V4:
> * Fill rd with all-Fs if the skipped instruction is load and emulate the
>   instruction.
> * Let KVM/QEMU deal with the exception if the machine check comes from
> KVM.
>=20
>  arch/powerpc/kernel/cpu_setup_fsl_booke.S |   2 +-
>  arch/powerpc/kernel/traps.c               |   3 +
>  arch/powerpc/sysdev/fsl_pci.c             | 121
> ++++++++++++++++++++++++++++++
>  arch/powerpc/sysdev/fsl_pci.h             |   6 ++
>  4 files changed, 131 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/kernel/cpu_setup_fsl_booke.S
> b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
> index dcd8819..f1bde90 100644
> --- a/arch/powerpc/kernel/cpu_setup_fsl_booke.S
> +++ b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
> @@ -66,7 +66,7 @@ _GLOBAL(__setup_cpu_e500v2)
>  	bl	__e500_icache_setup
>  	bl	__e500_dcache_setup
>  	bl	__setup_e500_ivors
> -#ifdef CONFIG_FSL_RIO
> +#if defined(CONFIG_FSL_RIO) || defined(CONFIG_FSL_PCI)
>  	/* Ensure that RFXE is set */
>  	mfspr	r3,SPRN_HID1
>  	oris	r3,r3,HID1_RFXE@h
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index a008cf5..dd275a4 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -59,6 +59,7 @@
>  #include <asm/fadump.h>
>  #include <asm/switch_to.h>
>  #include <asm/debug.h>
> +#include <sysdev/fsl_pci.h>
>=20
>  #if defined(CONFIG_DEBUGGER) || defined(CONFIG_KEXEC)  int
> (*__debugger)(struct pt_regs *regs) __read_mostly; @@ -556,6 +557,8 @@
> int machine_check_e500(struct pt_regs *regs)
>  	if (reason & MCSR_BUS_RBERR) {
>  		if (fsl_rio_mcheck_exception(regs))
>  			return 1;
> +		if (fsl_pci_mcheck_exception(regs))
> +			return 1;
>  	}
>=20
>  	printk("Machine check in kernel mode.\n"); diff --git
> a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c index
> 682084d..48326cd 100644
> --- a/arch/powerpc/sysdev/fsl_pci.c
> +++ b/arch/powerpc/sysdev/fsl_pci.c
> @@ -26,11 +26,14 @@
>  #include <linux/memblock.h>
>  #include <linux/log2.h>
>  #include <linux/slab.h>
> +#include <linux/uaccess.h>
>=20
>  #include <asm/io.h>
>  #include <asm/prom.h>
>  #include <asm/pci-bridge.h>
> +#include <asm/ppc-pci.h>
>  #include <asm/machdep.h>
> +#include <asm/disassemble.h>
>  #include <sysdev/fsl_soc.h>
>  #include <sysdev/fsl_pci.h>
>=20
> @@ -826,6 +829,124 @@ u64 fsl_pci_immrbar_base(struct pci_controller
> *hose)
>  	return 0;
>  }
>=20
> +#ifdef CONFIG_E500
> +
> +#define OP_LWZ  32
> +#define OP_LWZU 33
> +#define OP_LBZ  34
> +#define OP_LBZU 35
> +#define OP_LHZ  40
> +#define OP_LHZU 41
> +#define OP_LHA  42
> +#define OP_LHAU 43
> +
> +static int mcheck_handle_load(struct pt_regs *regs, u32 inst) {
> +	unsigned int rd, ra, d;
> +
> +	rd =3D get_rt(inst);
> +	ra =3D get_ra(inst);
> +	d =3D get_d(inst);
> +
> +	switch (get_op(inst)) {
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
> +	case OP_LHA:
> +		regs->gpr[rd] =3D 0xffff;
> +		break;
> +
> +	case OP_LHAU:
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
> +static int is_in_pci_mem_space(phys_addr_t addr) {
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
> +				addr >=3D res->start && addr <=3D res->end)
> +				return 1;
> +		}
> +	}
> +	return 0;
> +}
> +
> +int fsl_pci_mcheck_exception(struct pt_regs *regs) {
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
>  #if defined(CONFIG_FSL_SOC_BOOKE) || defined(CONFIG_PPC_86xx)  static
> const struct of_device_id pci_ids[] =3D {
>  	{ .compatible =3D "fsl,mpc8540-pci", },
> diff --git a/arch/powerpc/sysdev/fsl_pci.h
> b/arch/powerpc/sysdev/fsl_pci.h index 851dd56..b0d01ea 100644
> --- a/arch/powerpc/sysdev/fsl_pci.h
> +++ b/arch/powerpc/sysdev/fsl_pci.h
> @@ -115,5 +115,11 @@ static inline int mpc85xx_pci_err_probe(struct
> platform_device *op)  }  #endif
>=20
> +#ifdef CONFIG_FSL_PCI
> +extern int fsl_pci_mcheck_exception(struct pt_regs *); #else static
> +inline int fsl_pci_mcheck_exception(struct pt_regs *regs) {return 0; }
> +#endif
> +
>  #endif /* __POWERPC_FSL_PCI_H */
>  #endif /* __KERNEL__ */
> --
> 1.8.0
