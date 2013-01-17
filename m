Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e33.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 962BB2C007C
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2013 04:29:53 +1100 (EST)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Thu, 17 Jan 2013 10:29:49 -0700
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
 [9.17.195.228])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id A5FA5C40007
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Jan 2013 10:29:35 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r0HHTkxf225318
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Jan 2013 10:29:46 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r0HHSD7B002116
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Jan 2013 10:28:15 -0700
Date: Thu, 17 Jan 2013 09:28:14 -0800
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: acme@ghostprotocols.net
Subject: [PATCH] perf: Fix PMU format parsing test failure
Message-ID: <20130117172814.GA18882@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org, Anton Blanchard <anton@au1.ibm.com>, jolsa@redhat.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


>From 776e6d7942754f139c27753213c9cf4617536618 Mon Sep 17 00:00:00 2001
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Date: Thu, 17 Jan 2013 09:11:30 -0800
Subject: [PATCH] perf; Fix PMU format parsing test failure

On POWER, the 'perf format parsing' test always fails.

Looks like it is because memset() is being passed number of longs
rather than number of bytes. It is interesting that the test always
passes on my x86 box.

With this patch, the test passes on POWER and continues to pass on x86.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 tools/perf/util/include/linux/bitops.h |    1 +
 tools/perf/util/pmu.c                  |    2 +-
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/tools/perf/util/include/linux/bitops.h b/tools/perf/util/include/linux/bitops.h
index a55d8cf..45cf10a 100644
--- a/tools/perf/util/include/linux/bitops.h
+++ b/tools/perf/util/include/linux/bitops.h
@@ -14,6 +14,7 @@
 #define BITS_TO_LONGS(nr)       DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(long))
 #define BITS_TO_U64(nr)         DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(u64))
 #define BITS_TO_U32(nr)         DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(u32))
+#define BITS_TO_BYTES(nr)       DIV_ROUND_UP(nr, BITS_PER_BYTE)
 
 #define for_each_set_bit(bit, addr, size) \
 	for ((bit) = find_first_bit((addr), (size));		\
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 9bdc60c..b93ff14 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -548,7 +548,7 @@ void perf_pmu__set_format(unsigned long *bits, long from, long to)
 	if (!to)
 		to = from;
 
-	memset(bits, 0, BITS_TO_LONGS(PERF_PMU_FORMAT_BITS));
+	memset(bits, 0, BITS_TO_BYTES(PERF_PMU_FORMAT_BITS));
 	for (b = from; b <= to; b++)
 		set_bit(b, bits);
 }
-- 
1.7.1
