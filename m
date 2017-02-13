Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vMdHl2xnfzDqBQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 08:00:51 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1DKwpE4101018
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Feb 2017 16:00:49 -0500
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28kk8mtav1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Feb 2017 16:00:49 -0500
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Mon, 13 Feb 2017 19:00:46 -0200
Received: from d24relay04.br.ibm.com (d24relay04.br.ibm.com [9.18.232.146])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 51FAA1DC006F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Feb 2017 16:00:46 -0500 (EST)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay04.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1DL0ji428311740
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Feb 2017 19:00:45 -0200
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1DL0je5013083
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Feb 2017 19:00:46 -0200
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 npiggin@gmail.com, xinhui.pan@linux.vnet.ibm.com,
 gpiccoli@linux.vnet.ibm.com
Subject: [PATCH] powerpc/xmon: add debugfs entry for xmon
Date: Mon, 13 Feb 2017 19:00:42 -0200
Message-Id: <1487019642-11411-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently the xmon debugger is set only via kernel boot command-line.
It's disabled by default, and can be enabled with "xmon=on" on the
command-line. Also, xmon may be accessed via sysrq mechanism, but once
we enter xmon via sysrq,  it's  kept enabled until system is rebooted,
even if we exit the debugger. A kernel crash will then lead to xmon
instance, instead of triggering a kdump procedure (if configured), for
example.

This patch introduces a debugfs entry for xmon, allowing user to query
its current state and change it if desired. Basically, the "xmon" file
to read from/write to is under the debugfs mount point, on powerpc
directory. Reading this file will provide the current state of the
debugger, one of the following: "on", "off", "early" or "nobt". Writing
one of these states to the file will take immediate effect on the debugger.

Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
---
* I had this patch partially done for some time, and after a discussion
at the kernel slack channel latest week, I decided to rebase and fix
some remaining bugs. I'd change 'x' option to always disable the debugger,
since with this patch we can always re-enable xmon, but today I noticed
Pan's patch on the mailing list, so perhaps his approach of adding a flag
to 'x' option is preferable. I can change this in a V2, if requested.
Thanks in advance!

 arch/powerpc/xmon/xmon.c | 124 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 105 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 9c0e17c..5fb39db 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -29,6 +29,12 @@
 #include <linux/nmi.h>
 #include <linux/ctype.h>
 
+#ifdef CONFIG_DEBUG_FS
+#include <linux/debugfs.h>
+#include <linux/uaccess.h>
+#include <linux/slab.h>
+#endif
+
 #include <asm/ptrace.h>
 #include <asm/string.h>
 #include <asm/prom.h>
@@ -184,7 +190,12 @@ static void dump_tlb_44x(void);
 static void dump_tlb_book3e(void);
 #endif
 
-static int xmon_no_auto_backtrace;
+/* xmon_state values */
+#define XMON_OFF	0
+#define XMON_ON	1
+#define XMON_EARLY	2
+#define XMON_NOBT	3
+static int xmon_state;
 
 #ifdef CONFIG_PPC64
 #define REG		"%.16lx"
@@ -880,8 +891,8 @@ cmds(struct pt_regs *excp)
 	last_cmd = NULL;
 	xmon_regs = excp;
 
-	if (!xmon_no_auto_backtrace) {
-		xmon_no_auto_backtrace = 1;
+	if (xmon_state != XMON_NOBT) {
+		xmon_state = XMON_NOBT;
 		xmon_show_stack(excp->gpr[1], excp->link, excp->nip);
 	}
 
@@ -3244,6 +3255,26 @@ static void xmon_init(int enable)
 	}
 }
 
