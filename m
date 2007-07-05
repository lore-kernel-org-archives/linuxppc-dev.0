Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 0ED5BDDF60
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jul 2007 03:03:50 +1000 (EST)
Message-Id: <20070705170240.257555000@lixom.net>
References: <20070705170233.258351000@lixom.net>
Date: Thu, 05 Jul 2007 12:02:58 -0500
From: Olof Johansson <olof@lixom.net>
To: linuxppc-dev@ozlabs.org
Subject: [patch 25/35] Work around errata 4025
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Errata 4025 workaround: A SLB load can in some cases be corrupted. As a workaround,
insert an instruction with sync side effects after the load (in this case it's the
mtmsrd).

Index: 2.6.21/arch/powerpc/kernel/entry_64.S
===================================================================
--- 2.6.21.orig/arch/powerpc/kernel/entry_64.S
+++ 2.6.21/arch/powerpc/kernel/entry_64.S
@@ -395,6 +395,8 @@ BEGIN_FTR_SECTION
 	slbie	r6
 	slbie	r6		/* Workaround POWER5 < DD2.1 issue */
 	slbmte	r7,r0
+	mfmsr	r7		/* PA6T Ax workaround */
+	mtmsrd	r7
 	isync
 
 2:
Index: 2.6.21/arch/powerpc/mm/slb.c
===================================================================
--- 2.6.21.orig/arch/powerpc/mm/slb.c
+++ 2.6.21/arch/powerpc/mm/slb.c
@@ -79,7 +79,7 @@ static inline void create_shadowed_slbe(
 	slb_shadow_update(mk_esid_data(ea, entry), mk_vsid_data(ea, flags),
 			  entry);
 
-	asm volatile("slbmte  %0,%1" :
+	asm volatile("slbmte  %0,%1 ; mfmsr %0 ; mtmsrd %0" :
 		     : "r" (mk_vsid_data(ea, flags)),
 		       "r" (mk_esid_data(ea, entry))
 		     : "memory" );
@@ -113,8 +113,14 @@ void slb_flush_and_rebolt(void)
 		     "slbia\n"
 		     /* Slot 1 - first VMALLOC segment */
 		     "slbmte	%0,%1\n"
+		     /* PA6T Ax workaround */
+		     "mfmsr	%0\n"
+		     "mtmsrd	%0\n"
 		     /* Slot 2 - kernel stack */
 		     "slbmte	%2,%3\n"
+		     /* PA6T Ax workaround */
+		     "mfmsr	%0\n"
+		     "mtmsrd	%0\n"
 		     "isync"
 		     :: "r"(mk_vsid_data(VMALLOC_START, vflags)),
 		        "r"(mk_esid_data(VMALLOC_START, 1)),
Index: 2.6.21/arch/powerpc/mm/slb_low.S
===================================================================
--- 2.6.21.orig/arch/powerpc/mm/slb_low.S
+++ 2.6.21/arch/powerpc/mm/slb_low.S
@@ -221,6 +221,8 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_ISER
 	 * we enter with and the rfid we exit with are context synchronizing.
 	 */
 	slbmte	r11,r10
+	mfmsr	r3
+	mtmsrd	r3
 
 	/* we're done for kernel addresses */
 	crclr	4*cr0+eq		/* set result to "success" */

--
