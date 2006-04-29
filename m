Return-Path: <arnd@arndb.de>
Message-Id: <20060429233919.767106000@localhost.localdomain>
References: <20060429232812.825714000@localhost.localdomain>
Date: Sun, 30 Apr 2006 01:28:14 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: paulus@samba.org
Subject: [PATCH 02/13] spufs: restore mapping of mssync register
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>, linuxppc-dev@ozlabs.org,
	cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

A recent change to the way that the mfc file gets mapped made it
impossible to map the SPE Multi-Source Synchronization register
into user space, but that may be needed by some applications.

This restores the missing functionality.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Index: linus-2.6/arch/powerpc/platforms/cell/spufs/file.c
===================================================================
--- linus-2.6.orig/arch/powerpc/platforms/cell/spufs/file.c	2006-04-29 22:47:55.000000000 +0200
+++ linus-2.6/arch/powerpc/platforms/cell/spufs/file.c	2006-04-29 22:53:41.000000000 +0200
@@ -825,6 +825,55 @@
 					spufs_signal2_type_set, "%llu");
 
 #ifdef CONFIG_SPUFS_MMAP
+static struct page *spufs_mss_mmap_nopage(struct vm_area_struct *vma,
+					   unsigned long address, int *type)
+{
+	return spufs_ps_nopage(vma, address, type, 0x0000);
+}
+
+static struct vm_operations_struct spufs_mss_mmap_vmops = {
+	.nopage = spufs_mss_mmap_nopage,
+};
+
+/*
+ * mmap support for problem state MFC DMA area [0x0000 - 0x0fff].
+ * Mapping this area requires that the application have CAP_SYS_RAWIO,
+ * as these registers require special care when read/writing.
+ */
+static int spufs_mss_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	if (!(vma->vm_flags & VM_SHARED))
+		return -EINVAL;
+
+	if (!capable(CAP_SYS_RAWIO))
+		return -EPERM;
+
+	vma->vm_flags |= VM_RESERVED;
+	vma->vm_page_prot = __pgprot(pgprot_val(vma->vm_page_prot)
+				     | _PAGE_NO_CACHE);
+
+	vma->vm_ops = &spufs_mss_mmap_vmops;
+	return 0;
+}
+#endif
+
+static int spufs_mss_open(struct inode *inode, struct file *file)
+{
+	struct spufs_inode_info *i = SPUFS_I(inode);
+
+	file->private_data = i->i_ctx;
+	return nonseekable_open(inode, file);
+}
+
+static struct file_operations spufs_mss_fops = {
+	.open	 = spufs_mss_open,
+#ifdef CONFIG_SPUFS_MMAP
+	.mmap	 = spufs_mss_mmap,
+#endif
+};
+
+
+#ifdef CONFIG_SPUFS_MMAP
 static struct page *spufs_mfc_mmap_nopage(struct vm_area_struct *vma,
 					   unsigned long address, int *type)
 {
@@ -1292,6 +1341,7 @@
 	{ "signal2", &spufs_signal2_fops, 0666, },
 	{ "signal1_type", &spufs_signal1_type, 0666, },
 	{ "signal2_type", &spufs_signal2_type, 0666, },
+	{ "mss", &spufs_mss_fops, 0666, },
 	{ "mfc", &spufs_mfc_fops, 0666, },
 	{ "cntl", &spufs_cntl_fops,  0666, },
 	{ "npc", &spufs_npc_ops, 0666, },

--
