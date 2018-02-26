Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zqftJ4DWLzF1V4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 22:36:39 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1QBTTTZ037664
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 06:36:37 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2gcerpy1c7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 06:36:36 -0500
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Mon, 26 Feb 2018 11:36:35 -0000
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Balbir Singh <bsingharora@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Douglas Miller <dougmill@linux.vnet.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Subject: [PATCH] xmon: Setup xmon debugger hooks when first break-point is set
Date: Mon, 26 Feb 2018 17:06:07 +0530
Message-Id: <20180226113607.20321-1-vaibhav@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Presently sysrq key for xmon('x') is registered during kernel init
irrespective of the value of kernel param 'xmon'. Thus xmon is enabled
even if 'xmon=off' is passed on the kernel command line. However this
doesn't enable the kernel debugger hooks needed for instruction or data
breakpoints. Thus when a break-point is hit with xmon=off a kernel oops
of the form below is reported:

Oops: Exception in kernel mode, sig: 5 [#1]
< snip >
Trace/breakpoint trap

To fix this the patch checks and enables debugger hooks when an
instruction or data break-point is set via xmon console. It also clears
all breakpoints when xmon is disabled via debugfs.

Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
---
 arch/powerpc/xmon/xmon.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 82e1a3ee6e0f..3679f5417a7e 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -1295,6 +1295,7 @@ bpt_cmds(void)
 	switch (cmd) {
 #ifndef CONFIG_PPC_8xx
 	static const char badaddr[] = "Only kernel addresses are permitted for breakpoints\n";
+	static const char warnxmon[] = "xmon: Enabling debugger hooks\n";
 	int mode;
 	case 'd':	/* bd - hardware data breakpoint */
 		mode = 7;
@@ -1315,6 +1316,11 @@ bpt_cmds(void)
 			dabr.address &= ~HW_BRK_TYPE_DABR;
 			dabr.enabled = mode | BP_DABR;
 		}
+		/* Enable xmon hooks if needed */
+		if (!xmon_on) {
+			printf(warnxmon);
+			xmon_on = 1;
+		}
 		break;
 
 	case 'i':	/* bi - hardware instr breakpoint */
@@ -1335,6 +1341,12 @@ bpt_cmds(void)
 		if (bp != NULL) {
 			bp->enabled |= BP_CIABR;
 			iabr = bp;
+
+			/* Enable xmon hooks if needed */
+			if (!xmon_on) {
+				printf(warnxmon);
+				xmon_on = 1;
+			}
 		}
 		break;
 #endif
@@ -1399,8 +1411,15 @@ bpt_cmds(void)
 		if (!check_bp_loc(a))
 			break;
 		bp = new_breakpoint(a);
-		if (bp != NULL)
+		if (bp != NULL) {
 			bp->enabled |= BP_TRAP;
+
+			/* Enable xmon hooks if needed */
+			if (!xmon_on) {
+				printf(warnxmon);
+				xmon_on = 1;
+			}
+		}
 		break;
 	}
 }
@@ -3651,9 +3670,22 @@ device_initcall(setup_xmon_sysrq);
 #ifdef CONFIG_DEBUG_FS
 static int xmon_dbgfs_set(void *data, u64 val)
 {
+	int i;
+
 	xmon_on = !!val;
 	xmon_init(xmon_on);
 
+	/* make sure all breakpoints removed when disabling */
+	if (!xmon_on) {
+		for (i = 0; i < NBPTS; ++i)
+			bpts[i].enabled = 0;
+		/* if anything set inform user that breakpoints are cleared */
+		if (iabr || dabr.enabled)
+			pr_info("xmon: All breakpoints cleared\n");
+
+		iabr = NULL;
+		dabr.enabled = 0;
+	}
 	return 0;
 }
 
-- 
2.14.3
