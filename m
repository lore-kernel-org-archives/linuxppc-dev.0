Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vPYXf3gRlzDqJv
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2017 11:18:42 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1H0EPuU146168
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 19:18:40 -0500
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28napme8r1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 19:18:39 -0500
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Thu, 16 Feb 2017 22:18:38 -0200
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.18.232.225])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 8AF643520068
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 19:18:01 -0500 (EST)
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1H0IY8I34930938
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 22:18:34 -0200
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1H0IXM3029622
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 22:18:34 -0200
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 npiggin@gmail.com, xinhui.pan@linux.vnet.ibm.com,
 gpiccoli@linux.vnet.ibm.com
Subject: [PATCH v2 3/3] powerpc/xmon: add debugfs entry for xmon
Date: Thu, 16 Feb 2017 22:17:57 -0200
In-Reply-To: <1487290677-7200-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
References: <1487290677-7200-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
Message-Id: <1487290677-7200-4-git-send-email-gpiccoli@linux.vnet.ibm.com>
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
command-line. Also, xmon may be accessed via sysrq mechanism.
But we cannot enable/disable xmon in runtime, it needs kernel reload.

This patch introduces a debugfs entry for xmon, allowing user to query
its current state and change it if desired. Basically, the "xmon" file
to read from/write to is under the debugfs mount point, on powerpc
directory. It's a simple attribute, value 0 meaning xmon is disabled
and value 1 the opposite. Writing these states to the file will take
immediate effect on the debugger.

Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
---
v2: dropped the custom parser by using simple attributes [mpe suggestion].

 arch/powerpc/xmon/xmon.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 03f5d65..5f03b3c 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -29,6 +29,10 @@
 #include <linux/nmi.h>
 #include <linux/ctype.h>
 
+#ifdef CONFIG_DEBUG_FS
+#include <linux/debugfs.h>
+#endif
+
 #include <asm/ptrace.h>
 #include <asm/string.h>
 #include <asm/prom.h>
@@ -3275,6 +3279,33 @@ static int __init setup_xmon_sysrq(void)
 device_initcall(setup_xmon_sysrq);
 #endif /* CONFIG_MAGIC_SYSRQ */
 
+#ifdef CONFIG_DEBUG_FS
+static int xmon_dbgfs_set(void *data, u64 val)
+{
+	xmon_off = !val;
+	xmon_init(!xmon_off);
+
+	return 0;
+}
+
+static int xmon_dbgfs_get(void *data, u64 *val)
+{
+	*val = !xmon_off;
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(xmon_dbgfs_ops, xmon_dbgfs_get,
+			xmon_dbgfs_set, "%llu\n");
+
+static int __init setup_xmon_dbgfs(void)
+{
+	debugfs_create_file("xmon", 0600, powerpc_debugfs_root, NULL,
+				&xmon_dbgfs_ops);
+	return 0;
+}
+device_initcall(setup_xmon_dbgfs);
+#endif /* CONFIG_DEBUG_FS */
+
 static int xmon_early __initdata;
 
 static int __init early_parse_xmon(char *p)
-- 
2.7.4
