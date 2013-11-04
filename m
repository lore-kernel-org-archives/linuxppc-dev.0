Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id EC5132C008E
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Nov 2013 13:20:47 +1100 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id rA42Kd86020434
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 3 Nov 2013 20:20:41 -0600
Message-ID: <1383531635.4776.40.camel@pasglop>
Subject: [PATCH] powerpc/scom: Improve debugfs interface
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Mon, 04 Nov 2013 13:20:35 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The current debugfs interface to scom is essentially unused
and racy. It uses two different files "address" and "data"
to perform accesses which is at best impractical for anything
but manual use by a developer.

This replaces it with an "access" file which represent the entire
scom address space which can be lseek/read/writen too.

This file only supports accesses that are 8 bytes aligned and
multiple of 8 bytes in size. The offset is logically the SCOM
address multiplied by 8.

Since nothing in userspace exploits that file at the moment, the ABI
change is a no-brainer.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

This replaces the previously posted

"powerpc/scom: Replace debugfs interface with cleaner sysfs"

After discussion with Greg KH, we decided that debugfs was the
right place to put that facility.

 arch/powerpc/sysdev/scom.c | 136 +++++++++++++++++++++++++++------------------
 1 file changed, 81 insertions(+), 55 deletions(-)

diff --git a/arch/powerpc/sysdev/scom.c b/arch/powerpc/sysdev/scom.c
index 3963d99..6f5a8d1 100644
--- a/arch/powerpc/sysdev/scom.c
+++ b/arch/powerpc/sysdev/scom.c
@@ -25,6 +25,7 @@
 #include <asm/debug.h>
 #include <asm/prom.h>
 #include <asm/scom.h>
+#include <asm/uaccess.h>
 
 const struct scom_controller *scom_controller;
 EXPORT_SYMBOL_GPL(scom_controller);
@@ -98,61 +99,89 @@ EXPORT_SYMBOL_GPL(scom_map_device);
 #ifdef CONFIG_SCOM_DEBUGFS
 struct scom_debug_entry {
 	struct device_node *dn;
-	unsigned long addr;
-	scom_map_t map;
-	spinlock_t lock;
-	char name[8];
-	struct debugfs_blob_wrapper blob;
+	struct debugfs_blob_wrapper path;
+	char name[16];
 };
 
-static int scom_addr_set(void *data, u64 val)
-{
-	struct scom_debug_entry *ent = data;
-
-	ent->addr = 0;
-	scom_unmap(ent->map);
-
-	ent->map = scom_map(ent->dn, val, 1);
-	if (scom_map_ok(ent->map))
-		ent->addr = val;
-	else
-		return -EFAULT;
-
-	return 0;
-}
-
-static int scom_addr_get(void *data, u64 *val)
+static ssize_t scom_debug_read(struct file *filp, char __user *ubuf,
+			       size_t count, loff_t *ppos)
 {
-	struct scom_debug_entry *ent = data;
-	*val = ent->addr;
-	return 0;
+	struct scom_debug_entry *ent = filp->private_data;
+	u64 __user *ubuf64 = (u64 __user *)ubuf;
+	loff_t off = *ppos;
+	ssize_t done = 0; 
+	u64 reg, reg_cnt, val;
+	scom_map_t map;
+	int rc;
+
+	if (off < 0 || (off & 7) || (count & 7))
+		return -EINVAL;
+	reg = off >> 3;
+	reg_cnt = count >> 3;
+
+	map = scom_map(ent->dn, reg, reg_cnt);
+	if (!scom_map_ok(map))
+		return -ENXIO;
+
+	for (reg = 0; reg < reg_cnt; reg++) {
+		rc = scom_read(map, reg, &val);
+		if (!rc)
+			rc = put_user(val, ubuf64);
+		if (rc) {
+			if (!done)
+				done = rc;
+			break;
+		}
+		ubuf64++;
+		*ppos += 8;
+		done += 8;
+	}
+	scom_unmap(map);
+	return done;
 }
-DEFINE_SIMPLE_ATTRIBUTE(scom_addr_fops, scom_addr_get, scom_addr_set,
-			"0x%llx\n");
 
-static int scom_val_set(void *data, u64 val)
+static ssize_t scom_debug_write(struct file* filp, const char __user *ubuf,
+				size_t count, loff_t *ppos)
 {
-	struct scom_debug_entry *ent = data;
-
-	if (!scom_map_ok(ent->map))
-		return -EFAULT;
-
-	scom_write(ent->map, 0, val);
-
-	return 0;
+	struct scom_debug_entry *ent = filp->private_data;
+	u64 __user *ubuf64 = (u64 __user *)ubuf;
+	loff_t off = *ppos;
+	ssize_t done = 0; 
+	u64 reg, reg_cnt, val;
+	scom_map_t map;
+	int rc;
+
+	if (off < 0 || (off & 7) || (count & 7))
+		return -EINVAL;
+	reg = off >> 3;
+	reg_cnt = count >> 3;
+
+	map = scom_map(ent->dn, reg, reg_cnt);
+	if (!scom_map_ok(map))
+		return -ENXIO;
+
+	for (reg = 0; reg < reg_cnt; reg++) {
+		rc = get_user(val, ubuf64);
+		if (!rc)
+			rc = scom_write(map, reg,  val);
+		if (rc) {
+			if (!done)
+				done = rc;
+			break;
+		}
+		ubuf64++;
+		done += 8;
+	}
+	scom_unmap(map);
+	return done;
 }
 
-static int scom_val_get(void *data, u64 *val)
-{
-	struct scom_debug_entry *ent = data;
-
-	if (!scom_map_ok(ent->map))
-		return -EFAULT;
-
-	return scom_read(ent->map, 0, val);
-}
-DEFINE_SIMPLE_ATTRIBUTE(scom_val_fops, scom_val_get, scom_val_set,
-			"0x%llx\n");
+static const struct file_operations scom_debug_fops = {
+	.read =		scom_debug_read,
+	.write =	scom_debug_write,
+	.open =		simple_open,
+	.llseek =	default_llseek,
+};
 
 static int scom_debug_init_one(struct dentry *root, struct device_node *dn,
 			       int i)
@@ -165,11 +194,9 @@ static int scom_debug_init_one(struct dentry *root, struct device_node *dn,
 		return -ENOMEM;
 
 	ent->dn = of_node_get(dn);
-	ent->map = SCOM_MAP_INVALID;
-	spin_lock_init(&ent->lock);
-	snprintf(ent->name, 8, "scom%d", i);
-	ent->blob.data = (void*) dn->full_name;
-	ent->blob.size = strlen(dn->full_name);
+	snprintf(ent->name, 16, "%08x", i);
+	ent->path.data = (void*) dn->full_name;
+	ent->path.size = strlen(dn->full_name);
 
 	dir = debugfs_create_dir(ent->name, root);
 	if (!dir) {
@@ -178,9 +205,8 @@ static int scom_debug_init_one(struct dentry *root, struct device_node *dn,
 		return -1;
 	}
 
-	debugfs_create_file("addr", 0600, dir, ent, &scom_addr_fops);
-	debugfs_create_file("value", 0600, dir, ent, &scom_val_fops);
-	debugfs_create_blob("devspec", 0400, dir, &ent->blob);
+	debugfs_create_blob("devspec", 0400, dir, &ent->path);
+	debugfs_create_file("access", 0600, dir, ent, &scom_debug_fops);
 
 	return 0;
 }
