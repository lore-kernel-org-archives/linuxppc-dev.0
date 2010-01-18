Return-Path: <shaggy@linux.vnet.ibm.com>
Date: Mon, 18 Jan 2010 14:57:09 -0700
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: linuxppc-dev list <Linuxppc-dev@ozlabs.org>
Message-Id: <20100118215709.15684.28776.sendpatchset@norville.austin.ibm.com>
In-Reply-To: <20100118215704.15684.60646.sendpatchset@norville.austin.ibm.com>
References: <20100118215704.15684.60646.sendpatchset@norville.austin.ibm.com>
Subject: [RFC:PATCH 01/03] powerpc: Extended ptrace interface
Cc: Sergio Durigan Junior <sergiodj@br.ibm.com>, David Gibson <dwg@au1.ibm.com>,
	Torez Smith <torez@us.ibm.com>, Thiago Jung Bauermann <bauerman@br.ibm.com>
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

Signed-off-by: Torez Smith  <lnxtorez@linux.vnet.ibm.com>
Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Acked-by: David Gibson <dwg@au1.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Cc: Kumar Gala <galak@kernel.crashing.org>
Cc: Sergio Durigan Junior <sergiodj@br.ibm.com>
Cc: Thiago Jung Bauermann <bauerman@br.ibm.com>
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>
---

 Documentation/powerpc/ptrace.txt  |  134 +++++++++++++++++++++++++++++++++++++
 arch/powerpc/include/asm/ptrace.h |   77 +++++++++++++++++++++
 arch/powerpc/kernel/ptrace.c      |   90 +++++++++++++++++++++++++
 3 files changed, 301 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/powerpc/ptrace.txt


