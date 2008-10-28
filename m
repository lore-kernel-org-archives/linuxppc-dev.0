Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 28 Oct 2008 16:48:47 +1100
Subject: [PATCH 8/10] powerpc/pci: Fix unmapping of IO space on 64-bit
In-Reply-To: <1225172895.217185.958686212130.qpush@grosgo>
Message-Id: <20081028054949.2125EDE0CC@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

A typo/thinko made us pass the wrong argument to __flush_hash_table_range
when unplugging bridges, thus not flushing all the translations for
the IO space on unplug.

This causes the hypervisor to refuse unplugging slots.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/pci_64.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-work.orig/arch/powerpc/kernel/pci_64.c	2008-10-28 16:33:48.000000000 +1100
+++ linux-work/arch/powerpc/kernel/pci_64.c	2008-10-28 16:38:45.000000000 +1100
@@ -426,7 +426,7 @@ int pcibios_unmap_io_space(struct pci_bu
 			 pci_name(bus->self));
 
 		__flush_hash_table_range(&init_mm, res->start + _IO_BASE,
-					 res->end - res->start + 1);
+					 res->end + _IO_BASE + 1);
 		return 0;
 	}
 
