Return-Path: <lnxtorez@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CB17BDE064
	for <linuxppc-dev@ozlabs.org>; Mon, 18 May 2009 14:51:08 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n4I4mNGD003379
	for <linuxppc-dev@ozlabs.org>; Sun, 17 May 2009 22:48:23 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4I4p58G224570
	for <linuxppc-dev@ozlabs.org>; Sun, 17 May 2009 22:51:05 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n4I4p5Fc004491
	for <linuxppc-dev@ozlabs.org>; Sun, 17 May 2009 22:51:05 -0600
Subject: [PATCH]  bug fix in arch/powerpc/mm/tlb_nohash_low.S
From: Torez Smith <lnxtorez@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Sun, 17 May 2009 23:49:06 -0500
Message-Id: <1242622146.31702.26.camel@torez.austin.ibm.com>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

File arch/powerpc/mm/tlb_nohash_low.S defines various processor specific low level TLB invalidation. Most all family of validations are grouped via pre-processor defines with the intent we error out if we reach the end and our platform is not represented. Given this, the last few lines of the file should look similar to the following....
<<  SNIP  >>
1:      wrtee   r10
        blr
#else
#error Unsupported processor type !
#endif

However, the #else is incorrectly written as #elif.  On some of the newer compilers/assemblers, this will not successfully assemble and will cause an error.

Signed-off-by: Torez Smith  <lnxtorez@linux.vnet.ibm.com>
---

Index: linux-2.6.29/arch/powerpc/mm/tlb_nohash_low.S
===================================================================
--- linux-2.6.29.orig/arch/powerpc/mm/tlb_nohash_low.S	2009-05-17 21:31:20.000000000 -0500
+++ linux-2.6.29/arch/powerpc/mm/tlb_nohash_low.S	2009-05-17 21:31:40.000000000 -0500
@@ -161,6 +161,6 @@
 	isync
 1:	wrtee	r10
 	blr
-#elif
+#else
 #error Unsupported processor type !
 #endif

-- 
Torez Smith
IBM Linux Technology Center
