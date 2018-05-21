Return-Path: <ravi.bangoria@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40q5FW4qp4zF0dT
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 May 2018 14:21:35 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4L4J3uG063853
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 May 2018 00:21:32 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2j3hfu23h9-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 May 2018 00:21:32 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.ibm.com>;
 Mon, 21 May 2018 05:21:30 +0100
From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To: mpe@ellerman.id.au, mikey@neuling.org
Cc: benh@kernel.crashing.org, paulus@samba.org,
 naveen.n.rao@linux.vnet.ibm.com, matthew.brown.dev@gmail.com,
 cyrilbur@gmail.com, anton@samba.org, sandipan@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH 3/3] powerpc/sstep: Fix emulate_step test if VSX not present
Date: Mon, 21 May 2018 09:51:08 +0530
In-Reply-To: <20180521042108.8318-1-ravi.bangoria@linux.ibm.com>
References: <20180521042108.8318-1-ravi.bangoria@linux.ibm.com>
Message-Id: <20180521042108.8318-4-ravi.bangoria@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

emulate_step() tests are failing if VSX is not supported or disabled.

  emulate_step_test: lxvd2x         : FAIL
  emulate_step_test: stxvd2x        : FAIL

If !CPU_FTR_VSX, emulate_step() failure is expected and testcase should
PASS with a valid justification. After patch:

  emulate_step_test: lxvd2x         : PASS (!CPU_FTR_VSX)
  emulate_step_test: stxvd2x        : PASS (!CPU_FTR_VSX)

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 arch/powerpc/lib/test_emulate_step.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/lib/test_emulate_step.c b/arch/powerpc/lib/test_emulate_step.c
index 2534c1447554..6c47daa61614 100644
--- a/arch/powerpc/lib/test_emulate_step.c
+++ b/arch/powerpc/lib/test_emulate_step.c
@@ -387,10 +387,14 @@ static void __init test_lxvd2x_stxvd2x(void)
 	/* lxvd2x vsr39, r3, r4 */
 	stepped = emulate_step(&regs, TEST_LXVD2X(39, 3, 4));
 
-	if (stepped == 1)
+	if (stepped == 1 && cpu_has_feature(CPU_FTR_VSX)) {
 		show_result("lxvd2x", "PASS");
-	else
-		show_result("lxvd2x", "FAIL");
+	} else {
+		if (!cpu_has_feature(CPU_FTR_VSX))
+			show_result("lxvd2x", "PASS (!CPU_FTR_VSX)");
+		else
+			show_result("lxvd2x", "FAIL");
+	}
 
 
 	/*** stxvd2x ***/
@@ -404,10 +408,15 @@ static void __init test_lxvd2x_stxvd2x(void)
 	stepped = emulate_step(&regs, TEST_STXVD2X(39, 3, 4));
 
 	if (stepped == 1 && cached_b[0] == c.b[0] && cached_b[1] == c.b[1] &&
-	    cached_b[2] == c.b[2] && cached_b[3] == c.b[3])
+	    cached_b[2] == c.b[2] && cached_b[3] == c.b[3] &&
+	    cpu_has_feature(CPU_FTR_VSX)) {
 		show_result("stxvd2x", "PASS");
-	else
-		show_result("stxvd2x", "FAIL");
+	} else {
+		if (!cpu_has_feature(CPU_FTR_VSX))
+			show_result("stxvd2x", "PASS (!CPU_FTR_VSX)");
+		else
+			show_result("stxvd2x", "FAIL");
+	}
 }
 #else
 static void __init test_lxvd2x_stxvd2x(void)
-- 
2.16.2
