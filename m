Return-Path: <B38951@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0188.outbound.messaging.microsoft.com [213.199.154.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9961B2C009F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2013 13:05:28 +1000 (EST)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>, Wood Scott-B07421
 <B07421@freescale.com>
Subject: RE: [PATCH V6] powerpc/85xx: Add machine check handler to fix PCIe
 erratum on mpc85xx
Date: Fri, 12 Apr 2013 03:05:16 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5D01C3A4C4@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1365669382-18534-1-git-send-email-hongtao.jia@freescale.com>
 <A11571AB-BF5B-4943-A4DB-62C33D814165@kernel.crashing.org>
In-Reply-To: <A11571AB-BF5B-4943-A4DB-62C33D814165@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Thursday, April 11, 2013 9:47 PM
> To: Jia Hongtao-B38951
> Cc: linuxppc-dev@lists.ozlabs.org; Wood Scott-B07421; Li Yang-R58472
> Subject: Re: [PATCH V6] powerpc/85xx: Add machine check handler to fix
> PCIe erratum on mpc85xx
>=20
>=20
> On Apr 11, 2013, at 3:36 AM, Jia Hongtao wrote:
>=20
> > A PCIe erratum of mpc85xx may causes a core hang when a link of PCIe
> > goes down. when the link goes down, Non-posted transactions issued via
> > the ATMU requiring completion result in an instruction stall.
> > At the same time a machine-check exception is generated to the core to
> > allow further processing by the handler. We implements the handler
> > which skips the instruction caused the stall.
> >
> > This patch depends on patch:
> > powerpc/85xx: Add platform_device declaration to fsl_pci.h
> >
> > Signed-off-by: Zhao Chenhui <b35336@freescale.com>
> > Signed-off-by: Li Yang <leoli@freescale.com>
> > Signed-off-by: Liu Shuo <soniccat.liu@gmail.com>
> > Signed-off-by: Jia Hongtao <hongtao.jia@freescale.com>
> > ---
> > V5:
> > * Move OP and XOP defines to a new header file: asm/ppc-disassemble.h
> > * Add X UX BRX variant of load instruction emulation
> > * Remove A variant of load instruction emulation
> >
> > V4:
> > * Fill rd with all-Fs if the skipped instruction is load and emulate
> > the  instruction.
> > * Let KVM/QEMU deal with the exception if the machine check comes from
> KVM.
> >
> > arch/powerpc/include/asm/ppc-disassemble.h |  31 +++++++
> > arch/powerpc/kernel/cpu_setup_fsl_booke.S  |   2 +-
> > arch/powerpc/kernel/traps.c                |   3 +
> > arch/powerpc/sysdev/fsl_pci.c              | 140
> +++++++++++++++++++++++++++++
> > arch/powerpc/sysdev/fsl_pci.h              |   6 ++
> > 5 files changed, 181 insertions(+), 1 deletion(-) create mode 100644
> > arch/powerpc/include/asm/ppc-disassemble.h
> >
> > diff --git a/arch/powerpc/include/asm/ppc-disassemble.h
> > b/arch/powerpc/include/asm/ppc-disassemble.h
> > new file mode 100644
> > index 0000000..f9782b8
> > --- /dev/null
> > +++ b/arch/powerpc/include/asm/ppc-disassemble.h
> > @@ -0,0 +1,31 @@
> > +/*
> > + * Copyright 2012-2013 Freescale Semiconductor, Inc.
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License
> > + * as published by the Free Software Foundation; either version
> > + * 2 of the License, or (at your option) any later version.
> > + *
> > + * provides opcode and xopcode images for use by emulating
> > + * instructions
> > + */
> > +#ifndef _ASM_POWERPC_PPC_DISASSEMBLE_H #define
> > +_ASM_POWERPC_PPC_DISASSEMBLE_H
> > +
>=20
> This should really just be in asm/ppc-opcode.h

Hi Kumar and Scott,

This is the different method of describing instructions so I put them
in a new file.

But I agree that a patch to extract these from existing code is more
well-organized.

Is that OK if I extract these definitions from arch/powerpc/kvm/emulate.c
to asm/ppc-opcode.h? Even though These definitions are different.

Scott,
What's your opinion on this?

>=20
> > +#define OP_LWZ  32
> > +#define OP_LWZU 33
> > +#define OP_LBZ  34
> > +#define OP_LBZU 35
> > +#define OP_LHZ  40
> > +#define OP_LHZU 41
> > +
> > +#define OP_31_XOP_LWZX      23
> > +#define OP_31_XOP_LWZUX     55
> > +#define OP_31_XOP_LBZX      87
> > +#define OP_31_XOP_LBZUX     119
> > +#define OP_31_XOP_LHZX      279
> > +#define OP_31_XOP_LHZUX     311
> > +#define OP_31_XOP_LWBRX     534
> > +#define OP_31_XOP_LHBRX     790
> > +
>=20
> Also, submit a patch to extract these from existing code so we stop
> duplicating them everywhere.
>=20
> > +#endif
> > diff --git a/arch/powerpc/kernel/cpu_setup_fsl_booke.S
> > b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
> > index dcd8819..f1bde90 100644
> > --- a/arch/powerpc/kernel/cpu_setup_fsl_booke.S
> > +++ b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
> > @@ -66,7 +66,7 @@ _GLOBAL(__setup_cpu_e500v2)
> > 	bl	__e500_icache_setup
> > 	bl	__e500_dcache_setup
> > 	bl	__setup_e500_ivors
> > -#ifdef CONFIG_FSL_RIO
> > +#if defined(CONFIG_FSL_RIO) || defined(CONFIG_FSL_PCI)
> > 	/* Ensure that RFXE is set */
> > 	mfspr	r3,SPRN_HID1
> > 	oris	r3,r3,HID1_RFXE@h
> > diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> > index a008cf5..dd275a4 100644
> > --- a/arch/powerpc/kernel/traps.c
> > +++ b/arch/powerpc/kernel/traps.c
> > @@ -59,6 +59,7 @@
> > #include <asm/fadump.h>
> > #include <asm/switch_to.h>
> > #include <asm/debug.h>
> > +#include <sysdev/fsl_pci.h>
> >
> > #if defined(CONFIG_DEBUGGER) || defined(CONFIG_KEXEC) int
> > (*__debugger)(struct pt_regs *regs) __read_mostly; @@ -556,6 +557,8 @@
> > int machine_check_e500(struct pt_regs *regs)
> > 	if (reason & MCSR_BUS_RBERR) {
> > 		if (fsl_rio_mcheck_exception(regs))
> > 			return 1;
> > +		if (fsl_pci_mcheck_exception(regs))
> > +			return 1;
> > 	}
> >
> > 	printk("Machine check in kernel mode.\n"); diff --git
> > a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c index
> > 682084d..aaa54c5 100644
> > --- a/arch/powerpc/sysdev/fsl_pci.c
> > +++ b/arch/powerpc/sysdev/fsl_pci.c
> > @@ -26,11 +26,15 @@
> > #include <linux/memblock.h>
> > #include <linux/log2.h>
> > #include <linux/slab.h>
> > +#include <linux/uaccess.h>
> >
> > #include <asm/io.h>
> > #include <asm/prom.h>
> > #include <asm/pci-bridge.h>
> > +#include <asm/ppc-pci.h>
>=20
> what are you pulling in from ppc-pci.h?

is_in_pci_mem_space() uses list_for_each_entry(hose, &hose_list, list_node)=
.
host_list defined in asm/ppc-pci.h.

>=20
> > #include <asm/machdep.h>
> > +#include <asm/disassemble.h>
> > +#include <asm/ppc-disassemble.h>
> > #include <sysdev/fsl_soc.h>
> > #include <sysdev/fsl_pci.h>
> >
> > @@ -826,6 +830,142 @@ u64 fsl_pci_immrbar_base(struct pci_controller
> *hose)
> > 	return 0;
> > }
> >
> > +#ifdef CONFIG_E500
> > +static int mcheck_handle_load(struct pt_regs *regs, u32 inst) {
> > +	unsigned int rd, ra, rb, d;
> > +
> > +	rd =3D get_rt(inst);
> > +	ra =3D get_ra(inst);
> > +	rb =3D get_rb(inst);
> > +	d =3D get_d(inst);
> > +
> > +	switch (get_op(inst)) {
> > +	case 31:
>=20
> What about 64-bit loads (LD...)?

This erratum only happened in E500 core chips in which there is no
64-bit loads.

- Hongtao
