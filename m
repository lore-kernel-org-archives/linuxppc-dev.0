Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40H9WM3fFnzF1ql
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Apr 2018 03:56:47 +1000 (AEST)
Received: by mail-pl0-x241.google.com with SMTP id s10-v6so18255366plp.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Apr 2018 10:56:47 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@ozlabs.org>, Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH 1/2] KVM: PPC: Book3S HV: trace_tlbie must not be called in
 realmode
Date: Fri,  6 Apr 2018 03:56:30 +1000
Message-Id: <20180405175631.31381-2-npiggin@gmail.com>
In-Reply-To: <20180405175631.31381-1-npiggin@gmail.com>
References: <20180405175631.31381-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This crashes with a "Bad real address for load" attempting to load
from the vmalloc region in realmode (faulting address is in DAR).

  Oops: Bad interrupt in KVM entry/exit code, sig: 6 [#1]
  LE SMP NR_CPUS=2048 NUMA PowerNV
  CPU: 53 PID: 6582 Comm: qemu-system-ppc Not tainted 4.16.0-01530-g43d1859f0994
  NIP:  c0000000000155ac LR: c0000000000c2430 CTR: c000000000015580
  REGS: c000000fff76dd80 TRAP: 0200   Not tainted  (4.16.0-01530-g43d1859f0994)
  MSR:  9000000000201003 <SF,HV,ME,RI,LE>  CR: 48082222  XER: 00000000
  CFAR: 0000000102900ef0 DAR: d00017fffd941a28 DSISR: 00000040 SOFTE: 3
  NIP [c0000000000155ac] perf_trace_tlbie+0x2c/0x1a0
  LR [c0000000000c2430] do_tlbies+0x230/0x2f0

I suspect the reason is the per-cpu data is not in the linear chunk.
This could be restored if that was able to be fixed, but for now,
just remove the tracepoints.

Fixes: 0428491cba ("powerpc/mm: Trace tlbie(l) instructions")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kvm/book3s_hv_rm_mmu.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index e1c083fbe434..78e6a392330f 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -470,8 +470,6 @@ static void do_tlbies(struct kvm *kvm, unsigned long *rbvalues,
 		for (i = 0; i < npages; ++i) {
 			asm volatile(PPC_TLBIE_5(%0,%1,0,0,0) : :
 				     "r" (rbvalues[i]), "r" (kvm->arch.lpid));
-			trace_tlbie(kvm->arch.lpid, 0, rbvalues[i],
-				kvm->arch.lpid, 0, 0, 0);
 		}
 
 		if (cpu_has_feature(CPU_FTR_P9_TLBIE_BUG)) {
@@ -492,8 +490,6 @@ static void do_tlbies(struct kvm *kvm, unsigned long *rbvalues,
 		for (i = 0; i < npages; ++i) {
 			asm volatile(PPC_TLBIEL(%0,%1,0,0,0) : :
 				     "r" (rbvalues[i]), "r" (0));
-			trace_tlbie(kvm->arch.lpid, 1, rbvalues[i],
-				0, 0, 0, 0);
 		}
 		asm volatile("ptesync" : : : "memory");
 	}
-- 
2.16.3
