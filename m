Return-Path: <adobriyan@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 61EC7B7B66
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  7 Sep 2009 19:55:26 +1000 (EST)
Received: from mail-yx0-f178.google.com (mail-yx0-f178.google.com
	[209.85.210.178]) by ozlabs.org (Postfix) with ESMTP id AB5E8DDD04
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Sep 2009 19:55:22 +1000 (EST)
Received: by yxe8 with SMTP id 8so3296962yxe.17
	for <linuxppc-dev@ozlabs.org>; Mon, 07 Sep 2009 02:55:20 -0700 (PDT)
Date: Mon, 7 Sep 2009 13:31:25 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] seq_file: convert /proc/device-tree/ to seq_file
Message-ID: <20090907093124.GA3266@x200.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/proc_devtree.c |   41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

--- a/fs/proc/proc_devtree.c
+++ b/fs/proc/proc_devtree.c
@@ -7,6 +7,7 @@
 #include <linux/init.h>
 #include <linux/time.h>
 #include <linux/proc_fs.h>
+#include <linux/seq_file.h>
 #include <linux/stat.h>
 #include <linux/string.h>
 #include <asm/prom.h>
@@ -25,26 +26,27 @@ static struct proc_dir_entry *proc_device_tree;
 /*
  * Supply data on a read from /proc/device-tree/node/property.
  */
-static int property_read_proc(char *page, char **start, off_t off,
-			      int count, int *eof, void *data)
+static int property_proc_show(struct seq_file *m, void *v)
 {
-	struct property *pp = data;
-	int n;
+	struct property *pp = m->private;
 
-	if (off >= pp->length) {
-		*eof = 1;
-		return 0;
-	}
-	n = pp->length - off;
-	if (n > count)
-		n = count;
-	else
-		*eof = 1;
-	memcpy(page, (char *)pp->value + off, n);
-	*start = page;
-	return n;
+	seq_write(m, pp->value, pp->length);
+	return 0;
+}
+
+static int property_proc_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, property_proc_show, PDE(inode)->data);
 }
 
+static const struct file_operations property_proc_fops = {
+	.owner		= THIS_MODULE,
+	.open		= property_proc_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 /*
  * For a node with a name like "gc@10", we make symlinks called "gc"
  * and "@10" to it.
@@ -63,10 +65,9 @@ __proc_device_tree_add_prop(struct proc_dir_entry *de, struct property *pp,
 	 * Unfortunately proc_register puts each new entry
 	 * at the beginning of the list.  So we rearrange them.
 	 */
-	ent = create_proc_read_entry(name,
-				     strncmp(name, "security-", 9)
-				     ? S_IRUGO : S_IRUSR, de,
-				     property_read_proc, pp);
+	ent = proc_create_data(name,
+			       strncmp(name, "security-", 9) ? S_IRUGO : S_IRUSR,
+			       de, &property_proc_fops, pp);
 	if (ent == NULL)
 		return NULL;
 
