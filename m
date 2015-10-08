Return-Path: <sam.bobroff@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B05B71A0026
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Oct 2015 11:51:26 +1100 (AEDT)
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8531014010F
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Oct 2015 11:51:26 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sam.bobroff@au1.ibm.com>;
 Thu, 8 Oct 2015 10:51:25 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id AF3FD2CE8052
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Oct 2015 11:51:23 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t980pHH656754406
 for <linuxppc-dev@ozlabs.org>; Thu, 8 Oct 2015 11:51:25 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t980ooYF014634
 for <linuxppc-dev@ozlabs.org>; Thu, 8 Oct 2015 11:50:51 +1100
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: khandual@linux.vnet.ibm.com, mpe@ellerman.id.au
Subject: [PATCH v3 1/2] powerpc/xmon: Paged output for paca display
Date: Thu,  8 Oct 2015 11:50:23 +1100
Message-Id: <77516a018529fe23ca466db2ea513f7f03d820ec.1444265419.git.sam.bobroff@au1.ibm.com>
In-Reply-To: <cover.1444265419.git.sam.bobroff@au1.ibm.com>
References: <cover.1444265419.git.sam.bobroff@au1.ibm.com>
In-Reply-To: <cover.1444265419.git.sam.bobroff@au1.ibm.com>
References: <cover.1444265419.git.sam.bobroff@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The paca display is already more than 24 lines, which can be problematic
if you have an old school 80x24 terminal, or more likely you are on a
virtual terminal which does not scroll for whatever reason.

This patch adds a new command ".", which takes a single (hex) numeric
argument: lines per page. It will cause the output of "dp" and "dpa"
to be broken into pages, if necessary.

Sample output:

0:mon> .10
0:mon> dp1
paca for cpu 0x1 @ c00000000fdc0480:
 possible         = yes
 present          = yes
 online           = yes
 lock_token       = 0x8000            	(0x8)
 paca_index       = 0x1               	(0xa)
 kernel_toc       = 0xc000000000eb2400	(0x10)
 kernelbase       = 0xc000000000000000	(0x18)
 kernel_msr       = 0xb000000000001032	(0x20)
 emergency_sp     = 0xc00000003ffe8000	(0x28)
 mc_emergency_sp  = 0xc00000003ffe4000	(0x2e0)
 in_mce           = 0x0               	(0x2e8)
 data_offset      = 0x7f170000        	(0x30)
 hw_cpu_id        = 0x8               	(0x38)
 cpu_start        = 0x1               	(0x3a)
 kexec_state      = 0x0               	(0x3b)
[Hit a key (a:all, q:truncate, any:next page)]
0:mon>
 __current        = 0xc00000007e696620	(0x290)
 kstack           = 0xc00000007e6ebe30	(0x298)
 stab_rr          = 0xb               	(0x2a0)
 saved_r1         = 0xc00000007ef37860	(0x2a8)
 trap_save        = 0x0               	(0x2b8)
 soft_enabled     = 0x0               	(0x2ba)
 irq_happened     = 0x1               	(0x2bb)
 io_sync          = 0x0               	(0x2bc)
 irq_work_pending = 0x0               	(0x2bd)
 nap_state_lost   = 0x0               	(0x2be)
0:mon>

(Based on a similar patch by Michael Ellerman <mpe@ellerman.id.au>
"[v2] powerpc/xmon: Allow limiting the size of the paca display".
This patch is an alternative and cannot coexist with the original.)

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
---
 arch/powerpc/xmon/nonstdio.c | 57 ++++++++++++++++++++++++++++++++++++++++++--
 arch/powerpc/xmon/nonstdio.h |  3 +++
 arch/powerpc/xmon/xmon.c     | 18 ++++++++++++++
 3 files changed, 76 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/xmon/nonstdio.c b/arch/powerpc/xmon/nonstdio.c
index c987486..18819d7 100644
--- a/arch/powerpc/xmon/nonstdio.c
+++ b/arch/powerpc/xmon/nonstdio.c
@@ -11,10 +11,25 @@
 #include <asm/time.h>
 #include "nonstdio.h"
 
