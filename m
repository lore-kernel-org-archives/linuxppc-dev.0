Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, rusty@rustcorp.com.au,
 ulrich.weigand@de.ibm.com, amodra@gmail.com, mikey@neuling.org,
 mjw@linux.vnet.ibm.com
Subject: [PATCH 05/33] powerpc: Remove _INIT_GLOBAL(),
 _STATIC() and _INIT_STATIC()
Date: Tue, 25 Mar 2014 22:44:11 +1100
Message-Id: <1395747879-5948-6-git-send-email-anton@samba.org>
In-Reply-To: <1395747879-5948-1-git-send-email-anton@samba.org>
References: <1395747879-5948-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now there are no users of _INIT_GLOBAL(), _STATIC() and _INIT_STATIC()
we can remove them.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/ppc_asm.h | 38 --------------------------------------
 1 file changed, 38 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index 3128ba3..35b23a6 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -209,20 +209,6 @@ name: \
 	.type GLUE(.,name),@function; \
 GLUE(.,name):
 
-#define _INIT_GLOBAL(name) \
-	__REF; \
-	.align 2 ; \
-	.globl name; \
-	.globl GLUE(.,name); \
-	.section ".opd","aw"; \
-name: \
-	.quad GLUE(.,name); \
-	.quad .TOC.@tocbase; \
-	.quad 0; \
-	.previous; \
-	.type GLUE(.,name),@function; \
-GLUE(.,name):
-
 #define _KPROBE(name) \
 	.section ".kprobes.text","a"; \
 	.align 2 ; \
@@ -237,30 +223,6 @@ name: \
 	.type GLUE(.,name),@function; \
 GLUE(.,name):
 
-#define _STATIC(name) \
-	.section ".text"; \
-	.align 2 ; \
-	.section ".opd","aw"; \
-name: \
-	.quad GLUE(.,name); \
-	.quad .TOC.@tocbase; \
-	.quad 0; \
-	.previous; \
-	.type GLUE(.,name),@function; \
-GLUE(.,name):
-
-#define _INIT_STATIC(name) \
-	__REF; \
-	.align 2 ; \
-	.section ".opd","aw"; \
-name: \
-	.quad GLUE(.,name); \
-	.quad .TOC.@tocbase; \
-	.quad 0; \
-	.previous; \
-	.type GLUE(.,name),@function; \
-GLUE(.,name):
-
 #else /* 32-bit */
 
 #define _ENTRY(n)	\
-- 
1.8.3.2
