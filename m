Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6B4781A0DB0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2015 17:10:29 +1000 (AEST)
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B72A4140DC0
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jul 2015 17:10:28 +1000 (AEST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 29 Jul 2015 12:40:24 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 61B2D125806E
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jul 2015 12:43:19 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6T7AAR761341894
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jul 2015 12:40:11 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6T7A6kv001251
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jul 2015 12:40:07 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, mikey@neuling.org
Subject: [PATCH 7/8] powerpc/xmon: Drop the 'valid' variable completely in
 'dump_segments'
Date: Wed, 29 Jul 2015 12:40:04 +0530
Message-Id: <1438153805-31828-7-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1438153805-31828-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1438153805-31828-1-git-send-email-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Value of the 'valid' variable is zero when 'esid' is zero and it does
not matter when 'esid' is non-zero. The variable 'valid' can be dropped
from the function 'dump_segments' by checking for validity of 'esid'
inside the nested code block. This patch does that change.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/xmon/xmon.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index e599259..bc1b066a 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -2731,7 +2731,7 @@ static void xmon_print_symbol(unsigned long address, const char *mid,
 void dump_segments(void)
 {
 	int i;
-	unsigned long esid,vsid,valid;
+	unsigned long esid,vsid;
 	unsigned long llp;
 
 	printf("SLB contents of cpu 0x%x\n", smp_processor_id());
@@ -2739,10 +2739,9 @@ void dump_segments(void)
 	for (i = 0; i < mmu_slb_size; i++) {
 		asm volatile("slbmfee  %0,%1" : "=r" (esid) : "r" (i));
 		asm volatile("slbmfev  %0,%1" : "=r" (vsid) : "r" (i));
-		valid = (esid & SLB_ESID_V);
-		if (valid | esid | vsid) {
+		if (esid || vsid) {
 			printf("%02d %016lx %016lx", i, esid, vsid);
-			if (valid) {
+			if (esid & SLB_ESID_V) {
 				llp = vsid & SLB_VSID_LLP;
 				if (vsid & SLB_VSID_B_1T) {
 					printf("  1T  ESID=%9lx  VSID=%13lx LLP:%3lx \n",
-- 
2.1.0