+static int parse_xmon(char *p)
+{
+	if (!p || strncmp(p, "early", 5) == 0) {
+		/* just "xmon" is equivalent to "xmon=early" */
+		xmon_init(1);
+		xmon_state = XMON_EARLY;
+	} else if (strncmp(p, "on", 2) == 0) {
+		xmon_init(1);
+		xmon_state = XMON_ON;
+	} else if (strncmp(p, "off", 3) == 0) {
+		xmon_init(0);
+		xmon_state = XMON_OFF;
+	} else if (strncmp(p, "nobt", 4) == 0)
+		xmon_state = XMON_NOBT;
+	else
+		return 1;
+
+	return 0;
+}
+
 #ifdef CONFIG_MAGIC_SYSRQ
 static void sysrq_handle_xmon(int key)
 {
@@ -3266,34 +3297,89 @@ static int __init setup_xmon_sysrq(void)
 __initcall(setup_xmon_sysrq);
 #endif /* CONFIG_MAGIC_SYSRQ */
 
-static int __initdata xmon_early, xmon_off;
+#ifdef CONFIG_DEBUG_FS
+static ssize_t xmon_dbgfs_read(struct file *file, char __user *ubuffer,
+				size_t len, loff_t *offset)
+{
+	int buf_len = 0;
+	char buf[6] = { 0 };
 
-static int __init early_parse_xmon(char *p)
+	switch (xmon_state) {
+	case XMON_OFF:
+		buf_len = sprintf(buf, "off");
+		break;
+	case XMON_ON:
+		buf_len = sprintf(buf, "on");
+		break;
+	case XMON_EARLY:
+		buf_len = sprintf(buf, "early");
+		break;
+	case XMON_NOBT:
+		buf_len = sprintf(buf, "nobt");
+		break;
+	}
+
+	return simple_read_from_buffer(ubuffer, len, offset, buf, buf_len);
+}
+
+static ssize_t xmon_dbgfs_write(struct file *file, const char __user *ubuffer,
+				size_t len, loff_t *offset)
 {
-	if (!p || strncmp(p, "early", 5) == 0) {
-		/* just "xmon" is equivalent to "xmon=early" */
-		xmon_init(1);
-		xmon_early = 1;
-	} else if (strncmp(p, "on", 2) == 0)
-		xmon_init(1);
-	else if (strncmp(p, "off", 3) == 0)
-		xmon_off = 1;
-	else if (strncmp(p, "nobt", 4) == 0)
-		xmon_no_auto_backtrace = 1;
-	else
-		return 1;
+	int ret, not_copied;
+	char *buf;
+
+	/* Valid states are on, off, early and nobt. */
+	if ((*offset != 0) || (len <= 0) || (len > 6))
+                return -EINVAL;
+
+	buf = kzalloc(len + 1, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	not_copied = copy_from_user(buf, ubuffer, len);
+	if (not_copied) {
+		kfree(buf);
+		return -EFAULT;
+        }
 
+	ret = parse_xmon(buf);
+	kfree(buf);
+
+	/* parse_xmon returns 0 on success. */
+	if (ret)
+		return -EINVAL;
+	return len;
+}
+
+static const struct file_operations xmon_dbgfs_ops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.read = xmon_dbgfs_read,
+	.write = xmon_dbgfs_write,
+};
+
+static int __init setup_xmon_dbgfs(void)
+{
+	debugfs_create_file("xmon", 0600, powerpc_debugfs_root, NULL,
+			    &xmon_dbgfs_ops);
 	return 0;
 }
+__initcall(setup_xmon_dbgfs);
+#endif /*CONFIG_DEBUG_FS*/
+
+static int __init early_parse_xmon(char *p)
+{
+	return parse_xmon(p);
+}
 early_param("xmon", early_parse_xmon);
 
 void __init xmon_setup(void)
 {
 #ifdef CONFIG_XMON_DEFAULT
-	if (!xmon_off)
+	if (xmon_state) /* XMON_OFF */
 		xmon_init(1);
 #endif
-	if (xmon_early)
+	if (xmon_state == XMON_EARLY)
 		debugger(NULL);
 }
 
-- 
2.7.4
