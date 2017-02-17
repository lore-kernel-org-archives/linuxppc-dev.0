Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vPYXV5NzVzDqHB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2017 11:18:34 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1H0EM3w082426
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 19:18:32 -0500
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28nnyah7n2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 19:18:32 -0500
Received: from localhost
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Thu, 16 Feb 2017 22:18:29 -0200
Received: from d24relay04.br.ibm.com (d24relay04.br.ibm.com [9.18.232.146])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id C7D4E3520070
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 19:17:53 -0500 (EST)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay04.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1H0IRpT34275382
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 22:18:27 -0200
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1H0IQSN023511
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 22:18:27 -0200
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 npiggin@gmail.com, xinhui.pan@linux.vnet.ibm.com,
 gpiccoli@linux.vnet.ibm.com
Subject: [PATCH 2/3] powerpc/xmon: drop the nobt option from xmon plus minor
 fixes
Date: Thu, 16 Feb 2017 22:17:56 -0200
In-Reply-To: <1487290677-7200-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
References: <1487290677-7200-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
Message-Id: <1487290677-7200-3-git-send-email-gpiccoli@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The xmon parameter nobt was added long time ago, by commit 26c8af5f01df
("[POWERPC] print backtrace when entering xmon"). The problem that time
was that during a crash in a machine with USB keyboard, xmon wouldn't
respond to commands from the keyboard, so printing the backtrace wouldn't
be possible.

Idea then was to show automatically the backtrace on xmon crash for the
first time it's invoked (if it recovers, next time xmon won't show
backtrace automatically). The nobt parameter was added _only_ to prevent
this automatic trace show. Seems long time ago USB keyboards didn't work
that well!

We don't need it anymore, but the feature of auto showing the backtrace
on first crash seems interesting (imagine a case of auto-reboot script),
so this patch keeps the functionality, yet removes the nobt parameter.
Also, this patch fixes __initdata placement on xmon_early and replaces
__initcall() with modern device_initcall() on sysrq handler.

Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
---
 arch/powerpc/xmon/xmon.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index f6e5c3d..03f5d65 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -185,7 +185,7 @@ static void dump_tlb_44x(void);
 static void dump_tlb_book3e(void);
 #endif
 
-static int xmon_no_auto_backtrace;
+static bool xmon_no_auto_backtrace;
 
 #ifdef CONFIG_PPC64
 #define REG		"%.16lx"
@@ -882,7 +882,7 @@ cmds(struct pt_regs *excp)
 	xmon_regs = excp;
 
 	if (!xmon_no_auto_backtrace) {
-		xmon_no_auto_backtrace = 1;
+		xmon_no_auto_backtrace = true;
 		xmon_show_stack(excp->gpr[1], excp->link, excp->nip);
 	}
 
@@ -3248,11 +3248,17 @@ static void xmon_init(int enable)
 #ifdef CONFIG_MAGIC_SYSRQ
 static void sysrq_handle_xmon(int key)
 {
+	bool autobt_state = xmon_no_auto_backtrace;
+
+	xmon_no_auto_backtrace = true;
 	/* ensure xmon is enabled */
 	xmon_init(1);
+
 	debugger(get_irq_regs());
 	if (xmon_off)
 		xmon_init(0);
+
+	xmon_no_auto_backtrace = autobt_state;
 }
 
 static struct sysrq_key_op sysrq_xmon_op = {
@@ -3266,10 +3272,10 @@ static int __init setup_xmon_sysrq(void)
 	register_sysrq_key('x', &sysrq_xmon_op);
 	return 0;
 }
-__initcall(setup_xmon_sysrq);
+device_initcall(setup_xmon_sysrq);
 #endif /* CONFIG_MAGIC_SYSRQ */
 
-static int __initdata xmon_early;
+static int xmon_early __initdata;
 
 static int __init early_parse_xmon(char *p)
 {
@@ -3281,8 +3287,6 @@ static int __init early_parse_xmon(char *p)
 		xmon_off = 0;
 	else if (strncmp(p, "off", 3) == 0)
 		xmon_off = 1;
-	else if (strncmp(p, "nobt", 4) == 0)
-		xmon_no_auto_backtrace = 1;
 	else
 		return 1;
 
-- 
2.7.4
