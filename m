Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vpKTs2hNtzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Mar 2017 06:28:17 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2MJNfCf085596
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 15:28:12 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29bxhytj1h-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 15:28:12 -0400
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Wed, 22 Mar 2017 16:28:10 -0300
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by d24relay04.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2MJS78736503590
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 16:28:07 -0300
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2MJS6dJ030390
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 16:28:07 -0300
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: gpiccoli@linux.vnet.ibm.com, xinhui.pan@linux.vnet.ibm.com,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Subject: [PATCH v4 1/3] powerpc/xmon: Fix an unexpected xmon on/off state
 change
Date: Wed, 22 Mar 2017 16:27:49 -0300
In-Reply-To: <20170322192751.30531-1-gpiccoli@linux.vnet.ibm.com>
References: <20170322192751.30531-1-gpiccoli@linux.vnet.ibm.com>
Message-Id: <20170322192751.30531-2-gpiccoli@linux.vnet.ibm.com>
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
v3: changed xmon_off to xmon_on, simplifying the logic [mpe suggestion].

 arch/powerpc/xmon/xmon.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 16321ad9e70c..a89db1b3f66d 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -76,6 +76,7 @@ static int xmon_gate;
 #endif /* CONFIG_SMP */
 
 static unsigned long in_xmon __read_mostly = 0;
+static int xmon_on = IS_ENABLED(CONFIG_XMON_DEFAULT);
 
 static unsigned long adrs;
 static int size = 1;
@@ -3302,6 +3303,8 @@ static void sysrq_handle_xmon(int key)
 	/* ensure xmon is enabled */
 	xmon_init(1);
 	debugger(get_irq_regs());
+	if (!xmon_on)
+		xmon_init(0);
 }
 
 static struct sysrq_key_op sysrq_xmon_op = {
@@ -3318,7 +3321,7 @@ static int __init setup_xmon_sysrq(void)
 __initcall(setup_xmon_sysrq);
 #endif /* CONFIG_MAGIC_SYSRQ */
 
-static int __initdata xmon_early, xmon_off;
+static int __initdata xmon_early;
 
 static int __init early_parse_xmon(char *p)
 {
@@ -3326,10 +3329,12 @@ static int __init early_parse_xmon(char *p)
 		/* just "xmon" is equivalent to "xmon=early" */
 		xmon_init(1);
 		xmon_early = 1;
-	} else if (strncmp(p, "on", 2) == 0)
+		xmon_on = 1;
+	} else if (strncmp(p, "on", 2) == 0) {
 		xmon_init(1);
-	else if (strncmp(p, "off", 3) == 0)
-		xmon_off = 1;
+		xmon_on = 1;
+	} else if (strncmp(p, "off", 3) == 0)
+		xmon_on = 0;
 	else if (strncmp(p, "nobt", 4) == 0)
 		xmon_no_auto_backtrace = 1;
 	else
@@ -3341,10 +3346,8 @@ early_param("xmon", early_parse_xmon);
 
 void __init xmon_setup(void)
 {
-#ifdef CONFIG_XMON_DEFAULT
-	if (!xmon_off)
+	if (xmon_on)
 		xmon_init(1);
-#endif
 	if (xmon_early)
 		debugger(NULL);
 }
-- 
2.11.0
