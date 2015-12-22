Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DB571A11C6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Dec 2015 16:14:15 +1100 (AEDT)
From: David Gibson <david@gibson.dropbear.id.au>
To: paulus@samba.org,
	benh@kernel.crashing.org,
	bharata@linux.vnet.ibm.com
Cc: thuth@redhat.com, lvivier@redhat.com, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [RFC 2/3] pseries: Add support for hash table resizing
Date: Tue, 22 Dec 2015 16:14:57 +1100
Message-Id: <1450761298-12172-3-git-send-email-david@gibson.dropbear.id.au>
In-Reply-To: <1450761298-12172-1-git-send-email-david@gibson.dropbear.id.au>
References: <1450761298-12172-1-git-send-email-david@gibson.dropbear.id.au>
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

This patch only supplies a function to execute the hash table change,
nothing yet calls it.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/platforms/pseries/lpar.c | 109 ++++++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index b7a67e3..aadb242 100644
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
@@ -794,3 +796,110 @@ int h_get_mpp_x(struct hvcall_mpp_x_data *mpp_x_data)
 
 	return rc;
 }
+
+#define HPT_RESIZE_TIMEOUT	10000 /* ms */
+
+struct hpt_resize_state {
+	unsigned long shift;
+	int commit_rc;
+};
+
+static int pSeries_lpar_resize_hpt_commit(void *data)
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
+int pSeries_lpar_resize_hpt(unsigned long shift)
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
+	get_online_cpus();
+	mb();
+	rc = stop_machine(pSeries_lpar_resize_hpt_commit, &state,
+			  cpu_online_mask);
+	put_online_cpus();
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
-- 
2.5.0
