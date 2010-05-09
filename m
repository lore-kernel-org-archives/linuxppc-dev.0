Return-Path: <sam@ravnborg.org>
Date: Sun, 9 May 2010 08:59:31 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Subject: [PATCH] powerpc: fix userspace build of ptrace.h
Message-ID: <20100509065931.GA6633@merkur.ravnborg.org>
References: <4BE5C203.6060509@varma-el.com>
	<1273375269.5312.4.camel@norville.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1273375269.5312.4.camel@norville.austin.ibm.com>
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>,
	Andrey Volkov <avolkov@varma-el.com>, LKML <linux-kernel@vger.kernel.org>,
	David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>From ff056c080d2b0b93bac07ad71125fee701919f5e Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 9 May 2010 08:52:31 +0200
Subject: [PATCH] powerpc: fix userspace build of ptrace.h

Build of ptrace.h failed for assembly because it
pulls in stdint.h.
Use exportable types (__u32, __u64) to avoid the dependency
on stdint.h.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Andrey Volkov <avolkov@varma-el.com>
Cc: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

A better fix is to remove the use of stdint like the following patch does.
Note - I have not even build tested this patch!

	Sam

 arch/powerpc/include/asm/ptrace.h |   32 ++++++++++++++------------------
 1 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
index 9e2d84c..77bbc68 100644
--- a/arch/powerpc/include/asm/ptrace.h
+++ b/arch/powerpc/include/asm/ptrace.h
@@ -24,11 +24,7 @@
  * 2 of the License, or (at your option) any later version.
  */
 
-#ifdef __KERNEL__
 #include <linux/types.h>
-#else
-#include <stdint.h>
-#endif
 
 #ifndef __ASSEMBLY__
 
@@ -300,13 +296,13 @@ do {									      \
 #ifndef __ASSEMBLY__
 
 struct ppc_debug_info {
-	uint32_t version;		/* Only version 1 exists to date */
-	uint32_t num_instruction_bps;
-	uint32_t num_data_bps;
-	uint32_t num_condition_regs;
-	uint32_t data_bp_alignment;
-	uint32_t sizeof_condition;	/* size of the DVC register */
-	uint64_t features;
+	__u32 version;			/* Only version 1 exists to date */
+	__u32 num_instruction_bps;
+	__u32 num_data_bps;
+	__u32 num_condition_regs;
+	__u32 data_bp_alignment;
+	__u32 sizeof_condition;		/* size of the DVC register */
+	__u64 features;
 };
 
 #endif /* __ASSEMBLY__ */
@@ -322,13 +318,13 @@ struct ppc_debug_info {
 #ifndef __ASSEMBLY__
 
 struct ppc_hw_breakpoint {
-	uint32_t version;		/* currently, version must be 1 */
-	uint32_t trigger_type;		/* only some combinations allowed */
-	uint32_t addr_mode;		/* address match mode */
-	uint32_t condition_mode;	/* break/watchpoint condition flags */
-	uint64_t addr;			/* break/watchpoint address */
-	uint64_t addr2;			/* range end or mask */
-	uint64_t condition_value;	/* contents of the DVC register */
+	__u32 version;		/* currently, version must be 1 */
+	__u32 trigger_type;	/* only some combinations allowed */
+	__u32 addr_mode;	/* address match mode */
+	__u32 condition_mode;	/* break/watchpoint condition flags */
+	__u64 addr;		/* break/watchpoint address */
+	__u64 addr2;		/* range end or mask */
+	__u64 condition_value;	/* contents of the DVC register */
 };
 
 #endif /* __ASSEMBLY__ */
-- 
1.6.0.6
