Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 41BB92C0289
 for <linuxppc-dev@ozlabs.org>; Sun, 11 Aug 2013 03:52:26 +1000 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Sat, 10 Aug 2013 18:52:22 +0100
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 48C4A38C8027
 for <linuxppc-dev@ozlabs.org>; Sat, 10 Aug 2013 13:52:18 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7AHqJSp127982
 for <linuxppc-dev@ozlabs.org>; Sat, 10 Aug 2013 13:52:19 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r7AHqICC006523
 for <linuxppc-dev@ozlabs.org>; Sat, 10 Aug 2013 13:52:19 -0400
Date: Sat, 10 Aug 2013 10:51:54 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 5/7] powerpc/perf: Define big-endian version of
 perf_mem_data_src
Message-ID: <20130810175153.GF15551@us.ibm.com>
References: <20130810174831.GA15551@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130810174831.GA15551@us.ibm.com>
Cc: Anton Blanchard <anton@au1.ibm.com>, Paul Mackerras <paulus@samba.org>,
 Stephane Eranian <eranian@google.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


[PATCH 5/7] powerpc/perf: Define big-endian version of perf_mem_data_src

perf_mem_data_src is an union that is initialized via the ->val field
and accessed via the bitmap fields. For this to work on big endian
platforms, we also need a big-endian represenation of perf_mem_data_src.

Cc: Stephane Eranian <eranian@google.com>
Cc: Paul Mckerras <paulus@samba.org>
Cc: Michael Ellerman <michael@ellerman.id.au>
Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---

Thanks to input from Stephane Eranian and Michael Ellerman.

 include/uapi/linux/perf_event.h |   55 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 55 insertions(+), 0 deletions(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 62c25a2..8497c51 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -19,6 +19,47 @@
 #include <asm/byteorder.h>
 
 /*
+ * Kernel and userspace check for endianness in incompatible ways.
+ * In user space, <endian.h> defines both __BIG_ENDIAN and __LITTLE_ENDIAN
+ * but sets __BYTE_ORDER to one or the other. So user space uses checks are:
+ *
+ *	#if __BYTE_ORDER == __LITTLE_ENDIAN
+ *
+ * In the kernel, __BYTE_ORDER is undefined, so using the above check doesn't
+ * work. Further, kernel code assumes that exactly one of __BIG_ENDIAN and
+ * __LITTLE_ENDIAN is defined.  So the kernel checks are like:
+ *
+ *	#if defined(__LITTLE_ENDIAN)
+ *
+ * But we can't use that check in user space since __LITTLE_ENDIAN (and
+ * __BIG_ENDIAN) are always defined.
+ *
+ * Since some perf data structures depend on endianness _and_ are shared
+ * between kernel and user, perf needs its own notion of endian macros (at
+ * least until user and kernel endian checks converge).
+ */
+#define __PERF_LE	1234
+#define __PERF_BE	4321
+
+#if defined(__KERNEL__)
+
+#if defined(__LITTLE_ENDIAN)
+#define __PERF_BYTE_ORDER	__PERF_LE
+#elif defined(__BIG_ENDIAN)
+#define __PERF_BYTE_ORDER	__PERF_BE
+#endif
+
+#else /* __KERNEL__ */
+
+#if __BYTE_ORDER == __LITTLE_ENDIAN
+#define __PERF_BYTE_ORDER	__PERF_LE
+#elif __BYTE_ORDER == __BIG_ENDIAN
+#define __PERF_BYTE_ORDER	__PERF_BE
+#endif
+
+#endif /* __KERNEL__ */
+
+/*
  * User-space ABI bits:
  */
 
@@ -659,6 +700,7 @@ enum perf_callchain_context {
 #define PERF_FLAG_FD_OUTPUT		(1U << 1)
 #define PERF_FLAG_PID_CGROUP		(1U << 2) /* pid=cgroup id, per-cpu mode only */
 
+#if __PERF_BYTE_ORDER == __PERF_LE
 union perf_mem_data_src {
 	__u64 val;
 	struct {
@@ -670,6 +712,19 @@ union perf_mem_data_src {
 			mem_rsvd:31;
 	};
 };
+#elif __PERF_BYTE_ORDER == __PERF_BE
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
+#endif
 
 /* type of opcode (load/store/prefetch,code) */
 #define PERF_MEM_OP_NA		0x01 /* not available */
-- 
1.7.1
