Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CB76D1A0E00
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 17:37:18 +1000 (AEST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 14 Apr 2015 17:37:17 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 384EE2CE804E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 17:37:15 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3E7b6wL47251534
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 17:37:15 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3E7afgE018352
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 17:36:41 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Subject: [PATCH V2] powerpc/mm: Add trace point for tracking hash pte fault
Date: Tue, 14 Apr 2015 13:05:57 +0530
Message-Id: <1428996957-26176-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

NOTE:
The impact of the tracepoint was not noticeable when running test. It was
within the run-time variance of the test. For ex:

without-patch:
--------------

 Performance counter stats for './a.out 3000 300':

	       643      page-faults               #    0.089 M/sec
	  7.236562      task-clock (msec)         #    0.928 CPUs utilized
	 2,179,213      stalled-cycles-frontend   #    0.00% frontend cycles idle
	17,174,367      stalled-cycles-backend    #    0.00% backend  cycles idle
		 0      context-switches          #    0.000 K/sec

       0.007794658 seconds time elapsed

And with-patch:
---------------

 Performance counter stats for './a.out 3000 300':

	       643      page-faults               #    0.089 M/sec
	  7.233746      task-clock (msec)         #    0.921 CPUs utilized
		 0      context-switches          #    0.000 K/sec

       0.007854876 seconds time elapsed

 Performance counter stats for './a.out 3000 300':

	       643      page-faults               #    0.087 M/sec
	       649      powerpc:hash_fault        #    0.087 M/sec
	  7.430376      task-clock (msec)         #    0.938 CPUs utilized
	 2,347,174      stalled-cycles-frontend   #    0.00% frontend cycles idle
	17,524,282      stalled-cycles-backend    #    0.00% backend  cycles idle
		 0      context-switches          #    0.000 K/sec

       0.007920284 seconds time elapsed

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
