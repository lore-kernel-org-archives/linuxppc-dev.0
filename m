Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0CB48DEADA
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 08:35:38 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m2PLZXar004109
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Mar 2008 14:35:34 -0700 (MST)
From: Timur Tabi <timur@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Enable CONFIG_FORCE_MAX_ZONEORDER for all PowerPC,
	and make selectable
Date: Tue, 25 Mar 2008 16:35:32 -0500
Message-Id: <1206480932-30190-1-git-send-email-timur@freescale.com>
Cc: Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch enables the FORCE_MAX_ZONEORDER Kconfig option for all PowerPC
systems.  Previously, it was enabled only for 64-bit systems.  We also make
the option selectable from the menu, so that the user can specify different
values.  This is useful for 32-bit systems that need to allocate more than
4MB of physically contiguous memory.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

I tested this on a Freescale 8610 32-bit PowerPC system, and when I increased
CONFIG_FORCE_MAX_ZONEORDER to 13, I was able to allocate 5MB of memory via
__get_free_pages(), so this change should be safe.

 arch/powerpc/Kconfig |   23 +++++++++++++++++------
 1 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index ef12db0..4e7eec8 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -211,14 +211,25 @@ source kernel/Kconfig.hz
 source kernel/Kconfig.preempt
 source "fs/Kconfig.binfmt"
 
-# We optimistically allocate largepages from the VM, so make the limit
-# large enough (16MB). This badly named config option is actually
-# max order + 1
 config FORCE_MAX_ZONEORDER
-	int
-	depends on PPC64
+	int "Maximum zone order"
 	default "9" if PPC_64K_PAGES
-	default "13"
+	default "13" if PPC64
+	default "11"
+	help
+	  The kernel memory allocator divides physically contiguous memory
+	  blocks into "zones", where each zone is a power of two number of
+	  pages.  This option selects the largest power of two that the kernel
+	  keeps in the memory allocator.  If you need to allocate very large
+	  blocks of physically contiguous memory, then you may need to
+	  increase this value.
+
+	  This config option is actually maximum order plus one. For example,
+	  a value of 11 means that the largest free memory block is 2^10 pages.
+
+	  The page size is not necessarily 4KB.  For example, on 64-bit
+	  systems, 64KB pages can be enabled via CONFIG_PPC_64K_PAGES.  Keep
+	  this in mind when choosing a value for this option.
 
 config HUGETLB_PAGE_SIZE_VARIABLE
 	bool
-- 
1.5.4
