Return-Path: <geoffrey.levand@am.sony.com>
Received: from mgw3.sony.co.jp (MGW3.Sony.CO.JP [137.153.0.15])
	by ozlabs.org (Postfix) with ESMTP id 82A5167E71
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Nov 2006 19:44:31 +1100 (EST)
Received: from mail2.sony.co.jp (localhost [127.0.0.1])
	by mail2.sony.co.jp (R8/Sony) with ESMTP id kA88iUXG000253
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Nov 2006 17:44:30 +0900 (JST)
Received: from mailgw01.scei.sony.co.jp (mailgw01.scei.sony.co.jp [43.27.73.7])
	by mail2.sony.co.jp (R8/Sony) with SMTP id kA88iTqY000242
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Nov 2006 17:44:29 +0900 (JST)
Message-ID: <455198E7.8030201@am.sony.com>
Date: Wed, 08 Nov 2006 00:44:23 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] cell: replace spu.nid with spu.node
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Replace the use of the platform specific variable spu.nid with the
platform independednt variable spu.node.


Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---
Index: cell--common--6/arch/powerpc/platforms/cell/spu_base.c
===================================================================
--- cell--common--6.orig/arch/powerpc/platforms/cell/spu_base.c
+++ cell--common--6/arch/powerpc/platforms/cell/spu_base.c
@@ -810,14 +810,14 @@
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
 
