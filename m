Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id C9342DDFF2
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 20:03:47 +1100 (EST)
Date: Fri, 14 Dec 2007 03:09:15 -0600
From: Olof Johansson <olof@lixom.net>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] Fix build break caused by "ide: remove ideprobe_init()"
Message-ID: <20071214090915.GA28681@lixom.net>
References: <200711182325.09262.bzolnier@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200711182325.09262.bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix build break of powerpc holly_defconfig:

In file included from arch/powerpc/platforms/embedded6xx/holly.c:24:
include/linux/ide.h:1206: error: 'CONFIG_IDE_MAX_HWIFS' undeclared here (not in a function)

There's no need to have a sized array in the prototype, might as well
turn it into a pointer.

It could probably be argued that large parts of the include file can be
covered under #ifdef CONFIG_IDE, but that's a larger undertaking.


Signed-off-by: Olof Johansson <olof@lixom.net>

---

On Sun, Nov 18, 2007 at 11:25:09PM +0100, Bartlomiej Zolnierkiewicz wrote:
> 
> * Rename ide_device_add() to ide_device_add_all() and make it accept
>   'u8 idx[MAX_HWIFS]' instead of 'u8 idx[4]' as an argument.
> 
> * Add ide_device_add() wrapper for ide_device_add_all().
> 
> * Convert ide_generic_init() to use ide_device_add_all().
> 
> * Remove no longer needed ideprobe_init().
> 
> There should be no functionality changes caused by this patch.

This patch broke builds of powerpc holly_defconfig in -mm. It has
CONFIG_EMBEDDED=y, CONFIG_IDE=n but includes linux/ide.h:


Index: mm/drivers/ide/ide-probe.c
===================================================================
--- mm.orig/drivers/ide/ide-probe.c
+++ mm/drivers/ide/ide-probe.c
@@ -1335,7 +1335,7 @@ static void hwif_register_devices(ide_hw
 	}
 }
 
-int ide_device_add_all(u8 idx[MAX_HWIFS])
+int ide_device_add_all(u8 *idx)
 {
 	ide_hwif_t *hwif;
 	int i, rc = 0;
Index: mm/include/linux/ide.h
===================================================================
--- mm.orig/include/linux/ide.h
+++ mm/include/linux/ide.h
@@ -1203,7 +1203,7 @@ void ide_unregister_region(struct gendis
 
 void ide_undecoded_slave(ide_drive_t *);
 
-int ide_device_add_all(u8 idx[MAX_HWIFS]);
+int ide_device_add_all(u8 *idx);
 int ide_device_add(u8 idx[4]);
 
 static inline void *ide_get_hwifdata (ide_hwif_t * hwif)
