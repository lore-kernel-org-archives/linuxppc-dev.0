Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vdwZs4wMtzDqXh
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Mar 2017 14:18:29 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2939HIM065744
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Mar 2017 22:18:26 -0500
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 292msdkfsn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Mar 2017 22:18:26 -0500
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Thu, 9 Mar 2017 13:18:23 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v293IEFD46858380
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Mar 2017 14:18:22 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v293HnbN025685
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Mar 2017 14:17:49 +1100
Received: from ozlabs.au.ibm.com (ozlabs.au.ibm.com [9.192.253.14])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 v293HnNZ024861
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Mar 2017 14:17:49 +1100
Received: from camb691.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 447AFA01D3
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Mar 2017 14:17:26 +1100 (AEDT)
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] selftests/powerpc: Replace stxvx and lxvx with their
 equivalent instruction
Date: Thu,  9 Mar 2017 14:14:59 +1100
Message-Id: <20170309031459.14253-1-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On POWER8 (ISA 2.07) lxvx and stxvx are defined to be extended mnemonics
of lxvd2x and stxvd2x. For POWER9 (ISA 3.0) the HW architects in their
infinite wisdom made lxvx and stxvx instructions in their own right.

POWER9 aware GCC will use the POWER9 instruction for lxvx and stxvx
causing these selftests to fail on POWER8. Further compounding the
issue, because of the way -mvsx works it will cause the power9
instructions to be used regardless of -mcpu=power8 to GCC or -mpower8 to
AS.

The safest way to address the problem for now is to not use the extended
mnemonic. We don't care how the CPU loads the values from memory since
the tests only performs register comparisons, using stxvd2x/lxvd2x does
not impact the test.

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
Acked-by: Balbir Singh<bsingharora@gmail.com>
---
V2: Reword last sentence of commit message

 tools/testing/selftests/powerpc/include/vsx_asm.h | 48 +++++++++++------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/powerpc/include/vsx_asm.h b/tools/testing/selftests/powerpc/include/vsx_asm.h
index d828bfb6ef2d..54064ced9e95 100644
--- a/tools/testing/selftests/powerpc/include/vsx_asm.h
+++ b/tools/testing/selftests/powerpc/include/vsx_asm.h
@@ -16,56 +16,56 @@
  */
 FUNC_START(load_vsx)
 	li	r5,0
-	lxvx	vs20,r5,r3
+	lxvd2x	vs20,r5,r3
 	addi	r5,r5,16
-	lxvx	vs21,r5,r3
+	lxvd2x	vs21,r5,r3
 	addi	r5,r5,16
-	lxvx	vs22,r5,r3
+	lxvd2x	vs22,r5,r3
 	addi	r5,r5,16
-	lxvx	vs23,r5,r3
+	lxvd2x	vs23,r5,r3
 	addi	r5,r5,16
-	lxvx	vs24,r5,r3
+	lxvd2x	vs24,r5,r3
 	addi	r5,r5,16
-	lxvx	vs25,r5,r3
+	lxvd2x	vs25,r5,r3
 	addi	r5,r5,16
-	lxvx	vs26,r5,r3
+	lxvd2x	vs26,r5,r3
 	addi	r5,r5,16
-	lxvx	vs27,r5,r3
+	lxvd2x	vs27,r5,r3
 	addi	r5,r5,16
-	lxvx	vs28,r5,r3
+	lxvd2x	vs28,r5,r3
 	addi	r5,r5,16
-	lxvx	vs29,r5,r3
+	lxvd2x	vs29,r5,r3
 	addi	r5,r5,16
-	lxvx	vs30,r5,r3
+	lxvd2x	vs30,r5,r3
 	addi	r5,r5,16
-	lxvx	vs31,r5,r3
+	lxvd2x	vs31,r5,r3
 	blr
 FUNC_END(load_vsx)
 
 FUNC_START(store_vsx)
 	li	r5,0
-	stxvx	vs20,r5,r3
+	stxvd2x	vs20,r5,r3
 	addi	r5,r5,16
-	stxvx	vs21,r5,r3
+	stxvd2x	vs21,r5,r3
 	addi	r5,r5,16
-	stxvx	vs22,r5,r3
+	stxvd2x	vs22,r5,r3
 	addi	r5,r5,16
-	stxvx	vs23,r5,r3
+	stxvd2x	vs23,r5,r3
 	addi	r5,r5,16
-	stxvx	vs24,r5,r3
+	stxvd2x	vs24,r5,r3
 	addi	r5,r5,16
-	stxvx	vs25,r5,r3
+	stxvd2x	vs25,r5,r3
 	addi	r5,r5,16
-	stxvx	vs26,r5,r3
+	stxvd2x	vs26,r5,r3
 	addi	r5,r5,16
-	stxvx	vs27,r5,r3
+	stxvd2x	vs27,r5,r3
 	addi	r5,r5,16
-	stxvx	vs28,r5,r3
+	stxvd2x	vs28,r5,r3
 	addi	r5,r5,16
-	stxvx	vs29,r5,r3
+	stxvd2x	vs29,r5,r3
 	addi	r5,r5,16
-	stxvx	vs30,r5,r3
+	stxvd2x	vs30,r5,r3
 	addi	r5,r5,16
-	stxvx	vs31,r5,r3
+	stxvd2x	vs31,r5,r3
 	blr
 FUNC_END(store_vsx)
-- 
2.12.0
