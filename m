Return-Path: <xinhui.pan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vNP6Y1789zDq8X
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 13:55:32 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1F2s2gv134299
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 21:55:30 -0500
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28m8a1c6d2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 21:55:30 -0500
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui.pan@linux.vnet.ibm.com>;
 Wed, 15 Feb 2017 08:25:27 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 11BEB125804F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 08:25:27 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1F2tObT23920856
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 08:25:24 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1F2tNFt002207
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 08:25:24 +0530
From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 npiggin@gmail.com, gpiccoli@linux.vnet.ibm.com,
 Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/xmon: Fix an unexpected xmon onoff state change
Date: Wed, 15 Feb 2017 02:49:50 -0500
Message-Id: <1487144990-5969-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Once xmon is triggered by sysrq-x, it is enabled always afterwards even
if it is disabled during boot. This will cause a system reset interrut
fail to dump. So keep xmon in its original state after exit.

Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
---
 arch/powerpc/xmon/xmon.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 9c0e17c..721212f 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -76,6 +76,7 @@ static int xmon_gate;
 #endif /* CONFIG_SMP */
 
 static unsigned long in_xmon __read_mostly = 0;
+static int xmon_off = 0;
 
 static unsigned long adrs;
 static int size = 1;
@@ -3250,6 +3251,8 @@ static void sysrq_handle_xmon(int key)
 	/* ensure xmon is enabled */
 	xmon_init(1);
 	debugger(get_irq_regs());
+	if (xmon_off)
+		xmon_init(0);
 }
 
 static struct sysrq_key_op sysrq_xmon_op = {
@@ -3266,7 +3269,7 @@ static int __init setup_xmon_sysrq(void)
 __initcall(setup_xmon_sysrq);
 #endif /* CONFIG_MAGIC_SYSRQ */
 
-static int __initdata xmon_early, xmon_off;
+static int __initdata xmon_early;
 
 static int __init early_parse_xmon(char *p)
 {
-- 
2.4.11
