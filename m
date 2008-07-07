Return-Path: <shaggy@linux.vnet.ibm.com>
Message-Id: <20080707143011.015842948@linux.vnet.ibm.com>
References: <20080707142850.034542257@linux.vnet.ibm.com>
Date: Mon, 07 Jul 2008 09:28:51 -0500
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: [patch 1/5] mm: Allow architectures to define additional protection
	bits
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hugh@veritas.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch allows architectures to define functions to deal with
additional protections bits for mmap() and mprotect().

arch_calc_vm_prot_bits() maps additonal protection bits to vm_flags
arch_vm_get_page_prot() maps additional vm_flags to the vma's vm_page_prot
arch_validate_prot() checks for valid values of the protection bits

Note: vm_get_page_prot() is now pretty ugly, but the generated code
should be identical for architectures that don't define additional
protection bits.

Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Acked-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Hugh Dickins <hugh@veritas.com>
---

 include/linux/mman.h |   29 ++++++++++++++++++++++++++++-
 mm/mmap.c            |    5 +++--
 mm/mprotect.c        |    2 +-
 3 files changed, 32 insertions(+), 4 deletions(-)

Index: b/include/linux/mman.h
===================================================================
--- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -34,6 +34,32 @@
 }
 
 /*
+ * Allow architectures to handle additional protection bits
+ */
+
+#ifndef arch_calc_vm_prot_bits
+#define arch_calc_vm_prot_bits(prot) 0
+#endif
+
+#ifndef arch_vm_get_page_prot
+#define arch_vm_get_page_prot(vm_flags) __pgprot(0)
+#endif
+
+#ifndef arch_validate_prot
+/*
+ * This is called from mprotect().  PROT_GROWSDOWN and PROT_GROWSUP have
+ * already been masked out.
+ *
+ * Returns true if the prot flags are valid
+ */
+static inline int arch_validate_prot(unsigned long prot)
+{
+	return (prot & ~(PROT_READ | PROT_WRITE | PROT_EXEC | PROT_SEM)) == 0;
+}
+#define arch_validate_prot arch_validate_prot
+#endif
+
+/*
  * Optimisation macro.  It is equivalent to:
  *      (x & bit1) ? bit2 : 0
  * but this version is faster.
@@ -51,7 +77,8 @@
 {
 	return _calc_vm_trans(prot, PROT_READ,  VM_READ ) |
 	       _calc_vm_trans(prot, PROT_WRITE, VM_WRITE) |
-	       _calc_vm_trans(prot, PROT_EXEC,  VM_EXEC );
+	       _calc_vm_trans(prot, PROT_EXEC,  VM_EXEC) |
+	       arch_calc_vm_prot_bits(prot);
 }
 
 /*
Index: b/mm/mmap.c
===================================================================
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -72,8 +72,9 @@
 
 pgprot_t vm_get_page_prot(unsigned long vm_flags)
 {
-	return protection_map[vm_flags &
-				(VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)];
+	return __pgprot(pgprot_val(protection_map[vm_flags &
+				(VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)]) |
+			pgprot_val(arch_vm_get_page_prot(vm_flags)));
 }
 EXPORT_SYMBOL(vm_get_page_prot);
 
Index: b/mm/mprotect.c
===================================================================
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -239,7 +239,7 @@
 	end = start + len;
 	if (end <= start)
 		return -ENOMEM;
-	if (prot & ~(PROT_READ | PROT_WRITE | PROT_EXEC | PROT_SEM))
+	if (!arch_validate_prot(prot))
 		return -EINVAL;
 
 	reqprot = prot;

-- 
Dave Kleikamp
IBM Linux Technology Center
