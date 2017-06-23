Return-Path: <oohall@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wvBWh55d6zDqnm
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jun 2017 18:32:00 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id d5so6441774pfe.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jun 2017 01:32:00 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: bsingharora@gmail.com, Oliver O'Halloran <oohall@gmail.com>,
 linux-mm@kvack.org
Subject: [PATCH v3 1/6] mm, x86: Add ARCH_HAS_ZONE_DEVICE to Kconfig
Date: Fri, 23 Jun 2017 18:31:17 +1000
Message-Id: <20170623083122.5992-1-oohall@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently ZONE_DEVICE depends on X86_64 and this will get unwieldly as
new architectures (and platforms) get ZONE_DEVICE support. Move to an
arch selected Kconfig option to save us the trouble.

Cc: linux-mm@kvack.org
Acked-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Balbir Singh <bsingharora@gmail.com>
Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
v2: Added missing hunk.
v3: No changes
---
 arch/x86/Kconfig | 1 +
 mm/Kconfig       | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 0efb4c9497bc..325429a3f32f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -59,6 +59,7 @@ config X86
 	select ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_HAS_STRICT_MODULE_RWX
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
+	select ARCH_HAS_ZONE_DEVICE		if X86_64
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select ARCH_MIGHT_HAVE_ACPI_PDC		if ACPI
 	select ARCH_MIGHT_HAVE_PC_PARPORT
diff --git a/mm/Kconfig b/mm/Kconfig
index beb7a455915d..790e52a8a486 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -683,12 +683,16 @@ config IDLE_PAGE_TRACKING
 
 	  See Documentation/vm/idle_page_tracking.txt for more details.
 
+# arch_add_memory() comprehends device memory
+config ARCH_HAS_ZONE_DEVICE
+	bool
+
 config ZONE_DEVICE
 	bool "Device memory (pmem, etc...) hotplug support"
 	depends on MEMORY_HOTPLUG
 	depends on MEMORY_HOTREMOVE
 	depends on SPARSEMEM_VMEMMAP
-	depends on X86_64 #arch_add_memory() comprehends device memory
+	depends on ARCH_HAS_ZONE_DEVICE
 
 	help
 	  Device memory hotplug support allows for establishing pmem,
-- 
2.9.4
