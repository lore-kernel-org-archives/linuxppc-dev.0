Return-Path: <SRS0=1E/h=NL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32526C0044C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 14:40:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE1C420664
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 14:40:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE1C420664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42lWGK3345zF3Jt
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 01:40:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=debian.org
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=leitao@debian.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42lWD85gXdzF2Pq
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Nov 2018 01:38:32 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w9VEZ1ac045533
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2018 10:38:30 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2nfdmqteam-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2018 10:38:30 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Wed, 31 Oct 2018 14:38:29 -0000
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
 by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 31 Oct 2018 14:38:26 -0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w9VEcPXB19988530
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 31 Oct 2018 14:38:25 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 87B3D78067;
 Wed, 31 Oct 2018 14:38:25 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5E81B7806B;
 Wed, 31 Oct 2018 14:38:24 +0000 (GMT)
Received: from indigo.ibm.com (unknown [9.85.161.207])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 31 Oct 2018 14:38:24 +0000 (GMT)
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 1/3] selftests/powerpc: Allocate base registers
Date: Wed, 31 Oct 2018 11:38:20 -0300
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 18103114-0012-0000-0000-000016D21783
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009960; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01110651; UDB=6.00575506; IPR=6.00890743; 
 MB=3.00023979; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-31 14:38:28
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18103114-0013-0000-0000-000054F4505B
Message-Id: <1540996702-27161-1-git-send-email-leitao@debian.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-31_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=557 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810310123
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Breno Leitao <leitao@debian.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Some ptrace selftests are passing input operands using a constraint that
can allocate any register for the operand, and using these registers on
load/store operations.

If the register allocated by the compiler happens to be zero (r0), it might
cause an invalid memory address access, since load and store operations
consider the content of 0x0 address if the base register is r0, instead of
the content of the r0 register. For example:

	r1 := 0xdeadbeef
	r0 := 0xdeadbeef

	ld r2, 0(1) /* will load into r2 the content of r1 address */
	ld r2, 0(0) /* will load into r2 the content of 0x0 */

In order to avoid this possible problem, the inline assembly constraint
should be aware that these registers will be used as a base register, thus,
r0 should not be allocated.

Other than that, this patch removes inline assembly operands that are not
used by the tests.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Segher Boessenkool <segher@kernel.crashing.org>
---
 tools/testing/selftests/powerpc/ptrace/ptrace-gpr.c        | 2 +-
 tools/testing/selftests/powerpc/ptrace/ptrace-tm-gpr.c     | 4 ++--
 tools/testing/selftests/powerpc/ptrace/ptrace-tm-spd-tar.c | 2 +-
 tools/testing/selftests/powerpc/ptrace/ptrace-tm-spd-vsx.c | 3 +--
 tools/testing/selftests/powerpc/ptrace/ptrace-tm-spr.c     | 2 +-
 tools/testing/selftests/powerpc/ptrace/ptrace-tm-tar.c     | 2 +-
 tools/testing/selftests/powerpc/ptrace/ptrace-tm-vsx.c     | 3 +--
 7 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace-gpr.c b/tools/testing/selftests/powerpc/ptrace/ptrace-gpr.c
index 0b4ebcc2f485..ca29fafeed5d 100644
--- a/tools/testing/selftests/powerpc/ptrace/ptrace-gpr.c
+++ b/tools/testing/selftests/powerpc/ptrace/ptrace-gpr.c
@@ -31,7 +31,7 @@ void gpr(void)
 		ASM_LOAD_GPR_IMMED(gpr_1)
 		ASM_LOAD_FPR_SINGLE_PRECISION(flt_1)
 		:
-		: [gpr_1]"i"(GPR_1), [flt_1] "r" (&a)
+		: [gpr_1]"i"(GPR_1), [flt_1] "b" (&a)
 		: "memory", "r6", "r7", "r8", "r9", "r10",
 		"r11", "r12", "r13", "r14", "r15", "r16", "r17",
 		"r18", "r19", "r20", "r21", "r22", "r23", "r24",
diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace-tm-gpr.c b/tools/testing/selftests/powerpc/ptrace/ptrace-tm-gpr.c
index 59206b96e98a..a08a91594dbe 100644
--- a/tools/testing/selftests/powerpc/ptrace/ptrace-tm-gpr.c
+++ b/tools/testing/selftests/powerpc/ptrace/ptrace-tm-gpr.c
@@ -59,8 +59,8 @@ void tm_gpr(void)
 		"3: ;"
 		: [res] "=r" (result), [texasr] "=r" (texasr)
 		: [gpr_1]"i"(GPR_1), [gpr_2]"i"(GPR_2),
-		[sprn_texasr] "i" (SPRN_TEXASR), [flt_1] "r" (&a),
-		[flt_2] "r" (&b), [cptr1] "r" (&cptr[1])
+		[sprn_texasr] "i" (SPRN_TEXASR), [flt_1] "b" (&a),
+		[flt_2] "b" (&b), [cptr1] "b" (&cptr[1])
 		: "memory", "r7", "r8", "r9", "r10",
 		"r11", "r12", "r13", "r14", "r15", "r16",
 		"r17", "r18", "r19", "r20", "r21", "r22",
diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace-tm-spd-tar.c b/tools/testing/selftests/powerpc/ptrace/ptrace-tm-spd-tar.c
index b3c061dc9512..f47174746231 100644
--- a/tools/testing/selftests/powerpc/ptrace/ptrace-tm-spd-tar.c
+++ b/tools/testing/selftests/powerpc/ptrace/ptrace-tm-spd-tar.c
@@ -72,7 +72,7 @@ void tm_spd_tar(void)
 		"3: ;"
 
 		: [res] "=r" (result), [texasr] "=r" (texasr)
-		: [val] "r" (cptr[1]), [sprn_dscr]"i"(SPRN_DSCR),
+		: [sprn_dscr]"i"(SPRN_DSCR),
 		[sprn_tar]"i"(SPRN_TAR), [sprn_ppr]"i"(SPRN_PPR),
 		[sprn_texasr]"i"(SPRN_TEXASR), [tar_1]"i"(TAR_1),
 		[dscr_1]"i"(DSCR_1), [tar_2]"i"(TAR_2), [dscr_2]"i"(DSCR_2),
diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace-tm-spd-vsx.c b/tools/testing/selftests/powerpc/ptrace/ptrace-tm-spd-vsx.c
index 277dade1b382..18a685bf6a09 100644
--- a/tools/testing/selftests/powerpc/ptrace/ptrace-tm-spd-vsx.c
+++ b/tools/testing/selftests/powerpc/ptrace/ptrace-tm-spd-vsx.c
@@ -77,8 +77,7 @@ void tm_spd_vsx(void)
 
 		"3: ;"
 		: [res] "=r" (result), [texasr] "=r" (texasr)
-		: [fp_load] "r" (fp_load), [fp_load_ckpt] "r" (fp_load_ckpt),
-		[sprn_texasr] "i"  (SPRN_TEXASR)
+		: [sprn_texasr] "i"  (SPRN_TEXASR)
 		: "memory", "r0", "r1", "r3", "r4",
 		"r7", "r8", "r9", "r10", "r11"
 		);
diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace-tm-spr.c b/tools/testing/selftests/powerpc/ptrace/ptrace-tm-spr.c
index 51427a2465f6..ba04999254e3 100644
--- a/tools/testing/selftests/powerpc/ptrace/ptrace-tm-spr.c
+++ b/tools/testing/selftests/powerpc/ptrace/ptrace-tm-spr.c
@@ -74,7 +74,7 @@ void tm_spr(void)
 
 		"3: ;"
 		: [tfhar] "=r" (tfhar), [res] "=r" (result),
-		[texasr] "=r" (texasr), [cptr1] "=r" (cptr1)
+		[texasr] "=r" (texasr), [cptr1] "=b" (cptr1)
 		: [sprn_texasr] "i"  (SPRN_TEXASR)
 		: "memory", "r0", "r8", "r31"
 		);
diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace-tm-tar.c b/tools/testing/selftests/powerpc/ptrace/ptrace-tm-tar.c
index 48b462f75023..f70023b25e6e 100644
--- a/tools/testing/selftests/powerpc/ptrace/ptrace-tm-tar.c
+++ b/tools/testing/selftests/powerpc/ptrace/ptrace-tm-tar.c
@@ -65,7 +65,7 @@ void tm_tar(void)
 		: [sprn_dscr]"i"(SPRN_DSCR), [sprn_tar]"i"(SPRN_TAR),
 		[sprn_ppr]"i"(SPRN_PPR), [sprn_texasr]"i"(SPRN_TEXASR),
 		[tar_1]"i"(TAR_1), [dscr_1]"i"(DSCR_1), [tar_2]"i"(TAR_2),
-		[dscr_2]"i"(DSCR_2), [cptr1] "r" (&cptr[1])
+		[dscr_2]"i"(DSCR_2), [cptr1] "b" (&cptr[1])
 		: "memory", "r0", "r1", "r3", "r4", "r5", "r6"
 		);
 
diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace-tm-vsx.c b/tools/testing/selftests/powerpc/ptrace/ptrace-tm-vsx.c
index 17c23cabac3e..dfba80058977 100644
--- a/tools/testing/selftests/powerpc/ptrace/ptrace-tm-vsx.c
+++ b/tools/testing/selftests/powerpc/ptrace/ptrace-tm-vsx.c
@@ -65,8 +65,7 @@ void tm_vsx(void)
 
 		"3: ;"
 		: [res] "=r" (result), [texasr] "=r" (texasr)
-		: [fp_load] "r" (fp_load), [fp_load_ckpt] "r" (fp_load_ckpt),
-		[sprn_texasr] "i"  (SPRN_TEXASR), [cptr1] "r" (&cptr[1])
+		: [sprn_texasr] "i"  (SPRN_TEXASR), [cptr1] "b" (&cptr[1])
 		: "memory", "r0", "r1", "r3", "r4",
 		"r7", "r8", "r9", "r10", "r11"
 		);
-- 
2.13.2