+int paginating = 0, paginate_skipping = 0;
+unsigned long paginate_lpp = 0 /* Lines Per Page */;
+unsigned long paginate_pos;
 
-static int xmon_write(const void *ptr, int nb)
+void xmon_start_pagination(void)
 {
-	return udbg_write(ptr, nb);
+	paginating = 1;
+	paginate_skipping = 0;
+	paginate_pos = 0;
+}
+
+void xmon_end_pagination(void)
+{
+	paginating = 0;
+}
+
+void xmon_set_pagination_lpp(unsigned long lpp)
+{
+	paginate_lpp = lpp;
 }
 
 static int xmon_readchar(void)
@@ -24,6 +39,44 @@ static int xmon_readchar(void)
 	return -1;
 }
 
+static int xmon_write(const char *ptr, int nb)
+{
+	int rv = 0;
+	const char *p = ptr, *q;
+	const char msg[] = "[Hit a key (a:all, q:truncate, any:next page)]";
+
+	if (nb <= 0)
+		return rv;
+	if (paginating && paginate_skipping)
+		return nb;
+	if (paginate_lpp) {
+		while (paginating && (q = strchr(p, '\n'))) {
+			rv += udbg_write(p, q - p + 1);
+			p = q + 1;
+			paginate_pos++;
+			if (paginate_pos >= paginate_lpp) {
+				udbg_write(msg, strlen(msg));
+				switch (xmon_readchar()) {
+				case 'a':
+					paginating = 0;
+					break;
+				case 'q':
+					paginate_skipping = 1;
+					break;
+				default:
+					/* nothing */
+					break;
+				}
+				paginate_pos = 0;
+				udbg_write("\r\n", 2);
+				if (paginate_skipping)
+					return nb;
+			}
+		}
+	}
+	return rv + udbg_write(p, nb - (p - ptr));
+}
+
 int xmon_putchar(int c)
 {
 	char ch = c;
diff --git a/arch/powerpc/xmon/nonstdio.h b/arch/powerpc/xmon/nonstdio.h
index 18a51de..f865336 100644
--- a/arch/powerpc/xmon/nonstdio.h
+++ b/arch/powerpc/xmon/nonstdio.h
@@ -3,6 +3,9 @@
 #define printf	xmon_printf
 #define putchar	xmon_putchar
 
+extern void xmon_set_pagination_lpp(unsigned long lpp);
+extern void xmon_start_pagination(void);
+extern void xmon_end_pagination(void);
 extern int xmon_putchar(int c);
 extern void xmon_puts(const char *);
 extern char *xmon_gets(char *, int);
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 6ef1231..cc070c3 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -242,6 +242,9 @@ Commands:\n\
 "  u	dump TLB\n"
 #endif
 "  ?	help\n"
+#ifdef CONFIG_PPC64
+"  .#	limit output to # lines per page (dump paca only)\n"
+#endif
 "  zr	reboot\n\
   zh	halt\n"
 ;
@@ -833,6 +836,16 @@ static void remove_cpu_bpts(void)
 	write_ciabr(0);
 }
 
+static void set_lpp_cmd(void)
+{
+	unsigned long lpp;
+
+	if (!scanhex(&lpp)) {
+		printf("Invalid number.\n");
+		lpp = 0;
+	}
+	xmon_set_pagination_lpp(lpp);
+}
 /* Command interpreting routine */
 static char *last_cmd;
 
@@ -924,6 +937,9 @@ cmds(struct pt_regs *excp)
 		case '?':
 			xmon_puts(help_string);
 			break;
+		case '.':
+			set_lpp_cmd();
+			break;
 		case 'b':
 			bpt_cmds();
 			break;
@@ -2166,7 +2182,9 @@ dump(void)
 
 #ifdef CONFIG_PPC64
 	if (c == 'p') {
+		xmon_start_pagination();
 		dump_pacas();
+		xmon_end_pagination();
 		return;
 	}
 #endif
-- 
2.1.4
