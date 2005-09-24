Return-Path: <zippel@linux-m68k.org>
Received: from scrub.xs4all.nl (scrub.xs4all.nl [194.109.195.176])
	by ozlabs.org (Postfix) with ESMTP id 9ECAC683B5
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Sep 2005 08:43:36 +1000 (EST)
Received: from roman (helo=localhost)
	by scrub.xs4all.nl with local-esmtp (Exim 3.36 #1 (Debian))
	id 1EJIk3-0004zI-00
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Sep 2005 00:43:35 +0200
Date: Sun, 25 Sep 2005 00:43:35 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
To: linuxppc-dev@ozlabs.org
Message-ID: <Pine.LNX.4.61.0509250042460.19169@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [PATCH 4/8] fix include wrapper
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Outside the include protection must only be comments, so that cpp can
optimize the header scan.

---

 include/asm-ppc/current.h |    4 ++--
 include/asm-ppc/io.h      |    5 ++---
 2 files changed, 4 insertions(+), 5 deletions(-)

Index: linux/include/asm-ppc/current.h
===================================================================
--- linux.orig/include/asm-ppc/current.h	2005-09-23 16:19:24.000000000 +0200
+++ linux/include/asm-ppc/current.h	2005-09-23 16:20:24.000000000 +0200
@@ -1,11 +1,11 @@
-#ifdef __KERNEL__
 #ifndef _PPC_CURRENT_H
 #define _PPC_CURRENT_H
+#ifdef __KERNEL__
 
 /*
  * We keep `current' in r2 for speed.
  */
 register struct task_struct *current asm ("r2");
 
-#endif /* !(_PPC_CURRENT_H) */
 #endif /* __KERNEL__ */
+#endif /* !(_PPC_CURRENT_H) */
Index: linux/include/asm-ppc/io.h
===================================================================
--- linux.orig/include/asm-ppc/io.h	2005-09-23 16:19:24.000000000 +0200
+++ linux/include/asm-ppc/io.h	2005-09-23 16:20:24.000000000 +0200
@@ -1,6 +1,6 @@
-#ifdef __KERNEL__
 #ifndef _PPC_IO_H
 #define _PPC_IO_H
+#ifdef __KERNEL__
 
 #include <linux/config.h>
 #include <linux/string.h>
@@ -546,8 +546,6 @@ struct pci_dev;
 extern void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long max);
 extern void pci_iounmap(struct pci_dev *dev, void __iomem *);
 
-#endif /* _PPC_IO_H */
-
 #ifdef CONFIG_8260_PCI9
 #include <asm/mpc8260_pci9.h>
 #endif
@@ -564,3 +562,4 @@ extern void pci_iounmap(struct pci_dev *
 #define xlate_dev_kmem_ptr(p)	p
 
 #endif /* __KERNEL__ */
+#endif /* _PPC_IO_H */
