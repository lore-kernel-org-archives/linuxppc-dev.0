Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id E60F8DDE3F
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Mar 2007 09:13:59 +1100 (EST)
Date: Thu, 22 Mar 2007 23:14:07 +0100
From: Olaf Hering <olaf@aepfle.de>
To: Paul Mackeras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] fix link errors when eeh is disabled
Message-ID: <20070322221407.GA13592@aepfle.de>
References: <20070322221117.GA13481@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20070322221117.GA13481@aepfle.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


fix link errors with CONFIG_EEH=n

arch/powerpc/platforms/built-in.o: In function `.pcibios_fixup_new_pci_devices':
(.text+0x41c8): undefined reference to `.eeh_add_device_tree_late'
arch/powerpc/platforms/built-in.o: In function `.init_phb_dynamic':
(.text+0x4280): undefined reference to `.eeh_add_device_tree_early'
arch/powerpc/platforms/built-in.o: In function `.pcibios_remove_pci_devices':
(.text+0x42fc): undefined reference to `.eeh_remove_bus_device'
arch/powerpc/platforms/built-in.o: In function `.pcibios_add_pci_devices':
(.text+0x43c0): undefined reference to `.eeh_add_device_tree_early'
arch/powerpc/platforms/built-in.o: In function `.pSeries_final_fixup':
(.init.text+0xb4): undefined reference to `.pci_addr_cache_build'
arch/powerpc/platforms/built-in.o: In function `.pSeries_setup_arch':
setup.c:(.init.text+0x620): undefined reference to `.eeh_init'
make[1]: *** [.tmp_vmlinux1] Error 1


Signed-off-by: Olaf Hering <olaf@aepfle.de>

---
 arch/powerpc/platforms/pseries/pci.c       |    1 +
 arch/powerpc/platforms/pseries/pci_dlpar.c |    1 +
 arch/powerpc/platforms/pseries/setup.c     |    1 +
 3 files changed, 3 insertions(+)

Index: b/arch/powerpc/platforms/pseries/pci.c
===================================================================
--- a/arch/powerpc/platforms/pseries/pci.c
+++ b/arch/powerpc/platforms/pseries/pci.c
@@ -25,6 +25,7 @@
 #include <linux/pci.h>
 #include <linux/string.h>
 
+#include <asm/eeh.h>
 #include <asm/pci-bridge.h>
 #include <asm/prom.h>
 #include <asm/ppc-pci.h>
Index: b/arch/powerpc/platforms/pseries/pci_dlpar.c
===================================================================
--- a/arch/powerpc/platforms/pseries/pci_dlpar.c
+++ b/arch/powerpc/platforms/pseries/pci_dlpar.c
@@ -29,6 +29,7 @@
 #include <asm/pci-bridge.h>
 #include <asm/ppc-pci.h>
 #include <asm/firmware.h>
+#include <asm/eeh.h>
 
 static struct pci_bus *
 find_bus_among_children(struct pci_bus *bus,
Index: b/arch/powerpc/platforms/pseries/setup.c
===================================================================
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -65,6 +65,7 @@
 #include <asm/udbg.h>
 #include <asm/smp.h>
 #include <asm/firmware.h>
+#include <asm/eeh.h>
 
 #include "plpar_wrappers.h"
 #include "pseries.h"
