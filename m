Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B15F71A0E50
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2015 22:11:20 +1000 (AEST)
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B8DA41402AD
 for <linuxppc-dev@ozlabs.org>; Mon, 15 Jun 2015 22:11:19 +1000 (AEST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 15 Jun 2015 17:41:17 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 2D6F33940049
 for <linuxppc-dev@ozlabs.org>; Mon, 15 Jun 2015 17:41:15 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5FCBASI3146054
 for <linuxppc-dev@ozlabs.org>; Mon, 15 Jun 2015 17:41:10 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5FBD3Gi024940
 for <linuxppc-dev@ozlabs.org>; Mon, 15 Jun 2015 16:43:04 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: dja@axtens.net, mpe@ellerman.id.au, sukadev@linux.vnet.ibm.com,
 mikey@neuling.org
Subject: [PATCH V9 01/13] powerpc,
 perf: Drop the branch sample when 'from' cannot be fetched
Date: Mon, 15 Jun 2015 17:40:56 +0530
Message-Id: <1434370268-19056-2-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1434370268-19056-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1434370268-19056-1-git-send-email-khandual@linux.vnet.ibm.com>
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
index 12b6384..c246e65 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -452,7 +452,6 @@ static void power_pmu_bhrb_read(struct cpu_hw_events *cpuhw)
 			 *    In this case we need to read the instruction from
 			 *    memory to determine the target/to address.
 			 */
-
 			if (val & BHRB_TARGET) {
 				/* Target branches use two entries
 				 * (ie. computed gotos/XL form)
@@ -463,6 +462,8 @@ static void power_pmu_bhrb_read(struct cpu_hw_events *cpuhw)
 
 				/* Get from address in next entry */
 				val = read_bhrb(r_index++);
+				if (!val)
+					break;
 				addr = val & BHRB_EA;
 				if (val & BHRB_TARGET) {
 					/* Shouldn't have two targets in a
-- 
2.1.0
