Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sFs3L6ZTRzDr6X
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 15:29:34 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7J5SgWL108618
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 01:29:33 -0400
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24vkhv4aqa-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 01:29:33 -0400
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Fri, 19 Aug 2016 10:59:29 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id C38683940069
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 10:59:27 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7J5TREO63373464
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 10:59:27 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7J5TLKN000952
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 10:59:27 +0530
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 acme@kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com,
 treeze.taeung@gmail.com, naveen.n.rao@linux.vnet.ibm.com,
 markus@trippelsdorf.de, chris.ryder@arm.com, pawel.moll@arm.com,
 mhiramat@kernel.org, rmk+kernel@arm.linux.org.uk, jolsa@kernel.org,
 mpe@ellerman.id.au, hemant@linux.vnet.ibm.com, namhyung@kernel.org,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH v5 4/7] perf annotate: Do not ignore call instruction with
 indirect target
Date: Fri, 19 Aug 2016 10:59:03 +0530
In-Reply-To: <1471584546-11080-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
References: <1471584546-11080-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
Message-Id: <1471584546-11080-5-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Do not ignore call instruction with indirect target when its already
identified as a call. This is an extension of commit e8ea1561952b
("perf annotate: Use raw form for register indirect call instructions")
to generalize annotation for all instructions with indirect calls.

This is needed for certain powerpc call instructions that use address
in a register (such as bctrl, btarl, ...).

Apart from that, when kcore is used to disassemble function, all call
instructions were ignored. This patch will fix it as a side effect by
not ignoring them. For example,

Before (with kcore):
       mov    %r13,%rdi
       callq  0xffffffff811a7e70
     ^ jmpq   64
       mov    %gs:0x7ef41a6e(%rip),%al

After (with kcore):
       mov    %r13,%rdi
     > callq  0xffffffff811a7e70
     ^ jmpq   64
       mov    %gs:0x7ef41a6e(%rip),%al

Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
[Suggested about 'bctrl' instruction]
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
---
Changes in v5:
  - New patch, introduced to annotate all indirect call instructions.

 tools/perf/util/annotate.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 0b64841..6368ba9 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -81,16 +81,12 @@ static int call__parse(struct ins_operands *ops, const char *norm_arch)
 	return ops->target.name == NULL ? -1 : 0;
 
 indirect_call:
-	tok = strchr(endptr, '(');
-	if (tok != NULL) {
+	tok = strchr(endptr, '*');
+	if (tok == NULL) {
 		ops->target.addr = 0;
 		return 0;
 	}
 
-	tok = strchr(endptr, '*');
-	if (tok == NULL)
-		return -1;
-
 	ops->target.addr = strtoull(tok + 1, NULL, 16);
 	return 0;
 }
-- 
2.5.5