diff --git a/Documentation/powerpc/ptrace.txt b/Documentation/powerpc/ptrace.txt
new file mode 100644
index 0000000..f4a5499
--- /dev/null
+++ b/Documentation/powerpc/ptrace.txt
@@ -0,0 +1,134 @@
+GDB intends to support the following hardware debug features of BookE
+processors:
+
+4 hardware breakpoints (IAC)
+2 hardware watchpoints (read, write and read-write) (DAC)
+2 value conditions for the hardware watchpoints (DVC)
+
+For that, we need to extend ptrace so that GDB can query and set these
+resources. Since we're extending, we're trying to create an interface
+that's extendable and that covers both BookE and server processors, so
+that GDB doesn't need to special-case each of them. We added the
+following 3 new ptrace requests.
+
+1. PTRACE_PPC_GETHWDEBUGINFO
+
+Query for GDB to discover the hardware debug features. The main info to
+be returned here is the minimum alignment for the hardware watchpoints.
+BookE processors don't have restrictions here, but server processors have
+an 8-byte alignment restriction for hardware watchpoints. We'd like to avoid
+adding special cases to GDB based on what it sees in AUXV.
+
+Since we're at it, we added other useful info that the kernel can return to
+GDB: this query will return the number of hardware breakpoints, hardware
+watchpoints and whether it supports a range of addresses and a condition.
+The query will fill the following structure provided by the requesting process:
+
+struct ppc_debug_info {
+       unit32_t version;
+       unit32_t num_instruction_bps;
+       unit32_t num_data_bps;
+       unit32_t num_condition_regs;
+       unit32_t data_bp_alignment;
+       unit32_t sizeof_condition; /* size of the DVC register */
+       uint64_t features; /* bitmask of the individual flags */
+};
+
+features will have bits indicating whether there is support for:
+
+#define PPC_DEBUG_FEATURE_INSN_BP_RANGE		0x1
+#define PPC_DEBUG_FEATURE_INSN_BP_MASK		0x2
+#define PPC_DEBUG_FEATURE_DATA_BP_RANGE		0x4
+#define PPC_DEBUG_FEATURE_DATA_BP_MASK		0x8
+
+2. PTRACE_SETHWDEBUG
+
+Sets a hardware breakpoint or watchpoint, according to the provided structure:
+
+struct ppc_hw_breakpoint {
+        uint32_t version;
+#define PPC_BREAKPOINT_TRIGGER_EXECUTE  0x1
+#define PPC_BREAKPOINT_TRIGGER_READ     0x2
+#define PPC_BREAKPOINT_TRIGGER_WRITE    0x4
+        uint32_t trigger_type;       /* only some combinations allowed */
+#define PPC_BREAKPOINT_MODE_EXACT               0x0
+#define PPC_BREAKPOINT_MODE_RANGE_INCLUSIVE     0x1
+#define PPC_BREAKPOINT_MODE_RANGE_EXCLUSIVE     0x2
+#define PPC_BREAKPOINT_MODE_MASK                0x3
+        uint32_t addr_mode;          /* address match mode */
+
+#define PPC_BREAKPOINT_CONDITION_MODE   0x3
+#define PPC_BREAKPOINT_CONDITION_NONE   0x0
+#define PPC_BREAKPOINT_CONDITION_AND    0x1
+#define PPC_BREAKPOINT_CONDITION_EXACT  0x1	/* different name for the same thing as above */
+#define PPC_BREAKPOINT_CONDITION_OR     0x2
+#define PPC_BREAKPOINT_CONDITION_AND_OR 0x3
+#define PPC_BREAKPOINT_CONDITION_BE_ALL 0x00ff0000	/* byte enable bits */
+#define PPC_BREAKPOINT_CONDITION_BE(n)  (1<<((n)+16))
+        uint32_t condition_mode;     /* break/watchpoint condition flags */
+
+        uint64_t addr;
+        uint64_t addr2;
+        uint64_t condition_value;
+};
+
+A request specifies one event, not necessarily just one register to be set.
+For instance, if the request is for a watchpoint with a condition, both the
+DAC and DVC registers will be set in the same request.
+
+With this GDB can ask for all kinds of hardware breakpoints and watchpoints
+that the BookE supports. COMEFROM breakpoints available in server processors
+are not contemplated, but that is out of the scope of this work.
+
+ptrace will return an integer (handle) uniquely identifying the breakpoint or
+watchpoint just created. This integer will be used in the PTRACE_DELHWDEBUG
+request to ask for its removal. Return -ENOSPC if the requested breakpoint
+can't be allocated on the registers.
+
+Some examples of using the structure to:
+
+- set a breakpoint in the first breakpoint register
+
+  p.version         = PPC_DEBUG_CURRENT_VERSION;
+  p.trigger_type    = PPC_BREAKPOINT_TRIGGER_EXECUTE;
+  p.addr_mode       = PPC_BREAKPOINT_MODE_EXACT;
+  p.condition_mode  = PPC_BREAKPOINT_CONDITION_NONE;
+  p.addr            = (uint64_t) address;
+  p.addr2           = 0;
+  p.condition_value = 0;
+
+- set a watchpoint which triggers on reads in the second watchpoint register
+
+  p.version         = PPC_DEBUG_CURRENT_VERSION;
+  p.trigger_type    = PPC_BREAKPOINT_TRIGGER_READ;
+  p.addr_mode       = PPC_BREAKPOINT_MODE_EXACT;
+  p.condition_mode  = PPC_BREAKPOINT_CONDITION_NONE;
+  p.addr            = (uint64_t) address;
+  p.addr2           = 0;
+  p.condition_value = 0;
+
+- set a watchpoint which triggers only with a specific value
+
+  p.version         = PPC_DEBUG_CURRENT_VERSION;
+  p.trigger_type    = PPC_BREAKPOINT_TRIGGER_READ;
+  p.addr_mode       = PPC_BREAKPOINT_MODE_EXACT;
+  p.condition_mode  = PPC_BREAKPOINT_CONDITION_AND | PPC_BREAKPOINT_CONDITION_BE_ALL;
+  p.addr            = (uint64_t) address;
+  p.addr2           = 0;
+  p.condition_value = (uint64_t) condition;
+
+- set a ranged hardware breakpoint
+
+  p.version         = PPC_DEBUG_CURRENT_VERSION;
+  p.trigger_type    = PPC_BREAKPOINT_TRIGGER_EXECUTE;
+  p.addr_mode       = PPC_BREAKPOINT_MODE_RANGE_INCLUSIVE;
+  p.condition_mode  = PPC_BREAKPOINT_CONDITION_NONE;
+  p.addr            = (uint64_t) begin_range;
+  p.addr2           = (uint64_t) end_range;
+  p.condition_value = 0;
+
+3. PTRACE_DELHWDEBUG
+
+Takes an integer which identifies an existing breakpoint or watchpoint
+(i.e., the value returned from PTRACE_SETHWDEBUG), and deletes the
+corresponding breakpoint or watchpoint..
diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
index cbd759e..b451081 100644
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
@@ -294,4 +300,75 @@ extern void user_disable_single_step(struct task_struct *);
 
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
+#define PPC_DEBUG_FEATURE_INSN_BP_RANGE		0x0000000000000001
+#define PPC_DEBUG_FEATURE_INSN_BP_MASK		0x0000000000000002
+#define PPC_DEBUG_FEATURE_DATA_BP_RANGE		0x0000000000000004
+#define PPC_DEBUG_FEATURE_DATA_BP_MASK		0x0000000000000008
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
+#define PPC_BREAKPOINT_TRIGGER_EXECUTE	0x00000001
+#define PPC_BREAKPOINT_TRIGGER_READ	0x00000002
+#define PPC_BREAKPOINT_TRIGGER_WRITE	0x00000004
+#define PPC_BREAKPOINT_TRIGGER_RW	\
+	(PPC_BREAKPOINT_TRIGGER_READ | PPC_BREAKPOINT_TRIGGER_WRITE)
+
+/*
+ * Address Mode
+ */
+#define PPC_BREAKPOINT_MODE_EXACT		0x00000000
+#define PPC_BREAKPOINT_MODE_RANGE_INCLUSIVE	0x00000001
+#define PPC_BREAKPOINT_MODE_RANGE_EXCLUSIVE	0x00000002
+#define PPC_BREAKPOINT_MODE_MASK		0x00000003
+
+/*
+ * Condition Mode
+ */
+#define PPC_BREAKPOINT_CONDITION_MODE	0x00000003
+#define PPC_BREAKPOINT_CONDITION_NONE	0x00000000
+#define PPC_BREAKPOINT_CONDITION_AND	0x00000001
+#define PPC_BREAKPOINT_CONDITION_EXACT	PPC_BREAKPOINT_CONDITION_AND
+#define PPC_BREAKPOINT_CONDITION_OR	0x00000002
+#define PPC_BREAKPOINT_CONDITION_AND_OR	0x00000003
+#define PPC_BREAKPOINT_CONDITION_BE_ALL	0x00ff0000
+#define PPC_BREAKPOINT_CONDITION_BE_SHIFT	16
+#define PPC_BREAKPOINT_CONDITION_BE(n)	\
+	(1<<((n)+PPC_BREAKPOINT_CONDITION_BE_SHIFT))
+
 #endif /* _ASM_POWERPC_PTRACE_H */
diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index ef14988..33ab496 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -839,6 +839,52 @@ void ptrace_disable(struct task_struct *child)
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
+	if (data != 1)
+		return -EINVAL;
+	if (child->thread.dabr == 0)
+		return -ENOENT;
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
@@ -932,6 +978,50 @@ long arch_ptrace(struct task_struct *child, long request, long addr, long data)
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
+		dbginfo.data_bp_alignment = 4;
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
