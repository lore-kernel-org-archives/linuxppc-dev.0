Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: benh@kernel.crashing.org
MIME-Version: 1.0
Subject: [PATCH] powerpc/ptrace: Add DAWR debug feature info for userspace
Date: Fri, 22 Mar 2013 17:12:33 +1100
Message-ID: <15228.1363932753@ale.ozlabs.ibm.com>
Cc: Linux PPC dev <linuxppc-dev@ozlabs.org>,
 Edjunior Barbosa Machado <emachado@linux.vnet.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds new debug feature information so that the DAWR can be
identified by userspace tools like GDB.

Unfortunately the DAWR doesn't sit nicely into the current description
that ptrace provides to userspace via struct ppc_debug_info.  It doesn't
allow for specifying that only some ranges are possible or even the end
alignment constraints (DAWR only allows 512 byte wide ranges which can't
cross a 512 byte boundary).

After talking to Edjunior Machado (GDB ppc developer), it was decided
this was the best approach.  Just mark it as debug feature DAWR and
tools like GDB can internally decide the constraints.

Signed-off-by: Michael Neuling <mikey@neuling.org>

diff --git a/Documentation/powerpc/ptrace.txt b/Documentation/powerpc/ptrace.txt
index f2a7a39..99c5ce8 100644
--- a/Documentation/powerpc/ptrace.txt
+++ b/Documentation/powerpc/ptrace.txt
@@ -40,6 +40,7 @@ features will have bits indicating whether there is support for:
 #define PPC_DEBUG_FEATURE_INSN_BP_MASK		0x2
 #define PPC_DEBUG_FEATURE_DATA_BP_RANGE		0x4
 #define PPC_DEBUG_FEATURE_DATA_BP_MASK		0x8
+#define PPC_DEBUG_FEATURE_DATA_BP_DAWR		0x10
 
 2. PTRACE_SETHWDEBUG
 
diff --git a/arch/powerpc/include/uapi/asm/ptrace.h b/arch/powerpc/include/uapi/asm/ptrace.h
index 66b9ca4..77d2ed3 100644
--- a/arch/powerpc/include/uapi/asm/ptrace.h
+++ b/arch/powerpc/include/uapi/asm/ptrace.h
@@ -211,6 +211,7 @@ struct ppc_debug_info {
 #define PPC_DEBUG_FEATURE_INSN_BP_MASK		0x0000000000000002
 #define PPC_DEBUG_FEATURE_DATA_BP_RANGE		0x0000000000000004
 #define PPC_DEBUG_FEATURE_DATA_BP_MASK		0x0000000000000008
+#define PPC_DEBUG_FEATURE_DATA_BP_DAWR		0x0000000000000010
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index f9b30c6..8240c1a 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -1637,6 +1637,8 @@ long arch_ptrace(struct task_struct *child, long request,
 		dbginfo.sizeof_condition = 0;
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
 		dbginfo.features = PPC_DEBUG_FEATURE_DATA_BP_RANGE;
+		if (cpu_has_feature(CPU_FTR_DAWR))
+			dbginfo.features |= PPC_DEBUG_FEATURE_DATA_BP_DAWR;
 #else
 		dbginfo.features = 0;
 #endif /* CONFIG_HAVE_HW_BREAKPOINT */
