Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc/powernv: Disable interrupts while taking phb->lock
Date: Mon, 13 Feb 2012 11:28:20 +1100
Message-Id: <1329092900-27132-1-git-send-email-michael@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We need to disable interrupts when taking the phb->lock. Otherwise
we could deadlock with pci_lock taken from an interrupt.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
--

=========================================================
[ INFO: possible irq lock inversion dependency detected ]
3.2.0-rc5-mpe+ #17
---------------------------------------------------------
swapper/56/0 just changed the state of lock:
 (pci_lock){-.....}, at: [<c000000000421824>] .pci_bus_read_config_word+0x84/0x110
but this lock took another, HARDIRQ-unsafe lock in the past:
 (&(&phb->lock)->rlock){+.+...}

and interrupts could create inverse lock ordering between them.

other info that might help us debug this:
 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&(&phb->lock)->rlock);
                               local_irq_disable();
                               lock(pci_lock);
                               lock(&(&phb->lock)->rlock);
  <Interrupt>
    lock(pci_lock);

 *** DEADLOCK ***

1 lock held by swapper/56/0:
 #0:  (&(shost->host_lock)->rlock){-.-...}, at: [<c0000000005ee84c>] .ipr_isr+0x4c/0x540

the shortest dependencies between 2nd lock and 1st lock:
 -> (&(&phb->lock)->rlock){+.+...} ops: 622770257920 {
    HARDIRQ-ON-W at:
                          [<c0000000000be848>] .lock_acquire+0xb8/0x190
                          [<c0000000008e1c24>] ._raw_spin_lock+0x34/0x60
                          [<c000000000047320>] .pnv_setup_msi_irqs+0xb0/0x320
                          [<c00000000002dfc4>] .arch_setup_msi_irqs+0x34/0x50
                          [<c000000000434160>] .pci_enable_msi_block+0x210/0x300
                          [<c00000000090ad90>] .ipr_probe+0x6a8/0x1560
                          [<c00000000042a9b0>] .pci_device_probe+0x1a0/0x1b0
                          [<c00000000048c7c0>] .driver_probe_device+0xb0/0x1e0
                          [<c00000000048c9fc>] .__driver_attach+0x10c/0x110
                          [<c00000000048b2f8>] .bus_for_each_dev+0x88/0xe0
                          [<c00000000048c2c8>] .driver_attach+0x28/0x40
                          [<c00000000048bd68>] .bus_add_driver+0x178/0x310
                          [<c00000000048cebc>] .driver_register+0x9c/0x1b0
                          [<c00000000042b040>] .__pci_register_driver+0x70/0x150
                          [<c000000000cddb80>] .ipr_init+0x4c/0x68
                          [<c00000000000a9f0>] .do_one_initcall+0x60/0x1e0
                          [<c000000000cb0b58>] .kernel_init+0x134/0x1c0
                          [<c0000000000215a8>] .kernel_thread+0x54/0x70
    SOFTIRQ-ON-W at:
                          [<c0000000000be848>] .lock_acquire+0xb8/0x190
                          [<c0000000008e1c24>] ._raw_spin_lock+0x34/0x60
                          [<c000000000047320>] .pnv_setup_msi_irqs+0xb0/0x320
                          [<c00000000002dfc4>] .arch_setup_msi_irqs+0x34/0x50
                          [<c000000000434160>] .pci_enable_msi_block+0x210/0x300
                          [<c00000000090ad90>] .ipr_probe+0x6a8/0x1560
                          [<c00000000042a9b0>] .pci_device_probe+0x1a0/0x1b0
                          [<c00000000048c7c0>] .driver_probe_device+0xb0/0x1e0
                          [<c00000000048c9fc>] .__driver_attach+0x10c/0x110
                          [<c00000000048b2f8>] .bus_for_each_dev+0x88/0xe0
                          [<c00000000048c2c8>] .driver_attach+0x28/0x40
                          [<c00000000048bd68>] .bus_add_driver+0x178/0x310
                          [<c00000000048cebc>] .driver_register+0x9c/0x1b0
                          [<c00000000042b040>] .__pci_register_driver+0x70/0x150
                          [<c000000000cddb80>] .ipr_init+0x4c/0x68
                          [<c00000000000a9f0>] .do_one_initcall+0x60/0x1e0
                          [<c000000000cb0b58>] .kernel_init+0x134/0x1c0
                          [<c0000000000215a8>] .kernel_thread+0x54/0x70
    INITIAL USE at:
                         [<c0000000000be848>] .lock_acquire+0xb8/0x190
                         [<c0000000008e1d64>] ._raw_spin_lock_irqsave+0x54/0x80
                         [<c000000000046a80>] .pnv_pci_config_check_eeh+0xe0/0x4d0
                         [<c000000000047044>] .pnv_pci_read_config+0xc4/0x150
                         [<c000000000421750>] .pci_bus_read_config_dword+0xc0/0x110
                         [<c0000000007a4764>] .pci_scan_single_device+0xa4/0x1d0
                         [<c000000000424730>] .pci_scan_slot+0x100/0x1f0
                         [<c000000000900990>] .pci_scan_child_bus+0x40/0x108
                         [<c000000000900bc0>] .pci_scan_bridge+0x168/0x4d0
                         [<c000000000900a0c>] .pci_scan_child_bus+0xbc/0x108
                         [<c0000000008fe0fc>] .pcibios_scan_phb+0xe8/0x18c
                         [<c000000000cbb98c>] .pcibios_init+0x80/0xe4
                         [<c00000000000a9f0>] .do_one_initcall+0x60/0x1e0
                         [<c000000000cb0b58>] .kernel_init+0x134/0x1c0
                         [<c0000000000215a8>] .kernel_thread+0x54/0x70
  }
  ... key      at: [<c00000000144934c>] __key.22640+0x0/0x8
  ... acquired at:
   [<c0000000008e1d64>] ._raw_spin_lock_irqsave+0x54/0x80
   [<c000000000046a80>] .pnv_pci_config_check_eeh+0xe0/0x4d0
   [<c000000000047044>] .pnv_pci_read_config+0xc4/0x150
   [<c000000000421750>] .pci_bus_read_config_dword+0xc0/0x110
   [<c0000000007a4764>] .pci_scan_single_device+0xa4/0x1d0
   [<c000000000424730>] .pci_scan_slot+0x100/0x1f0
   [<c000000000900990>] .pci_scan_child_bus+0x40/0x108
   [<c000000000900bc0>] .pci_scan_bridge+0x168/0x4d0
   [<c000000000900a0c>] .pci_scan_child_bus+0xbc/0x108
   [<c0000000008fe0fc>] .pcibios_scan_phb+0xe8/0x18c
   [<c000000000cbb98c>] .pcibios_init+0x80/0xe4
   [<c00000000000a9f0>] .do_one_initcall+0x60/0x1e0
   [<c000000000cb0b58>] .kernel_init+0x134/0x1c0
   [<c0000000000215a8>] .kernel_thread+0x54/0x70

