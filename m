Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C5654DDDE4
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 01:27:12 +1000 (EST)
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by pokfb.esmtp.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	l6AF50g7012736
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 11:05:01 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l6AEuOd9032303
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 10:56:24 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l6AF1paR251508
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 09:01:51 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6AF1ogp026940
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 09:01:51 -0600
Subject: [PATCH] Consolidate mm_context_t definition in mmu.h
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: paulus@samba.org
Content-Type: text/plain
Date: Tue, 10 Jul 2007 10:01:49 -0500
Message-Id: <1184079709.32199.6.camel@weaponx.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, david@gibson.dropbear.id.au
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
header files.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

---
 include/asm-powerpc/mmu-44x.h       |    5 -----
 include/asm-powerpc/mmu-8xx.h       |    4 ----
 include/asm-powerpc/mmu-fsl-booke.h |    4 ----
 include/asm-powerpc/mmu-hash32.h    |    5 -----
 include/asm-powerpc/mmu-hash64.h    |   16 ----------------
 include/asm-powerpc/mmu.h           |   28 ++++++++++++++++++++++++++++
 6 files changed, 28 insertions(+), 34 deletions(-)

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
@@ -19,5 +19,33 @@
 #  include <asm/mmu-8xx.h>
 #endif
 
+#ifndef __ASSEMBLY__
+
+#ifdef CONFIG_PPC64
+typedef unsigned long mm_context_id_t;
+
+typedef struct {
+	mm_context_id_t id;
+	u16 user_psize;		/* page size index */
+
+#ifdef CONFIG_PPC_MM_SLICES
+	u64 low_slices_psize;	/* SLB page size encodings */
+	u64 high_slices_psize;  /* 4 bits per slice for now */
+#else
+	u16 sllp;		/* SLB page size encoding */
+#endif
+	unsigned long vdso_base;
+} mm_context_t;
+
+#else /* !CONFIG_PPC64 */
+
+typedef struct {
+	unsigned long id;
+	unsigned long vdso_base;
+} mm_context_t;
+
+#endif /* CONFIG_PPC64 */
+#endif /* !__ASSEMBLY__ */
+
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_MMU_H_ */
