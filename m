Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qW3Tt2n9bzDq72
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Mar 2016 22:04:18 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: bsingharora@gmail.com, duwe@lst.de, <linux-kernel@vger.kernel.org>,
 rostedt@goodmis.org, kamalesh@linux.vnet.ibm.com, pmladek@suse.com,
 jeyu@redhat.com, jkosina@suse.cz, live-patching@vger.kernel.org,
 mbenes@suse.cz
Subject: [PATCH HACK 1/6] livepatch-test: Add more cases
Date: Thu, 24 Mar 2016 22:04:00 +1100
Message-Id: <1458817445-5855-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Not for merging.

---
 arch/powerpc/kernel/setup_64.c       | 26 +++++++++++
 samples/livepatch/livepatch-sample.c | 90 ++++++++++++++++++++++++++++++++++--
 2 files changed, 113 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index f98be8383a39..3807fb05b6de 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -823,3 +823,29 @@ static int __init disable_hardlockup_detector(void)
 }
 early_initcall(disable_hardlockup_detector);
 #endif
+
+int func_with_lots_of_args(int a, int b, int c, int d, int e, int f, int g,
+			   int h, int i, int j, int k, int l)
+{
+	printk("%s: %d %d %d %d %d %d %d %d %d %d %d %d\n",
+	       __func__, a, b, c, d, e, f, g, h, i, j, k, l);
+
+	return a + b + c + d + e + f + g + h + i + j + k + l;
+}
+EXPORT_SYMBOL(func_with_lots_of_args);
+
+int func_with_nested_func(int a, int b, int c)
+{
+	volatile int z;
+
+	int noinline nested_sum (int x, int y) {
+		return z + x + y;
+	}
+
+	z = a + b;
+
+	printk("%s: %d %d\n", __func__, nested_sum(a, b), nested_sum(a, c));
+
+	return nested_sum(nested_sum(a, b), nested_sum(b, c));
+}
+EXPORT_SYMBOL(func_with_nested_func);
diff --git a/samples/livepatch/livepatch-sample.c b/samples/livepatch/livepatch-sample.c
index fb8c8614e728..b34ffa4f82ae 100644
--- a/samples/livepatch/livepatch-sample.c
+++ b/samples/livepatch/livepatch-sample.c
@@ -40,24 +40,108 @@
  */
 
 #include <linux/seq_file.h>
+
+static struct seq_file *cmdline_seq_file = NULL;
+
+int func_with_lots_of_args(int a, int b, int c, int d, int e, int f, int g,
+			   int h, int i, int j, int k, int l);
+
+int func_with_nested_func(int a, int b, int c);
+
 static int livepatch_cmdline_proc_show(struct seq_file *m, void *v)
 {
-	seq_printf(m, "%s\n", "this has been live patched");
+	int i, j;
+
+	cmdline_seq_file = m;
+
+	i = func_with_lots_of_args(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12);
+	j = func_with_nested_func(8, 9, 10);
+
+	seq_printf(m, "%s %p i = %d j = %d\n", "this has been live patched", m, i, j);
+
 	return 0;
 }
 
+static void livepatch_seq_printf(struct seq_file *m, const char *f, ...)
+{
+	va_list args;
+
+	va_start(args, f);
+	seq_vprintf(m, f, args);
+	va_end(args);
+
+	if (m == cmdline_seq_file) {
+		printk("livepatch: patched seq_printf() called\n");
+		dump_stack();
+		m = NULL;
+	}
+}
+
+static int livepatch_func_with_lots_of_args(int a, int b, int c, int d, int e,
+					    int f, int g, int h, int i, int j,
+					    int k, int l)
+{
+	printk("%s: %d %d %d %d %d %d %d %d %d %d %d %d\n",
+	       __func__, a, b, c, d, e, f, g, h, i, j, k, l);
+
+	return 1 + a + b + c + d + e + f + g + h + i + j + k + l;
+}
+
+struct scsi_lun {
+	__u8 scsi_lun[8];
+};
+
+static void livepatch_int_to_scsilun(u64 lun, struct scsi_lun *scsilun)
+{
+	int i;
+
+	memset(scsilun->scsi_lun, 0, sizeof(scsilun->scsi_lun));
+
+	for (i = 0; i < sizeof(lun); i += 2) {
+		scsilun->scsi_lun[i] = (lun >> 8) & 0xFF;
+		scsilun->scsi_lun[i+1] = lun & 0xFF;
+		lun = lun >> 16;
+	}
+
+	printk("livepatch: patched int_to_scsilun()\n");
+}
+
 static struct klp_func funcs[] = {
 	{
 		.old_name = "cmdline_proc_show",
 		.new_func = livepatch_cmdline_proc_show,
-	}, { }
+	},
+	{
+		.old_name = "seq_printf",
+		.new_func = livepatch_seq_printf,
+	},
+	{
+		.old_name = "func_with_lots_of_args",
+		.new_func = livepatch_func_with_lots_of_args,
+	},
+	{ }
+};
+
+static struct klp_func scsi_funcs[] = {
+	{
+		.old_name = "int_to_scsilun",
+		.new_func = livepatch_int_to_scsilun,
+	},
+	{ }
 };
 
 static struct klp_object objs[] = {
 	{
 		/* name being NULL means vmlinux */
 		.funcs = funcs,
-	}, { }
+	},
+	{
+#if IS_MODULE(CONFIG_SCSI)
+		.name = "scsi_mod",
+#endif
+		.funcs = scsi_funcs,
+	},
+	{ }
 };
 
 static struct klp_patch patch = {
-- 
2.5.0
