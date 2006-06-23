Return-Path: <arnd@arndb.de>
Message-Id: <20060623185824.868024000@klappe.arndb.de>
References: <20060623185746.037897000@klappe.arndb.de>
Date: Fri, 23 Jun 2006 20:57:49 +0200
From: arnd@arndb.de
To: paulus@samba.org
Subject: [PATCH 3/5] spufs: fix memory hotplug dependency
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>, linuxppc-dev@ozlabs.org,
	cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Geoff Levand <geoffrey.levand@am.sony.com>

spufs_base.c calls __add_pages, which depends on CONFIG_MEMORY_HOTPLUG.

Moved the selection of CONFIG_MEMORY_HOTPLUG from CONFIG_SPUFS_MMAP
to CONFIG_SPU_FS.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Index: linus-2.6/arch/powerpc/platforms/cell/Kconfig
===================================================================
--- linus-2.6.orig/arch/powerpc/platforms/cell/Kconfig
+++ linus-2.6/arch/powerpc/platforms/cell/Kconfig
@@ -6,6 +6,7 @@ config SPU_FS
 	default m
 	depends on PPC_CELL
 	select SPU_BASE
+	select MEMORY_HOTPLUG
 	help
 	  The SPU file system is used to access Synergistic Processing
 	  Units on machines implementing the Broadband Processor
@@ -18,7 +19,6 @@ config SPU_BASE
 config SPUFS_MMAP
 	bool
 	depends on SPU_FS && SPARSEMEM
-	select MEMORY_HOTPLUG
 	default y
 
 config CBE_RAS

--
