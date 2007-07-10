Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2CEAFDDE46
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 03:52:35 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6AHqWGQ022226
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 13:52:32 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l6AHqWea222732
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 11:52:32 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6AHqV2Z007438
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 11:52:32 -0600
Subject: [PATCH v2] Consolidate mm_context_t definition in mmu.h
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: paulus@samba.org
Content-Type: text/plain
Date: Tue, 10 Jul 2007 12:52:30 -0500
Message-Id: <1184089950.32199.24.camel@weaponx.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, arnd@arndb.de, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

All of the platforms except PPC64 share a common mm_context_t definition.
Defining it in mmu.h avoids duplicating it in the platform specific mmu
header files.  We further consolidate it by having the PPC32 definition
share the mm_context_id_t type for the id member.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

---
 include/asm-powerpc/mmu-44x.h       |    5 -----
 include/asm-powerpc/mmu-8xx.h       |    4 ----
 include/asm-powerpc/mmu-fsl-booke.h |    4 ----
 include/asm-powerpc/mmu-hash32.h    |    5 -----
 include/asm-powerpc/mmu-hash64.h    |   16 ----------------
 include/asm-powerpc/mmu.h           |   21 +++++++++++++++++++++
 6 files changed, 21 insertions(+), 34 deletions(-)

--- linux-2.6.orig/include/asm-powerpc/mmu-44x.h
+++ linux-2.6/include/asm-powerpc/mmu-44x.h
@@ -55,11 +55,6 @@
 
 typedef unsigned long long phys_addr_t;
 
-typedef struct {
-	unsigned long id;
-	unsigned long vdso_base;
-} mm_context_t;
-
 #endif /* !__ASSEMBLY__ */
 
 #ifndef CONFIG_PPC_EARLY_DEBUG_44x
--- linux-2.6.orig/include/asm-powerpc/mmu-8xx.h
+++ linux-2.6/include/asm-powerpc/mmu-8xx.h
@@ -138,10 +138,6 @@
 #ifndef __ASSEMBLY__
 typedef unsigned long phys_addr_t;
 
-typedef struct {
-	unsigned long id;
-	unsigned long vdso_base;
-} mm_context_t;
 #endif /* !__ASSEMBLY__ */
 
 #endif /* _ASM_POWERPC_MMU_8XX_H_ */
--- linux-2.6.orig/include/asm-powerpc/mmu-fsl-booke.h
+++ linux-2.6/include/asm-powerpc/mmu-fsl-booke.h
@@ -79,10 +79,6 @@ typedef unsigned long phys_addr_t;
 typedef unsigned long long phys_addr_t;
 #endif
 
-typedef struct {
-	unsigned long id;
-	unsigned long vdso_base;
-} mm_context_t;
 #endif /* !__ASSEMBLY__ */
 
 #endif /* _ASM_POWERPC_MMU_FSL_BOOKE_H_ */
--- linux-2.6.orig/include/asm-powerpc/mmu-hash32.h
+++ linux-2.6/include/asm-powerpc/mmu-hash32.h
@@ -79,11 +79,6 @@ struct hash_pte {
 	unsigned long pp:2;	/* Page protection */
 };
 
-typedef struct {
-	unsigned long id;
-	unsigned long vdso_base;
-} mm_context_t;
-
 typedef unsigned long phys_addr_t;
 
 #endif /* !__ASSEMBLY__ */
--- linux-2.6.orig/include/asm-powerpc/mmu-hash64.h
+++ linux-2.6/include/asm-powerpc/mmu-hash64.h
@@ -359,22 +359,6 @@ extern void stab_initialize(unsigned lon
 
 #ifndef __ASSEMBLY__
 
-typedef unsigned long mm_context_id_t;
-
-typedef struct {
-	mm_context_id_t id;
-	u16 user_psize;		/* page size index */
-
-#ifdef CONFIG_PPC_MM_SLICES
-	u64 low_slices_psize;	/* SLB page size encodings */
-	u64 high_slices_psize;  /* 4 bits per slice for now */
-#else
-	u16 sllp;		/* SLB page size encoding */
-#endif
-	unsigned long vdso_base;
-} mm_context_t;
-
-
 static inline unsigned long vsid_scramble(unsigned long protovsid)
 {
 #if 0
--- linux-2.6.orig/include/asm-powerpc/mmu.h
+++ linux-2.6/include/asm-powerpc/mmu.h
@@ -19,5 +19,26 @@
 #  include <asm/mmu-8xx.h>
 #endif
 
+#ifndef __ASSEMBLY__
+
+typedef unsigned long mm_context_id_t;
+
+typedef struct {
+	mm_context_id_t id;
+#ifdef CONFIG_PPC64
+	u16 user_psize;		/* page size index */
+
+#ifdef CONFIG_PPC_MM_SLICES
+	u64 low_slices_psize;	/* SLB page size encodings */
+	u64 high_slices_psize;  /* 4 bits per slice for now */
+#else
+	u16 sllp;		/* SLB page size encoding */
+#endif
+#endif /* CONFIG_PPC64 */
+	unsigned long vdso_base;
+} mm_context_t;
+
+#endif /* !__ASSEMBLY__ */
+
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_MMU_H_ */
