Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp06.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 059682C008E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2013 19:36:41 +1100 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 14 Feb 2013 14:03:53 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 3439BE0058
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2013 14:07:22 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1E8aSvr30867598
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2013 14:06:28 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1E8aSef020306
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2013 19:36:28 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, phileas-fogg@mail.ru,
 geoff@infradead.org
Subject: [PATCH 4/4] powerpc: Add vm debug code to catch errors
Date: Thu, 14 Feb 2013 14:06:23 +0530
Message-Id: <1360830983-1812-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1360830983-1812-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <a>
 <1360830983-1812-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

We need to make sure that we don't have higher bits of kernel effective
address set. That would result in multiple kernel segments having same
proto vsid. Add debug code to make sure we capture this.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/mmu-hash64.h |   49 +++++++++++++++++++++++++++++----
 1 file changed, 43 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include/asm/mmu-hash64.h
index 0e08252..3e297ea 100644
--- a/arch/powerpc/include/asm/mmu-hash64.h
+++ b/arch/powerpc/include/asm/mmu-hash64.h
@@ -22,6 +22,13 @@
  */
 #include <asm/pgtable-ppc64.h>
 
+#ifdef CONFIG_DEBUG_VM
+#ifndef __ASSEMBLY__
+#include <asm/udbg.h>
+#include <asm/bug.h>
+#endif
+#endif
+
 /*
  * Segment table
  */
@@ -522,11 +529,32 @@ static inline int user_segment_size(unsigned long addr)
 static inline unsigned long get_vsid(unsigned long context, unsigned long ea,
 				     int ssize)
 {
-	if (ssize == MMU_SEGSIZE_256M)
-		return vsid_scramble((context << USER_ESID_BITS)
-				     | (ea >> SID_SHIFT), 256M);
-	return vsid_scramble((context << USER_ESID_BITS_1T)
-			     | (ea >> SID_SHIFT_1T), 1T);
+	if (ssize == MMU_SEGSIZE_256M) {
+		context = context << USER_ESID_BITS;
+		ea = ea >> SID_SHIFT;
+#ifdef CONFIG_DEBUG_VM
+		/*
+		 * context and ea should not overlap.
+		 */
+		if (context & ea) {
+			udbg_printf("Overlapping bits %lx %lx\n", context, ea);
+			WARN_ON(1);
+		}
+#endif
+		return vsid_scramble(context | ea, 256M);
+	}
+	context = context << USER_ESID_BITS_1T;
+	ea = ea >> SID_SHIFT_1T;
+#ifdef CONFIG_DEBUG_VM
+	/*
+	 * context and ea should not overlap.
+	 */
+	if (context & ea) {
+		udbg_printf("Overlapping bits for 1T %lx %lx\n", context, ea);
+		WARN_ON(1);
+	}
+#endif
+	return vsid_scramble(context | ea, 1T);
 }
 
 /*
@@ -540,11 +568,20 @@ static inline unsigned long get_vsid(unsigned long context, unsigned long ea,
  */
 static inline unsigned long get_kernel_vsid(unsigned long ea, int ssize)
 {
+	unsigned int c_index;
 	unsigned long context;
 	/*
 	 * kernel take the top 4 context from the available range
 	 */
-	context = (MAX_CONTEXT - 4) +  ((ea >> 60) - 0xc);
+	c_index =   ((ea >> 60) - 0xc);
+	context = (MAX_CONTEXT - 4) + c_index;
+#ifdef CONFIG_DEBUG_VM
+	/*
+	 * Drop the c_index related bits from ea, so we get
+	 * non overlapping context and ea.
+	 */
+	ea = ea - ((0xcUL + c_index) << 60);
+#endif
 	return get_vsid(context, ea, ssize);
 }
 #endif /* __ASSEMBLY__ */
-- 
1.7.10
