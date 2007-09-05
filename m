Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id AA894DDE3C
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Sep 2007 13:36:26 +1000 (EST)
Date: Tue, 4 Sep 2007 21:43:17 -0500
From: Olof Johansson <olof@lixom.net>
To: paulus@samba.org
Subject: [PATCH] powerpc: Remove warning in arch/powerpc/kernel/sysfs.c
Message-ID: <20070905024317.GD27139@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

arch/powerpc/kernel/sysfs.c: In function 'cpu_add_sysdev_attr_group':
arch/powerpc/kernel/sysfs.c:388: warning: ignoring return value of
	'sysfs_create_group', declared with attribute warn_unused_result
    
Signed-off-by: Olof Johansson <olof@lixom.net>

diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index 55d29ed..63c0302 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -380,12 +380,14 @@ int cpu_add_sysdev_attr_group(struct attribute_group *attrs)
 {
 	int cpu;
 	struct sys_device *sysdev;
+	int ret;
 
 	mutex_lock(&cpu_mutex);
 
 	for_each_possible_cpu(cpu) {
 		sysdev = get_cpu_sysdev(cpu);
-		sysfs_create_group(&sysdev->kobj, attrs);
+		ret = sysfs_create_group(&sysdev->kobj, attrs);
+		WARN_ON(ret != 0);
 	}
 
 	mutex_unlock(&cpu_mutex);
