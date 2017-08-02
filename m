Return-Path: <leitao@debian.org>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xN4CZ3tF0zDqnP
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Aug 2017 06:14:18 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v72KDefu090750
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Aug 2017 16:14:13 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c3g8hr169-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Aug 2017 16:14:13 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Wed, 2 Aug 2017 14:14:12 -0600
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v72KE9gR61341834
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Aug 2017 13:14:10 -0700
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v72KEAHd004917
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Aug 2017 17:14:10 -0300
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Breno Leitao <leitao@debian.org>
Subject: [PATCH v3 2/2] powerpc/xmon: Disable tracing when entering xmon
Date: Wed,  2 Aug 2017 17:14:06 -0300
In-Reply-To: <1501704846-22625-1-git-send-email-leitao@debian.org>
References: <1501704846-22625-1-git-send-email-leitao@debian.org>
Message-Id: <1501704846-22625-2-git-send-email-leitao@debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If tracing is enabled and you get into xmon, the tracing buffer
continues to be updated, causing possible loss of data and unnecessary
tracing information coming from xmon functions.

This patch simple disables tracing when entering xmon, and re-enables it
if the kernel is resumed (with 'x').

Signed-off-by: Breno Leitao <leitao@debian.org>
Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/xmon/xmon.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index e0522f60f0ee..d038e7db44c4 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -89,6 +89,7 @@ static unsigned long nidump = 16;
 static unsigned long ncsum = 4096;
 static int termch;
 static char tmpstr[128];
+static int tracing_enabled;
 
 static long bus_error_jmp[JMP_BUF_LEN];
 static int catch_memory_errors;
@@ -462,6 +463,9 @@ static int xmon_core(struct pt_regs *regs, int fromipi)
 	local_irq_save(flags);
 	hard_irq_disable();
 
+	tracing_enabled = tracing_is_on();
+	tracing_off();
+
 	bp = in_breakpoint_table(regs->nip, &offset);
 	if (bp != NULL) {
 		regs->nip = bp->address + offset;
@@ -982,6 +986,8 @@ cmds(struct pt_regs *excp)
 			break;
 		case 'x':
 		case 'X':
+			if (tracing_enabled)
+				tracing_on();
 			return cmd;
 		case EOF:
 			printf(" <no input ...>\n");
@@ -2241,8 +2247,6 @@ static void dump_tracing(void)
 		ftrace_dump(DUMP_ORIG);
 	else
 		ftrace_dump(DUMP_ALL);
-
-	tracing_on();
 }
 
 #ifdef CONFIG_PPC64
-- 
2.13.2
