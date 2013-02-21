Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp04.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 959482C008D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2013 03:47:52 +1100 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 21 Feb 2013 22:15:17 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 26135E0055
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2013 22:18:45 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1LGlgMk17039532
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2013 22:17:43 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1LGlgcE009863
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2013 03:47:44 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [RFC PATCH -V2 02/21] powerpc: Save DAR and DSISR in pt_regs on MCE
Date: Thu, 21 Feb 2013 22:17:09 +0530
Message-Id: <1361465248-10867-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1361465248-10867-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1361465248-10867-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

We were not saving DAR and DSISR on MCE. Save then and also print the values
along with exception details in xmon.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/exceptions-64s.S |    9 +++++++++
 arch/powerpc/xmon/xmon.c             |    2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 0e9c48c..d02e730 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -640,9 +640,18 @@ slb_miss_user_pseries:
 	.align	7
 	.globl machine_check_common
 machine_check_common:
+
+	mfspr	r10,SPRN_DAR
+	std	r10,PACA_EXGEN+EX_DAR(r13)
+	mfspr	r10,SPRN_DSISR
+	stw	r10,PACA_EXGEN+EX_DSISR(r13)
 	EXCEPTION_PROLOG_COMMON(0x200, PACA_EXMC)
 	FINISH_NAP
 	DISABLE_INTS
+	ld	r3,PACA_EXGEN+EX_DAR(r13)
+	lwz	r4,PACA_EXGEN+EX_DSISR(r13)
+	std	r3,_DAR(r1)
+	std	r4,_DSISR(r1)
 	bl	.save_nvgprs
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	.machine_check_exception
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 1f8d2f1..a72e490 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -1423,7 +1423,7 @@ static void excprint(struct pt_regs *fp)
 	printf("    sp: %lx\n", fp->gpr[1]);
 	printf("   msr: %lx\n", fp->msr);
 
-	if (trap == 0x300 || trap == 0x380 || trap == 0x600) {
+	if (trap == 0x300 || trap == 0x380 || trap == 0x600 || trap == 0x200) {
 		printf("   dar: %lx\n", fp->dar);
 		if (trap != 0x380)
 			printf(" dsisr: %lx\n", fp->dsisr);
-- 
1.7.10
