Date: Thu, 20 Sep 2001 21:08:36 -0700
From: andrew may <acmay@acmay.homeip.net>
To: linuxppc-embedded@lists.linuxppc.org
Subject: [PATCH]ppc_ksyms needs consistent_ funcs
Message-ID: <20010920210836.C19199@ecam.san.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I don't know if these need to be conditional or not but I need
them exported to work on a PCI driver.

It seems strange the pci_alloc/free_consistent need CONFIG_PCI
and pci_bus_to_phys and friends check CONFIG_ALL_PPC.


diff -ur linux-base/arch/ppc/kernel/ppc_ksyms.c linux-ppc/arch/ppc/kernel/ppc_ksyms.c
--- linux-base/arch/ppc/kernel/ppc_ksyms.c      Thu Sep 20 08:56:50 2001
+++ linux-ppc/arch/ppc/kernel/ppc_ksyms.c       Thu Sep 20 20:22:12 2001
@@ -174,6 +174,10 @@
 EXPORT_SYMBOL(pci_free_consistent);
 #endif /* CONFIG_PCI */

+EXPORT_SYMBOL(consistent_alloc);
+EXPORT_SYMBOL(consistent_free);
+EXPORT_SYMBOL(consistent_sync);
+
 EXPORT_SYMBOL(start_thread);
 EXPORT_SYMBOL(kernel_thread);

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
