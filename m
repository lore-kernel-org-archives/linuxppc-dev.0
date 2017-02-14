Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vMnjX0828zDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 14:20:16 +1100 (AEDT)
Date: Tue, 14 Feb 2017 14:20:15 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@kernel.org>,
 KVM <kvm@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, PowerPC
 <linuxppc-dev@lists.ozlabs.org>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, David Gibson
 <david@gibson.dropbear.id.au>, Paul Mackerras <paulus@ozlabs.org>
Subject: linux-next: manual merge of the kvm tree with the powerpc tree
Message-ID: <20170214142015.156e9c4d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

Today's linux-next merge of the kvm tree got a conflict in:

  arch/powerpc/platforms/pseries/lpar.c

between commit:

  dbcf929c0062 ("powerpc/pseries: Add support for hash table resizing")

from the powerpc tree and commit:

  cc3d2940133d ("powerpc/64: Enable use of radix MMU under hypervisor on POWER9")

from the kvm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

-- 
Cheers,
Stephen Rothwell

diff --cc arch/powerpc/platforms/pseries/lpar.c
index c2e13a51f369,0587655aea69..000000000000
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@@ -611,112 -609,29 +611,135 @@@ static int __init disable_bulk_remove(c
  
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
 +			/* prepare with shift==0 cancels an in-progress resize */
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
+ /* Actually only used for radix, so far */
+ static int pseries_lpar_register_process_table(unsigned long base,
+ 			unsigned long page_size, unsigned long table_size)
+ {
+ 	long rc;
+ 	unsigned long flags = PROC_TABLE_NEW;
+ 
+ 	if (radix_enabled())
+ 		flags |= PROC_TABLE_RADIX | PROC_TABLE_GTSE;
+ 	for (;;) {
+ 		rc = plpar_hcall_norets(H_REGISTER_PROC_TBL, flags, base,
+ 					page_size, table_size);
+ 		if (!H_IS_LONG_BUSY(rc))
+ 			break;
+ 		mdelay(get_longbusy_msecs(rc));
+ 	}
+ 	if (rc != H_SUCCESS) {
+ 		pr_err("Failed to register process table (rc=%ld)\n", rc);
+ 		BUG();
+ 	}
+ 	return rc;
+ }
+ 
  void __init hpte_init_pseries(void)
  {
  	mmu_hash_ops.hpte_invalidate	 = pSeries_lpar_hpte_invalidate;
@@@ -728,9 -643,14 +751,15 @@@
  	mmu_hash_ops.flush_hash_range	 = pSeries_lpar_flush_hash_range;
  	mmu_hash_ops.hpte_clear_all      = pseries_hpte_clear_all;
  	mmu_hash_ops.hugepage_invalidate = pSeries_lpar_hugepage_invalidate;
 +	mmu_hash_ops.resize_hpt		 = pseries_lpar_resize_hpt;
  }
  
+ void radix_init_pseries(void)
+ {
+ 	pr_info("Using radix MMU under hypervisor\n");
+ 	register_process_table = pseries_lpar_register_process_table;
+ }
+ 
  #ifdef CONFIG_PPC_SMLPAR
  #define CMO_FREE_HINT_DEFAULT 1
  static int cmo_free_hint_flag = CMO_FREE_HINT_DEFAULT;
