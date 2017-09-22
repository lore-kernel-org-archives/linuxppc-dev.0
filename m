Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xz74w46JlzDsM5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 19:11:12 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8M99Kjg076201
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 05:11:10 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2d4xb5brx8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 05:11:09 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 22 Sep 2017 19:11:07 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v8M9B5Yj38797490
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 19:11:05 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v8M9AuOH020516
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 19:10:56 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 2/6] powerpc/kprobes: Do not suppress instruction emulation
 if a single run failed
Date: Fri, 22 Sep 2017 14:40:44 +0530
In-Reply-To: <9e98f74834af349564b71bc8443bdad55d6e37c6.1505934128.git.naveen.n.rao@linux.vnet.ibm.com>
References: <9e98f74834af349564b71bc8443bdad55d6e37c6.1505934128.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1505934128.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1505934128.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <4b00ce57a202313ae0fcab03d07b6ea84dae811d.1505934128.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, we disable instruction emulation if emulate_step() fails for
any reason. However, such failures could be transient and specific to a
particular run. Instead, only disable instruction emulation if we have
never been able to emulate this. If we had emulated this instruction
successfully at least once, then we single step only this probe hit and
continue to try emulating the instruction in subsequent probe hits.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/kprobes.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index c2a6ab38a67f..4c1702423676 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -261,9 +261,20 @@ static int try_to_emulate(struct kprobe *p, struct pt_regs *regs)
 		 */
 		printk("Can't step on instruction %x\n", insn);
 		BUG();
-	} else
-		/* This instruction can't be boosted */
-		p->ainsn.boostable = -1;
+	} else {
+		/*
+		 * If we haven't previously emulated this instruction, then it
+		 * can't be boosted. Note it down so we don't try to do so again.
+		 *
+		 * If, however, we had emulated this instruction in the past,
+		 * then this is just an error with the current run (for
+		 * instance, exceptions due to a load/store). We return 0 so
+		 * that this is now single-stepped, but continue to try
+		 * emulating it in subsequent probe hits.
+		 */
+		if (unlikely(p->ainsn.boostable != 1))
+			p->ainsn.boostable = -1;
+	}
 
 	return ret;
 }
-- 
2.14.1
