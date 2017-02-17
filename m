Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vPYXk3hxMzDqJ5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2017 11:18:46 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1H0ENlZ055962
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 19:18:44 -0500
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28nefjm194-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 19:18:44 -0500
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Thu, 16 Feb 2017 22:18:41 -0200
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.18.232.42])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 2952E352006E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 19:18:05 -0500 (EST)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1H0IX2B24772718
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 22:18:38 -0200
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1H0IH9r020556
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 22:18:18 -0200
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 npiggin@gmail.com, xinhui.pan@linux.vnet.ibm.com,
 gpiccoli@linux.vnet.ibm.com
Subject: [PATCH v2 1/3] powerpc/xmon: Fix an unexpected xmon on/off state
 change
Date: Thu, 16 Feb 2017 22:17:55 -0200
In-Reply-To: <1487290677-7200-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
References: <1487290677-7200-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
Message-Id: <1487290677-7200-2-git-send-email-gpiccoli@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>

Once xmon is triggered by sysrq-x, it is enabled always afterwards even
if it is disabled during boot. This will cause a system reset interrupt
fail to dump. So keep xmon in its original state after exit.

We have several ways to set xmon on or off.
1) by a build config CONFIG_XMON_DEFAULT.
2) by a boot cmdline with xmon or xmon=early or xmon=on to enable xmon
and xmon=off to disable xmon. This value will override that in step 1.
3) by a debugfs interface, as proposed in this patchset.
And this value can override those in step 1 and 2.

Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
---
 arch/powerpc/xmon/xmon.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 9c0e17c..f6e5c3d 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -76,6 +76,7 @@ static int xmon_gate;
 #endif /* CONFIG_SMP */
 
 static unsigned long in_xmon __read_mostly = 0;
+static int xmon_off = !IS_ENABLED(CONFIG_XMON_DEFAULT);
 
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
@@ -3266,16 +3269,16 @@ static int __init setup_xmon_sysrq(void)
 __initcall(setup_xmon_sysrq);
 #endif /* CONFIG_MAGIC_SYSRQ */
 
-static int __initdata xmon_early, xmon_off;
+static int __initdata xmon_early;
 
 static int __init early_parse_xmon(char *p)
 {
 	if (!p || strncmp(p, "early", 5) == 0) {
 		/* just "xmon" is equivalent to "xmon=early" */
-		xmon_init(1);
 		xmon_early = 1;
+		xmon_off = 0;
 	} else if (strncmp(p, "on", 2) == 0)
-		xmon_init(1);
+		xmon_off = 0;
 	else if (strncmp(p, "off", 3) == 0)
 		xmon_off = 1;
 	else if (strncmp(p, "nobt", 4) == 0)
@@ -3289,10 +3292,9 @@ early_param("xmon", early_parse_xmon);
 
 void __init xmon_setup(void)
 {
-#ifdef CONFIG_XMON_DEFAULT
-	if (!xmon_off)
-		xmon_init(1);
-#endif
+	if (xmon_off)
+		return;
+	xmon_init(1);
 	if (xmon_early)
 		debugger(NULL);
 }
-- 
2.7.4
