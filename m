Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vWnP85jmxzDqGh
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2017 14:33:48 +1100 (AEDT)
Date: Mon, 27 Feb 2017 14:33:42 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org, kvm@vger.kernel.org
Cc: kvm-ppc@vger.kernel.org
Subject: [PATCH] KVM: PPC: Book3S HV: Fix software walk of guest process page
 tables
Message-ID: <20170227033342.GB3591@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This fixes some bugs in the code that walks the guest's page tables.
These bugs cause MMIO emulation to fail whenever the guest is in
virtial mode (MMU on), leading to the guest hanging if it tried to
access a virtio device.

The first bug was that when reading the guest's process table, we were
using the whole of arch->process_table, not just the field that contains
the process table base address.  The second bug was that the mask used
when reading the process table entry to get the radix tree base address,
RPDB_MASK, had the wrong value.

Fixes: 9e04ba69beec ("KVM: PPC: Book3S HV: Add basic infrastructure for radix guests")
Fixes: e99833448c5f ("powerpc/mm/radix: Add partition table format & callback")
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/book3s/64/mmu.h | 3 ++-
 arch/powerpc/kvm/book3s_64_mmu_radix.c   | 5 +++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index d73e9df..440f342 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -46,7 +46,7 @@ extern struct patb_entry *partition_tb;
 
 /* Bits in patb0 field */
 #define PATB_HR		(1UL << 63)
-#define RPDB_MASK	0x0ffffffffffff00fUL
+#define RPDB_MASK	0x0fffffffffffff00UL
 #define RPDB_SHIFT	(1UL << 8)
 #define RTS1_SHIFT	61		/* top 2 bits of radix tree size */
 #define RTS1_MASK	(3UL << RTS1_SHIFT)
@@ -57,6 +57,7 @@ extern struct patb_entry *partition_tb;
 /* Bits in patb1 field */
 #define PATB_GR		(1UL << 63)	/* guest uses radix; must match HR */
 #define PRTS_MASK	0x1f		/* process table size field */
+#define PRTB_MASK	0x0ffffffffffff000UL
 
 /*
  * Limit process table to PAGE_SIZE table. This
diff --git a/arch/powerpc/kvm/book3s_64_mmu_radix.c b/arch/powerpc/kvm/book3s_64_mmu_radix.c
index 4344651..f6b3e67 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_radix.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_radix.c
@@ -32,6 +32,7 @@ int kvmppc_mmu_radix_xlate(struct kvm_vcpu *vcpu, gva_t eaddr,
 	u32 pid;
 	int ret, level, ps;
 	__be64 prte, rpte;
+	unsigned long ptbl;
 	unsigned long root, pte, index;
 	unsigned long rts, bits, offset;
 	unsigned long gpa;
@@ -53,8 +54,8 @@ int kvmppc_mmu_radix_xlate(struct kvm_vcpu *vcpu, gva_t eaddr,
 		return -EINVAL;
 
 	/* Read partition table to find root of tree for effective PID */
-	ret = kvm_read_guest(kvm, kvm->arch.process_table + pid * 16,
-			     &prte, sizeof(prte));
+	ptbl = (kvm->arch.process_table & PRTB_MASK) + (pid * 16);
+	ret = kvm_read_guest(kvm, ptbl, &prte, sizeof(prte));
 	if (ret)
 		return ret;
 
-- 
2.10.2
