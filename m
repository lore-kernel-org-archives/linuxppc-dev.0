Return-Path: <arnd@arndb.de>
Message-Id: <20071218175107.145430000@arndb.de>
References: <20071218174852.112644000@arndb.de>
Date: Tue, 18 Dec 2007 18:49:10 +0100
From: arnd@arndb.de
To: paulus@samba.org
Subject: [POWERPC 18/18] cell: catch errors from sysfs_create_group()
Cc: linuxppc-dev@ozlabs.org, Jeremy Kerr <jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We're currently getting a warning from not checking the result of
sysfs_create_group, which is declared as __must_check.

This change introduces appropriate error-handling for
spu_add_sysdev_attr_group()

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/platforms/cell/spu_base.c |   20 +++++++++++++++++---
 1 files changed, 17 insertions(+), 3 deletions(-)

Index: linux-2.6-new/arch/powerpc/platforms/cell/spu_base.c
===================================================================
--- linux-2.6-new.orig/arch/powerpc/platforms/cell/spu_base.c
+++ linux-2.6-new/arch/powerpc/platforms/cell/spu_base.c
@@ -574,13 +574,27 @@ EXPORT_SYMBOL_GPL(spu_add_sysdev_attr);
 int spu_add_sysdev_attr_group(struct attribute_group *attrs)
 {
 	struct spu *spu;
+	int rc = 0;
 
 	mutex_lock(&spu_full_list_mutex);
-	list_for_each_entry(spu, &spu_full_list, full_list)
-		sysfs_create_group(&spu->sysdev.kobj, attrs);
+	list_for_each_entry(spu, &spu_full_list, full_list) {
+		rc = sysfs_create_group(&spu->sysdev.kobj, attrs);
+
+		/* we're in trouble here, but try unwinding anyway */
+		if (rc) {
+			printk(KERN_ERR "%s: can't create sysfs group '%s'\n",
+					__func__, attrs->name);
+
+			list_for_each_entry_continue_reverse(spu,
+					&spu_full_list, full_list)
+				sysfs_remove_group(&spu->sysdev.kobj, attrs);
+			break;
+		}
+	}
+
 	mutex_unlock(&spu_full_list_mutex);
 
-	return 0;
+	return rc;
 }
 EXPORT_SYMBOL_GPL(spu_add_sysdev_attr_group);
 

-- 
