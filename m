Return-Path: <shaggy@linux.vnet.ibm.com>
Date: Thu, 10 Dec 2009 13:57:15 -0200
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: linuxppc-dev list <Linuxppc-dev@ozlabs.org>
Message-Id: <20091210155715.6697.92627.sendpatchset@norville.austin.ibm.com>
In-Reply-To: <20091210155709.6697.4635.sendpatchset@norville.austin.ibm.com>
References: <20091210155709.6697.4635.sendpatchset@norville.austin.ibm.com>
Subject: [RFC:PATCH 01/03] powerpc: Extended ptrace interface
Cc: Sergio Durigan Junior <sergiodj@br.ibm.com>,
	Thiago Jung Bauermann <bauerman@br.ibm.com>,
	Torez Smith <torez@us.ibm.com>, David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

powerpc: Extended ptrace interface

From: Torez Smith <lnxtorez@linux.vnet.ibm.com>

Add a new extended ptrace interface so that user-space has a single
interface for powerpc, without having to know the specific layout
of the debug registers.

Implement:
PPC_PTRACE_GETHWDEBUGINFO
PPC_PTRACE_SETHWDEBUG
PPC_PTRACE_DELHWDEBUG

Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Signed-off-by: Torez Smith  <lnxtorez@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Thiago Jung Bauermann <bauerman@br.ibm.com>
Cc: Sergio Durigan Junior <sergiodj@br.ibm.com>
Cc: David Gibson <dwg@au1.ibm.com>
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>
---

 arch/powerpc/include/asm/ptrace.h |   75 ++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/ptrace.c      |   88 +++++++++++++++++++++++++++++++++++++
 2 files changed, 163 insertions(+), 0 deletions(-)


diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
index 8c34149..7ae887b 100644
--- a/arch/powerpc/include/asm/ptrace.h
+++ b/arch/powerpc/include/asm/ptrace.h
@@ -24,6 +24,12 @@
  * 2 of the License, or (at your option) any later version.
  */
 
+#ifdef __KERNEL__
+#include <linux/types.h>
+#else
+#include <stdint.h>
+#endif
+
 #ifndef __ASSEMBLY__
 
 struct pt_regs {
@@ -292,4 +298,73 @@ extern void user_disable_single_step(struct task_struct *);
 
 #define PTRACE_SINGLEBLOCK	0x100	/* resume execution until next branch */
 
+#define PPC_PTRACE_GETHWDBGINFO	0x89
+#define PPC_PTRACE_SETHWDEBUG	0x88
+#define PPC_PTRACE_DELHWDEBUG	0x87
+
+#ifndef __ASSEMBLY__
+
+struct ppc_debug_info {
+	uint32_t version;		/* Only version 1 exists to date */
+	uint32_t num_instruction_bps;
+	uint32_t num_data_bps;
+	uint32_t num_condition_regs;
+	uint32_t data_bp_alignment;
+	uint32_t sizeof_condition;	/* size of the DVC register */
+	uint64_t features;
+};
+
+#endif /* __ASSEMBLY__ */
+
+/*
+ * features will have bits indication whether there is support for:
+ */
+#define PPC_DEBUG_FEATURE_INSN_BP_RANGE		0x1
+#define PPC_DEBUG_FEATURE_INSN_BP_MASK		0x2
+#define PPC_DEBUG_FEATURE_DATA_BP_RANGE		0x4
+#define PPC_DEBUG_FEATURE_DATA_BP_MASK		0x8
+
+#ifndef __ASSEMBLY__
+
+struct ppc_hw_breakpoint {
+	uint32_t version;		/* currently, version must be 1 */
+	uint32_t trigger_type;		/* only some combinations allowed */
+	uint32_t addr_mode;		/* address match mode */
+	uint32_t condition_mode;	/* break/watchpoint condition flags */
+	uint64_t addr;			/* break/watchpoint address */
+	uint64_t addr2;			/* range end or mask */
+	uint64_t condition_value;	/* contents of the DVC register */
+};
+
+#endif /* __ASSEMBLY__ */
+
+/*
+ * Trigger Type
+ */
+#define PPC_BREAKPOINT_TRIGGER_EXECUTE	0x1
+#define PPC_BREAKPOINT_TRIGGER_READ	0x2
+#define PPC_BREAKPOINT_TRIGGER_WRITE	0x4
+#define PPC_BREAKPOINT_TRIGGER_RW	0x6
+
+/*
+ * Address Mode
+ */
+#define PPC_BREAKPOINT_MODE_EXACT		0x0
+#define PPC_BREAKPOINT_MODE_RANGE_INCLUSIVE	0x1
+#define PPC_BREAKPOINT_MODE_RANGE_EXCLUSIVE	0x2
+#define PPC_BREAKPOINT_MODE_MASK		0x3
+
+/*
+ * Condition Mode
+ */
+#define PPC_BREAKPOINT_CONDITION_NONE	0x0
+#define PPC_BREAKPOINT_CONDITION_AND	0x1
+#define PPC_BREAKPOINT_CONDITION_EXACT	0x1
+#define PPC_BREAKPOINT_CONDITION_OR	0x2
+#define PPC_BREAKPOINT_CONDITION_AND_OR	0x3
+#define PPC_BREAKPOINT_CONDITION_BE_ALL	0x00ff0000
+#define PPC_BREAKPOINT_CONDITION_BE_SHIFT	16
+#define PPC_BREAKPOINT_CONDITION_BE(n)	\
+	(1<<((n)+PPC_BREAKPOINT_CONDITION_BE_SHIFT))
+
 #endif /* _ASM_POWERPC_PTRACE_H */
diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index ef14988..6be2ce0 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -839,6 +839,50 @@ void ptrace_disable(struct task_struct *child)
 	user_disable_single_step(child);
 }
 
