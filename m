Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tXTsj4rC4zDvtW
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Dec 2016 02:57:13 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uB5Frut3097070
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Dec 2016 10:57:10 -0500
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2756h6tgdh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Dec 2016 10:57:10 -0500
Received: from localhost
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Mon, 5 Dec 2016 21:27:06 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id ECC5D1258060
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Dec 2016 21:28:09 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uB5Fv2p539715042
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Dec 2016 21:27:02 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uB5FuvhW012892
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Dec 2016 21:27:01 +0530
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
To: acme@kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com,
 chris.ryder@arm.com, mhiramat@kernel.org, kim.phillips@arm.com,
 treeze.taeung@gmail.com, markus@trippelsdorf.de,
 naveen.n.rao@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH v8 1/3] perf annotate: Show raw form for jump instruction with
 indirect target
Date: Mon,  5 Dec 2016 21:26:45 +0530
Message-Id: <1480953407-7605-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For jump instructions that does not include target address as direct
operand, show the original disassembled line for them. This is needed
for certain powerpc jump instructions that use target address in a
register (such as bctr, btar, ...).

Before:
     ld     r12,32088(r12)
     mtctr  r12
  v  bctr   ffffffffffffca2c
     std    r2,24(r1)
     addis  r12,r2,-1

After:
     ld     r12,32088(r12)
     mtctr  r12
  v  bctr
     std    r2,24(r1)
     addis  r12,r2,-1

Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
---
Changes in v8:
  - v7: https://lkml.org/lkml/2016/9/21/436
  - Rebase to acme/perf/core
  - No logical changes. (Cross arch annotate patches are in. This patch
    is for hardening annotate for powerpc.)

 tools/perf/util/annotate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 4012b1d..ea7e0de 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -237,6 +237,9 @@ static int jump__parse(struct arch *arch __maybe_unused, struct ins_operands *op
 static int jump__scnprintf(struct ins *ins, char *bf, size_t size,
 			   struct ins_operands *ops)
 {
+	if (!ops->target.addr)
+		return ins__raw_scnprintf(ins, bf, size, ops);
+
 	return scnprintf(bf, size, "%-6.6s %" PRIx64, ins->name, ops->target.offset);
 }
 
-- 
2.4.11
