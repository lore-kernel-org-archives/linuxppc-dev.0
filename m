Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D86241A17C7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2015 18:20:41 +1000 (AEST)
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 092A51402CC
 for <linuxppc-dev@ozlabs.org>; Tue, 30 Jun 2015 18:20:40 +1000 (AEST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 30 Jun 2015 13:50:38 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 14663394005C
 for <linuxppc-dev@ozlabs.org>; Tue, 30 Jun 2015 13:50:37 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5U8KWwr54264046
 for <linuxppc-dev@ozlabs.org>; Tue, 30 Jun 2015 13:50:33 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5U7DMa9029611
 for <linuxppc-dev@ozlabs.org>; Tue, 30 Jun 2015 12:43:23 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: mikey@neuling.org, sukadev@linux.vnet.ibm.com, dja@axtens.net,
 mpe@ellerman.id.au
Subject: [PATCH 1/5] powerpc/perf: Drop the branch sample when 'from' cannot
 be fetched
Date: Tue, 30 Jun 2015 13:50:27 +0530
Message-Id: <1435652431-22024-2-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1435652431-22024-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1435652431-22024-1-git-send-email-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

BHRB (Branch History Rolling Buffer) is a rolling buffer. Hence we
might end up in a situation where we have read one target address
but when we try to read the next entry indicating the from address
of the target address, the buffer just overflows. In this case, the
captured from address will be zero which indicates the end of the
buffer.

	This patch drops the entire branch record which would have
otherwise confused the user space tools.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/perf/core-book3s.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index d90893b..b0c2d53 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -461,7 +461,6 @@ static void power_pmu_bhrb_read(struct cpu_hw_events *cpuhw)
 			 *    In this case we need to read the instruction from
 			 *    memory to determine the target/to address.
 			 */
-
 			if (val & BHRB_TARGET) {
 				/* Target branches use two entries
 				 * (ie. computed gotos/XL form)
@@ -472,6 +471,8 @@ static void power_pmu_bhrb_read(struct cpu_hw_events *cpuhw)
 
 				/* Get from address in next entry */
 				val = read_bhrb(r_index++);
+				if (!val)
+					break;
 				addr = val & BHRB_EA;
 				if (val & BHRB_TARGET) {
 					/* Shouldn't have two targets in a
-- 
2.1.0
