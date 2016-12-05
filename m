Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tXTsj4sctzDvtX
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Dec 2016 02:57:13 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uB5Ft7ZG058205
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Dec 2016 10:57:10 -0500
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2759gxpx6b-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Dec 2016 10:57:10 -0500
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Mon, 5 Dec 2016 21:27:06 +0530
Received: from d28relay08.in.ibm.com (d28relay08.in.ibm.com [9.184.220.159])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 3A52B1258063
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Dec 2016 21:28:11 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay08.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uB5FuSnW28180642
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Dec 2016 21:26:28 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uB5Fuxm2013054
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Dec 2016 21:27:03 +0530
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
To: acme@kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com,
 chris.ryder@arm.com, mhiramat@kernel.org, kim.phillips@arm.com,
 treeze.taeung@gmail.com, markus@trippelsdorf.de,
 naveen.n.rao@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH v8 2/3] perf annotate: Support jump instruction with target as
 second operand
Date: Mon,  5 Dec 2016 21:26:46 +0530
In-Reply-To: <1480953407-7605-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
References: <1480953407-7605-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
Message-Id: <1480953407-7605-2-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Arch like powerpc has jump instructions that includes target address
as second operand. For example, 'bne  cr7,0xc0000000000f6154'. Add
support for such instruction in perf annotate.

objdump o/p:
  c0000000000f6140:   ld     r9,1032(r31)
  c0000000000f6144:   cmpdi  cr7,r9,0
  c0000000000f6148:   bne    cr7,0xc0000000000f6154
  c0000000000f614c:   ld     r9,2312(r30)
  c0000000000f6150:   std    r9,1032(r31)
  c0000000000f6154:   ld     r9,88(r31)

Corresponding perf annotate o/p:

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
Changes in v8:
  - v7: https://lkml.org/lkml/2016/9/21/436
  - Rebase to acme/perf/core
  - Little change in patch description.
  - No logical changes. (Cross arch annotate patches are in. This patch
    is for hardening annotate for powerpc.)

 tools/perf/util/annotate.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index ea7e0de..590244e 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -223,8 +223,12 @@ bool ins__is_call(const struct ins *ins)
 static int jump__parse(struct arch *arch __maybe_unused, struct ins_operands *ops, struct map *map __maybe_unused)
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
2.4.11
