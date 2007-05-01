Return-Path: <domen@coderock.org>
Received: from kukmak.uni-mb.si (kukmak.uni-mb.si [164.8.100.3])
	by ozlabs.org (Postfix) with ESMTP id 5C20EDDDE7
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  2 May 2007 05:55:18 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by kukmak.uni-mb.si (Postfix) with ESMTP id B3D45BEE6C
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 May 2007 21:37:36 +0200 (CEST)
Received: from localhost ([127.0.0.1])
	by localhost (kukmak.uni-mb.si [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 16557-02 for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 May 2007 21:37:27 +0200 (CEST)
Received: from localhost (um-sd06-229-2.uni-mb.si [164.8.213.91])
	by kukmak.uni-mb.si (Postfix) with ESMTP id 5326FBEE65
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 May 2007 21:37:27 +0200 (CEST)
Date: Tue, 1 May 2007 21:37:27 +0200
From: Domen Puncer <domen@coderock.org>
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH] enable compile on !CONFIG_PCI and CONFIG_PPC_EFIKA
Message-ID: <20070501193727.GA2822@nd47.coderock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Trivial fix to enable compile on !CONFIG_PCI and CONFIG_PPC_EFIKA


Signed-off-by: Domen Puncer <domen.puncer@telargo.com>

---
Used in arch/powerpc/platforms/52xx/efika.c by
define_machine(efika) { .phys_mem_access_prot = }


 include/asm-powerpc/pci.h |    4 ++++
 1 file changed, 4 insertions(+)

Index: grant.git/include/asm-powerpc/pci.h
===================================================================
--- grant.git.orig/include/asm-powerpc/pci.h
+++ grant.git/include/asm-powerpc/pci.h
@@ -240,10 +240,14 @@ extern int pci_read_irq_line(struct pci_
 extern void pcibios_add_platform_entries(struct pci_dev *dev);
 
 struct file;
+#ifdef CONFIG_PCI
 extern pgprot_t	pci_phys_mem_access_prot(struct file *file,
 					 unsigned long pfn,
 					 unsigned long size,
 					 pgprot_t prot);
+#else
+#define pci_phys_mem_access_prot NULL
+#endif
 
 #define HAVE_ARCH_PCI_RESOURCE_TO_USER
 extern void pci_resource_to_user(const struct pci_dev *dev, int bar,
