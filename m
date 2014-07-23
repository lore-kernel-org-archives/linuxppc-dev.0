Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2B7C81A044D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 17:31:45 +1000 (EST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 07/10] selftests/powerpc: Dump MMCR2 as part of the EBB HW
 state
Date: Wed, 23 Jul 2014 17:31:37 +1000
Message-Id: <1406100700-9702-7-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1406100700-9702-1-git-send-email-mpe@ellerman.id.au>
References: <1406100700-9702-1-git-send-email-mpe@ellerman.id.au>
Cc: sam.bobroff@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/powerpc/pmu/ebb/ebb.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/powerpc/pmu/ebb/ebb.c b/tools/testing/selftests/powerpc/pmu/ebb/ebb.c
index b7ee607c0fca..d7a72ce696b5 100644
--- a/tools/testing/selftests/powerpc/pmu/ebb/ebb.c
+++ b/tools/testing/selftests/powerpc/pmu/ebb/ebb.c
@@ -224,6 +224,7 @@ void dump_ebb_hw_state(void)
 
 	printf("HW state:\n"		\
 	       "MMCR0 0x%016x %s\n"	\
+	       "MMCR2 0x%016lx\n"	\
 	       "EBBHR 0x%016lx\n"	\
 	       "BESCR 0x%016llx %s\n"	\
 	       "PMC1  0x%016lx\n"	\
@@ -233,10 +234,11 @@ void dump_ebb_hw_state(void)
 	       "PMC5  0x%016lx\n"	\
 	       "PMC6  0x%016lx\n"	\
 	       "SIAR  0x%016lx\n",
-	       mmcr0, decode_mmcr0(mmcr0), mfspr(SPRN_EBBHR), bescr,
-	       decode_bescr(bescr), mfspr(SPRN_PMC1), mfspr(SPRN_PMC2),
-	       mfspr(SPRN_PMC3), mfspr(SPRN_PMC4), mfspr(SPRN_PMC5),
-	       mfspr(SPRN_PMC6), mfspr(SPRN_SIAR));
+	       mmcr0, decode_mmcr0(mmcr0), mfspr(SPRN_MMCR2),
+	       mfspr(SPRN_EBBHR), bescr, decode_bescr(bescr),
+	       mfspr(SPRN_PMC1), mfspr(SPRN_PMC2), mfspr(SPRN_PMC3),
+	       mfspr(SPRN_PMC4), mfspr(SPRN_PMC5), mfspr(SPRN_PMC6),
+	       mfspr(SPRN_SIAR));
 }
 
 void dump_ebb_state(void)
-- 
1.9.1
