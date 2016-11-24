Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tPNlW0YykzDw3S
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2016 13:42:15 +1100 (AEDT)
Date: Thu, 24 Nov 2016 13:42:14 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paul Mackerras <paulus@ozlabs.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, "Naveen N.
 Rao" <naveen.n.rao@linux.vnet.ibm.com>, Daniel Axtens <dja@axtens.net>
Subject: linux-next: manual merge of the kvm-ppc-paulus tree with the
 powerpc-fixes tree
Message-ID: <20161124134214.3287a024@canb.auug.org.au>
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

Hi Paul,

Today's linux-next merge of the kvm-ppc-paulus tree got a conflict in:

  arch/powerpc/include/asm/asm-prototypes.h

between commit:

  82de5797a260 ("powerpc: Remove extraneous header from asm-prototypes.h")

from the powerpc-fixes tree and commit:

  ebe4535fbe7a ("KVM: PPC: Book3S HV: sparse: prototypes for functions called from assembler")

from the kvm-ppc-paulus tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

-- 
Cheers,
Stephen Rothwell

diff --cc arch/powerpc/include/asm/asm-prototypes.h
index 81592562e0f8,6c853bcd11fa..000000000000
--- a/arch/powerpc/include/asm/asm-prototypes.h
+++ b/arch/powerpc/include/asm/asm-prototypes.h
@@@ -13,10 -13,10 +13,13 @@@
   */
  
  #include <linux/threads.h>
 -#include <linux/kprobes.h>
 +#include <asm/cacheflush.h>
 +#include <asm/checksum.h>
 +#include <asm/uaccess.h>
 +#include <asm/epapr_hcalls.h>
+ #ifdef CONFIG_KVM
+ #include <linux/kvm_host.h>
+ #endif
  
  #include <uapi/asm/ucontext.h>
  
@@@ -112,12 -112,45 +115,53 @@@ void early_setup_secondary(void)
  /* time */
  void accumulate_stolen_time(void);
  
 +/* misc runtime */
 +extern u64 __bswapdi2(u64);
 +extern s64 __lshrdi3(s64, int);
 +extern s64 __ashldi3(s64, int);
 +extern s64 __ashrdi3(s64, int);
 +extern int __cmpdi2(s64, s64);
 +extern int __ucmpdi2(u64, u64);
 +
+ /* kvm */
+ #ifdef CONFIG_KVM
+ long kvmppc_rm_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
+ 			 unsigned long ioba, unsigned long tce);
+ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vcpu,
+ 				  unsigned long liobn, unsigned long ioba,
+ 				  unsigned long tce_list, unsigned long npages);
+ long kvmppc_rm_h_stuff_tce(struct kvm_vcpu *vcpu,
+ 			   unsigned long liobn, unsigned long ioba,
+ 			   unsigned long tce_value, unsigned long npages);
+ long int kvmppc_rm_h_confer(struct kvm_vcpu *vcpu, int target,
+                             unsigned int yield_count);
+ long kvmppc_h_random(struct kvm_vcpu *vcpu);
+ void kvmhv_commence_exit(int trap);
+ long kvmppc_realmode_machine_check(struct kvm_vcpu *vcpu);
+ void kvmppc_subcore_enter_guest(void);
+ void kvmppc_subcore_exit_guest(void);
+ long kvmppc_realmode_hmi_handler(void);
+ long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
+                     long pte_index, unsigned long pteh, unsigned long ptel);
+ long kvmppc_h_remove(struct kvm_vcpu *vcpu, unsigned long flags,
+                      unsigned long pte_index, unsigned long avpn);
+ long kvmppc_h_bulk_remove(struct kvm_vcpu *vcpu);
+ long kvmppc_h_protect(struct kvm_vcpu *vcpu, unsigned long flags,
+                       unsigned long pte_index, unsigned long avpn,
+                       unsigned long va);
+ long kvmppc_h_read(struct kvm_vcpu *vcpu, unsigned long flags,
+                    unsigned long pte_index);
+ long kvmppc_h_clear_ref(struct kvm_vcpu *vcpu, unsigned long flags,
+                         unsigned long pte_index);
+ long kvmppc_h_clear_mod(struct kvm_vcpu *vcpu, unsigned long flags,
+                         unsigned long pte_index);
+ long kvmppc_hpte_hv_fault(struct kvm_vcpu *vcpu, unsigned long addr,
+                           unsigned long slb_v, unsigned int status, bool data);
+ unsigned long kvmppc_rm_h_xirr(struct kvm_vcpu *vcpu);
+ int kvmppc_rm_h_ipi(struct kvm_vcpu *vcpu, unsigned long server,
+                     unsigned long mfrr);
+ int kvmppc_rm_h_cppr(struct kvm_vcpu *vcpu, unsigned long cppr);
+ int kvmppc_rm_h_eoi(struct kvm_vcpu *vcpu, unsigned long xirr);
+ #endif
+ 
  #endif /* _ASM_POWERPC_ASM_PROTOTYPES_H */
