Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E970D1A02C2
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Dec 2014 15:31:21 +1100 (AEDT)
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2FFFE1400D2
 for <linuxppc-dev@ozlabs.org>; Fri,  5 Dec 2014 15:31:20 +1100 (AEDT)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Fri, 5 Dec 2014 10:01:18 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 7A082125804B
 for <linuxppc-dev@ozlabs.org>; Fri,  5 Dec 2014 10:01:35 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB54VSkd64684166
 for <linuxppc-dev@ozlabs.org>; Fri, 5 Dec 2014 10:01:29 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB54VFVA023383
 for <linuxppc-dev@ozlabs.org>; Fri, 5 Dec 2014 10:01:15 +0530
Subject: [PATCH] powerpc/book3s: Fix partial invalidation of TLBs in MCE code.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Date: Fri, 05 Dec 2014 10:01:15 +0530
Message-ID: <20141205042616.17216.16015.stgit@mars>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

The existing MCE code calls flush_tlb hook with IS=0 (single page) resulting
partial invalidation of TLBs which is not right. This patch fixes that
by passing IS=0xc00 to invalidate whole TLB for successful recovery from
TLB and ERAT errors.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
Hi Michael,
	This MCE fix patch is for stable.

 arch/powerpc/kernel/mce_power.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
index aa9aff3..b6f123a 100644
--- a/arch/powerpc/kernel/mce_power.c
+++ b/arch/powerpc/kernel/mce_power.c
@@ -79,7 +79,7 @@ static long mce_handle_derror(uint64_t dsisr, uint64_t slb_error_bits)
 	}
 	if (dsisr & P7_DSISR_MC_TLB_MULTIHIT_MFTLB) {
 		if (cur_cpu_spec && cur_cpu_spec->flush_tlb)
-			cur_cpu_spec->flush_tlb(TLBIEL_INVAL_PAGE);
+			cur_cpu_spec->flush_tlb(TLBIEL_INVAL_SET);
 		/* reset error bits */
 		dsisr &= ~P7_DSISR_MC_TLB_MULTIHIT_MFTLB;
 	}
@@ -110,7 +110,7 @@ static long mce_handle_common_ierror(uint64_t srr1)
 		break;
 	case P7_SRR1_MC_IFETCH_TLB_MULTIHIT:
 		if (cur_cpu_spec && cur_cpu_spec->flush_tlb) {
-			cur_cpu_spec->flush_tlb(TLBIEL_INVAL_PAGE);
+			cur_cpu_spec->flush_tlb(TLBIEL_INVAL_SET);
 			handled = 1;
 		}
 		break;
