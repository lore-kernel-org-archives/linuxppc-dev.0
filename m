Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, rusty@rustcorp.com.au,
 ulrich.weigand@de.ibm.com, amodra@gmail.com, mikey@neuling.org,
 mjw@linux.vnet.ibm.com, rostedt@goodmis.org, philippe.bergheaud@fr.ibm.com
Subject: [PATCH 1/7] powerpc: Add _GLOBAL_TOC for ABIv2 assembly functions
 exported to modules
Date: Fri,  4 Apr 2014 17:09:04 +1100
Message-Id: <1396591750-8203-2-git-send-email-anton@samba.org>
In-Reply-To: <1396591750-8203-1-git-send-email-anton@samba.org>
References: <1396591750-8203-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If an assembly function that calls back into c code is exported to
modules, we need to ensure r2 is setup correctly. There are only
two places crazy enough to do it (two of which are my fault).

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/ppc_asm.h | 12 ++++++++++++
 arch/powerpc/lib/copyuser_64.S     |  2 +-
 arch/powerpc/lib/memcpy_64.S       |  2 +-
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index 2cc2511..6400f18 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -207,6 +207,16 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
 	.globl name; \
 name:
 
+#define _GLOBAL_TOC(name) \
+	.section ".text"; \
+	.align 2 ; \
+	.type name,@function; \
+	.globl name; \
+name: \
+0:	addis r2,r12,(.TOC.-0b)@ha; \
+	addi r2,r2,(.TOC.-0b)@l; \
+	.localentry name,.-name
+
 #define _KPROBE(name) \
 	.section ".kprobes.text","a"; \
 	.align 2 ; \
@@ -235,6 +245,8 @@ name: \
 	.type GLUE(.,name),@function; \
 GLUE(.,name):
 
+#define _GLOBAL_TOC(name) _GLOBAL(name)
+
 #define _KPROBE(name) \
 	.section ".kprobes.text","a"; \
 	.align 2 ; \
diff --git a/arch/powerpc/lib/copyuser_64.S b/arch/powerpc/lib/copyuser_64.S
index 596a285..0860ee4 100644
--- a/arch/powerpc/lib/copyuser_64.S
+++ b/arch/powerpc/lib/copyuser_64.S
@@ -18,7 +18,7 @@
 #endif
 
 	.align	7
-_GLOBAL(__copy_tofrom_user)
+_GLOBAL_TOC(__copy_tofrom_user)
 BEGIN_FTR_SECTION
 	nop
 FTR_SECTION_ELSE
diff --git a/arch/powerpc/lib/memcpy_64.S b/arch/powerpc/lib/memcpy_64.S
index 9d3960c..bc9a2ca 100644
--- a/arch/powerpc/lib/memcpy_64.S
+++ b/arch/powerpc/lib/memcpy_64.S
@@ -10,7 +10,7 @@
 #include <asm/ppc_asm.h>
 
 	.align	7
-_GLOBAL(memcpy)
+_GLOBAL_TOC(memcpy)
 BEGIN_FTR_SECTION
 	std	r3,-STACKFRAMESIZE+STK_REG(R31)(r1)	/* save destination pointer for return value */
 FTR_SECTION_ELSE
-- 
1.8.3.2
