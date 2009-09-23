Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7384BB7B69
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Sep 2009 14:12:34 +1000 (EST)
Subject: [PATCH] powerpc/mm: Fix 40x and 8xx vs. _PAGE_SPECIAL
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Weirich, Bernhard" <Bernhard.Weirich@riedel.net>,
	Rex Feany <RFeany@mrv.com>
Content-Type: text/plain
Date: Wed, 23 Sep 2009 14:12:26 +1000
Message-Id: <1253679146.7103.270.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The test to check whether we have _PAGE_SPECIAL defined is broken,
since we always define it, just not always to a meaninful value :-)

That broke 8xx and 40x under some circumstances.

This fixes it by adding _PAGE_SPECIAL for both of these since they
had a free PTE bit, and removing the condition around advertising
it.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Bernhard, Rex, please let me know if that works for you.


diff --git a/arch/powerpc/include/asm/pte-40x.h b/arch/powerpc/include/asm/pte-40x.h
index 6c3e1f4..ec0b0b0 100644
--- a/arch/powerpc/include/asm/pte-40x.h
+++ b/arch/powerpc/include/asm/pte-40x.h
@@ -43,6 +43,7 @@
 #define	_PAGE_NO_CACHE	0x004	/* I: caching is inhibited */
 #define	_PAGE_WRITETHRU	0x008	/* W: caching is write-through */
 #define	_PAGE_USER	0x010	/* matches one of the zone permission bits */
+#define	_PAGE_SPECIAL	0x020	/* software: Special page */
 #define	_PAGE_RW	0x040	/* software: Writes permitted */
 #define	_PAGE_DIRTY	0x080	/* software: dirty page */
 #define _PAGE_HWWRITE	0x100	/* hardware: Dirty & RW, set in exception */
diff --git a/arch/powerpc/include/asm/pte-8xx.h b/arch/powerpc/include/asm/pte-8xx.h
index 94e9797..dd5ea95 100644
--- a/arch/powerpc/include/asm/pte-8xx.h
+++ b/arch/powerpc/include/asm/pte-8xx.h
@@ -32,6 +32,7 @@
 #define _PAGE_FILE	0x0002	/* when !present: nonlinear file mapping */
 #define _PAGE_NO_CACHE	0x0002	/* I: cache inhibit */
 #define _PAGE_SHARED	0x0004	/* No ASID (context) compare */
+#define _PAGE_SPECIAL	0x0008	/* SW entry, forced to 0 by the TLB miss */
 
 /* These five software bits must be masked out when the entry is loaded
  * into the TLB.
diff --git a/arch/powerpc/include/asm/pte-common.h b/arch/powerpc/include/asm/pte-common.h
index c3b6507..f2b3701 100644
--- a/arch/powerpc/include/asm/pte-common.h
+++ b/arch/powerpc/include/asm/pte-common.h
@@ -25,9 +25,6 @@
 #ifndef _PAGE_WRITETHRU
 #define _PAGE_WRITETHRU	0
 #endif
-#ifndef _PAGE_SPECIAL
-#define _PAGE_SPECIAL	0
-#endif
 #ifndef _PAGE_4K_PFN
 #define _PAGE_4K_PFN		0
 #endif
@@ -179,7 +176,5 @@ extern unsigned long bad_call_to_PMD_PAGE_SIZE(void);
 #define HAVE_PAGE_AGP
 
 /* Advertise support for _PAGE_SPECIAL */
-#ifdef _PAGE_SPECIAL
 #define __HAVE_ARCH_PTE_SPECIAL
-#endif
 
