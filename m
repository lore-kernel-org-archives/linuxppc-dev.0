Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyx6j6FHwzDr5f
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 20:41:49 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5TAd8Sb083972
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 06:41:47 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bcrja0fdm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 06:41:47 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 29 Jun 2017 20:41:44 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5TAfaap11469174
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 20:41:36 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5TAfSDf029402
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 20:41:28 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 7/7] powerpc/64s: Blacklist rtas entry/exit from kprobes
Date: Thu, 29 Jun 2017 16:11:10 +0530
In-Reply-To: <cover.1498732172.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1498732172.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1498732172.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1498732172.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <39d40efd808c6346b97e5bfe4be47546919cb91b.1498732172.git.naveen.n.rao@linux.vnet.ibm.com>
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
 arch/powerpc/kernel/entry_64.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 0c27084800b6..16f4c4a1a294 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -1082,6 +1082,7 @@ _GLOBAL(enter_rtas)
 	sync				/* disable interrupts so SRR0/1 */
 	mtmsrd	r0			/* don't get trashed */
 
+__enter_rtas:
 	LOAD_REG_ADDR(r4, rtas)
 	ld	r5,RTASENTRY(r4)	/* get the rtas->entry value */
 	ld	r4,RTASBASE(r4)		/* get the rtas->base value */
@@ -1115,6 +1116,8 @@ rtas_return_loc:
 	mtspr	SPRN_SRR1,r4
 	rfid
 	b	.	/* prevent speculative execution */
+_ASM_NOKPROBE_SYMBOL(__enter_rtas)
+_ASM_NOKPROBE_SYMBOL(rtas_return_loc)
 
 	.align	3
 1:	.llong	rtas_restore_regs
-- 
2.13.1
