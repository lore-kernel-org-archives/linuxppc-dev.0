Return-Path: <leitao@debian.org>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xLmV862BJzDrFt
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Aug 2017 03:22:24 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6VHJ4bq121966
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 13:22:22 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c21x0e1nb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 13:22:22 -0400
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Mon, 31 Jul 2017 14:22:19 -0300
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6VHMHTT38797424
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 14:22:17 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6VHMKu1031981
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 14:22:20 -0300
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Breno Leitao <leitao@debian.org>
Subject: [PATCH 2/3] powerpc/xmon: Disable and enable tracing command
Date: Mon, 31 Jul 2017 14:22:10 -0300
In-Reply-To: <1501521731-12123-1-git-send-email-leitao@debian.org>
References: <1501521731-12123-1-git-send-email-leitao@debian.org>
Message-Id: <1501521731-12123-2-git-send-email-leitao@debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If tracing is enabled and you get into xmon, the tracing buffer
continues to be updated, causing possible loss of data due to buffer
overflow and unnecessary tracing information coming from xmon functions.

This patch adds a new option that allows the tracing to be disabled and
re-enabled from inside xmon.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/powerpc/xmon/xmon.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 0cbd910193fa..19276d2f2f25 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -89,6 +89,7 @@ static unsigned long nidump = 16;
 static unsigned long ncsum = 4096;
 static int termch;
 static char tmpstr[128];
+static char tracing_enabled = 1;
 
 static long bus_error_jmp[JMP_BUF_LEN];
 static int catch_memory_errors;
@@ -268,6 +269,7 @@ Commands:\n\
   Sr #	read SPR #\n\
   Sw #v write v to SPR #\n\
   t	print backtrace\n\
+  v	trace enable/disable\n\
   x	exit monitor and recover\n\
   X	exit monitor and don't recover\n"
 #if defined(CONFIG_PPC64) && !defined(CONFIG_PPC_BOOK3E)
@@ -983,6 +985,17 @@ cmds(struct pt_regs *excp)
 		case 'x':
 		case 'X':
 			return cmd;
+		case 'v':
+			if (tracing_is_on()) {
+				printk("Disabling tracing\n");
+				tracing_enabled = 0;
+				tracing_off();
+			} else {
+				printk("Enabling tracing\n");
+				tracing_enabled = 1;
+				tracing_on();
+			}
+			break;
 		case EOF:
 			printf(" <no input ...>\n");
 			mdelay(2000);
@@ -2353,7 +2366,8 @@ static void dump_tracing(void)
 	else
 		ftrace_dump(DUMP_ALL);
 
-	tracing_on();
+	if (tracing_enabled)
+		tracing_on();
 }
 
 static void dump_all_pacas(void)
-- 
2.13.2
