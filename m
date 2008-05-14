Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx2.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0ACB8DDE0E
	for <linuxppc-dev@ozlabs.org>; Wed, 14 May 2008 19:05:27 +1000 (EST)
Date: Wed, 14 May 2008 18:05:19 +0900 (JST)
Message-Id: <20080514.180519.-1300524066.kouish@swc.toshiba.co.jp>
To: paulus@samba.org
Subject: [PATCH] cell: fix section mismatch warnings
From: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix following warnings:
WARNING: arch/powerpc/platforms/cell/built-in.o(.devinit.text+0x9c): Section mismatch in reference from the function .cell_setup_phb() to the function .init.text:.iowa_register_bus()
WARNING: arch/powerpc/platforms/cell/built-in.o(.devinit.text+0xa4): Section mismatch in reference from the function .cell_setup_phb() to the function .init.text:.io_workaround_init()

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
---
 arch/powerpc/platforms/cell/io-workarounds.c |    6 +++---
 arch/powerpc/platforms/cell/io-workarounds.h |    6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/cell/io-workarounds.c b/arch/powerpc/platforms/cell/io-workarounds.c
index 3b84e8b..b5f84e8 100644
--- a/arch/powerpc/platforms/cell/io-workarounds.c
+++ b/arch/powerpc/platforms/cell/io-workarounds.c
@@ -118,7 +118,7 @@ static void iowa_##name at					\
 #undef DEF_PCI_AC_RET
 #undef DEF_PCI_AC_NORET
 
-static struct ppc_pci_io __initdata iowa_pci_io = {
+static const struct ppc_pci_io __devinitconst iowa_pci_io = {
 
 #define DEF_PCI_AC_RET(name, ret, at, al, space, aa)	.name = iowa_##name,
 #define DEF_PCI_AC_NORET(name, at, al, space, aa)	.name = iowa_##name,
@@ -146,7 +146,7 @@ static void __iomem *iowa_ioremap(unsigned long addr, unsigned long size,
 }
 
 /* Regist new bus to support workaround */
-void __init iowa_register_bus(struct pci_controller *phb,
+void __devinit iowa_register_bus(struct pci_controller *phb,
 			struct ppc_pci_io *ops,
 			int (*initfunc)(struct iowa_bus *, void *), void *data)
 {
@@ -173,7 +173,7 @@ void __init iowa_register_bus(struct pci_controller *phb,
 }
 
 /* enable IO workaround */
-void __init io_workaround_init(void)
+void __devinit io_workaround_init(void)
 {
 	static int io_workaround_inited;
 
diff --git a/arch/powerpc/platforms/cell/io-workarounds.h b/arch/powerpc/platforms/cell/io-workarounds.h
index 79d8ed3..6efc778 100644
--- a/arch/powerpc/platforms/cell/io-workarounds.h
+++ b/arch/powerpc/platforms/cell/io-workarounds.h
@@ -31,9 +31,9 @@ struct iowa_bus {
 	void   *private;
 };
 
-void __init io_workaround_init(void);
-void __init iowa_register_bus(struct pci_controller *, struct ppc_pci_io *,
-			      int (*)(struct iowa_bus *, void *), void *);
+void __devinit io_workaround_init(void);
+void __devinit iowa_register_bus(struct pci_controller *, struct ppc_pci_io *,
+				 int (*)(struct iowa_bus *, void *), void *);
 struct iowa_bus *iowa_mem_find_bus(const PCI_IO_ADDR);
 struct iowa_bus *iowa_pio_find_bus(unsigned long);
 
-- 
1.5.4.1
