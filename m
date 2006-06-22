Return-Path: <mkravetz@us.ibm.com>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 78DD467A0E
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jun 2006 10:08:07 +1000 (EST)
Received: from e3.ny.us.ibm.com ([192.168.1.103])
	by pokfb.esmtp.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k5MN0Ak6031613
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jun 2006 19:00:10 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k5MN05Go031358
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jun 2006 19:00:06 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k5MN05Bd147910
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jun 2006 19:00:05 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k5MN05fq012105
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jun 2006 19:00:05 -0400
Date: Thu, 22 Jun 2006 16:00:21 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/3] powerpc: Instrument Hypervisor Calls: add debugfs files
Message-ID: <20060622230021.GD4877@w-mikek2.ibm.com>
References: <20060622225609.GA4877@w-mikek2.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060622225609.GA4877@w-mikek2.ibm.com>
Cc: Bryan Rosenburg <rosnbrg@us.ibm.com>, Christopher Yeoh <cyeoh@samba.org>,
	Nathan Lynch <ntl@pobox.com>, Arnd Bergmann <arnd@arndb.de>
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

diff -Naupr linux-2.6.17.1/arch/powerpc/platforms/pseries/hvCall_inst.c linux-2.6.17.1.work/arch/powerpc/platforms/pseries/hvCall_inst.c
--- linux-2.6.17.1/arch/powerpc/platforms/pseries/hvCall_inst.c	2006-06-22 23:02:50.000000000 +0000
+++ linux-2.6.17.1.work/arch/powerpc/platforms/pseries/hvCall_inst.c	2006-06-22 23:03:55.000000000 +0000
@@ -217,3 +217,94 @@ long plpar_hcall_9arg_9ret(unsigned long
 	preempt_enable();
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