-> (pci_lock){-.....} ops: 21178483736576 {
   IN-HARDIRQ-W at:
                        [<c0000000000be848>] .lock_acquire+0xb8/0x190
                        [<c0000000008e1d64>] ._raw_spin_lock_irqsave+0x54/0x80
                        [<c000000000421824>] .pci_bus_read_config_word+0x84/0x110
                        [<c0000000005e8200>] .ipr_reset_alert+0x50/0x130
                        [<c0000000005e84cc>] .ipr_reset_ioa_job+0x8c/0xf0
                        [<c0000000005ee920>] .ipr_isr+0x120/0x540
                        [<c0000000000f26a8>] .handle_irq_event_percpu+0x98/0x350
                        [<c0000000000f29b8>] .handle_irq_event+0x58/0xa0
                        [<c0000000000f6be0>] .handle_fasteoi_irq+0xa0/0x1c0
                        [<c000000000021410>] .call_handle_irq+0x1c/0x2c
                        [<c00000000001005c>] .do_IRQ+0x29c/0x320
                        [<c00000000000500c>] hardware_interrupt_entry+0x1c/0x90
                        [<c0000000000177ec>] .cpu_idle+0x12c/0x220
                        [<c0000000008fcfa4>] .start_secondary+0x360/0x368
                        [<c000000000009368>] .start_secondary_prolog+0x10/0x14
   INITIAL USE at:
                       [<c0000000000be848>] .lock_acquire+0xb8/0x190
                       [<c0000000008e1d64>] ._raw_spin_lock_irqsave+0x54/0x80
                       [<c000000000421714>] .pci_bus_read_config_dword+0x84/0x110
                       [<c0000000007a4764>] .pci_scan_single_device+0xa4/0x1d0
                       [<c0000000004246b8>] .pci_scan_slot+0x88/0x1f0
                       [<c000000000900990>] .pci_scan_child_bus+0x40/0x108
                       [<c0000000008fe0fc>] .pcibios_scan_phb+0xe8/0x18c
                       [<c000000000cbb98c>] .pcibios_init+0x80/0xe4
                       [<c00000000000a9f0>] .do_one_initcall+0x60/0x1e0
                       [<c000000000cb0b58>] .kernel_init+0x134/0x1c0
                       [<c0000000000215a8>] .kernel_thread+0x54/0x70
 }
 ... key      at: [<c0000000012b64b8>] pci_lock+0x18/0x38
 ... acquired at:
   [<c0000000000bc1e4>] .mark_lock+0x244/0x740
   [<c0000000000bcfcc>] .__lock_acquire+0x8ec/0x1b10
   [<c0000000000be848>] .lock_acquire+0xb8/0x190
   [<c0000000008e1d64>] ._raw_spin_lock_irqsave+0x54/0x80
   [<c000000000421824>] .pci_bus_read_config_word+0x84/0x110
   [<c0000000005e8200>] .ipr_reset_alert+0x50/0x130
   [<c0000000005e84cc>] .ipr_reset_ioa_job+0x8c/0xf0
   [<c0000000005ee920>] .ipr_isr+0x120/0x540
   [<c0000000000f26a8>] .handle_irq_event_percpu+0x98/0x350
   [<c0000000000f29b8>] .handle_irq_event+0x58/0xa0
   [<c0000000000f6be0>] .handle_fasteoi_irq+0xa0/0x1c0
   [<c000000000021410>] .call_handle_irq+0x1c/0x2c
   [<c00000000001005c>] .do_IRQ+0x29c/0x320
   [<c00000000000500c>] hardware_interrupt_entry+0x1c/0x90
   [<c0000000000177ec>] .cpu_idle+0x12c/0x220
   [<c0000000008fcfa4>] .start_secondary+0x360/0x368
   [<c000000000009368>] .start_secondary_prolog+0x10/0x14

