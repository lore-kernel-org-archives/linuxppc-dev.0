Return-Path: <benh@au1.ibm.com>
Received: from e23smtp05.au.ibm.com (E23SMTP05.au.ibm.com [202.81.18.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A0BEADDEED
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Oct 2007 08:50:04 +1100 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp05.au.ibm.com (8.13.1/8.13.1) with ESMTP id l9RLo1G9014641
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Oct 2007 08:50:01 +1100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9RLrbZe034080
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Oct 2007 08:53:37 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9RLniEW007327
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Oct 2007 08:49:44 +1100
Subject: [PATCH] powerpc: Fix cache line vs. block size confusion
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Sun, 28 Oct 2007 08:49:28 +1100
Message-Id: <1193521768.18243.95.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Ronald L Rockhold <rockhold@us.ibm.com>, Lixin Zhang <zhangl@us.ibm.com>
Reply-To: benh@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We had an historical confusion in the kernel between cache line
and cache block size. The former is an implementation detail of
the L1 cache which can be useful for performance optimisations,
the later is the actual size on which the cache control
instructions operate, which can be different.

For some reason, we had a weird hack reading the right property
on powermac and the wrong one on any other 64 bits (32 bits is
unaffected as it only uses the cputable for cache block size
infos at this stage).

This fixes the booting-without-of.txt documentation to mention
the right properties, and fixes the 64 bits initialization code
to look for the block size first, with a fallback to the line
size if the property is missing.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Note: I didn't update all the .dts files which is fine as only
64 bits currently cares about those properties and the code has
a fallback to the line size property. So they can be fixed
gradually if necessary.

Index: linux-work/Documentation/powerpc/booting-without-of.txt
===================================================================
--- linux-work.orig/Documentation/powerpc/booting-without-of.txt	2007-10-28 08:45:27.000000000 +1100
+++ linux-work/Documentation/powerpc/booting-without-of.txt	2007-10-28 08:45:38.000000000 +1100
@@ -851,12 +851,18 @@ address which can extend beyond that lim
         /cpus/PowerPC,970FX@0
         /cpus/PowerPC,970FX@1
       (unit addresses do not require leading zeroes)
-    - d-cache-line-size : one cell, L1 data cache line size in bytes
-    - i-cache-line-size : one cell, L1 instruction cache line size in
+    - d-cache-block-size : one cell, L1 data cache block size in bytes (*)
+    - i-cache-block-size : one cell, L1 instruction cache block size in
       bytes
     - d-cache-size : one cell, size of L1 data cache in bytes
     - i-cache-size : one cell, size of L1 instruction cache in bytes
 
+(*) The cache "block" size is the size on which the cache management
+instructions operate. Historically, this document used the cache
+"line" size here which is incorrect. The kernel will prefer the cache
+block size and will fallback to cache line size for backward
+compatibility.
+
   Recommended properties:
 
     - timebase-frequency : a cell indicating the frequency of the
@@ -870,6 +876,10 @@ address which can extend beyond that lim
       for the above, the common code doesn't use that property, but
       you are welcome to re-use the pSeries or Maple one. A future
       kernel version might provide a common function for this.
+    - d-cache-line-size : one cell, L1 data cache line size in bytes
+      if different from the block size
+    - i-cache-line-size : one cell, L1 instruction cache line size in
+      bytes if different from the block size
 
   You are welcome to add any property you find relevant to your board,
   like some information about the mechanism used to soft-reset the
Index: linux-work/arch/powerpc/kernel/setup_64.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/setup_64.c	2007-10-28 08:45:27.000000000 +1100
+++ linux-work/arch/powerpc/kernel/setup_64.c	2007-10-28 08:46:19.000000000 +1100
@@ -291,23 +291,16 @@ static void __init initialize_cache_info
 		if ( num_cpus == 1 ) {
 			const u32 *sizep, *lsizep;
 			u32 size, lsize;
-			const char *dc, *ic;
-
-			/* Then read cache informations */
-			if (machine_is(powermac)) {
-				dc = "d-cache-block-size";
-				ic = "i-cache-block-size";
-			} else {
-				dc = "d-cache-line-size";
-				ic = "i-cache-line-size";
-			}
 
 			size = 0;
 			lsize = cur_cpu_spec->dcache_bsize;
 			sizep = of_get_property(np, "d-cache-size", NULL);
 			if (sizep != NULL)
 				size = *sizep;
-			lsizep = of_get_property(np, dc, NULL);
+			lsizep = of_get_property(np, "d-cache-block-size", NULL);
+			/* fallback if block size missing */
+			if (lsizep == NULL)
+				lsizep = of_get_property(np, "d-cache-line-size", NULL);
 			if (lsizep != NULL)
 				lsize = *lsizep;
 			if (sizep == 0 || lsizep == 0)
@@ -324,7 +317,9 @@ static void __init initialize_cache_info
 			sizep = of_get_property(np, "i-cache-size", NULL);
 			if (sizep != NULL)
 				size = *sizep;
-			lsizep = of_get_property(np, ic, NULL);
+			lsizep = of_get_property(np, "i-cache-block-size", NULL);
+			if (lsizep == NULL)
+				lsizep = of_get_property(np, "i-cache-line-size", NULL);
 			if (lsizep != NULL)
 				lsize = *lsizep;
 			if (sizep == 0 || lsizep == 0)
