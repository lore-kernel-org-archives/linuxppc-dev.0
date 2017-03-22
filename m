Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vpKTw4phczDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Mar 2017 06:28:20 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2MJQ7Lb002402
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 15:28:16 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29b9vm75r8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 15:28:16 -0400
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Wed, 22 Mar 2017 16:28:14 -0300
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2MJSAhP41549882
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 16:28:10 -0300
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2MJS9v6030416
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 16:28:09 -0300
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: gpiccoli@linux.vnet.ibm.com, xinhui.pan@linux.vnet.ibm.com,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Subject: [PATCH v4 2/3] powerpc/xmon: drop the nobt option from xmon plus
 minor fixes
Date: Wed, 22 Mar 2017 16:27:50 -0300
In-Reply-To: <20170322192751.30531-1-gpiccoli@linux.vnet.ibm.com>
References: <20170322192751.30531-1-gpiccoli@linux.vnet.ibm.com>
Message-Id: <20170322192751.30531-3-gpiccoli@linux.vnet.ibm.com>
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

We don't need this parameter anymore, the feature of auto showing the
backtrace is interesting (imagine a case of auto-reboot script),
so this patch extends the functionality, by always showing the backtrace
automatically when xmon is invoked; it removes the nobt parameter too.

Also, this patch fixes __initdata placement on xmon_early and replaces
__initcall() with modern device_initcall() on sysrq handler.

Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
---
v4: extended the auto backtrace functionality, by showing the trace
in every xmon invokation [mpe suggestion].

 arch/powerpc/xmon/xmon.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index a89db1b3f66d..25a32815f310 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -185,8 +185,6 @@ static void dump_tlb_44x(void);
 static void dump_tlb_book3e(void);
 #endif
 
-static int xmon_no_auto_backtrace;
-
 #ifdef CONFIG_PPC64
 #define REG		"%.16lx"
 #else
@@ -885,10 +883,7 @@ cmds(struct pt_regs *excp)
 	last_cmd = NULL;
 	xmon_regs = excp;
 
-	if (!xmon_no_auto_backtrace) {
-		xmon_no_auto_backtrace = 1;
-		xmon_show_stack(excp->gpr[1], excp->link, excp->nip);
-	}
+	xmon_show_stack(excp->gpr[1], excp->link, excp->nip);
 
 	for(;;) {
 #ifdef CONFIG_SMP
@@ -3318,10 +3313,10 @@ static int __init setup_xmon_sysrq(void)
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
@@ -3335,8 +3330,6 @@ static int __init early_parse_xmon(char *p)
 		xmon_on = 1;
 	} else if (strncmp(p, "off", 3) == 0)
 		xmon_on = 0;
-	else if (strncmp(p, "nobt", 4) == 0)
-		xmon_no_auto_backtrace = 1;
 	else
 		return 1;
 
-- 
2.11.0
