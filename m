Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tKPfz0cwLzDvxJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 02:09:30 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAHF8eO6060156
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 10:09:29 -0500
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26sa2kg6sk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 10:09:29 -0500
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 17 Nov 2016 20:39:25 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 3A849E005A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 20:39:35 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAHF9Mfo41943130
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 20:39:22 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAHF9Kcb005266
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 20:39:22 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>, Anton Blanchard <anton@samba.org>,
 linuxppc-dev@lists.ozlabs.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: [RFC PATCH 3/4] powerpc: mm/slb: convert slb_low.S to use the new
 macros
Date: Thu, 17 Nov 2016 20:38:32 +0530
In-Reply-To: <cover.1479394571.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1479394571.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1479394571.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1479394571.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <9eaba393132fdec6ea1dd1d61e7d803de5415591.1479394571.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Also convert slb_finish_load[_1T] to a local symbol as this doesn't need
to be globally visible.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/mm/slb_low.S | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
index e2974fc..c1c7456 100644
--- a/arch/powerpc/mm/slb_low.S
+++ b/arch/powerpc/mm/slb_low.S
@@ -59,8 +59,7 @@ _GLOBAL(slb_allocate_realmode)
 	/* Linear mapping encoding bits, the "li" instruction below will
 	 * be patched by the kernel at boot
 	 */
-.globl slb_miss_kernel_load_linear
-slb_miss_kernel_load_linear:
+_GLOBAL_SYM(slb_miss_kernel_load_linear)
 	li	r11,0
 	/*
 	 * context = (MAX_USER_CONTEXT) + ((ea >> 60) - 0xc) + 1
@@ -71,17 +70,16 @@ slb_miss_kernel_load_linear:
 
 
 BEGIN_FTR_SECTION
-	b	slb_finish_load
+	b	.Lslb_finish_load
 END_MMU_FTR_SECTION_IFCLR(MMU_FTR_1T_SEGMENT)
-	b	slb_finish_load_1T
+	b	.Lslb_finish_load_1T
 
 1:
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
 	/* Check virtual memmap region. To be patches at kernel boot */
 	cmpldi	cr0,r9,0xf
 	bne	1f
-.globl slb_miss_kernel_load_vmemmap
-slb_miss_kernel_load_vmemmap:
+_GLOBAL_SYM(slb_miss_kernel_load_vmemmap)
 	li	r11,0
 	b	6f
 1:
@@ -97,8 +95,7 @@ slb_miss_kernel_load_vmemmap:
 	b	6f
 5:
 	/* IO mapping */
-.globl slb_miss_kernel_load_io
-slb_miss_kernel_load_io:
+_GLOBAL_SYM(slb_miss_kernel_load_io)
 	li	r11,0
 6:
 	/*
@@ -109,9 +106,9 @@ slb_miss_kernel_load_io:
 	addi	r9,r9,(MAX_USER_CONTEXT - 0xc + 1)@l
 
 BEGIN_FTR_SECTION
-	b	slb_finish_load
+	b	.Lslb_finish_load
 END_MMU_FTR_SECTION_IFCLR(MMU_FTR_1T_SEGMENT)
-	b	slb_finish_load_1T
+	b	.Lslb_finish_load_1T
 
 0:	/*
 	 * For userspace addresses, make sure this is region 0.
@@ -174,9 +171,9 @@ END_MMU_FTR_SECTION_IFCLR(MMU_FTR_1T_SEGMENT)
 	ld	r9,PACACONTEXTID(r13)
 BEGIN_FTR_SECTION
 	cmpldi	r10,0x1000
-	bge	slb_finish_load_1T
+	bge	.Lslb_finish_load_1T
 END_MMU_FTR_SECTION_IFSET(MMU_FTR_1T_SEGMENT)
-	b	slb_finish_load
+	b	.Lslb_finish_load
 
 8:	/* invalid EA - return an error indication */
 	crset	4*cr0+eq		/* indicate failure */
@@ -187,7 +184,7 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_1T_SEGMENT)
  *
  * r3 = EA, r9 = context, r10 = ESID, r11 = flags, clobbers r9, cr7 = <> PAGE_OFFSET
  */
-slb_finish_load:
+.Lslb_finish_load:
 	rldimi  r10,r9,ESID_BITS,0
 	ASM_VSID_SCRAMBLE(r10,r9,256M)
 	/*
@@ -206,8 +203,7 @@ slb_finish_load:
 7:	ld	r10,PACASTABRR(r13)
 	addi	r10,r10,1
 	/* This gets soft patched on boot. */
-.globl slb_compare_rr_to_size
-slb_compare_rr_to_size:
+_GLOBAL_SYM(slb_compare_rr_to_size)
 	cmpldi	r10,0
 
 	blt+	4f
@@ -256,7 +252,7 @@ slb_compare_rr_to_size:
  *
  * r3 = EA, r9 = context, r10 = ESID(256MB), r11 = flags, clobbers r9
  */
-slb_finish_load_1T:
+.Lslb_finish_load_1T:
 	srdi	r10,r10,(SID_SHIFT_1T - SID_SHIFT)	/* get 1T ESID */
 	rldimi  r10,r9,ESID_BITS_1T,0
 	ASM_VSID_SCRAMBLE(r10,r9,1T)
-- 
2.10.2
