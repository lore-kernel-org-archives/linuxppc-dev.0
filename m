Return-Path: <imunsie@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rfsGb4jP5zDqxS
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 04:51:51 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5TIhuJq113793
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 14:51:49 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23v097yfa2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 14:51:48 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Thu, 30 Jun 2016 04:51:46 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 4E6093578053
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 04:51:43 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5TIphti59965442
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 04:51:43 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5TIpgFO029060
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 04:51:43 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, mikey <mikey@neuling.org>,
 linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <frederic.barrat@fr.ibm.com>,
 Huy Nguyen <huyn@mellanox.com>
Cc: Ian Munsie <imunsie@au1.ibm.com>
Subject: [PATCH 2/2] cxl: Workaround XSL bug that does not clear the RA bit
 after a reset
Date: Thu, 30 Jun 2016 04:51:26 +1000
In-Reply-To: <1467226286-28547-1-git-send-email-imunsie@au.ibm.com>
References: <1467226286-28547-1-git-send-email-imunsie@au.ibm.com>
Message-Id: <1467226286-28547-2-git-send-email-imunsie@au.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

An issue was noted in our debug logs where the XSL would leave the RA
bit asserted after an AFU reset operation, which would effectively
prevent further AFU reset operations from working.

Workaround the issue by clearing the RA bit with an MMIO write if it is
still asserted after any AFU control operation.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 drivers/misc/cxl/native.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
index 9479bfc..bc79be8 100644
--- a/drivers/misc/cxl/native.c
+++ b/drivers/misc/cxl/native.c
@@ -55,6 +55,16 @@ static int afu_control(struct cxl_afu *afu, u64 command, u64 clear,
 		cpu_relax();
 		AFU_Cntl = cxl_p2n_read(afu, CXL_AFU_Cntl_An);
 	};
+
+	if (AFU_Cntl & CXL_AFU_Cntl_An_RA) {
+		/*
+		 * Workaround for a bug in the XSL used in the Mellanox CX4
+		 * that fails to clear the RA bit after an AFU reset,
+		 * preventing subsequent AFU resets from working.
+		 */
+		cxl_p2n_write(afu, CXL_AFU_Cntl_An, AFU_Cntl & ~CXL_AFU_Cntl_An_RA);
+	}
+
 	pr_devel("AFU command complete: %llx\n", command);
 	afu->enabled = enabled;
 out:
-- 
2.8.1
