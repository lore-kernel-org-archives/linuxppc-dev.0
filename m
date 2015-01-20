Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 14E041A0DA2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jan 2015 22:36:04 +1100 (AEDT)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 20 Jan 2015 17:06:02 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id BCA49E0044
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jan 2015 17:07:11 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0KBZvBT30146792
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jan 2015 17:05:57 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0KBZuaW002159
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jan 2015 17:05:56 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Subject: [PATCH] powerpc/mm: Add trace point for tracking hash pte fault
Date: Tue, 20 Jan 2015 17:05:50 +0530
Message-Id: <1421753750-17135-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

This enables us to understand how many hash fault we are taking
when running benchmarks.

For ex:
-bash-4.2# ./perf stat -e  powerpc:hash_fault -e page-faults /tmp/ebizzy.ppc64 -S 30  -P -n 1000
...

 Performance counter stats for '/tmp/ebizzy.ppc64 -S 30 -P -n 1000':

       1,10,04,075      powerpc:hash_fault
       1,10,03,429      page-faults

      30.865978991 seconds time elapsed

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/trace.h | 21 +++++++++++++++++++++
 arch/powerpc/mm/hash_utils_64.c  |  2 ++
 2 files changed, 23 insertions(+)

diff --git a/arch/powerpc/include/asm/trace.h b/arch/powerpc/include/asm/trace.h
index c15da6073cb8..ded56b183888 100644
--- a/arch/powerpc/include/asm/trace.h
+++ b/arch/powerpc/include/asm/trace.h
@@ -142,8 +142,29 @@ TRACE_EVENT_FN(opal_exit,
 
 	opal_tracepoint_regfunc, opal_tracepoint_unregfunc
 );
+
 #endif
 
+TRACE_EVENT(hash_fault,
+
+	    TP_PROTO(unsigned long addr, unsigned long access, unsigned long trap),
+	    TP_ARGS(addr, access, trap),
+	    TP_STRUCT__entry(
+		    __field(unsigned long, addr)
+		    __field(unsigned long, access)
+		    __field(unsigned long, trap)
+		    ),
+
+	    TP_fast_assign(
+		    __entry->addr = addr;
+		    __entry->access = access;
+		    __entry->trap = trap;
+		    ),
+
+	    TP_printk("hash fault with addr 0x%lx and access = 0x%lx trap = 0x%lx",
+		      __entry->addr, __entry->access, __entry->trap)
+);
+
 #endif /* _TRACE_POWERPC_H */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 2c2022d16059..7e88470a876f 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -57,6 +57,7 @@
 #include <asm/fadump.h>
 #include <asm/firmware.h>
 #include <asm/tm.h>
+#include <asm/trace.h>
 
 #ifdef DEBUG
 #define DBG(fmt...) udbg_printf(fmt)
@@ -1004,6 +1005,7 @@ int hash_page_mm(struct mm_struct *mm, unsigned long ea,
 
 	DBG_LOW("hash_page(ea=%016lx, access=%lx, trap=%lx\n",
 		ea, access, trap);
+	trace_hash_fault(ea, access, trap);
 
 	/* Get region & vsid */
  	switch (REGION_ID(ea)) {
-- 
2.1.0
