Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sDkdm4chhzDr74
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 19:37:00 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7H9Zt7A040058
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 05:36:58 -0400
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24v4cjxbpr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 05:36:58 -0400
Received: from localhost
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 17 Aug 2016 15:06:54 +0530
Received: from d28relay10.in.ibm.com (d28relay10.in.ibm.com [9.184.220.161])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 3E70CE0062
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 15:10:54 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay10.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7H9aLLK34341060
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 15:06:21 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7H9aGL4020526
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 15:06:20 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 peterz@infradead.org, acme@kernel.org
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Yury Norov <ynorov@caviumnetworks.com>, Ingo Molnar <mingo@redhat.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2 2/2] perf/core: Fix the mask in perf_output_sample_regs
Date: Wed, 17 Aug 2016 15:06:08 +0530
In-Reply-To: <1471426568-31051-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1471426568-31051-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1471426568-31051-2-git-send-email-maddy@linux.vnet.ibm.com>
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
Changelog v1:
1)bitmap_from_u64() is inline now

 include/linux/bitmap.h | 18 ++++++++++++++++++
 kernel/events/core.c   |  5 +++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 598bc999f4c2..a9ea992161a1 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -339,6 +339,24 @@ static inline int bitmap_parse(const char *buf, unsigned int buflen,
 	return __bitmap_parse(buf, buflen, 0, maskp, nmaskbits);
 }
 
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
+static inline void bitmap_from_u64(unsigned long *dst, u64 mask)
+{
+	dst[0] = mask & ULONG_MAX;
+
+	if (sizeof(mask) > sizeof(unsigned long))
+		dst[1] = mask >> 32;
+}
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __LINUX_BITMAP_H */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 1903b8f3a705..de32e9bd8189 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5292,9 +5292,10 @@ perf_output_sample_regs(struct perf_output_handle *handle,
 			struct pt_regs *regs, u64 mask)
 {
 	int bit;
+	DECLARE_BITMAP(_mask, 64);
 
-	for_each_set_bit(bit, (const unsigned long *) &mask,
-			 sizeof(mask) * BITS_PER_BYTE) {
+	bitmap_from_u64(_mask, mask);
+	for_each_set_bit(bit, _mask, sizeof(mask) * BITS_PER_BYTE) {
 		u64 val;
 
 		val = perf_reg_value(regs, bit);
-- 
2.7.4
