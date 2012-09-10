Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp08.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 05A2D2C010F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2012 22:53:17 +1000 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 10 Sep 2012 18:23:15 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q8ACr3kJ39518404
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2012 18:23:04 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q8ACr3W4014885
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2012 22:53:03 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH -V9 01/11] arch/powerpc: Replace open coded CONTEXT_BITS value
Date: Mon, 10 Sep 2012 18:22:47 +0530
Message-Id: <1347281577-5460-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1347281577-5460-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1347281577-5460-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

To clarify the meaning for future readers, replace the open coded
19 with CONTEXT_BITS

Reviewed-by: Paul Mackerras <paulus@samba.org>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/mmu_context_hash64.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/mmu_context_hash64.c b/arch/powerpc/mm/mmu_context_hash64.c
index 40677aa..daa076c 100644
--- a/arch/powerpc/mm/mmu_context_hash64.c
+++ b/arch/powerpc/mm/mmu_context_hash64.c
@@ -34,7 +34,7 @@ static DEFINE_IDA(mmu_context_ida);
  * Each segment contains 2^28 bytes.  Each context maps 2^44 bytes,
  * so we can support 2^19-1 contexts (19 == 35 + 28 - 44).
  */
-#define MAX_CONTEXT	((1UL << 19) - 1)
+#define MAX_CONTEXT	((1UL << CONTEXT_BITS) - 1)
 
 int __init_new_context(void)
 {
-- 
1.7.10
