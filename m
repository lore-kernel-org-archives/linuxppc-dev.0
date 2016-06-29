Return-Path: <darren@stevens-zone.net>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rfwTm3C75zDqvB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 07:16:44 +1000 (AEST)
From: Darren Stevens <darren@stevens-zone.net>
To: linuxppc-dev@lists.ozlabs.org
CC: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>,
 Pat Wall <pjwall@mac.com>, matthew@a-eon.com, aperez@alexperez.com,
 R.T.Dickinson <rtd2@xtra.co.nz>,
 Christian Zigotzky <chzigotzky@xenosoft.de>
Date: Wed, 29 Jun 2016 21:06:28 +0100 (BST)
Message-ID: <4867f9385a2.1e1ca6c1@auth.smtp.1and1.co.uk>
Subject: [PATCH v2 RFC] pasemi: Fix boot failure on 4.7-rc1
MIME-Version: 1.0
Content-type: multipart/mixed; boundary="--=_BOUNDARY.6c7dc3c071961d4d.74"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Warning: This is a message in MIME format. Your mail reader does
not support MIME. Some parts of this message will be readable as
plain text. To see the rest, you will need to upgrade your mail
reader. Following are some URLs where you can find MIME-capable
mail programs for common platforms:

  AmigaOS...........: http://yam.ch/
  Unix/MacOS/Windows: http://www.mozilla.com/thunderbird/

General information about MIME can be found at:
http://en.wikipedia.org/wiki/MIME

----=_BOUNDARY.6c7dc3c071961d4d.74
Content-Type: text/plain


    Commit:d6a9996e84ac4beb7713e9485f4563e100a9b03e (powerpc/mm:
    vmalloc abstraction in preparation for radix) turned kernel memory
    and IO addresses from #defined constants to variables initialised
    at runtime.
    
    On PA6T systems the setup_arch machine call initialises the onboard
    PCI-e root-ports, and uses pci_io_base to do this, which is now before
    its value has been set resulting in a panic right after 'booting 
    linux via __start()'

    Move the pci_io_base initialisation to the same place as vmalloc
    ranges are set (hash__early_init_mmu()/radix__early_init_mmu())
    
    Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
    Signed-off-by: Darren Stevens <darren@stevens-zone.net>
    
---

Tested on my AmigaOneX1000, I don't have access to a refence board system,
and our developer with one is on honeymoon.

I am hoping to follow this patch with others to reduce the size of the nemo
patch we apply, eventually I'd like to see the patch gone, but that is a 
very big job.

Kind regards
Darren

----=_BOUNDARY.6c7dc3c071961d4d.74
Content-Type: text/plain;
	name="pa6t-bootfix-v2.patch"
Content-Disposition: attachment;
	filename="pa6t-bootfix-v2.patch";
	size=1932

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 88a5eca..ab84c89 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -230,6 +230,7 @@ extern unsigned long __kernel_virt_size;
 #define KERN_VIRT_SIZE  __kernel_virt_size
 extern struct page *vmemmap;
 extern unsigned long ioremap_bot;
+extern unsigned long pci_io_base;
 #endif /* __ASSEMBLY__ */
 
 #include <asm/book3s/64/hash.h>
diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index 3759df5..a5ae49a 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -47,7 +47,6 @@ static int __init pcibios_init(void)
 
 	printk(KERN_INFO "PCI: Probing PCI hardware\n");
 
-	pci_io_base = ISA_IO_BASE;
 	/* For now, override phys_mem_access_prot. If we need it,g
 	 * later, we may move that initialization to each ppc_md
 	 */
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 5b22ba0..b5b5fe6 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -922,6 +922,8 @@ void __init hash__early_init_mmu(void)
 	vmemmap = (struct page *)H_VMEMMAP_BASE;
 	ioremap_bot = IOREMAP_BASE;
 
+	pci_io_base = ISA_IO_BASE;
+
 	/* Initialize the MMU Hash table and create the linear mapping
 	 * of memory. Has to be done before SLB initialization as this is
 	 * currently where the page size encoding is obtained.
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index e58707d..095fbfa 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -328,6 +328,9 @@ void __init radix__early_init_mmu(void)
 	__vmalloc_end = RADIX_VMALLOC_END;
 	vmemmap = (struct page *)RADIX_VMEMMAP_BASE;
 	ioremap_bot = IOREMAP_BASE;
+
+	pci_io_base = ISA_IO_BASE;
+
 	/*
 	 * For now radix also use the same frag size
 	 */

----=_BOUNDARY.6c7dc3c071961d4d.74--
