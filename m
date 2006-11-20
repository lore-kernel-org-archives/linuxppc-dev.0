Return-Path: <arnd@arndb.de>
Message-Id: <20061120180523.217159000@arndb.de>
References: <20061120174454.067872000@arndb.de>
Date: Mon, 20 Nov 2006 18:45:02 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Subject: [PATCH 08/22] spufs: replace spu.nid with spu.node
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

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
@@ -835,14 +835,14 @@ static int spu_create_sysdev(struct spu 
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
 

--
