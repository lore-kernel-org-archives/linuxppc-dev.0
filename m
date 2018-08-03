Return-Path: <arbab@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41hYLp5TWhzF12N
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Aug 2018 14:03:46 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w733xDeN104417
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Aug 2018 00:03:43 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2kmahv9w9f-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Aug 2018 00:03:43 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <arbab@linux.ibm.com>;
 Thu, 2 Aug 2018 22:03:42 -0600
From: Reza Arbab <arbab@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alistair Popple <alistair@popple.id.au>
Subject: [PATCH] powerpc/powernv: Fix concurrency issue with
 npu->mmio_atsd_usage
Date: Thu,  2 Aug 2018 23:03:36 -0500
Message-Id: <1533269016-16238-1-git-send-email-arbab@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We've encountered a performance issue when multiple processors stress
{get,put}_mmio_atsd_reg(). These functions contend for mmio_atsd_usage,
an unsigned long used as a bitmask.

The accesses to mmio_atsd_usage are done using test_and_set_bit_lock()
and clear_bit_unlock(). As implemented, both of these will require a
(successful) stwcx to that same cache line.

What we end up with is thread A, attempting to unlock, being slowed by
other threads repeatedly attempting to lock. A's stwcx instructions fail
and retry because the memory reservation is lost every time a different
thread beats it to the punch.

There may be a long-term way to fix this at a larger scale, but for now
resolve the immediate problem by gating our call to
test_and_set_bit_lock() with one to test_bit(), which is obviously
implemented without using a store.

Signed-off-by: Reza Arbab <arbab@linux.ibm.com>
---
 arch/powerpc/platforms/powernv/npu-dma.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
index 8cdf91f..c773465 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -437,8 +437,9 @@ static int get_mmio_atsd_reg(struct npu *npu)
 	int i;
 
 	for (i = 0; i < npu->mmio_atsd_count; i++) {
-		if (!test_and_set_bit_lock(i, &npu->mmio_atsd_usage))
-			return i;
+		if (!test_bit(i, &npu->mmio_atsd_usage))
+			if (!test_and_set_bit_lock(i, &npu->mmio_atsd_usage))
+				return i;
 	}
 
 	return -ENOSPC;
-- 
1.8.3.1
