Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sFs3h5N7VzDr6D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 15:29:52 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7J5Sftl066150
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 01:29:49 -0400
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [125.16.236.8])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24wg7fyrfu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 01:29:49 -0400
Received: from localhost
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Fri, 19 Aug 2016 10:59:45 +0530
Received: from d28relay10.in.ibm.com (d28relay10.in.ibm.com [9.184.220.161])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id A9E1DE005A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 11:04:06 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay10.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7J5TWXO33751248
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 10:59:32 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7J5TPPL001298
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 10:59:31 +0530
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 acme@kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com,
 treeze.taeung@gmail.com, naveen.n.rao@linux.vnet.ibm.com,
 markus@trippelsdorf.de, chris.ryder@arm.com, pawel.moll@arm.com,
 mhiramat@kernel.org, rmk+kernel@arm.linux.org.uk, jolsa@kernel.org,
 mpe@ellerman.id.au, hemant@linux.vnet.ibm.com, namhyung@kernel.org,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH v5 6/7] perf annotate: Support jump instruction with target as
 second operand
Date: Fri, 19 Aug 2016 10:59:05 +0530
In-Reply-To: <1471584546-11080-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
References: <1471584546-11080-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
Message-Id: <1471584546-11080-7-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Current perf is not able to parse jump instruction when second operand
contains target address. Arch like powerpc has such instructions. For
example, 'beq  cr7,10173e60'.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
---
Changes in v5:
  - New patch

 tools/perf/util/annotate.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 4a4a583..678fb81 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -117,8 +117,12 @@ static int jump__parse(struct ins_operands *ops,
 		       const char *norm_arch __maybe_unused)
 {
 	const char *s = strchr(ops->raw, '+');
+	const char *c = strchr(ops->raw, ',');
 
-	ops->target.addr = strtoull(ops->raw, NULL, 16);
+	if (c++ != NULL)
+		ops->target.addr = strtoull(c, NULL, 16);
+	else
+		ops->target.addr = strtoull(ops->raw, NULL, 16);
 
 	if (s++ != NULL)
 		ops->target.offset = strtoull(s, NULL, 16);
-- 
2.5.5
