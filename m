Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2B42FB6F10
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Dec 2009 11:45:48 +1100 (EST)
Message-Id: <200912180045.nBI0j6Aa028424@imap1.linux-foundation.org>
Subject: [patch 4/5] iseries: convert to proc_fops
To: benh@kernel.crashing.org
From: akpm@linux-foundation.org
Date: Thu, 17 Dec 2009 16:45:05 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org, adobriyan@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Alexey Dobriyan <adobriyan@gmail.com>

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Ellerman <michael@ellerman.id.au>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/powerpc/platforms/iseries/mf.c |  147 ++++++++++++++------------
 1 file changed, 83 insertions(+), 64 deletions(-)

diff -puN arch/powerpc/platforms/iseries/mf.c~iseries-convert-to-proc_fops arch/powerpc/platforms/iseries/mf.c
--- a/arch/powerpc/platforms/iseries/mf.c~iseries-convert-to-proc_fops
+++ a/arch/powerpc/platforms/iseries/mf.c
@@ -855,59 +855,58 @@ static int mf_get_boot_rtc(struct rtc_ti
 }
 
 #ifdef CONFIG_PROC_FS
-
-static int proc_mf_dump_cmdline(char *page, char **start, off_t off,
-		int count, int *eof, void *data)
+static int mf_cmdline_proc_show(struct seq_file *m, void *v)
 {
-	int len;
-	char *p;
+	char *page, *p;
 	struct vsp_cmd_data vsp_cmd;
 	int rc;
 	dma_addr_t dma_addr;
 
 	/* The HV appears to return no more than 256 bytes of command line */
-	if (off >= 256)
-		return 0;
-	if ((off + count) > 256)
-		count = 256 - off;
+	page = kmalloc(256, GFP_KERNEL);
+	if (!page)
+		return -ENOMEM;
 
-	dma_addr = iseries_hv_map(page, off + count, DMA_FROM_DEVICE);
-	if (dma_addr == DMA_ERROR_CODE)
+	dma_addr = iseries_hv_map(page, 256, DMA_FROM_DEVICE);
+	if (dma_addr == DMA_ERROR_CODE) {
+		kfree(page);
 		return -ENOMEM;
-	memset(page, 0, off + count);
+	}
+	memset(page, 0, 256);
 	memset(&vsp_cmd, 0, sizeof(vsp_cmd));
 	vsp_cmd.cmd = 33;
 	vsp_cmd.sub_data.kern.token = dma_addr;
 	vsp_cmd.sub_data.kern.address_type = HvLpDma_AddressType_TceIndex;
-	vsp_cmd.sub_data.kern.side = (u64)data;
-	vsp_cmd.sub_data.kern.length = off + count;
+	vsp_cmd.sub_data.kern.side = (u64)m->private;
+	vsp_cmd.sub_data.kern.length = 256;
 	mb();
 	rc = signal_vsp_instruction(&vsp_cmd);
-	iseries_hv_unmap(dma_addr, off + count, DMA_FROM_DEVICE);
-	if (rc)
+	iseries_hv_unmap(dma_addr, 256, DMA_FROM_DEVICE);
+	if (rc) {
+		kfree(page);
 		return rc;
-	if (vsp_cmd.result_code != 0)
+	}
+	if (vsp_cmd.result_code != 0) {
+		kfree(page);
 		return -ENOMEM;
+	}
 	p = page;
-	len = 0;
-	while (len < (off + count)) {
-		if ((*p == '\0') || (*p == '\n')) {
-			if (*p == '\0')
-				*p = '\n';
-			p++;
-			len++;
-			*eof = 1;
+	while (p - page < 256) {
+		if (*p == '\0' || *p == '\n') {
+			*p = '\n';
 			break;
 		}
 		p++;
-		len++;
-	}
 
-	if (len < off) {
-		*eof = 1;
-		len = 0;
 	}
-	return len;
+	seq_write(m, page, p - page);
+	kfree(page);
+	return 0;
+}
+
+static int mf_cmdline_proc_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, mf_cmdline_proc_show, PDE(inode)->data);
 }
 
 #if 0
@@ -962,10 +961,8 @@ static int proc_mf_dump_vmlinux(char *pa
 }
 #endif
 
-static int proc_mf_dump_side(char *page, char **start, off_t off,
-		int count, int *eof, void *data)
+static int mf_side_proc_show(struct seq_file *m, void *v)
 {
-	int len;
 	char mf_current_side = ' ';
 	struct vsp_cmd_data vsp_cmd;
 
@@ -989,21 +986,17 @@ static int proc_mf_dump_side(char *page,
 		}
 	}
 
-	len = sprintf(page, "%c\n", mf_current_side);
+	seq_printf(m, "%c\n", mf_current_side);
+	return 0;
+}
 
