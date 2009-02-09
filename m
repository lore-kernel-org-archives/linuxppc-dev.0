Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 09 Feb 2009 11:27:21 +1100
Subject: [PATCH] powerpc/pci: mmap anonymous memory when legacy_mem doesn't
	exist
Message-Id: <20090209002745.B3436DDD1C@ozlabs.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, hugh@veritas.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The new legacy_mem file in sysfs is causing problems with X on machines
that don't support legacy memory access. The way I initially implemented
it, we would fail with -ENXIO when trying to mmap it, thus exposing to
X that we do support the API but there is no legacy memory.

Unfortunately, X poor error handling is causing it to fail to start when
it gets this error.

This implements a workaround hack that instead maps anonymous memory
instead (using shmem if VM_SHARED is set, just like /dev/zero does).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

This fixes a regression in .29 and is the less ugly way we found to
sort this problem out. I'll merge it ASAP so holler quick if you
have an objection

 arch/powerpc/kernel/pci-common.c |   17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

--- linux-work.orig/arch/powerpc/kernel/pci-common.c	2009-02-06 16:23:36.000000000 +1100
+++ linux-work/arch/powerpc/kernel/pci-common.c	2009-02-06 16:30:32.000000000 +1100
@@ -561,8 +561,21 @@ int pci_mmap_legacy_page_range(struct pc
 		 (unsigned long long)(offset + size - 1));
 
 	if (mmap_state == pci_mmap_mem) {
-		if ((offset + size) > hose->isa_mem_size)
-			return -ENXIO;
+		/* Hack alert !
+		 *
+		 * Because X is lame and can fail starting if it gets an error trying
+		 * to mmap legacy_mem (instead of just moving on without legacy memory
+		 * access) we fake it here by giving it anonymous memory, effectively
+		 * behaving just like /dev/zero
+		 */
+		if ((offset + size) > hose->isa_mem_size) {
+			printk(KERN_DEBUG
+			       "Process %s (pid:%d) mapped non-existing PCI legacy memory for 0%04x:%02x\n",
+			       current->comm, current->pid, pci_domain_nr(bus), bus->number);
+			if (vma->vm_flags & VM_SHARED)
+				return shmem_zero_setup(vma);
+			return 0;
+		}
 		offset += hose->isa_mem_phys;
 	} else {
 		unsigned long io_offset = (unsigned long)hose->io_base_virt - _IO_BASE;
