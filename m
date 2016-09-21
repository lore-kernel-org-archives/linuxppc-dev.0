Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfPGY4sPRzDsjZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Sep 2016 01:50:29 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8LFmpMC051175
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 11:50:27 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25kkqba9dr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 11:50:26 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Thu, 22 Sep 2016 01:50:24 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 06C353578057
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Sep 2016 01:50:22 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8LFoM4d393686
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Sep 2016 01:50:22 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8LFoLlr006480
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Sep 2016 01:50:21 +1000
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, acme@kernel.org, kim.phillips@arm.com
Cc: linuxppc-dev@lists.ozlabs.org, peterz@infradead.org, mingo@redhat.com,
 alexander.shishkin@linux.intel.com, treeze.taeung@gmail.com,
 naveen.n.rao@linux.vnet.ibm.com, markus@trippelsdorf.de,
 namhyung@kernel.org, pawel.moll@arm.com, chris.ryder@arm.com,
 jolsa@kernel.org, mhiramat@kernel.org,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH v7 4/6] perf annotate: Support jump instruction with target as
 second operand
Date: Wed, 21 Sep 2016 21:17:54 +0530
In-Reply-To: <1474472876-2706-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
References: <1474472876-2706-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
Message-Id: <1474472876-2706-5-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
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
example, 'bne  cr7,0xc0000000000f6154'.

objdump o/p:
  c0000000000f6140:   ld     r9,1032(r31)
  c0000000000f6144:   cmpdi  cr7,r9,0
  c0000000000f6148:   bne    cr7,0xc0000000000f6154
  c0000000000f614c:   ld     r9,2312(r30)
  c0000000000f6150:   std    r9,1032(r31)
  c0000000000f6154:   ld     r9,88(r31)

Before patch:
         ld     r9,1032(r31)
         cmpdi  cr7,r9,0
      v  bne    3ffffffffff09f2c
         ld     r9,2312(r30)
         std    r9,1032(r31)
  74:    ld     r9,88(r31)

After patch:
         ld     r9,1032(r31)
         cmpdi  cr7,r9,0
      v  bne    74
         ld     r9,2312(r30)
         std    r9,1032(r31)
  74:    ld     r9,88(r31)

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
---
Changes in v7:
  - Added example in description

 tools/perf/util/annotate.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 1ccf26a..a9dbac1 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -122,8 +122,12 @@ bool ins__is_call(const struct ins *ins)
 static int jump__parse(struct ins_operands *ops, struct map *map __maybe_unused)
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
