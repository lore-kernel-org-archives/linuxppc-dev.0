Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tZ3RW3RVWzDvhR
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Dec 2016 16:13:27 +1100 (AEDT)
From: David Gibson <david@gibson.dropbear.id.au>
To: michael@ellerman.id.au,
	paulus@samba.org
Cc: linuxppc-dev@ozlabs.org, kvm@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 4/6] pseries: Add support for hash table resizing
Date: Thu,  8 Dec 2016 16:13:19 +1100
Message-Id: <20161208051321.31446-5-david@gibson.dropbear.id.au>
In-Reply-To: <20161208051321.31446-1-david@gibson.dropbear.id.au>
References: <20161208051321.31446-1-david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds support for using experimental hypercalls to change the size
of the main hash page table while running as a PAPR guest.  For now these
hypercalls are only in experimental qemu versions.

The interface is two part: first H_RESIZE_HPT_PREPARE is used to allocate
and prepare the new hash table.  This may be slow, but can be done
asynchronously.  Then, H_RESIZE_HPT_COMMIT is used to switch to the new
hash table.  This requires that no CPUs be concurrently updating the HPT,
and so must be run under stop_machine().

This also adds a debugfs file which can be used to manually control
HPT resizing or testing purposes.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/book3s/64/mmu-hash.h |   1 +
 arch/powerpc/mm/hash_utils_64.c               |  28 +++++++
 arch/powerpc/platforms/pseries/lpar.c         | 110 ++++++++++++++++++++++++++
 3 files changed, 139 insertions(+)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index e407af2..efba649 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -153,6 +153,7 @@ struct mmu_hash_ops {
 					       unsigned long addr,
 					       unsigned char *hpte_slot_array,
 					       int psize, int ssize, int local);
+	int		(*resize_hpt)(unsigned long shift);
 	/*
 	 * Special for kexec.
 	 * To be called in real mode with interrupts disabled. No locks are
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 78dabf06..474da2e 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -35,6 +35,7 @@
 #include <linux/memblock.h>
 #include <linux/context_tracking.h>
 #include <linux/libfdt.h>
+#include <linux/debugfs.h>
 
 #include <asm/processor.h>
 #include <asm/pgtable.h>
@@ -1815,3 +1816,30 @@ void hash__setup_initial_memory_limit(phys_addr_t first_memblock_base,
 	/* Finally limit subsequent allocations */
 	memblock_set_current_limit(ppc64_rma_size);
 }
