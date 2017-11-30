Return-Path: <srs0=ddqe=c4=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ynWj90JCHzDrq9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Nov 2017 20:06:04 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3ynWj855BYz8tCT
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Nov 2017 20:06:04 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3ynWj81s6Lz9t2V
 for <linuxppc-dev@ozlabs.org>; Thu, 30 Nov 2017 20:06:03 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAU945OC080495
 for <linuxppc-dev@ozlabs.org>; Thu, 30 Nov 2017 04:06:02 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2eje4j2fbp-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 30 Nov 2017 04:06:01 -0500
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Thu, 30 Nov 2017 09:05:58 -0000
Subject: [PATCH] powerpc/radix: Remove trace_tlbie call from
 radix__flush_tlb_all
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Balbir Singh <bsingharora@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Thu, 30 Nov 2017 14:35:54 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <151203273555.16587.12957613472048945542.stgit@jupiter.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

radix__flush_tlb_all() is called only in kexec path in real mode and any
tracepoints at this stage will make kexec to fail if enabled.

To verify enable tlbie trace before kexec.

$ echo 1 > /sys/kernel/debug/tracing/events/powerpc/tlbie/enable
== kexec into new kernel and kexec fails.

Fix this by not calling trace_tlbie from radix__flush_tlb_all().

Fixes: 0428491cba92 ("powerpc/mm: Trace tlbie(l) instructions")
Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/mm/tlb-radix.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index 884f4b7..913a2b8 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -600,14 +600,12 @@ void radix__flush_tlb_all(void)
 	 */
 	asm volatile(PPC_TLBIE_5(%0, %4, %3, %2, %1)
 		     : : "r"(rb), "i"(r), "i"(1), "i"(ric), "r"(rs) : "memory");
-	trace_tlbie(0, 0, rb, rs, ric, prs, r);
 	/*
 	 * now flush host entires by passing PRS = 0 and LPID == 0
 	 */
 	asm volatile(PPC_TLBIE_5(%0, %4, %3, %2, %1)
 		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(0) : "memory");
 	asm volatile("eieio; tlbsync; ptesync": : :"memory");
-	trace_tlbie(0, 0, rb, 0, ric, prs, r);
 }
 
 void radix__flush_tlb_pte_p9_dd1(unsigned long old_pte, struct mm_struct *mm,
