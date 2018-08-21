Return-Path: <leitao@debian.org>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41w05d4ZPbzF2FK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Aug 2018 04:47:01 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7LIi4dI123810
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2018 14:46:58 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2m0qnq9hrd-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2018 14:46:57 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Tue, 21 Aug 2018 14:46:56 -0400
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Breno Leitao <leitao@debian.org>
Subject: [PATCH] powerpc/xive: Initialize symbol before usage
Date: Tue, 21 Aug 2018 15:46:52 -0300
Message-Id: <1534877212-22678-1-git-send-email-leitao@debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Function xive_native_get_ipi() might uses chip_id without it being
initialized. This gives the following error on 'smatch' tool:

	error: uninitialized symbol 'chip_id'

This patch simply sets chip_id initial value to 0.

CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/powerpc/sysdev/xive/native.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/xive/native.c b/arch/powerpc/sysdev/xive/native.c
index 311185b9960a..fc56673a3c0f 100644
--- a/arch/powerpc/sysdev/xive/native.c
+++ b/arch/powerpc/sysdev/xive/native.c
@@ -239,7 +239,7 @@ static bool xive_native_match(struct device_node *node)
 static int xive_native_get_ipi(unsigned int cpu, struct xive_cpu *xc)
 {
 	struct device_node *np;
-	unsigned int chip_id;
+	unsigned int chip_id = 0;
 	s64 irq;
 
 	/* Find the chip ID */
-- 
2.16.3
