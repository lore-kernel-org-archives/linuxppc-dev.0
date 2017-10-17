Return-Path: <leitao@debian.org>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yGk5B0DY0zDqlv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 05:20:29 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9HIJLbJ145306
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Oct 2017 14:20:26 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dnkpm29ba-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Oct 2017 14:20:26 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Tue, 17 Oct 2017 12:20:25 -0600
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Breno Leitao <leitao@debian.org>
Subject: [PATCH] powerpc/xmon: check before calling xive functions
Date: Tue, 17 Oct 2017 16:20:18 -0200
Message-Id: <1508264418-13448-1-git-send-email-leitao@debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently xmon could call XIVE functions from OPAL even if the XIVE is
disabled or does not exist in the system, as in POWER8 machines.  This
causes the following exception:

 1:mon> dx
 cpu 0x1: Vector: 700 (Program Check) at [c000000423c93450]
     pc: c00000000009cfa4: opal_xive_dump+0x50/0x68
     lr: c0000000000997b8: opal_return+0x0/0x50

This patch simply checks if XIVE is enabled before calling XIVE
functions.

Suggested-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/powerpc/xmon/xmon.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 4679aeb84767..b34976c4a6ba 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -2508,6 +2508,12 @@ static void dump_xives(void)
 	unsigned long num;
 	int c;
 
+	if (!xive_enabled()) {
+		printf("Xive disabled on this system\n");
+
+		return;
+	}
+
 	c = inchar();
 	if (c == 'a') {
 		dump_all_xives();
-- 
2.14.2
