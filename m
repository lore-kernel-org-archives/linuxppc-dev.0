Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8F4111A0CFA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 18:44:03 +1000 (AEST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 11 Jun 2015 14:14:00 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id CAC7C125805C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 14:16:28 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5B8hvOk40239244
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 14:13:57 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5B8ht44016352
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 14:13:56 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 sukadev@linux.vnet.ibm.com, eranian@google.com,
 khandual@linux.vnet.ibm.com, rusty@rustcorp.com.au,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH 5/8]powerpc/perf: Define big-endian version of
 perf_mem_data_src
Date: Thu, 11 Jun 2015 14:13:34 +0530
Message-Id: <1434012217-9776-6-git-send-email-maddy@linux.vnet.ibm.com>
In-Reply-To: <1434012217-9776-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1434012217-9776-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

perf_mem_data_src is an union that is initialized via the ->val field
and accessed via the bitmap fields. For this to work on big endian
platforms, we also need a big-endian represenation of perf_mem_data_src.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 include/uapi/linux/perf_event.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 9b79abb..b3f4099 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -747,6 +747,7 @@ enum perf_callchain_context {
 #define PERF_FLAG_PID_CGROUP		(1UL << 2) /* pid=cgroup id, per-cpu mode only */
 #define PERF_FLAG_FD_CLOEXEC		(1UL << 3) /* O_CLOEXEC */
 
+#if defined(__LITTLE_ENDIAN_BITFIELD)
 union perf_mem_data_src {
 	__u64 val;
 	struct {
@@ -758,6 +759,21 @@ union perf_mem_data_src {
 			mem_rsvd:31;
 	};
 };
+#elif defined(__BIG_ENDIAN_BITFIELD)
+union perf_mem_data_src {
+	__u64 val;
+	struct {
+		__u64	mem_rsvd:31,
+			mem_dtlb:7,	/* tlb access */
+			mem_lock:2,	/* lock instr */
+			mem_snoop:5,	/* snoop mode */
+			mem_lvl:14,	/* memory hierarchy level */
+			mem_op:5;	/* type of opcode */
+	};
+};
+#else
+#error "Unknown endianness"
+#endif
 
 /* type of opcode (load/store/prefetch,code) */
 #define PERF_MEM_OP_NA		0x01 /* not available */
-- 
1.9.1
