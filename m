Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vpKVy45GQzDqbD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Mar 2017 06:29:14 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2MJNpr4193384
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 15:29:12 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29b9vm770g-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 15:29:12 -0400
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Wed, 22 Mar 2017 16:29:10 -0300
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2MJSq4p40435752
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 16:29:00 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2MJSTbf028722
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 16:28:29 -0300
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: gpiccoli@linux.vnet.ibm.com, xinhui.pan@linux.vnet.ibm.com,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Subject: [PATCH v4 3/3] powerpc/xmon: add debugfs entry for xmon
Date: Wed, 22 Mar 2017 16:27:51 -0300
In-Reply-To: <20170322192751.30531-1-gpiccoli@linux.vnet.ibm.com>
References: <20170322192751.30531-1-gpiccoli@linux.vnet.ibm.com>
Message-Id: <20170322192751.30531-4-gpiccoli@linux.vnet.ibm.com>
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
immediate effect in the debugger.

Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
---
v4: fixed a bug in the patch (s/xmon_off/xmon_on/g basically).

v3: logic improved based in the changes made on patch 1.

 arch/powerpc/xmon/xmon.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 25a32815f310..0fab9d7349eb 100644
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
@@ -3316,6 +3320,33 @@ static int __init setup_xmon_sysrq(void)
 device_initcall(setup_xmon_sysrq);
 #endif /* CONFIG_MAGIC_SYSRQ */
 
+#ifdef CONFIG_DEBUG_FS
+static int xmon_dbgfs_set(void *data, u64 val)
+{
+	xmon_on = !!val;
+	xmon_init(xmon_on);
+
+	return 0;
+}
+
+static int xmon_dbgfs_get(void *data, u64 *val)
+{
+	*val = xmon_on;
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
2.11.0
