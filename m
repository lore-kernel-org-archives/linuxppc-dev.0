Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 22BBB2C0373
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Oct 2013 13:07:17 +1100 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 15 Oct 2013 20:07:16 -0600
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
 [9.17.195.228])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 83FEC3E4004E
 for <linuxppc-dev@ozlabs.org>; Tue, 15 Oct 2013 20:07:13 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9G27Dap300600
 for <linuxppc-dev@ozlabs.org>; Tue, 15 Oct 2013 20:07:13 -0600
Received: from d03av04.boulder.ibm.com (localhost [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9G27CwJ022902
 for <linuxppc-dev@ozlabs.org>; Tue, 15 Oct 2013 20:07:12 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: [PATCH 08/10][v6] powerpc/perf: Define big-endian version of
 perf_mem_data_src
Date: Tue, 15 Oct 2013 19:06:40 -0700
Message-Id: <1381889202-16826-9-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1381889202-16826-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1381889202-16826-1-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: Michael Ellerman <michaele@au1.ibm.com>, linux-kernel@vger.kernel.org,
 Stephane Eranian <eranian@google.com>, linuxppc-dev@ozlabs.org,
 Paul Mackerras <paulus@samba.org>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

perf_mem_data_src is an union that is initialized via the ->val field
and accessed via the bitmap fields. For this to work on big endian
platforms, we also need a big-endian represenation of perf_mem_data_src.

Cc: Stephane Eranian <eranian@google.com>
Cc: Michael Ellerman <michael@ellerman.id.au>
Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
Changelog [v6]
	- [Michael Ellerman] Use __BIG_ENDIAN_BITFIELD to simplify the
	  endian check.

Changelog [v5]:
	- perf_event.h includes <byteorder.h> which pulls in the local
	  byteorder.h when building the perf tool. This local byteorder.h
	  leaves __LITTLE_ENDIAN and __BIG_ENDIAN undefined.
	  Include <endian.h> explicitly in the local byteorder.h.

Changelog [v2]:
	- [Vince Weaver, Michael Ellerman] No __KERNEL__ in uapi headers.

 include/uapi/linux/perf_event.h |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index ca1d90b..383052b7 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -695,6 +695,7 @@ enum perf_callchain_context {
 #define PERF_FLAG_FD_OUTPUT		(1U << 1)
 #define PERF_FLAG_PID_CGROUP		(1U << 2) /* pid=cgroup id, per-cpu mode only */
 
+#if defined(__LITTLE_ENDIAN_BITFIELD)
 union perf_mem_data_src {
 	__u64 val;
 	struct {
@@ -706,6 +707,21 @@ union perf_mem_data_src {
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
1.7.9.5
