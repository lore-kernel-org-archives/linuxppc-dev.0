Return-Path: <mkravetz@us.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 445C967B72
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Jul 2006 09:41:35 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k6ENfVql028128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Jul 2006 19:41:31 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k6ENfV3Z180060
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Jul 2006 17:41:31 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k6ENfU7B021918
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Jul 2006 17:41:31 -0600
Date: Fri, 14 Jul 2006 16:41:34 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 3/3] powerpc: Instrument Hypervisor Calls: add debugfs files
Message-ID: <20060714234134.GD11487@monkey.ibm.com>
References: <20060714233739.GA11487@monkey.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060714233739.GA11487@monkey.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Bryan Rosenburg <rosnbrg@us.ibm.com>,
	linuxppc-dev@ozlabs.org, Nathan Lynch <ntl@pobox.com>,
	Christopher Yeoh <cyeoh@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Make statistics available via files in debugfs.
--
Signed-off-by: Mike Kravetz <kravetz@us.ibm.com>

diff -Naupr linux-2.6.17.4/arch/powerpc/platforms/pseries/hvCall_inst.c linux-2.6.17.4.work/arch/powerpc/platforms/pseries/hvCall_inst.c
--- linux-2.6.17.4/arch/powerpc/platforms/pseries/hvCall_inst.c	2006-07-14 23:32:01.000000000 +0000
+++ linux-2.6.17.4.work/arch/powerpc/platforms/pseries/hvCall_inst.c	2006-07-14 23:32:54.000000000 +0000
@@ -205,3 +205,94 @@ long plpar_hcall_9arg_9ret(unsigned long
 	update_stats(opcode, t_before);
 	return rc;
 }
+
+/*
+ * Routines for displaying the statistics in debugfs
+ */
+static void *hc_start(struct seq_file *m, loff_t *pos)
+{
+	if ((int)*pos < MAX_HCALL_OPCODES)
+		return (void *)(unsigned long)(*pos + 1);
+
+	return NULL;
+}
+
+static void *hc_next(struct seq_file *m, void *p, loff_t * pos)
+{
+	++*pos;
+
+	return hc_start(m, pos);
+}
+
+static void hc_stop(struct seq_file *m, void *p)
+{
+}
+
+static int hc_show(struct seq_file *m, void *p)
+{
+	unsigned long h_num = (unsigned long)p;
+	struct hcall_stats *hs = (struct hcall_stats *)m->private;
+
+	if (hs[h_num].num_calls)
+		seq_printf(m, "%lu %lu %lu\n", h_num<<2, hs[h_num].num_calls,
+			   hs[h_num].total_time);
+
+	return 0;
+}
+
+static struct seq_operations hcall_inst_seq_ops = {
+        .start = hc_start,
+        .next  = hc_next,
+        .stop  = hc_stop,
+        .show  = hc_show
+};
+
+static int hcall_inst_seq_open(struct inode *inode, struct file *file)
+{
+	int rc;
+	struct seq_file *seq;
+
+	rc = seq_open(file, &hcall_inst_seq_ops);
+	seq = file->private_data;
+	seq->private = file->f_dentry->d_inode->u.generic_ip;
+
+	return rc;
+}
+
+static struct file_operations hcall_inst_seq_fops = {
+	.open = hcall_inst_seq_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
+#define	HCALL_ROOT_DIR		"hcall_inst"
+#define CPU_NAME_BUF_SIZE	32
+
+static int __init hcall_inst_init(void)
+{
+	struct dentry *hcall_root;
+	struct dentry *hcall_file;
+	char cpu_name_buf[CPU_NAME_BUF_SIZE];
+	int cpu;
+
+	if (!firmware_has_feature(FW_FEATURE_LPAR))
+		return 0;
+
+	hcall_root = debugfs_create_dir(HCALL_ROOT_DIR, NULL);
+	if (!hcall_root)
+		return -ENOMEM;
+
+	for_each_cpu(cpu) {
+		snprintf(cpu_name_buf, CPU_NAME_BUF_SIZE, "cpu%d", cpu);
+		hcall_file = debugfs_create_file(cpu_name_buf, S_IRUGO,
+						 hcall_root,
+						 per_cpu(hcall_stats, cpu),
+						 &hcall_inst_seq_fops);
+		if (!hcall_file)
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+__initcall(hcall_inst_init);