+
+static int ppc64_pft_size_get(void *data, u64 *val)
+{
+	*val = ppc64_pft_size;
+	return 0;
+}
+
+static int ppc64_pft_size_set(void *data, u64 val)
+{
+	if (!mmu_hash_ops.resize_hpt)
+		return -ENODEV;
+	return mmu_hash_ops.resize_hpt(val);
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(fops_ppc64_pft_size,
+			ppc64_pft_size_get, ppc64_pft_size_set,	"%llu\n");
+
+static int __init hash64_debugfs(void)
+{
+	if (!debugfs_create_file("pft-size", 0600, powerpc_debugfs_root,
+				 NULL, &fops_ppc64_pft_size)) {
+		pr_err("lpar: unable to create ppc64_pft_size debugsfs file\n");
+	}
+
+	return 0;
+}
+machine_device_initcall(pseries, hash64_debugfs);
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index aa35245..5f0cee3 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -27,6 +27,8 @@
 #include <linux/console.h>
 #include <linux/export.h>
 #include <linux/jump_label.h>
+#include <linux/delay.h>
+#include <linux/stop_machine.h>
 #include <asm/processor.h>
 #include <asm/mmu.h>
 #include <asm/page.h>
@@ -589,6 +591,113 @@ static int __init disable_bulk_remove(char *str)
 
 __setup("bulk_remove=", disable_bulk_remove);
 
+#define HPT_RESIZE_TIMEOUT	10000 /* ms */
+
+struct hpt_resize_state {
+	unsigned long shift;
+	int commit_rc;
+};
+
+static int pseries_lpar_resize_hpt_commit(void *data)
+{
+	struct hpt_resize_state *state = data;
+
+	state->commit_rc = plpar_resize_hpt_commit(0, state->shift);
+	if (state->commit_rc != H_SUCCESS)
+		return -EIO;
+
+	/* Hypervisor has transitioned the HTAB, update our globals */
+	ppc64_pft_size = state->shift;
+	htab_size_bytes = 1UL << ppc64_pft_size;
+	htab_hash_mask = (htab_size_bytes >> 7) - 1;
+
+	return 0;
+}
+
+/* Must be called in user context */
+static int pseries_lpar_resize_hpt(unsigned long shift)
+{
+	struct hpt_resize_state state = {
+		.shift = shift,
+		.commit_rc = H_FUNCTION,
+	};
+	unsigned int delay, total_delay = 0;
+	int rc;
+	ktime_t t0, t1, t2;
+
+	might_sleep();
+
+	if (!firmware_has_feature(FW_FEATURE_HPT_RESIZE))
+		return -ENODEV;
+
+	printk(KERN_INFO "lpar: Attempting to resize HPT to shift %lu\n",
+	       shift);
+
+	t0 = ktime_get();
+
+	rc = plpar_resize_hpt_prepare(0, shift);
+	while (H_IS_LONG_BUSY(rc)) {
+		delay = get_longbusy_msecs(rc);
+		total_delay += delay;
+		if (total_delay > HPT_RESIZE_TIMEOUT) {
+			/* prepare call with shift==0 cancels an
+			 * in-progress resize */
+			rc = plpar_resize_hpt_prepare(0, 0);
+			if (rc != H_SUCCESS)
+				printk(KERN_WARNING
+				       "lpar: Unexpected error %d cancelling timed out HPT resize\n",
+				       rc);
+			return -ETIMEDOUT;
+		}
+		msleep(delay);
+		rc = plpar_resize_hpt_prepare(0, shift);
+	};
+
+	switch (rc) {
+	case H_SUCCESS:
+		/* Continue on */
+		break;
+
+	case H_PARAMETER:
+		return -EINVAL;
+	case H_RESOURCE:
+		return -EPERM;
+	default:
+		printk(KERN_WARNING
+		       "lpar: Unexpected error %d from H_RESIZE_HPT_PREPARE\n",
+		       rc);
+		return -EIO;
+	}
+
+	t1 = ktime_get();
+
+	rc = stop_machine(pseries_lpar_resize_hpt_commit, &state, NULL);
+
+	t2 = ktime_get();
+
+	if (rc != 0) {
+		switch (state.commit_rc) {
+		case H_PTEG_FULL:
+			printk(KERN_WARNING
+			       "lpar: Hash collision while resizing HPT\n");
+			return -ENOSPC;
+
+		default:
+			printk(KERN_WARNING
+			       "lpar: Unexpected error %d from H_RESIZE_HPT_COMMIT\n",
+			       state.commit_rc);
+			return -EIO;
+		};
+	}
+
+	printk(KERN_INFO
+	       "lpar: HPT resize to shift %lu complete (%lld ms / %lld ms)\n",
+	       shift, (long long) ktime_ms_delta(t1, t0),
+	       (long long) ktime_ms_delta(t2, t1));
+
+	return 0;
+}
+
 void __init hpte_init_pseries(void)
 {
 	mmu_hash_ops.hpte_invalidate	 = pSeries_lpar_hpte_invalidate;
@@ -600,6 +709,7 @@ void __init hpte_init_pseries(void)
 	mmu_hash_ops.flush_hash_range	 = pSeries_lpar_flush_hash_range;
 	mmu_hash_ops.hpte_clear_all      = pSeries_lpar_hptab_clear;
 	mmu_hash_ops.hugepage_invalidate = pSeries_lpar_hugepage_invalidate;
+	mmu_hash_ops.resize_hpt		 = pseries_lpar_resize_hpt;
 }
 
 #ifdef CONFIG_PPC_SMLPAR
-- 
2.9.3