+static long ppc_set_hwdebug(struct task_struct *child,
+		     struct ppc_hw_breakpoint *bp_info)
+{
+	/*
+	 * We currently support one data breakpoint
+	 */
+	if (((bp_info->trigger_type & PPC_BREAKPOINT_TRIGGER_RW) == 0) ||
+	    ((bp_info->trigger_type & ~PPC_BREAKPOINT_TRIGGER_RW) != 0) ||
+	    (bp_info->trigger_type != PPC_BREAKPOINT_TRIGGER_WRITE) ||
+	    (bp_info->addr_mode != PPC_BREAKPOINT_MODE_EXACT) ||
+	    (bp_info->condition_mode != PPC_BREAKPOINT_CONDITION_NONE))
+		return -EINVAL;
+
+	if (child->thread.dabr)
+		return -ENOSPC;
+
+	if ((unsigned long)bp_info->addr >= TASK_SIZE)
+		return -EIO;
+
+	child->thread.dabr = (unsigned long)bp_info->addr;
+#ifdef CONFIG_BOOKE
+	child->thread.dbcr0 = DBCR0_IDM;
+	if (bp_info->trigger_type & PPC_BREAKPOINT_TRIGGER_READ)
+		child->thread.dbcr0 |= DBSR_DAC1R;
+	if (bp_info->trigger_type & PPC_BREAKPOINT_TRIGGER_WRITE)
+		child->thread.dbcr0 |= DBSR_DAC1W;
+	child->thread.regs->msr |= MSR_DE;
+#endif
+	return 1;
+}
+
+static long ppc_del_hwdebug(struct task_struct *child, long addr, long data)
+{
+	if ((data != 1) || (child->thread.dabr == 0))
+		return -EINVAL;
+
+	child->thread.dabr = 0;
+#ifdef CONFIG_BOOKE
+	child->thread.dbcr0 &= ~(DBSR_DAC1R | DBSR_DAC1W | DBCR0_IDM);
+	child->thread.regs->msr &= ~MSR_DE;
+#endif
+	return 0;
+}
+
 /*
  * Here are the old "legacy" powerpc specific getregs/setregs ptrace calls,
  * we mark them as obsolete now, they will be removed in a future version
@@ -932,6 +976,50 @@ long arch_ptrace(struct task_struct *child, long request, long addr, long data)
 		break;
 	}
 
+	case PPC_PTRACE_GETHWDBGINFO: {
+		struct ppc_debug_info dbginfo;
+
+		dbginfo.version = 1;
+		dbginfo.num_instruction_bps = 0;
+		dbginfo.num_data_bps = 1;
+		dbginfo.num_condition_regs = 0;
+#ifdef CONFIG_PPC64
+		dbginfo.data_bp_alignment = 8;
+#else
+		dbginfo.data_bp_alignment = 0;
+#endif
+		dbginfo.sizeof_condition = 0;
+		dbginfo.features = 0;
+
+		if (!access_ok(VERIFY_WRITE, data,
+			       sizeof(struct ppc_debug_info)))
+			return -EFAULT;
+		ret = __copy_to_user((struct ppc_debug_info __user *)data,
+				     &dbginfo, sizeof(struct ppc_debug_info)) ?
+		      -EFAULT : 0;
+		break;
+	}
+
+	case PPC_PTRACE_SETHWDEBUG: {
+		struct ppc_hw_breakpoint bp_info;
+
+		if (!access_ok(VERIFY_READ, data,
+			       sizeof(struct ppc_hw_breakpoint)))
+			return -EFAULT;
+		ret = __copy_from_user(&bp_info,
+				       (struct ppc_hw_breakpoint __user *)data,
+				       sizeof(struct ppc_hw_breakpoint)) ?
+		      -EFAULT : 0;
+		if (!ret)
+			ret = ppc_set_hwdebug(child, &bp_info);
+		break;
+	}
+
+	case PPC_PTRACE_DELHWDEBUG: {
+		ret = ppc_del_hwdebug(child, addr, data);
+		break;
+	}
+
 	case PTRACE_GET_DEBUGREG: {
 		ret = -EINVAL;
 		/* We only support one DABR and no IABRS at the moment */

-- 
Dave Kleikamp
IBM Linux Technology Center
