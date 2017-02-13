Return-Path: <xinhui.pan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vMDPv74wyzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Feb 2017 16:19:47 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1D5JMDo118855
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Feb 2017 00:19:45 -0500
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28hyg1pq8m-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Feb 2017 00:19:45 -0500
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui.pan@linux.vnet.ibm.com>;
 Mon, 13 Feb 2017 15:19:42 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 3D96E3578052
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Feb 2017 16:19:40 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1D5JWw329294830
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Feb 2017 16:19:40 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1D5J7GY002070
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Feb 2017 16:19:08 +1100
From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 aneesh.kumar@linux.vnet.ibm.com, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/xmon: add turn off xmon option
Date: Mon, 13 Feb 2017 05:13:52 -0500
Message-Id: <1486980832-6846-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Once xmon is triggered, there is no interface to turn it off again.
However there exists disable/enable xmon code flows. And more important,
System reset interrupt on powerVM will fire an oops to make a dump. At
that time, xmon should not be triggered.

So add 'z' option after current 'x|X' exit commands. Turn xmon off if 'z'
is following.

Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
---
 arch/powerpc/xmon/xmon.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 9c0e17c..2f4e7b1 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -76,6 +76,7 @@ static int xmon_gate;
 #endif /* CONFIG_SMP */
 
 static unsigned long in_xmon __read_mostly = 0;
+static int xmon_off = 0;
 
 static unsigned long adrs;
 static int size = 1;
@@ -255,8 +256,8 @@ Commands:\n\
   Sr #	read SPR #\n\
   Sw #v write v to SPR #\n\
   t	print backtrace\n\
-  x	exit monitor and recover\n\
-  X	exit monitor and don't recover\n"
+  x[z]	exit monitor and recover, turn off xmon with 'z'\n\
+  X[z]	exit monitor and don't recover, turn off xmon with 'z'\n"
 #if defined(CONFIG_PPC64) && !defined(CONFIG_PPC_BOOK3E)
 "  u	dump segment table or SLB\n"
 #elif defined(CONFIG_PPC_STD_MMU_32)
@@ -952,6 +953,8 @@ cmds(struct pt_regs *excp)
 			break;
 		case 'x':
 		case 'X':
+			if (inchar() == 'z')
+				xmon_off = 1;
 			return cmd;
 		case EOF:
 			printf(" <no input ...>\n");
@@ -3248,8 +3251,11 @@ static void xmon_init(int enable)
 static void sysrq_handle_xmon(int key)
 {
 	/* ensure xmon is enabled */
+	xmon_off = 0;
 	xmon_init(1);
 	debugger(get_irq_regs());
+	if (xmon_off)
+		xmon_init(0);
 }
 
 static struct sysrq_key_op sysrq_xmon_op = {
@@ -3266,7 +3272,7 @@ static int __init setup_xmon_sysrq(void)
 __initcall(setup_xmon_sysrq);
 #endif /* CONFIG_MAGIC_SYSRQ */
 
-static int __initdata xmon_early, xmon_off;
+static int __initdata xmon_early;
 
 static int __init early_parse_xmon(char *p)
 {
-- 
2.4.11
