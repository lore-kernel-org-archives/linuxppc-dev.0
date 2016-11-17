Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tKPg10Xp2zDvx6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 02:09:32 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAHF8j6r120627
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 10:09:30 -0500
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26s8jccba9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 10:09:30 -0500
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 17 Nov 2016 20:39:26 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 714D1125804F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 20:40:18 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAHF9N3V27721936
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 20:39:23 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAHF9K4j005280
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 20:39:22 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>, Anton Blanchard <anton@samba.org>,
 linuxppc-dev@lists.ozlabs.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: [RFC PATCH 4/4] powerpc: mm/slb: blacklist symbols from kprobe
Date: Thu, 17 Nov 2016 20:38:33 +0530
In-Reply-To: <cover.1479394571.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1479394571.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1479394571.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1479394571.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <a599d736aa7323a767fd62e1af33b99b235aed39.1479394571.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We can't really take a trap at this point. So, blacklist these symbols.

Reported-by: Anton Blanchard <anton@samba.org>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/mm/slb_low.S | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
index c1c7456..c2bae92 100644
--- a/arch/powerpc/mm/slb_low.S
+++ b/arch/powerpc/mm/slb_low.S
@@ -30,7 +30,7 @@
  *	r9, r10, r11 are clobbered by this function
  * No other registers are examined or changed.
  */
-_GLOBAL(slb_allocate_realmode)
+_GLOBAL_NOKPROBE(slb_allocate_realmode)
 	/*
 	 * check for bad kernel/user address
 	 * (ea & ~REGION_MASK) >= PGTABLE_RANGE
@@ -59,7 +59,7 @@ _GLOBAL(slb_allocate_realmode)
 	/* Linear mapping encoding bits, the "li" instruction below will
 	 * be patched by the kernel at boot
 	 */
-_GLOBAL_SYM(slb_miss_kernel_load_linear)
+_GLOBAL_SYM_NOKPROBE(slb_miss_kernel_load_linear)
 	li	r11,0
 	/*
 	 * context = (MAX_USER_CONTEXT) + ((ea >> 60) - 0xc) + 1
@@ -79,7 +79,7 @@ END_MMU_FTR_SECTION_IFCLR(MMU_FTR_1T_SEGMENT)
 	/* Check virtual memmap region. To be patches at kernel boot */
 	cmpldi	cr0,r9,0xf
 	bne	1f
-_GLOBAL_SYM(slb_miss_kernel_load_vmemmap)
+_GLOBAL_SYM_NOKPROBE(slb_miss_kernel_load_vmemmap)
 	li	r11,0
 	b	6f
 1:
@@ -95,7 +95,7 @@ _GLOBAL_SYM(slb_miss_kernel_load_vmemmap)
 	b	6f
 5:
 	/* IO mapping */
-_GLOBAL_SYM(slb_miss_kernel_load_io)
+_GLOBAL_SYM_NOKPROBE(slb_miss_kernel_load_io)
 	li	r11,0
 6:
 	/*
@@ -203,7 +203,7 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_1T_SEGMENT)
 7:	ld	r10,PACASTABRR(r13)
 	addi	r10,r10,1
 	/* This gets soft patched on boot. */
-_GLOBAL_SYM(slb_compare_rr_to_size)
+_GLOBAL_SYM_NOKPROBE(slb_compare_rr_to_size)
 	cmpldi	r10,0
 
 	blt+	4f
-- 
2.10.2