stack backtrace:
Call Trace:
[c000000ffbe1b490] [c000000000015838] .show_stack+0x78/0x1b0 (unreliable)
[c000000ffbe1b540] [c0000000000bb4b0] .print_irq_inversion_bug+0x270/0x2c0
[c000000ffbe1b5f0] [c0000000000bb5a4] .check_usage_forwards+0xa4/0x130
[c000000ffbe1b6f0] [c0000000000bc1e4] .mark_lock+0x244/0x740
[c000000ffbe1b7b0] [c0000000000bcfcc] .__lock_acquire+0x8ec/0x1b10
[c000000ffbe1b930] [c0000000000be848] .lock_acquire+0xb8/0x190
[c000000ffbe1ba10] [c0000000008e1d64] ._raw_spin_lock_irqsave+0x54/0x80
[c000000ffbe1bab0] [c000000000421824] .pci_bus_read_config_word+0x84/0x110
[c000000ffbe1bb70] [c0000000005e8200] .ipr_reset_alert+0x50/0x130
[c000000ffbe1bc10] [c0000000005e84cc] .ipr_reset_ioa_job+0x8c/0xf0
[c000000ffbe1bca0] [c0000000005ee920] .ipr_isr+0x120/0x540
[c000000ffbe1bd80] [c0000000000f26a8] .handle_irq_event_percpu+0x98/0x350
[c000000ffbe1be70] [c0000000000f29b8] .handle_irq_event+0x58/0xa0
[c000000ffbe1bf00] [c0000000000f6be0] .handle_fasteoi_irq+0xa0/0x1c0
[c000000ffbe1bf90] [c000000000021410] .call_handle_irq+0x1c/0x2c
[c0000007f2d47a70] [c00000000001005c] .do_IRQ+0x29c/0x320
[c0000007f2d47b30] [c00000000000500c] hardware_interrupt_entry+0x1c/0x90
--- Exception: 501 at .arch_local_irq_restore+0x50/0x60
    LR = .cpu_idle+0x138/0x220
[c0000007f2d47e20] [c0000000000177ec] .cpu_idle+0x12c/0x220 (unreliable)
[c0000007f2d47ee0] [c0000000008fcfa4] .start_secondary+0x360/0x368
[c0000007f2d47f90] [c000000000009368] .start_secondary_prolog+0x10/0x14
---
 arch/powerpc/platforms/powernv/pci.c |   22 ++++++++++++++--------
 1 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index a70bc1e..f92b9ef 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -52,32 +52,38 @@ static int pnv_msi_check_device(struct pci_dev* pdev, int nvec, int type)
 
 static unsigned int pnv_get_one_msi(struct pnv_phb *phb)
 {
-	unsigned int id;
+	unsigned long flags;
+	unsigned int id, rc;
+
+	spin_lock_irqsave(&phb->lock, flags);
 
-	spin_lock(&phb->lock);
 	id = find_next_zero_bit(phb->msi_map, phb->msi_count, phb->msi_next);
 	if (id >= phb->msi_count && phb->msi_next)
 		id = find_next_zero_bit(phb->msi_map, phb->msi_count, 0);
 	if (id >= phb->msi_count) {
-		spin_unlock(&phb->lock);
-		return 0;
+		rc = 0;
+		goto out;
 	}
 	__set_bit(id, phb->msi_map);
-	spin_unlock(&phb->lock);
-	return id + phb->msi_base;
+	rc = id + phb->msi_base;
+out:
+	spin_unlock_irqrestore(&phb->lock, flags);
+	return rc;
 }
 
 static void pnv_put_msi(struct pnv_phb *phb, unsigned int hwirq)
 {
+	unsigned long flags;
 	unsigned int id;
 
 	if (WARN_ON(hwirq < phb->msi_base ||
 		    hwirq >= (phb->msi_base + phb->msi_count)))
 		return;
 	id = hwirq - phb->msi_base;
-	spin_lock(&phb->lock);
+
+	spin_lock_irqsave(&phb->lock, flags);
 	__clear_bit(id, phb->msi_map);
-	spin_unlock(&phb->lock);
+	spin_unlock_irqrestore(&phb->lock, flags);
 }
 
 static int pnv_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
-- 
1.7.5.4
