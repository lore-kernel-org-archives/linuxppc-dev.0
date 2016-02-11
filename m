Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8EFE41A003C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Feb 2016 18:37:41 +1100 (AEDT)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 53008140B8C
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Feb 2016 18:37:41 +1100 (AEDT)
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 11 Feb 2016 17:37:41 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id B635A2CE8054
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Feb 2016 18:37:35 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1B7bMD243057400
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Feb 2016 18:37:31 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1B7b3mu016267
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Feb 2016 18:37:03 +1100
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
To: linuxppc-dev@ozlabs.org, mpe@ellerman.id.au
Cc: stewart@linux.vnet.ibm.com, joel@jms.id.au
Subject: [PATCH V3 2/2] powerpc/xmon: add command to dump OPAL msglog
Date: Thu, 11 Feb 2016 18:36:20 +1100
Message-Id: <1455176180-19670-2-git-send-email-andrew.donnellan@au1.ibm.com>
In-Reply-To: <1455176180-19670-1-git-send-email-andrew.donnellan@au1.ibm.com>
References: <1455002269-26543-1-git-send-email-andrew.donnellan@au1.ibm.com>
 <1455176180-19670-1-git-send-email-andrew.donnellan@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add the 'do' command to dump the OPAL msglog in xmon.

Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
---
 arch/powerpc/xmon/xmon.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 07a8508..48b75ae 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -47,6 +47,11 @@
 #include <asm/debug.h>
 #include <asm/hw_breakpoint.h>
 
+#ifdef CONFIG_PPC_POWERNV
+#include <asm/opal.h>
+#include <asm/firmware.h>
+#endif
+
 #ifdef CONFIG_PPC64
 #include <asm/hvcall.h>
 #include <asm/paca.h>
@@ -119,6 +124,11 @@ static void dump(void);
 static void prdump(unsigned long, long);
 static int ppc_inst_dump(unsigned long, long, int);
 static void dump_log_buf(void);
+
+#ifdef CONFIG_PPC_POWERNV
+static void dump_opal_msglog(void);
+#endif
+
 static void backtrace(struct pt_regs *);
 static void excprint(struct pt_regs *);
 static void prregs(struct pt_regs *);
@@ -202,6 +212,10 @@ Commands:\n\
   df	dump float values\n\
   dd	dump double values\n\
   dl    dump the kernel log buffer\n"
+#ifdef CONFIG_PPC_POWERNV
+  "\
+  do    dump the OPAL message log\n"
+#endif
 #ifdef CONFIG_PPC64
   "\
   dp[#]	dump paca for current cpu, or cpu #\n\
@@ -2253,6 +2267,12 @@ dump(void)
 		last_cmd = "di\n";
 	} else if (c == 'l') {
 		dump_log_buf();
+	} else if (c == 'o') {
+#ifdef CONFIG_PPC_POWERNV
+		dump_opal_msglog();
+#else
+		printf("Machine is not running OPAL firmware.\n");
+#endif
 	} else if (c == 'r') {
 		scanhex(&ndump);
 		if (ndump == 0)
@@ -2395,6 +2415,46 @@ dump_log_buf(void)
 	catch_memory_errors = 0;
 }
 
+#ifdef CONFIG_PPC_POWERNV
+void
+dump_opal_msglog(void)
+{
+	unsigned char buf[128];
+	ssize_t res;
+	loff_t pos = 0;
+
+	if (!firmware_has_feature(FW_FEATURE_OPAL)) {
+		printf("Machine is not running OPAL firmware.\n");
+		return;
+	}
+
+	if (setjmp(bus_error_jmp) != 0) {
+		printf("Error dumping OPAL msglog!\n");
+		return;
+	}
+
+	catch_memory_errors = 1;
+	sync();
+
+	xmon_start_pagination();
+	while ((res = opal_msglog_copy(buf, pos, sizeof(buf) - 1))) {
+		if (res < 0) {
+			printf("Error dumping OPAL msglog! Error: %zd\n", res);
+			break;
+		}
+		buf[res] = '\0';
+		printf("%s", buf);
+		pos += res;
+	}
+	xmon_end_pagination();
+
+	sync();
+	/* wait a little while to see if we get a machine check */
+	__delay(200);
+	catch_memory_errors = 0;
+}
+#endif
+
 /*
  * Memory operations - move, set, print differences
  */
-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
