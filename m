Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 483262BDEB
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Nov 2004 10:56:52 +1100 (EST)
Message-ID: <418FF992.8040604@mvista.com>
Date: Mon, 08 Nov 2004 15:56:18 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: akpm <akpm@osdl.org>
Content-Type: multipart/mixed; boundary="------------000308090204000708050402"
Cc: linuxppc-dev@ozlabs.org, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH][PPC32] Add setup_indirect_pci_nomap() routine
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This is a multi-part message in MIME format.
--------------000308090204000708050402
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch adds a routine that sets up indirect pci config space access 
but doesn't ioremap the config space addr/data registers.

Signed-off-by: Mark Greer <mgreer@mvista.com>

--------------000308090204000708050402
Content-Type: text/plain;
 name="indirect_pci.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="indirect_pci.patch"

===== arch/ppc/syslib/indirect_pci.c 1.12 vs edited =====
--- 1.12/arch/ppc/syslib/indirect_pci.c	2004-03-17 05:02:23 -07:00
+++ edited/arch/ppc/syslib/indirect_pci.c	2004-10-12 14:24:23 -07:00
@@ -112,15 +112,24 @@
 };
 
 void __init
+setup_indirect_pci_nomap(struct pci_controller* hose, u32 cfg_addr,
+	u32 cfg_data)
+{
+	hose->cfg_addr = (unsigned int *)cfg_addr;
+	hose->cfg_data = (unsigned char *)cfg_data;
+	hose->ops = &indirect_pci_ops;
+}
+
+void __init
 setup_indirect_pci(struct pci_controller* hose, u32 cfg_addr, u32 cfg_data)
 {
 	unsigned long base = cfg_addr & PAGE_MASK;
 	char *mbase;
 
 	mbase = ioremap(base, PAGE_SIZE);
-	hose->cfg_addr = (unsigned int *)(mbase + (cfg_addr & ~PAGE_MASK));
+	cfg_addr = (u32)(mbase + (cfg_addr & ~PAGE_MASK));
 	if ((cfg_data & PAGE_MASK) != base)
 		mbase = ioremap(cfg_data & PAGE_MASK, PAGE_SIZE);
-	hose->cfg_data = (unsigned char *)(mbase + (cfg_data & ~PAGE_MASK));
-	hose->ops = &indirect_pci_ops;
+	cfg_data = (u32)(mbase + (cfg_data & ~PAGE_MASK));
+	setup_indirect_pci_nomap(hose, cfg_addr, cfg_data);
 }
===== include/asm-ppc/pci-bridge.h 1.12 vs edited =====
--- 1.12/include/asm-ppc/pci-bridge.h	2003-09-12 09:26:56 -07:00
+++ edited/include/asm-ppc/pci-bridge.h	2004-10-12 14:23:36 -07:00
@@ -94,6 +94,8 @@
 int early_write_config_dword(struct pci_controller *hose, int bus, int dev_fn,
 			     int where, u32 val);
 
+extern void setup_indirect_pci_nomap(struct pci_controller* hose,
+			       u32 cfg_addr, u32 cfg_data);
 extern void setup_indirect_pci(struct pci_controller* hose,
 			       u32 cfg_addr, u32 cfg_data);
 extern void setup_grackle(struct pci_controller *hose);

--------------000308090204000708050402--
