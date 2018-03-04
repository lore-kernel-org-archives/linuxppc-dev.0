Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zvVSz1JMhzF09j
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Mar 2018 04:31:30 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w24HTLl1138317
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 4 Mar 2018 12:31:28 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gga78r3mc-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Mar 2018 12:31:28 -0500
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Sun, 4 Mar 2018 17:31:26 -0000
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Balbir Singh <bsingharora@gmail.com>
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>,
 Douglas Miller <dougmill@linux.vnet.ibm.com>
Subject: [PATCH v2] xmon: Setup xmon debugger hooks when first break-point is
 set
Date: Sun,  4 Mar 2018 23:00:25 +0530
Message-Id: <20180304173025.19520-1-vaibhav@linux.vnet.ibm.com>
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
instruction or data break-point is set via xmon console.

Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
---
Change-log:

v2 -> Moved the code that was force enabling xmon to a separate inline
      function (Balbir)

      The change related to clearing all breakpoints when xmon is
      disabled via debugfs will be respinned as a separate
      patch. (Mpe)
---
 arch/powerpc/xmon/xmon.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 82e1a3ee6e0f..e9c7ec8f15f8 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -1273,6 +1273,18 @@ static long check_bp_loc(unsigned long addr)
 	return 1;
 }
 
+/* Force enable xmon if not already enabled */
+static inline void force_enable_xmon(void)
+{
+	static const char warnxmon[] = "xmon: Enabling debugger hooks\n";
+
+	/* Enable xmon hooks if needed */
+	if (!xmon_on) {
+		printf(warnxmon);
+		xmon_on = 1;
+	}
+}
+
 static char *breakpoint_help_string =
     "Breakpoint command usage:\n"
     "b                show breakpoints\n"
@@ -1315,6 +1327,8 @@ bpt_cmds(void)
 			dabr.address &= ~HW_BRK_TYPE_DABR;
 			dabr.enabled = mode | BP_DABR;
 		}
+
+		force_enable_xmon();
 		break;
 
 	case 'i':	/* bi - hardware instr breakpoint */
@@ -1335,6 +1349,7 @@ bpt_cmds(void)
 		if (bp != NULL) {
 			bp->enabled |= BP_CIABR;
 			iabr = bp;
+			force_enable_xmon();
 		}
 		break;
 #endif
@@ -1399,8 +1414,10 @@ bpt_cmds(void)
 		if (!check_bp_loc(a))
 			break;
 		bp = new_breakpoint(a);
-		if (bp != NULL)
+		if (bp != NULL) {
 			bp->enabled |= BP_TRAP;
+			force_enable_xmon();
+		}
 		break;
 	}
 }
-- 
2.14.3
