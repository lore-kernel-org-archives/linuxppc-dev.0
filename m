Return-Path: <galak@kernel.crashing.org>
Subject: Re: [RFC:PATCH 01/03] powerpc: Extended ptrace interface
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20091210155715.6697.92627.sendpatchset@norville.austin.ibm.com>
Date: Thu, 10 Dec 2009 20:51:02 -0600
Message-Id: <030D6CF9-8E28-4B91-A515-10A0D4A4FE5E@kernel.crashing.org>
References: <20091210155709.6697.4635.sendpatchset@norville.austin.ibm.com>
	<20091210155715.6697.92627.sendpatchset@norville.austin.ibm.com>
To: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>,
	Sergio Durigan Junior <sergiodj@br.ibm.com>,
	Torez Smith <torez@us.ibm.com>,
	Thiago Jung Bauermann <bauerman@br.ibm.com>, David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Dec 10, 2009, at 9:57 AM, Dave Kleikamp wrote:

> powerpc: Extended ptrace interface
>=20
> From: Torez Smith <lnxtorez@linux.vnet.ibm.com>
>=20
> Add a new extended ptrace interface so that user-space has a single
> interface for powerpc, without having to know the specific layout
> of the debug registers.
>=20
> Implement:
> PPC_PTRACE_GETHWDEBUGINFO
> PPC_PTRACE_SETHWDEBUG
> PPC_PTRACE_DELHWDEBUG
>=20
> Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
> Signed-off-by: Torez Smith  <lnxtorez@linux.vnet.ibm.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Thiago Jung Bauermann <bauerman@br.ibm.com>
> Cc: Sergio Durigan Junior <sergiodj@br.ibm.com>
> Cc: David Gibson <dwg@au1.ibm.com>
> Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>
> ---
>=20
> arch/powerpc/include/asm/ptrace.h |   75 =
++++++++++++++++++++++++++++++++
> arch/powerpc/kernel/ptrace.c      |   88 =
+++++++++++++++++++++++++++++++++++++
> 2 files changed, 163 insertions(+), 0 deletions(-)
>=20
>=20
> diff --git a/arch/powerpc/include/asm/ptrace.h =
b/arch/powerpc/include/asm/ptrace.h
> index 8c34149..7ae887b 100644
> --- a/arch/powerpc/include/asm/ptrace.h
> +++ b/arch/powerpc/include/asm/ptrace.h
> @@ -24,6 +24,12 @@
>  * 2 of the License, or (at your option) any later version.
>  */
>=20
> +#ifdef __KERNEL__
> +#include <linux/types.h>
> +#else
> +#include <stdint.h>
> +#endif
> +
> #ifndef __ASSEMBLY__
>=20
> struct pt_regs {
> @@ -292,4 +298,73 @@ extern void user_disable_single_step(struct =
task_struct *);
>=20
> #define PTRACE_SINGLEBLOCK	0x100	/* resume execution until next =
branch */
>=20
> +#define PPC_PTRACE_GETHWDBGINFO	0x89
> +#define PPC_PTRACE_SETHWDEBUG	0x88
> +#define PPC_PTRACE_DELHWDEBUG	0x87
> +
> +#ifndef __ASSEMBLY__
> +
> +struct ppc_debug_info {
> +	uint32_t version;		/* Only version 1 exists to date =
*/
> +	uint32_t num_instruction_bps;
> +	uint32_t num_data_bps;
> +	uint32_t num_condition_regs;
> +	uint32_t data_bp_alignment;
> +	uint32_t sizeof_condition;	/* size of the DVC register */
> +	uint64_t features;
> +};
> +
> +#endif /* __ASSEMBLY__ */
> +
> +/*
> + * features will have bits indication whether there is support for:
> + */
> +#define PPC_DEBUG_FEATURE_INSN_BP_RANGE		0x1
> +#define PPC_DEBUG_FEATURE_INSN_BP_MASK		0x2
> +#define PPC_DEBUG_FEATURE_DATA_BP_RANGE		0x4
> +#define PPC_DEBUG_FEATURE_DATA_BP_MASK		0x8

Pad these out.

#define PPC_DEBUG_FEATURE_INSN_BP_RANGE		0x0000000000000001
#define PPC_DEBUG_FEATURE_INSN_BP_MASK		0x0000000000000002

etc..


> +
> +#ifndef __ASSEMBLY__
> +
> +struct ppc_hw_breakpoint {
> +	uint32_t version;		/* currently, version must be 1 =
*/
> +	uint32_t trigger_type;		/* only some combinations =
allowed */
> +	uint32_t addr_mode;		/* address match mode */
> +	uint32_t condition_mode;	/* break/watchpoint condition =
flags */
> +	uint64_t addr;			/* break/watchpoint address */
> +	uint64_t addr2;			/* range end or mask */
> +	uint64_t condition_value;	/* contents of the DVC register =
*/
> +};
> +
> +#endif /* __ASSEMBLY__ */
> +
> +/*
> + * Trigger Type
> + */
> +#define PPC_BREAKPOINT_TRIGGER_EXECUTE	0x1
> +#define PPC_BREAKPOINT_TRIGGER_READ	0x2
> +#define PPC_BREAKPOINT_TRIGGER_WRITE	0x4
> +#define PPC_BREAKPOINT_TRIGGER_RW	0x6

(ditto on the padding)

> +
> +/*
> + * Address Mode
> + */
> +#define PPC_BREAKPOINT_MODE_EXACT		0x0
> +#define PPC_BREAKPOINT_MODE_RANGE_INCLUSIVE	0x1
> +#define PPC_BREAKPOINT_MODE_RANGE_EXCLUSIVE	0x2
> +#define PPC_BREAKPOINT_MODE_MASK		0x3
> +

(ditto on the padding)

> +/*
> + * Condition Mode
> + */
> +#define PPC_BREAKPOINT_CONDITION_NONE	0x0
> +#define PPC_BREAKPOINT_CONDITION_AND	0x1
> +#define PPC_BREAKPOINT_CONDITION_EXACT	0x1
> +#define PPC_BREAKPOINT_CONDITION_OR	0x2
> +#define PPC_BREAKPOINT_CONDITION_AND_OR	0x3

(ditto on the padding)

> +#define PPC_BREAKPOINT_CONDITION_BE_ALL	0x00ff0000
> +#define PPC_BREAKPOINT_CONDITION_BE_SHIFT	16
> +#define PPC_BREAKPOINT_CONDITION_BE(n)	\
> +	(1<<((n)+PPC_BREAKPOINT_CONDITION_BE_SHIFT))
> +
> #endif /* _ASM_POWERPC_PTRACE_H */
> diff --git a/arch/powerpc/kernel/ptrace.c =
b/arch/powerpc/kernel/ptrace.c
> index ef14988..6be2ce0 100644
> --- a/arch/powerpc/kernel/ptrace.c
> +++ b/arch/powerpc/kernel/ptrace.c
> @@ -839,6 +839,50 @@ void ptrace_disable(struct task_struct *child)
> 	user_disable_single_step(child);
> }
>=20
> +static long ppc_set_hwdebug(struct task_struct *child,
> +		     struct ppc_hw_breakpoint *bp_info)
> +{
> +	/*
> +	 * We currently support one data breakpoint
> +	 */
> +	if (((bp_info->trigger_type & PPC_BREAKPOINT_TRIGGER_RW) =3D=3D =
0) ||
> +	    ((bp_info->trigger_type & ~PPC_BREAKPOINT_TRIGGER_RW) !=3D =
0) ||
> +	    (bp_info->trigger_type !=3D PPC_BREAKPOINT_TRIGGER_WRITE) ||
> +	    (bp_info->addr_mode !=3D PPC_BREAKPOINT_MODE_EXACT) ||
> +	    (bp_info->condition_mode !=3D =
PPC_BREAKPOINT_CONDITION_NONE))
> +		return -EINVAL;
> +
> +	if (child->thread.dabr)
> +		return -ENOSPC;
> +
> +	if ((unsigned long)bp_info->addr >=3D TASK_SIZE)
> +		return -EIO;
> +
> +	child->thread.dabr =3D (unsigned long)bp_info->addr;
> +#ifdef CONFIG_BOOKE
> +	child->thread.dbcr0 =3D DBCR0_IDM;
> +	if (bp_info->trigger_type & PPC_BREAKPOINT_TRIGGER_READ)
> +		child->thread.dbcr0 |=3D DBSR_DAC1R;
> +	if (bp_info->trigger_type & PPC_BREAKPOINT_TRIGGER_WRITE)
> +		child->thread.dbcr0 |=3D DBSR_DAC1W;
> +	child->thread.regs->msr |=3D MSR_DE;
> +#endif
> +	return 1;
> +}
> +
> +static long ppc_del_hwdebug(struct task_struct *child, long addr, =
long data)
> +{
> +	if ((data !=3D 1) || (child->thread.dabr =3D=3D 0))
> +		return -EINVAL;
> +
> +	child->thread.dabr =3D 0;
> +#ifdef CONFIG_BOOKE
> +	child->thread.dbcr0 &=3D ~(DBSR_DAC1R | DBSR_DAC1W | DBCR0_IDM);
> +	child->thread.regs->msr &=3D ~MSR_DE;
> +#endif
> +	return 0;
> +}
> +
> /*
>  * Here are the old "legacy" powerpc specific getregs/setregs ptrace =
calls,
>  * we mark them as obsolete now, they will be removed in a future =
version
> @@ -932,6 +976,50 @@ long arch_ptrace(struct task_struct *child, long =
request, long addr, long data)
> 		break;
> 	}
>=20
> +	case PPC_PTRACE_GETHWDBGINFO: {
> +		struct ppc_debug_info dbginfo;
> +
> +		dbginfo.version =3D 1;
> +		dbginfo.num_instruction_bps =3D 0;
> +		dbginfo.num_data_bps =3D 1;
> +		dbginfo.num_condition_regs =3D 0;
> +#ifdef CONFIG_PPC64
> +		dbginfo.data_bp_alignment =3D 8;
> +#else
> +		dbginfo.data_bp_alignment =3D 0;
> +#endif
> +		dbginfo.sizeof_condition =3D 0;
> +		dbginfo.features =3D 0;
> +
> +		if (!access_ok(VERIFY_WRITE, data,
> +			       sizeof(struct ppc_debug_info)))
> +			return -EFAULT;
> +		ret =3D __copy_to_user((struct ppc_debug_info __user =
*)data,
> +				     &dbginfo, sizeof(struct =
ppc_debug_info)) ?
> +		      -EFAULT : 0;
> +		break;
> +	}
> +
> +	case PPC_PTRACE_SETHWDEBUG: {
> +		struct ppc_hw_breakpoint bp_info;
> +
> +		if (!access_ok(VERIFY_READ, data,
> +			       sizeof(struct ppc_hw_breakpoint)))
> +			return -EFAULT;
> +		ret =3D __copy_from_user(&bp_info,
> +				       (struct ppc_hw_breakpoint __user =
*)data,
> +				       sizeof(struct ppc_hw_breakpoint)) =
?
> +		      -EFAULT : 0;
> +		if (!ret)
> +			ret =3D ppc_set_hwdebug(child, &bp_info);
> +		break;
> +	}
> +
> +	case PPC_PTRACE_DELHWDEBUG: {
> +		ret =3D ppc_del_hwdebug(child, addr, data);
> +		break;
> +	}
> +
> 	case PTRACE_GET_DEBUGREG: {
> 		ret =3D -EINVAL;
> 		/* We only support one DABR and no IABRS at the moment =
*/
>=20
> --=20
> Dave Kleikamp
> IBM Linux Technology Center
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
