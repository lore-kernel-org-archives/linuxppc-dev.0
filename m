Return-Path: <rusty@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 30BDE1A01BA
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 17:54:49 +1100 (AEDT)
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Michael Neuling" <michael.neuling@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] cxl: allow example memcpy driver to be compiled as a
 module.
Date: Tue, 10 Feb 2015 17:23:34 +1030
Message-Id: <1423551214-10209-2-git-send-email-rusty@rustcorp.com.au>
In-Reply-To: <1423551214-10209-1-git-send-email-rusty@rustcorp.com.au>
References: <1423551214-10209-1-git-send-email-rusty@rustcorp.com.au>
Cc: Rusty Russell <rusty@rustcorp.com.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Requires fixing one typo.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/misc/Kconfig      | 2 +-
 drivers/misc/cxl-memcpy.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 5262514..f778497 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -516,7 +516,7 @@ config VEXPRESS_SYSCFG
 	  of generating transactions on this bus.
 
 config CXL_MEMCPY
-	bool "Example CXL memcpy AFU driver"
+	tristate "Example CXL memcpy AFU driver"
 	depends on CXL
 	default y
 	help
diff --git a/drivers/misc/cxl-memcpy.c b/drivers/misc/cxl-memcpy.c
index 6b7545d..fecc1fd 100644
--- a/drivers/misc/cxl-memcpy.c
+++ b/drivers/misc/cxl-memcpy.c
@@ -27,7 +27,7 @@ static DEFINE_PCI_DEVICE_TABLE(cxl_memcpy_pci_tbl) = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, 0x4350), },
 	{ }
 };
-MODULE_DEVICE_TABLE(pci, cxl_pci_tbl);
+MODULE_DEVICE_TABLE(pci, cxl_memcpy_pci_tbl);
 
 uint cpu_memcopy;
 module_param_named(cpu_memcopy, cpu_memcopy, uint, 0600);
-- 
2.1.0
