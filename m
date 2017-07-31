Return-Path: <leitao@debian.org>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xLmVB1TMlzDrF2
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Aug 2017 03:22:26 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6VHJ4Lc086312
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 13:22:24 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c28cxhjvf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 13:22:23 -0400
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Mon, 31 Jul 2017 14:22:21 -0300
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay04.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6VHMI1X20250722
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 14:22:18 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6VHMLon032011
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 14:22:21 -0300
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Breno Leitao <leitao@debian.org>
Subject: [PATCH 3/3] powerpc/xmon: Disable tracing on xmon by default
Date: Mon, 31 Jul 2017 14:22:11 -0300
In-Reply-To: <1501521731-12123-1-git-send-email-leitao@debian.org>
References: <1501521731-12123-1-git-send-email-leitao@debian.org>
Message-Id: <1501521731-12123-3-git-send-email-leitao@debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently tracing is enabled from inside xmon, which may cause some
noise into the tracing buffer, and makes it harder to find what, in
the tracing buffer, are kernel non-xmon functions and what is xmon
'noise' (as printk()s and terminal functions tracing).

This patch simple disables it by default, showing a better trace output
of the failing functions just before it gets into xmon.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/powerpc/xmon/xmon.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 19276d2f2f25..b614cc3a3a65 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -89,7 +89,7 @@ static unsigned long nidump = 16;
 static unsigned long ncsum = 4096;
 static int termch;
 static char tmpstr[128];
-static char tracing_enabled = 1;
+static char tracing_enabled = 0;
 
 static long bus_error_jmp[JMP_BUF_LEN];
 static int catch_memory_errors;
@@ -463,6 +463,7 @@ static int xmon_core(struct pt_regs *regs, int fromipi)
 
 	local_irq_save(flags);
 	hard_irq_disable();
+	tracing_off();
 
 	bp = in_breakpoint_table(regs->nip, &offset);
 	if (bp != NULL) {
-- 
2.13.2
