Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp01.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6FC0D2C037A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2013 05:32:20 +1100 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 12 Feb 2013 23:59:45 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id E0F5D394004F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2013 00:01:59 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1CIVtPk27983944
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2013 00:01:56 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1CIVuAQ012239
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2013 05:31:57 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 2/2] powerpc: Make context bits depend on virtual addr size.
Date: Wed, 13 Feb 2013 00:01:45 +0530
Message-Id: <1360693905-23503-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1360693905-23503-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1360693905-23503-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

Different platforms supports different virtual addr size(n bits). We need to mak sure
0:77-n bits of the VA generated is forced to zero.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/mmu-hash64.h |   22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include/asm/mmu-hash64.h
index 5f8c2bd..839efae 100644
--- a/arch/powerpc/include/asm/mmu-hash64.h
+++ b/arch/powerpc/include/asm/mmu-hash64.h
@@ -381,7 +381,27 @@ extern void slb_set_size(u16 size);
  * hash collisions.
  */
 
-#define CONTEXT_BITS		19
+/*
+ * Be careful with this value. This determines the VSID_MODULUS_*  and that
+ * need to be co-prime with VSID_MULTIPLIER*
+ */
+#if defined(CONFIG_POWER6_CPU) || defined(CONFIG_POWER7_CPU)
+/*
+ * Even if cpu support 68 bits, we limit this to 66 because
+ * we support only 2^19 context.
+ */
+#define MAX_VIRTUAL_ADDR_BITS 66
+#else
+/* power4,power 5 and cell is 65 */
+#define MAX_VIRTUAL_ADDR_BITS 65
+#endif
+
+/*
+ * One bit is taken by the kernel, only the rest of space is available for the
+ * user space.
+ */
+#define CONTEXT_BITS		(MAX_VIRTUAL_ADDR_BITS - \
+				 (USER_ESID_BITS + SID_SHIFT + 1))
 #define USER_ESID_BITS		18
 #define USER_ESID_BITS_1T	6
 
-- 
1.7.10
