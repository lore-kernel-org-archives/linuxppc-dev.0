Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w295W4CBbzDq7q
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 11:51:43 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3B1mXL2065526
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 21:51:35 -0400
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29rhv7gjyn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 21:51:35 -0400
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Tue, 11 Apr 2017 07:21:32 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay10.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3B1o8Ge7667714
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 07:20:08 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3B1pQsx029742
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 07:21:28 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org, sukadev@linux.vnet.ibm.com,
 andrew.donnellan@au1.ibm.com, peterz@infradead.org, mingo@redhat.com,
 acme@kernel.org, alexander.shishkin@linux.intel.com,
 wangnan0@huawei.com, ast@kernel.org, eranian@google.com,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v3 1/6] powerpc/perf: Define big-endian version of
 perf_mem_data_src
Date: Tue, 11 Apr 2017 07:21:05 +0530
In-Reply-To: <1491875470-17904-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1491875470-17904-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1491875470-17904-2-git-send-email-maddy@linux.vnet.ibm.com>
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
platforms (Which is broken now), we also need a big-endian represenation
of perf_mem_data_src. i.e, in a big endian system, if user request
PERF_SAMPLE_DATA_SRC (perf report -d), will get the default value from
perf_sample_data_init(), which is PERF_MEM_NA. Value for PERF_MEM_NA
is constructed using shifts:

  /* TLB access */
  #define PERF_MEM_TLB_NA		0x01 /* not available */
  ...
  #define PERF_MEM_TLB_SHIFT	26

  #define PERF_MEM_S(a, s) \
	(((__u64)PERF_MEM_##a##_##s) << PERF_MEM_##a##_SHIFT)

  #define PERF_MEM_NA (PERF_MEM_S(OP, NA)   |\
		    PERF_MEM_S(LVL, NA)   |\
		    PERF_MEM_S(SNOOP, NA) |\
		    PERF_MEM_S(LOCK, NA)  |\
		    PERF_MEM_S(TLB, NA))

Which works out as:

  ((0x01 << 0) | (0x01 << 5) | (0x01 << 19) | (0x01 << 24) | (0x01 << 26))

Which means the PERF_MEM_NA value comes out of the kernel as 0x5080021
in CPU endian.

But then in the perf tool, the code uses the bitfields to inspect the
value, and currently the bitfields are defined using little endian
ordering.

So eg. in perf_mem__tlb_scnprintf() we see:
  data_src->val = 0x5080021
             op = 0x0
            lvl = 0x0
          snoop = 0x0
           lock = 0x0
           dtlb = 0x0
           rsvd = 0x5080021

Patch does a minimal fix of adding big endian definition of the bitfields
to match the values that are already exported by the kernel on big endian.
And it makes no change on little endian.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 include/uapi/linux/perf_event.h       | 16 ++++++++++++++++
 tools/include/uapi/linux/perf_event.h | 16 ++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index c66a485a24ac..c4af1159a200 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -891,6 +891,7 @@ enum perf_callchain_context {
 #define PERF_FLAG_PID_CGROUP		(1UL << 2) /* pid=cgroup id, per-cpu mode only */
 #define PERF_FLAG_FD_CLOEXEC		(1UL << 3) /* O_CLOEXEC */
 
+#if defined(__LITTLE_ENDIAN_BITFIELD)
 union perf_mem_data_src {
 	__u64 val;
 	struct {
@@ -902,6 +903,21 @@ union perf_mem_data_src {
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
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index c66a485a24ac..c4af1159a200 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -891,6 +891,7 @@ enum perf_callchain_context {
 #define PERF_FLAG_PID_CGROUP		(1UL << 2) /* pid=cgroup id, per-cpu mode only */
 #define PERF_FLAG_FD_CLOEXEC		(1UL << 3) /* O_CLOEXEC */
 
+#if defined(__LITTLE_ENDIAN_BITFIELD)
 union perf_mem_data_src {
 	__u64 val;
 	struct {
@@ -902,6 +903,21 @@ union perf_mem_data_src {
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
2.7.4
