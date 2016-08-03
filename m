Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s45pF3G7mzDqQn
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Aug 2016 18:29:25 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u738TIZS099068
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Aug 2016 04:29:22 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24k0bmhgra-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Aug 2016 04:29:22 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 3 Aug 2016 18:29:19 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 6031C2BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Aug 2016 18:29:16 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u738TG1j28442704
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Aug 2016 18:29:16 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u738TFNV013752
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Aug 2016 18:29:16 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Yury Norov <ynorov@caviumnetworks.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [RESEND PATCH 2/2] perf/core: Fix the mask in perf_output_sample_regs
Date: Wed,  3 Aug 2016 13:59:07 +0530
In-Reply-To: <1470212947-10473-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1470212947-10473-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1470212947-10473-2-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When decoding the perf_regs mask in perf_output_sample_regs(),
we loop through the mask using find_first_bit and find_next_bit functions.
While the exisitng code works fine in most of the case,
the logic is broken for 32bit kernel (Big Endian).
When reading u64 mask using (u32 *)(&val)[0], find_*_bit() assumes it gets
lower 32bits of u64 but instead gets upper 32bits which is wrong.
Proposed fix is to swap the words of the u64 to handle this case.
This is _not_ endianness swap.

Suggested-by: Yury Norov <ynorov@caviumnetworks.com>
Reviewed-by: Yury Norov <ynorov@caviumnetworks.com>
Cc: Yury Norov <ynorov@caviumnetworks.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 include/linux/bitmap.h |  2 ++
 kernel/events/core.c   |  4 +++-
 lib/bitmap.c           | 19 +++++++++++++++++++
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 27bfc0b631a9..6f2cc9eb12d9 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -188,6 +188,8 @@ extern int bitmap_print_to_pagebuf(bool list, char *buf,
 #define small_const_nbits(nbits) \
 	(__builtin_constant_p(nbits) && (nbits) <= BITS_PER_LONG)
 
+extern void bitmap_from_u64(unsigned long *dst, u64 mask);
+
 static inline void bitmap_zero(unsigned long *dst, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 356a6c7cb52a..f5ed20a63a5e 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5269,8 +5269,10 @@ perf_output_sample_regs(struct perf_output_handle *handle,
 			struct pt_regs *regs, u64 mask)
 {
 	int bit;
+	DECLARE_BITMAP(_mask, 64);
 
-	for_each_set_bit(bit, (const unsigned long *) &mask,
+	bitmap_from_u64(_mask, mask);
+	for_each_set_bit(bit, _mask,
 			 sizeof(mask) * BITS_PER_BYTE) {
 		u64 val;
 
diff --git a/lib/bitmap.c b/lib/bitmap.c
index eca88087fa8a..2b9bda507645 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -1170,3 +1170,22 @@ void bitmap_copy_le(unsigned long *dst, const unsigned long *src, unsigned int n
 }
 EXPORT_SYMBOL(bitmap_copy_le);
 #endif
+
+/*
+ * bitmap_from_u64 - Check and swap words within u64.
+ *  @mask: source bitmap
+ *  @dst:  destination bitmap
+ *
+ * In 32bit Big Endian kernel, when using (u32 *)(&val)[*]
+ * to read u64 mask, we will get wrong word.
+ * That is "(u32 *)(&val)[0]" gets upper 32 bits,
+ * but expected could be lower 32bits of u64.
+ */
+void bitmap_from_u64(unsigned long *dst, u64 mask)
+{
+	dst[0] = mask & ULONG_MAX;
+
+	if (sizeof(mask) > sizeof(unsigned long))
+		dst[1] = mask >> 32;
+}
+EXPORT_SYMBOL(bitmap_from_u64);
-- 
2.7.4
