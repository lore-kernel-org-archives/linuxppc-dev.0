Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40GwdF6N8KzF1pk
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Apr 2018 18:16:01 +1000 (AEST)
Received: by mail-pl0-x241.google.com with SMTP id v18-v6so16106632ply.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Apr 2018 01:16:01 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Stewart Smith <stewart@linux.ibm.com>
Subject: [PATCH 1/6] powerpc/powernv: define a standard delay for OPAL_BUSY
 type retry loops
Date: Thu,  5 Apr 2018 18:15:42 +1000
Message-Id: <20180405081547.13266-2-npiggin@gmail.com>
In-Reply-To: <20180405081547.13266-1-npiggin@gmail.com>
References: <20180405081547.13266-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is the start of an effort to tidy up and standardise all the
delays. Existing loops have a range of delay/sleep periods from 1ms
to 20ms, and some have no delay. They all loop forever except rtc,
which times out after 10 retries, and that uses 10ms delays. So use
10ms as our standard delay. The OPAL maintainer agrees 10ms is a
reasonable starting point.

The idea is to use the same recipe everywhere, once this is proven to
work then it will be documented as an OPAL API standard. Then both
firmware and OS can agree, and if a particular call needs something
else, then that can be documented with reasoning.

This is not the end-all of this effort, it's just a relatively easy
change that fixes some existing high latency delays. There should be
provision for standardising timeouts and/or interruptible loops where
possible, so non-fatal firmware errors don't cause hangs.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/opal.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 12e70fb58700..fcf3ed5b8b18 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -21,6 +21,9 @@
 /* We calculate number of sg entries based on PAGE_SIZE */
 #define SG_ENTRIES_PER_NODE ((PAGE_SIZE - 16) / sizeof(struct opal_sg_entry))
 
+/* Default time to sleep or delay between OPAL_BUSY/OPAL_BUSY_EVENT loops */
+#define OPAL_BUSY_DELAY_MS	10
+
 /* /sys/firmware/opal */
 extern struct kobject *opal_kobj;
 
-- 
2.16.3
