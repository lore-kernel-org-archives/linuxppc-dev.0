Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sG33n5yhJzDr7h
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 23:00:37 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7JCxGb7049990
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 09:00:36 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24wwebe0v3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 09:00:35 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Fri, 19 Aug 2016 23:00:33 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id B20222CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 23:00:31 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7JD0Vv014090296
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 23:00:31 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7JD0TYF021909
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 23:00:30 +1000
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 acme@kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com,
 treeze.taeung@gmail.com, naveen.n.rao@linux.vnet.ibm.com,
 markus@trippelsdorf.de, chris.ryder@arm.com, pawel.moll@arm.com,
 mhiramat@kernel.org, rmk+kernel@arm.linux.org.uk, jolsa@kernel.org,
 mpe@ellerman.id.au, hemant@linux.vnet.ibm.com, namhyung@kernel.org,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH v6 4/7] perf annotate: Do not ignore call instruction with
 indirect target
Date: Fri, 19 Aug 2016 18:29:35 +0530
In-Reply-To: <1471611578-11255-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
References: <1471611578-11255-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
Message-Id: <1471611578-11255-5-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
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
Changes in v6:
  - No change

 tools/perf/util/annotate.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index ea07588..a05423b 100644
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
