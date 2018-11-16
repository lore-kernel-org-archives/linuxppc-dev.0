Return-Path: <SRS0=5aIK=N3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9B8C43441
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 17:08:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79B5720811
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 17:08:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79B5720811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42xPny3DrbzF3mT
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Nov 2018 04:08:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42xPlq5QgkzF3nR
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Nov 2018 04:06:47 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42xPlk1sfgz9vBmn;
 Fri, 16 Nov 2018 18:06:42 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id GPpubZAbHbOS; Fri, 16 Nov 2018 18:06:42 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42xPlk1Jgqz9vBLK;
 Fri, 16 Nov 2018 18:06:42 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 0A0308B91D;
 Fri, 16 Nov 2018 18:06:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id E4rQYU0K49P3; Fri, 16 Nov 2018 18:06:43 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id C9E508B8C0;
 Fri, 16 Nov 2018 18:06:43 +0100 (CET)
Received: by po14163vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id B897969A5C; Fri, 16 Nov 2018 17:06:43 +0000 (UTC)
Message-Id: <535d3d1838d3599d4f7535a92e3b7872102f9ff4.1542387964.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/mm: dump segment registers on book3s/32
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Fri, 16 Nov 2018 17:06:43 +0000 (UTC)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This patch creates a debugfs file to see content of
segment registers

~# cat /sys/kernel/debug/segment_registers
---[ User Segments ]---
0x00000000-0x0fffffff Kern key 1 User key 1 VSID 0xade2b0
0x10000000-0x1fffffff Kern key 1 User key 1 VSID 0xade3c1
0x20000000-0x2fffffff Kern key 1 User key 1 VSID 0xade4d2
0x30000000-0x3fffffff Kern key 1 User key 1 VSID 0xade5e3
0x40000000-0x4fffffff Kern key 1 User key 1 VSID 0xade6f4
0x50000000-0x5fffffff Kern key 1 User key 1 VSID 0xade805
0x60000000-0x6fffffff Kern key 1 User key 1 VSID 0xade916
0x70000000-0x7fffffff Kern key 1 User key 1 VSID 0xadea27
0x80000000-0x8fffffff Kern key 1 User key 1 VSID 0xadeb38
0x90000000-0x9fffffff Kern key 1 User key 1 VSID 0xadec49
0xa0000000-0xafffffff Kern key 1 User key 1 VSID 0xaded5a
0xb0000000-0xbfffffff Kern key 1 User key 1 VSID 0xadee6b

---[ Kernel Segments ]---
0xc0000000-0xcfffffff Kern key 0 User key 1 VSID 0x000ccc
0xd0000000-0xdfffffff Kern key 0 User key 1 VSID 0x000ddd
0xe0000000-0xefffffff Kern key 0 User key 1 VSID 0x000eee
0xf0000000-0xffffffff Kern key 0 User key 1 VSID 0x000fff

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/Makefile  |  2 +-
 arch/powerpc/mm/dump_sr.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/mm/dump_sr.c

diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index 2adad10b5856..cf3e99ceb420 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -47,7 +47,7 @@ ifdef CONFIG_PPC_PTDUMP
 obj-$(CONFIG_4xx)		+= dump_linuxpagetables-generic.o
 obj-$(CONFIG_PPC_8xx)		+= dump_linuxpagetables-8xx.o
 obj-$(CONFIG_PPC_BOOK3E_MMU)	+= dump_linuxpagetables-generic.o
-obj-$(CONFIG_PPC_BOOK3S_32)	+= dump_linuxpagetables-generic.o dump_bats.o
+obj-$(CONFIG_PPC_BOOK3S_32)	+= dump_linuxpagetables-generic.o dump_bats.o dump_sr.o
 obj-$(CONFIG_PPC_BOOK3S_64)	+= dump_linuxpagetables-book3s64.o
 endif
 obj-$(CONFIG_PPC_HTDUMP)	+= dump_hashpagetable.o
diff --git a/arch/powerpc/mm/dump_sr.c b/arch/powerpc/mm/dump_sr.c
new file mode 100644
index 000000000000..057b60bcb6fc
--- /dev/null
+++ b/arch/powerpc/mm/dump_sr.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2018, Christophe Leroy CS S.I.
+ * <christophe.leroy@c-s.fr>
+ *
+ * This dumps the content of Segment Registers
+ */
+
+#include <linux/debugfs.h>
+
+static void seg_show(struct seq_file *m, int i)
+{
+	u32 val = mfsrin(i << 28);
+
+	seq_printf(m, "0x%01x0000000-0x%01xfffffff ", i, i);
+	seq_printf(m, "Kern key %d ", (val >> 30) & 1);
+	seq_printf(m, "User key %d ", (val >> 29) & 1);
+	if (val & 0x80000000) {
+		seq_printf(m, "Device 0x%03x", (val >> 20) & 0x1ff);
+		seq_printf(m, "-0x%05x", val & 0xfffff);
+	} else {
+		if (val & 0x10000000)
+			seq_puts(m, "No Exec ");
+		seq_printf(m, "VSID 0x%06x", val & 0xffffff);
+	}
+	seq_puts(m, "\n");
+}
+
+static int sr_show(struct seq_file *m, void *v)
+{
+	int i;
+
+	seq_puts(m, "---[ User Segments ]---\n");
+	for (i = 0; i < TASK_SIZE >> 28; i++)
+		seg_show(m, i);
+
+	seq_puts(m, "\n---[ Kernel Segments ]---\n");
+	for (; i < 16; i++)
+		seg_show(m, i);
+
+	return 0;
+}
+
+static int sr_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, sr_show, NULL);
+}
+
+static const struct file_operations sr_fops = {
+	.open		= sr_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int sr_init(void)
+{
+	struct dentry *debugfs_file;
+
+	debugfs_file = debugfs_create_file("segment_registers", 0400,
+					   NULL, NULL, &sr_fops);
+	return debugfs_file ? 0 : -ENOMEM;
+}
+device_initcall(sr_init);
-- 
2.13.3

