Return-Path: <SRS0=xrHL=SE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE29C4360F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 18:21:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EC992084B
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 18:21:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EC992084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Ycwl1bjdzDqQH
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 05:21:27 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Ycnp66nJzDqN8
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2019 05:15:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44Ycnp3g9Mz8x89
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2019 05:15:26 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 44Ycnp2tXNz9sNf; Wed,  3 Apr 2019 05:15:26 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=cclaudio@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44Ycnn6cSkz9sDB
 for <linuxppc-dev@ozlabs.org>; Wed,  3 Apr 2019 05:15:25 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x32I9S5q063500
 for <linuxppc-dev@ozlabs.org>; Tue, 2 Apr 2019 14:15:24 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rmc12tjcs-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 02 Apr 2019 14:15:24 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <cclaudio@linux.ibm.com>;
 Tue, 2 Apr 2019 19:15:23 +0100
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
 by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 2 Apr 2019 19:15:18 +0100
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x32IFHPd24641628
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 2 Apr 2019 18:15:17 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 51015112063;
 Tue,  2 Apr 2019 18:15:17 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8D52A112062;
 Tue,  2 Apr 2019 18:15:15 +0000 (GMT)
Received: from rino.br.ibm.com (unknown [9.18.235.111])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  2 Apr 2019 18:15:15 +0000 (GMT)
From: Claudio Carvalho <cclaudio@linux.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-efi@vger.kernel.org,
 linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] powerpc/powernv: Detect the secure boot mode of the system
Date: Tue,  2 Apr 2019 15:15:04 -0300
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190402181505.25037-1-cclaudio@linux.ibm.com>
References: <20190402181505.25037-1-cclaudio@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19040218-2213-0000-0000-0000036F855F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010862; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01183359; UDB=6.00619523; IPR=6.00964108; 
 MB=3.00026264; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-02 18:15:21
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040218-2214-0000-0000-00005DE10038
Message-Id: <20190402181505.25037-4-cclaudio@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-02_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904020121
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
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Nayna Jain <nayna@linux.ibm.com>, Claudio Carvalho <cclaudio@linux.ibm.com>,
 Matthew Garret <matthew.garret@nebula.com>, Paul Mackerras <paulus@samba.org>,
 Jeremy Kerr <jk@ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Nayna Jain <nayna@linux.ibm.com>

PowerNV secure boot defines different IMA policies based on the secure
boot state of the system.

This patch defines a function to detect the secure boot state of the
system.

Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
---
 arch/powerpc/include/asm/secboot.h       | 21 +++++++++
 arch/powerpc/platforms/powernv/Makefile  |  2 +-
 arch/powerpc/platforms/powernv/secboot.c | 54 ++++++++++++++++++++++++
 3 files changed, 76 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/include/asm/secboot.h
 create mode 100644 arch/powerpc/platforms/powernv/secboot.c

diff --git a/arch/powerpc/include/asm/secboot.h b/arch/powerpc/include/asm/secboot.h
new file mode 100644
index 000000000000..1904fb4a3352
--- /dev/null
+++ b/arch/powerpc/include/asm/secboot.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * PowerPC secure boot definitions
+ *
+ * Copyright (C) 2019 IBM Corporation
+ * Author: Nayna Jain <nayna@linux.ibm.com>
+ *
+ */
+#ifndef POWERPC_SECBOOT_H
+#define POWERPC_SECBOOT_H
+
+#if defined(CONFIG_OPAL_SECVAR)
+extern bool get_powerpc_sb_mode(void);
+#else
+static inline bool get_powerpc_sb_mode(void)
+{
+	return false;
+}
+#endif
+
+#endif
diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index 1511d836fd19..a36e22f8ecf8 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -16,4 +16,4 @@ obj-$(CONFIG_PERF_EVENTS) += opal-imc.o
 obj-$(CONFIG_PPC_MEMTRACE)	+= memtrace.o
 obj-$(CONFIG_PPC_VAS)	+= vas.o vas-window.o vas-debug.o
 obj-$(CONFIG_OCXL_BASE)	+= ocxl.o
-obj-$(CONFIG_OPAL_SECVAR)	+= opal-secvar.o
+obj-$(CONFIG_OPAL_SECVAR)	+= opal-secvar.o secboot.o
diff --git a/arch/powerpc/platforms/powernv/secboot.c b/arch/powerpc/platforms/powernv/secboot.c
new file mode 100644
index 000000000000..afb1552636c5
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/secboot.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 IBM Corporation
+ * Author: Nayna Jain <nayna@linux.ibm.com>
+ *
+ * secboot.c
+ *      - util functions to get powerpc secboot state
+ *
+ */
+#include <linux/efi.h>
+#include <asm/secboot.h>
+
+bool get_powerpc_sb_mode(void)
+{
+	efi_char16_t efi_SecureBoot_name[] = L"SecureBoot";
+	efi_char16_t efi_SetupMode_name[] = L"SetupMode";
+	efi_guid_t efi_variable_guid = EFI_GLOBAL_VARIABLE_GUID;
+	efi_status_t status;
+	u8 secboot, setupmode;
+	unsigned long size = sizeof(secboot);
+
+	status = efi.get_variable(efi_SecureBoot_name, &efi_variable_guid,
+				  NULL, &size, &secboot);
+
+	/*
+	 * For now assume all failures reading the SecureBoot variable implies
+	 * secure boot is not enabled. Later differentiate failure types.
+	 */
+	if (status != EFI_SUCCESS) {
+		secboot = 0;
+		setupmode = 0;
+		goto out;
+	}
+
+	size = sizeof(setupmode);
+	status = efi.get_variable(efi_SetupMode_name, &efi_variable_guid,
+				  NULL, &size, &setupmode);
+
+	/*
+	 * Failure to read the SetupMode variable does not prevent
+	 * secure boot mode
+	 */
+	if (status != EFI_SUCCESS)
+		setupmode = 0;
+
+out:
+	if ((secboot == 0) || (setupmode == 1)) {
+		pr_info("ima: secureboot mode disabled\n");
+		return false;
+	}
+
+	pr_info("ima: secureboot mode enabled\n");
+	return true;
+}
-- 
2.20.1

