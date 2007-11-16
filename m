Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DACEDDDE0D
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Nov 2007 04:28:31 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lAGHSSDW013560
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Nov 2007 12:28:28 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lAGHSOM4046660
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Nov 2007 10:28:26 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lAGHSOqw026830
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Nov 2007 10:28:24 -0700
Date: Fri, 16 Nov 2007 11:28:22 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: vitb@kernel.crashing.org, benh@kernel.crashing.org
Subject: [POWERPC] [RFC] Fix 8xx tlbie definition
Message-ID: <20071116112822.37a238c0@weaponx>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Git commit e701d269aa28996f3502780951fe1b12d5d66b49 introduced an incorrect
definition for _tlbie on PowerPC 8xx platforms.  Only the address should be
passed to the function.  This patch corrects the definition of _tlbie and the
related tlb flushing functions for 8xx.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

Index: linux-2.6/include/asm-powerpc/tlbflush.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/tlbflush.h
+++ linux-2.6/include/asm-powerpc/tlbflush.h
@@ -28,19 +28,33 @@
 
 #include <linux/mm.h>
 
+#if defined(CONFIG_8xx)
+/* 8xx doesn't use PID for TLB invalidates */
+extern void _tlbie(unsigned address);
+#define _tlbia()	asm volatile ("tlbia; sync" : : : "memory")
+
+static inline void flush_tlb_page(struct vm_area_struct *vma,
+				  unsigned long vmaddr)
+{
+	_tlbie(vmaddr);
+}
+
+static inline void flush_tlb_page_nohash(struct vm_area_struct *vma,
+					 unsigned long vmaddr)
+{
+	_tlbie(vmaddr);
+}
+
+#else /* 4xx or FSL_BOOKE */
+
 extern void _tlbie(unsigned long address, unsigned int pid);
 
-#if defined(CONFIG_40x) || defined(CONFIG_8xx)
+#if defined(CONFIG_40x)
 #define _tlbia()	asm volatile ("tlbia; sync" : : : "memory")
 #else /* CONFIG_44x || CONFIG_FSL_BOOKE */
 extern void _tlbia(void);
 #endif
 
-static inline void flush_tlb_mm(struct mm_struct *mm)
-{
-	_tlbia();
-}
-
 static inline void flush_tlb_page(struct vm_area_struct *vma,
 				  unsigned long vmaddr)
 {
@@ -53,6 +67,13 @@ static inline void flush_tlb_page_nohash
 	_tlbie(vmaddr, vma->vm_mm->context.id);
 }
 
+#endif /* CONFIG_8xx */
+
+static inline void flush_tlb_mm(struct mm_struct *mm)
+{
+	_tlbia();
+}
+
 static inline void flush_tlb_range(struct vm_area_struct *vma,
 				   unsigned long start, unsigned long end)
 {
