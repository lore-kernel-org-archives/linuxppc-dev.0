Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xwp3r0s2mzDqDy
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Sep 2017 00:17:11 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8IEEbme027643
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Sep 2017 10:17:09 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2d2e9yp34n-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Sep 2017 10:17:09 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Mon, 18 Sep 2017 08:17:08 -0600
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: gpiccoli@linux.vnet.ibm.com, muvic@linux.vnet.ibm.com,
 benh@kernel.crashing.org, mpe@ellerman.id.au, paulus@samba.org
Subject: [PATCH] powerpc/xmon: Add option to show uptime information
Date: Mon, 18 Sep 2017 11:16:58 -0300
Message-Id: <20170918141658.27948-1-gpiccoli@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It might be useful to quickly get the uptime of a running
system on xmon, without needing to grab data from memory and
doing math on struct addresses.

For example, it'd be useful to check for how long after a crash
a system is on xmon shell or if some test was started after the
first test crashed (and this 2nd test crashed too into xmon).

This small patch adds the 'U' command, to accomplish this.

Suggested-by: Murilo Fossa Vicentini <muvic@linux.vnet.ibm.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
---

Patch written against mpe's powerpc/next branch.

 arch/powerpc/xmon/xmon.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 33351c6704b1..a12f89f4916b 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -278,6 +278,7 @@ Commands:\n\
 #elif defined(CONFIG_44x) || defined(CONFIG_PPC_BOOK3E)
 "  u	dump TLB\n"
 #endif
+"  U	show uptime information\n"
 "  ?	help\n"
 "  # n	limit output to n lines per page (for dp, dpa, dl)\n"
 "  zr	reboot\n\
@@ -896,6 +897,24 @@ static void remove_cpu_bpts(void)
 	write_ciabr(0);
 }
 
+/* Based on uptime_proc_show(). */
+static void
+show_uptime(void)
+{
+	struct timespec uptime;
+
+	if (setjmp(bus_error_jmp) == 0) {
+		catch_memory_errors = 1;
+		sync();
+
+		get_monotonic_boottime(&uptime);
+		printf("Uptime: %lu.%.2lu\n", (unsigned long) uptime.tv_sec,
+			((unsigned long) uptime.tv_nsec / (NSEC_PER_SEC/100)));
+
+	}
+	catch_memory_errors = 0;
+}
+
 static void set_lpp_cmd(void)
 {
 	unsigned long lpp;
@@ -1031,6 +1050,9 @@ cmds(struct pt_regs *excp)
 			dump_tlb_book3e();
 			break;
 #endif
+		case 'U':
+			show_uptime();
+			break;
 		default:
 			printf("Unrecognized command: ");
 			do {
-- 
2.14.1
