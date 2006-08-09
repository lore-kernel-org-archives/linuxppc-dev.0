Return-Path: <mikey@ozlabs.org>
From: Michael Neuling <mikey@neuling.org>
To: paulus@samba.org
MIME-Version: 1.0
Subject: [PATCH] SLB shadow buffer cleanup
Date: Wed, 09 Aug 2006 17:00:30 +1000
Sender: mikey@ozlabs.org
Message-Id: <20060809070030.B99FB67B6A@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, miltonm@bga.com
Reply-To: Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Cleanup some of the #define magic as suggested by Milton. 

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
Looks like and older version of this patch was imported into the powerpc
git tree.  This is an incremental update to the latest version. 

 arch/powerpc/kernel/asm-offsets.c |    5 +++++
 arch/powerpc/kernel/entry_64.S    |   13 ++++---------
 2 files changed, 9 insertions(+), 9 deletions(-)

Index: linux-2.6-ozlabs/arch/powerpc/kernel/asm-offsets.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/asm-offsets.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/asm-offsets.c
@@ -42,6 +42,7 @@
 #include <asm/lppaca.h>
 #include <asm/cache.h>
 #include <asm/compat.h>
+#include <asm/mmu.h>
 #endif
 
 #define DEFINE(sym, val) \
@@ -137,6 +138,10 @@ int main(void)
 	DEFINE(PACA_SYSTEM_TIME, offsetof(struct paca_struct, system_time));
 	DEFINE(PACA_SLBSHADOWPTR, offsetof(struct paca_struct, slb_shadow_ptr));
 
+	DEFINE(SLBSHADOW_STACKVSID,
+	       offsetof(struct slb_shadow, save_area[SLB_NUM_BOLTED - 1].vsid));
+	DEFINE(SLBSHADOW_STACKESID,
+	       offsetof(struct slb_shadow, save_area[SLB_NUM_BOLTED - 1].esid));
 	DEFINE(LPPACASRR0, offsetof(struct lppaca, saved_srr0));
 	DEFINE(LPPACASRR1, offsetof(struct lppaca, saved_srr1));
 	DEFINE(LPPACAANYINT, offsetof(struct lppaca, int_dword.any_int));
Index: linux-2.6-ozlabs/arch/powerpc/kernel/entry_64.S
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/entry_64.S
+++ linux-2.6-ozlabs/arch/powerpc/kernel/entry_64.S
@@ -323,11 +323,6 @@ _GLOBAL(ret_from_fork)
  * The code which creates the new task context is in 'copy_thread'
  * in arch/powerpc/kernel/process.c 
  */
-#define SHADOW_SLB_BOLTED_STACK_ESID \
-		(SLBSHADOW_SAVEAREA + 0x10*(SLB_NUM_BOLTED-1))
-#define SHADOW_SLB_BOLTED_STACK_VSID \
-		(SLBSHADOW_SAVEAREA + 0x10*(SLB_NUM_BOLTED-1) + 8)
-
 	.align	7
 _GLOBAL(_switch)
 	mflr	r0
@@ -383,10 +378,10 @@ BEGIN_FTR_SECTION
 
 	/* Update the last bolted SLB */
 	ld	r9,PACA_SLBSHADOWPTR(r13)
- 	li	r12,0
-  	std	r12,SHADOW_SLB_BOLTED_STACK_ESID(r9) /* Clear ESID */
-	std	r7,SHADOW_SLB_BOLTED_STACK_VSID(r9)  /* Save VSID */
- 	std	r0,SHADOW_SLB_BOLTED_STACK_ESID(r9)  /* Save ESID */
+	li	r12,0
+	std	r12,SLBSHADOW_STACKESID(r9) /* Clear ESID */
+	std	r7,SLBSHADOW_STACKVSID(r9)  /* Save VSID */
+	std	r0,SLBSHADOW_STACKESID(r9)  /* Save ESID */
 
 	slbie	r6
 	slbie	r6		/* Workaround POWER5 < DD2.1 issue */
