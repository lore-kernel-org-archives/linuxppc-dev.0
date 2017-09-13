Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xsvj91v9kzDrFt
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 07:21:01 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8DLJ216037594
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Sep 2017 17:20:58 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2cy89fqjx3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Sep 2017 17:20:58 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 14 Sep 2017 07:20:55 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v8DLKrUw42860662
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 07:20:53 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v8DLKsRY025892
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 07:20:55 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: [PATCH 2/5] powerpc/kprobes: Do not suppress instruction emulation if
 a single run failed
Date: Thu, 14 Sep 2017 02:50:33 +0530
In-Reply-To: <2bc413d679c563d3ee338c318066777318577ab2.1505336870.git.naveen.n.rao@linux.vnet.ibm.com>
References: <2bc413d679c563d3ee338c318066777318577ab2.1505336870.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <2bc413d679c563d3ee338c318066777318577ab2.1505336870.git.naveen.n.rao@linux.vnet.ibm.com>
References: <2bc413d679c563d3ee338c318066777318577ab2.1505336870.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <a3a2ddbd004f0410943edb998011cfd31b97384e.1505336870.git.naveen.n.rao@linux.vnet.ibm.com>
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
 arch/powerpc/kernel/kprobes.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index c2a6ab38a67f..e848fe2c93fb 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -261,9 +261,19 @@ static int try_to_emulate(struct kprobe *p, struct pt_regs *regs)
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
+		 * then this is just an error with the current run. We return
+		 * 0 so that this is now single-stepped, but continue to try
+		 * emulating it in subsequent probe hits.
+		 */
+		if (unlikely(p->ainsn.boostable != 1))
+			p->ainsn.boostable = -1;
+	}
 
 	return ret;
 }
-- 
2.14.1
