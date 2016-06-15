Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rV4Qj17xDzDqj8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 21:43:24 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5FBY4u7084739
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 07:43:22 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23jfuhh43k-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 07:43:22 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 15 Jun 2016 21:43:19 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 632013578058
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 21:43:02 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5FBh2rP6685140
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 21:43:02 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5FBh1Oe015289
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 21:43:02 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>, Borislav Petkov <bp@suse.de>,
 David Ahern <dsahern@gmail.com>, George Spelvin <linux@horizon.com>,
 Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Wang Nan <wangnan0@huawei.com>, Yury Norov <yury.norov@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] tools/perf: fix the word selected in find_*_bit
Date: Wed, 15 Jun 2016 17:12:53 +0530
Message-Id: <1465990973-31483-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When decoding the perf_regs mask in regs_dump__printf(),
we loop through the mask using find_first_bit and find_next_bit functions.
And mask is of type "u64". But "u64" is send as a "unsigned long *" to
lib functions along with sizeof().

While the exisitng code works fine in most of the case, when using a 32bit perf
on a 64bit kernel (Big Endian), we end reading the wrong word. In find_first_bit(),
one word at a time (based on BITS_PER_LONG) is loaded and
checked for any bit set. In 32bit BE userspace,
BITS_PER_LONG turns out to be 32, and for a mask value of
"0x00000000000000ff", find_first_bit will return 32, instead of 0.
Reason for this is that, value in the word0 is all zeros and value
in word1 is 0xff. Ideally, second word in the mask should be loaded
and searched. Patch swaps the word to look incase of 32bit BE.

Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: David Ahern <dsahern@gmail.com>
Cc: George Spelvin <linux@horizon.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: Yury Norov <yury.norov@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 tools/lib/find_bit.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/lib/find_bit.c b/tools/lib/find_bit.c
index 9122a9e80046..996b3e04324f 100644
--- a/tools/lib/find_bit.c
+++ b/tools/lib/find_bit.c
@@ -37,7 +37,12 @@ static unsigned long _find_next_bit(const unsigned long *addr,
 	if (!nbits || start >= nbits)
 		return nbits;

+#if (__BYTE_ORDER == __BIG_ENDIAN) && (BITS_PER_LONG != 64)
+	tmp = addr[(((nbits - 1)/BITS_PER_LONG) - (start / BITS_PER_LONG))]
+								^ invert;
+#else
 	tmp = addr[start / BITS_PER_LONG] ^ invert;
+#endif

 	/* Handle 1st word. */
 	tmp &= BITMAP_FIRST_WORD_MASK(start);
@@ -48,7 +53,12 @@ static unsigned long _find_next_bit(const unsigned long *addr,
 		if (start >= nbits)
 			return nbits;

+#if (__BYTE_ORDER == __BIG_ENDIAN) && (BITS_PER_LONG != 64)
+		tmp = addr[(((nbits - 1)/BITS_PER_LONG) - (start / BITS_PER_LONG))]
+								^ invert;
+#else
 		tmp = addr[start / BITS_PER_LONG] ^ invert;
+#endif
 	}

 	return min(start + __ffs(tmp), nbits);
@@ -75,8 +85,15 @@ unsigned long find_first_bit(const unsigned long *addr, unsigned long size)
 	unsigned long idx;

 	for (idx = 0; idx * BITS_PER_LONG < size; idx++) {
+#if (__BYTE_ORDER == __BIG_ENDIAN) && (BITS_PER_LONG != 64)
+		if (addr[(((size-1)/BITS_PER_LONG) - idx)])
+			return min(idx * BITS_PER_LONG +
+				__ffs(addr[(((size-1)/BITS_PER_LONG) - idx)]),
+									size);
+#else
 		if (addr[idx])
 			return min(idx * BITS_PER_LONG + __ffs(addr[idx]), size);
+#endif
 	}

 	return size;
--
1.9.1
