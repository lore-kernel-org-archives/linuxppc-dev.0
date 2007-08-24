Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: paulus@samba.org
MIME-Version: 1.0
Subject: [PATCH] Remove barriers from the SLB shadow buffer update
Date: Fri, 24 Aug 2007 16:58:37 +1000
Message-ID: <3992.1187938717@neuling.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

After talking to an IBM POWER hypervisor design and development (PHYP)
guy, there seems to be no need for memory barriers when updating the SLB
shadow buffer provided we only update it from the current CPU, which we
do.

Also, these guys see no need in the future for these barriers.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
Tested on PHYP and BML.

paulus: As you mentioned, this is 2.6.24 material.  

 arch/powerpc/kernel/entry_64.S |    8 ++++----
 arch/powerpc/mm/slb.c          |    6 ++----
 2 files changed, 6 insertions(+), 8 deletions(-)

Index: linux-2.6-ozlabs/arch/powerpc/kernel/entry_64.S
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/entry_64.S
+++ linux-2.6-ozlabs/arch/powerpc/kernel/entry_64.S
@@ -385,15 +385,15 @@ BEGIN_FTR_SECTION
 	oris	r0,r6,(SLB_ESID_V)@h
 	ori	r0,r0,(SLB_NUM_BOLTED-1)@l
 
-	/* Update the last bolted SLB */
+	/* Update the last bolted SLB.  No write barriers are needed
+	 * here, provided we only update the current CPU's SLB shadow
+	 * buffer.
+	 */
 	ld	r9,PACA_SLBSHADOWPTR(r13)
 	li	r12,0
 	std	r12,SLBSHADOW_STACKESID(r9) /* Clear ESID */
-	eieio
 	std	r7,SLBSHADOW_STACKVSID(r9)  /* Save VSID */
-	eieio
 	std	r0,SLBSHADOW_STACKESID(r9)  /* Save ESID */
-	eieio
 
 	slbie	r6
 	slbie	r6		/* Workaround POWER5 < DD2.1 issue */
Index: linux-2.6-ozlabs/arch/powerpc/mm/slb.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/mm/slb.c
+++ linux-2.6-ozlabs/arch/powerpc/mm/slb.c
@@ -59,14 +59,12 @@ static inline void slb_shadow_update(uns
 {
 	/*
 	 * Clear the ESID first so the entry is not valid while we are
-	 * updating it.
+	 * updating it.  No write barriers are needed here, provided
+	 * we only update the current CPU's SLB shadow buffer.
 	 */
 	get_slb_shadow()->save_area[entry].esid = 0;
-	smp_wmb();
 	get_slb_shadow()->save_area[entry].vsid = mk_vsid_data(ea, flags);
-	smp_wmb();
 	get_slb_shadow()->save_area[entry].esid = mk_esid_data(ea, entry);
-	smp_wmb();
 }
 
 static inline void slb_shadow_clear(unsigned long entry)
