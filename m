Return-Path: <geoffrey.levand@am.sony.com>
Received: from mgw2.sony.co.jp (MGW2.Sony.CO.JP [137.153.0.14])
	by ozlabs.org (Postfix) with ESMTP id 44B7E68473
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Nov 2006 07:01:22 +1100 (EST)
Received: from mail6.sony.co.jp (localhost [127.0.0.1])
	by mail6.sony.co.jp (R8/Sony) with ESMTP id kAAK1KKL007979
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Nov 2006 05:01:20 +0900 (JST)
Received: from mailgw01.scei.sony.co.jp (mailgw01.scei.sony.co.jp [43.27.73.7])
	by mail6.sony.co.jp (R8/Sony) with SMTP id kAAK1Kcs007945
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Nov 2006 05:01:20 +0900 (JST)
Message-ID: <4554DA8A.4090407@am.sony.com>
Date: Fri, 10 Nov 2006 12:01:14 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 5/16] cell: replace spu.nid with spu.node
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
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
 arch/powerpc/platforms/cell/spu_base.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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
 
