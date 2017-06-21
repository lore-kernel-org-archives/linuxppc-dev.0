Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtD5Q4GcqzDqj1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 04:39:22 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5LIcZ2c013068
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 14:39:20 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b7uyexqp0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 14:39:20 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 22 Jun 2017 04:39:17 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5LIdFTo5571012
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 04:39:15 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5LIdFlV018234
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 04:39:15 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 6/6] powerpc/64s: Blacklist rtas entry/exit from kprobes
Date: Thu, 22 Jun 2017 00:08:42 +0530
In-Reply-To: <cover.1498069502.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1498069502.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1498069502.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1498069502.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <482db382b611b0a97bb1d897b3b38cc083e10965.1498069502.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We can't take traps with relocation off, so blacklist enter_rtas() and
rtas_return_loc(). However, instead of blacklisting all of enter_rtas(),
introduce a new symbol __enter_rtas from where on we can't take a trap
and blacklist that.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/entry_64.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index d376f07153d7..49c35450f399 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -1076,6 +1076,8 @@ _GLOBAL(enter_rtas)
         rldicr  r9,r9,MSR_SF_LG,(63-MSR_SF_LG)
 	ori	r9,r9,MSR_IR|MSR_DR|MSR_FE0|MSR_FE1|MSR_FP|MSR_RI|MSR_LE
 	andc	r6,r0,r9
+
+__enter_rtas:
 	sync				/* disable interrupts so SRR0/1 */
 	mtmsrd	r0			/* don't get trashed */
 
@@ -1112,6 +1114,8 @@ rtas_return_loc:
 	mtspr	SPRN_SRR1,r4
 	rfid
 	b	.	/* prevent speculative execution */
+_ASM_NOKPROBE_SYMBOL(__enter_rtas)
+_ASM_NOKPROBE_SYMBOL(rtas_return_loc)
 
 	.align	3
 1:	.llong	rtas_restore_regs
-- 
2.13.1
