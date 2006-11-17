Return-Path: <geoffrey.levand@am.sony.com>
Received: from mgw3.sony.co.jp (MGW3.Sony.CO.JP [137.153.0.15])
	by ozlabs.org (Postfix) with ESMTP id 64FCE67BD2
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 14:41:36 +1100 (EST)
Received: from mail5.sony.co.jp (localhost [127.0.0.1])
	by mail5.sony.co.jp (R8/Sony) with ESMTP id kAH3fVsa024256
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 12:41:31 +0900 (JST)
Received: from mailgw01.scei.sony.co.jp (mailgw01.scei.sony.co.jp [43.27.73.7])
	by mail5.sony.co.jp (R8/Sony) with SMTP id kAH3fUdI024240
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 12:41:30 +0900 (JST)
Message-ID: <455D2F65.709@am.sony.com>
Date: Thu, 16 Nov 2006 19:41:25 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 1/16] cell: replace spu.nid with spu.node
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Subject: cell: replace spu.nid with spu.node

From: Geoff Levand <geoffrey.levand@am.sony.com>
Replace the use of the platform specific variable spu.nid with the
platform independednt variable spu.node.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

---
Index: linux-2.6/arch/powerpc/platforms/cell/spu_base.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spu_base.c
+++ linux-2.6/arch/powerpc/platforms/cell/spu_base.c
@@ -810,14 +810,14 @@ static int spu_create_sysdev(struct spu 
 		return ret;
 	}
 
-	sysfs_add_device_to_node(&spu->sysdev, spu->nid);
+	sysfs_add_device_to_node(&spu->sysdev, spu->node);
 
 	return 0;
 }
 
 static void spu_destroy_sysdev(struct spu *spu)
 {
-	sysfs_remove_device_from_node(&spu->sysdev, spu->nid);
+	sysfs_remove_device_from_node(&spu->sysdev, spu->node);
 	sysdev_unregister(&spu->sysdev);
 }
 
