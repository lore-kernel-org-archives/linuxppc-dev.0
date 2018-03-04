Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zvVTl5yHSzF0fZ
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Mar 2018 04:32:11 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w24HTMip018954
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 4 Mar 2018 12:32:09 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2gg9h90t3y-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Mar 2018 12:32:08 -0500
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Sun, 4 Mar 2018 17:32:07 -0000
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Balbir Singh <bsingharora@gmail.com>
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>,
 Douglas Miller <dougmill@linux.vnet.ibm.com>
Subject: [PATCH] xmon: Clear all breakpoints when xmon is disabled via debugfs
Date: Sun,  4 Mar 2018 23:01:32 +0530
Message-Id: <20180304173132.19677-1-vaibhav@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Presently when xmon is disabled by debugfs any existing
instruction/data-access breakpoints set are not disabled. This may
lead to kernel oops when those breakpoints are hit as the necessary
debugger hooks aren't installed.

Hence this patch introduces a new function named clear_all_bpt()
which is called when xmon is disabled via debugfs. The function will
unpatch/clear all the trap and ciabr/dab based breakpoints.

Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
---
 arch/powerpc/xmon/xmon.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index e9c7ec8f15f8..f43aacd74625 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -903,6 +903,27 @@ static void remove_bpts(void)
 	}
 }
 
+static void clear_all_bpt(void)
+{
+	int i;
+
+	/* clear/unpatch all breakpoints */
+	remove_bpts();
+	remove_cpu_bpts();
+
+	/* Disable all breakpoints */
+	for (i = 0; i < NBPTS; ++i)
+		bpts[i].enabled = 0;
+
+	/* Clear any data or iabr breakpoints */
+	if (iabr || dabr.enabled) {
+		iabr = NULL;
+		dabr.enabled = 0;
+	}
+
+	printf("xmon: All breakpoints cleared\n");
+}
+
 static void remove_cpu_bpts(void)
 {
 	hw_breakpoint_disable();
@@ -3671,6 +3692,9 @@ static int xmon_dbgfs_set(void *data, u64 val)
 	xmon_on = !!val;
 	xmon_init(xmon_on);
 
+	/* make sure all breakpoints removed when disabling */
+	if (!xmon_on)
+		clear_all_bpt();
 	return 0;
 }
 
-- 
2.14.3