-	if (len <= (off + count))
-		*eof = 1;
-	*start = page + off;
-	len -= off;
-	if (len > count)
-		len = count;
-	if (len < 0)
-		len = 0;
-	return len;
+static int mf_side_proc_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, mf_side_proc_show, NULL);
 }
 
-static int proc_mf_change_side(struct file *file, const char __user *buffer,
-		unsigned long count, void *data)
+static ssize_t mf_side_proc_write(struct file *file, const char __user *buffer,
+				  size_t count, loff_t *pos)
 {
 	char side;
 	u64 newSide;
@@ -1041,6 +1034,15 @@ static int proc_mf_change_side(struct fi
 	return count;
 }
 
+static const struct file_operations mf_side_proc_fops = {
+	.owner		= THIS_MODULE,
+	.open		= mf_side_proc_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+	.write		= mf_side_proc_write,
+};
+
 #if 0
 static void mf_getSrcHistory(char *buffer, int size)
 {
@@ -1087,8 +1089,7 @@ static void mf_getSrcHistory(char *buffe
 }
 #endif
 
-static int proc_mf_dump_src(char *page, char **start, off_t off,
-		int count, int *eof, void *data)
+static int mf_src_proc_show(struct seq_file *m, void *v)
 {
 #if 0
 	int len;
@@ -1109,8 +1110,13 @@ static int proc_mf_dump_src(char *page, 
 #endif
 }
 
-static int proc_mf_change_src(struct file *file, const char __user *buffer,
-		unsigned long count, void *data)
+static int mf_src_proc_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, mf_src_proc_show, NULL);
+}
+
+static ssize_t mf_src_proc_write(struct file *file, const char __user *buffer,
+				 size_t count, loff_t *pos)
 {
 	char stkbuf[10];
 
@@ -1135,9 +1141,19 @@ static int proc_mf_change_src(struct fil
 	return count;
 }
 
-static int proc_mf_change_cmdline(struct file *file, const char __user *buffer,
-		unsigned long count, void *data)
+static const struct file_operations mf_src_proc_fops = {
+	.owner		= THIS_MODULE,
+	.open		= mf_src_proc_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+	.write		= mf_src_proc_write,
+};
+
+static ssize_t mf_cmdline_proc_write(struct file *file, const char __user *buffer,
+				     size_t count, loff_t *pos)
 {
+	void *data = PDE(file->f_path.dentry->d_inode)->data;
 	struct vsp_cmd_data vsp_cmd;
 	dma_addr_t dma_addr;
 	char *page;
@@ -1172,6 +1188,15 @@ out:
 	return ret;
 }
 
+static const struct file_operations mf_cmdline_proc_fops = {
+	.owner		= THIS_MODULE,
+	.open		= mf_cmdline_proc_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+	.write		= mf_cmdline_proc_write,
+};
+
 static ssize_t proc_mf_change_vmlinux(struct file *file,
 				      const char __user *buf,
 				      size_t count, loff_t *ppos)
@@ -1246,12 +1271,10 @@ static int __init mf_proc_init(void)
 		if (!mf)
 			return 1;
 
-		ent = create_proc_entry("cmdline", S_IFREG|S_IRUSR|S_IWUSR, mf);
+		ent = proc_create_data("cmdline", S_IRUSR|S_IWUSR, mf,
+				       &mf_cmdline_proc_fops, (void *)(long)i);
 		if (!ent)
 			return 1;
-		ent->data = (void *)(long)i;
-		ent->read_proc = proc_mf_dump_cmdline;
-		ent->write_proc = proc_mf_change_cmdline;
 
 		if (i == 3)	/* no vmlinux entry for 'D' */
 			continue;
@@ -1263,19 +1286,15 @@ static int __init mf_proc_init(void)
 			return 1;
 	}
 
-	ent = create_proc_entry("side", S_IFREG|S_IRUSR|S_IWUSR, mf_proc_root);
+	ent = proc_create("side", S_IFREG|S_IRUSR|S_IWUSR, mf_proc_root,
+			  &mf_side_proc_fops);
 	if (!ent)
 		return 1;
-	ent->data = (void *)0;
-	ent->read_proc = proc_mf_dump_side;
-	ent->write_proc = proc_mf_change_side;
 
-	ent = create_proc_entry("src", S_IFREG|S_IRUSR|S_IWUSR, mf_proc_root);
+	ent = proc_create("src", S_IFREG|S_IRUSR|S_IWUSR, mf_proc_root,
+			  &mf_src_proc_fops);
 	if (!ent)
 		return 1;
-	ent->data = (void *)0;
-	ent->read_proc = proc_mf_dump_src;
-	ent->write_proc = proc_mf_change_src;
 
 	return 0;
 }
_
