Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: paulus@samba.org
MIME-Version: 1.0
Subject: [PATCH] fix compile warning in arch/powerpc/kernel/sysfs.c
Date: Fri, 17 Aug 2007 13:40:13 +1000
Message-ID: <7816.1187322013@neuling.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This fixes the following warning:
arch/powerpc/kernel/sysfs.c:388: warning: ignoring return value of
'sysfs_create_group', declared with attribute warn_unused_result

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kernel/sysfs.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

Index: linux-2.6-ozlabs/arch/powerpc/kernel/sysfs.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/sysfs.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/sysfs.c
@@ -378,14 +378,18 @@ EXPORT_SYMBOL_GPL(cpu_add_sysdev_attr);
 
 int cpu_add_sysdev_attr_group(struct attribute_group *attrs)
 {
-	int cpu;
+	int cpu, err;
 	struct sys_device *sysdev;
 
 	mutex_lock(&cpu_mutex);
 
 	for_each_possible_cpu(cpu) {
 		sysdev = get_cpu_sysdev(cpu);
-		sysfs_create_group(&sysdev->kobj, attrs);
+		err = sysfs_create_group(&sysdev->kobj, attrs);
+		if (err) {
+			mutex_unlock(&cpu_mutex);
+			return err;
+		}
 	}
 
 	mutex_unlock(&cpu_mutex);
