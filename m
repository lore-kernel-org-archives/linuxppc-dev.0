Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40G0dp4y6TzF29s
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Apr 2018 06:13:18 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w33KBEFk098816
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Apr 2018 16:13:16 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2h4fup9rt0-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Apr 2018 16:13:15 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 3 Apr 2018 21:13:14 +0100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Steven Rostedt <rostedt@goodmis.org>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@ozlabs.org>,
 Nicholas Piggin <npiggin@gmail.com>, Anton Blanchard <anton@samba.org>,
 sathnaga@linux.vnet.ibm.com
Subject: [PATCH v4 09/10] powerpc64/ftrace: Use the generic version of
 ftrace_replace_code()
Date: Wed,  4 Apr 2018 01:42:24 +0530
In-Reply-To: <cover.1522784883.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1522784883.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1522784883.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1522784883.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <ffad566abd23335b9fa1339ee1b5832f0592881c.1522784883.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Our implementation matches that of the generic version, which also
handles FTRACE_UPDATE_MODIFY_CALL. So, remove our implementation in
favor of the generic version.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/trace/ftrace.c | 36 ------------------------------------
 1 file changed, 36 deletions(-)

diff --git a/arch/powerpc/kernel/trace/ftrace.c b/arch/powerpc/kernel/trace/ftrace.c
index 4741fe112f05..80667128db3d 100644
--- a/arch/powerpc/kernel/trace/ftrace.c
+++ b/arch/powerpc/kernel/trace/ftrace.c
@@ -485,42 +485,6 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
 	return ret;
 }
 
-static int __ftrace_replace_code(struct dyn_ftrace *rec, int enable)
-{
-	unsigned long ftrace_addr = (unsigned long)FTRACE_ADDR;
-	int ret;
-
-	ret = ftrace_update_record(rec, enable);
-
-	switch (ret) {
-	case FTRACE_UPDATE_IGNORE:
-		return 0;
-	case FTRACE_UPDATE_MAKE_CALL:
-		return ftrace_make_call(rec, ftrace_addr);
-	case FTRACE_UPDATE_MAKE_NOP:
-		return ftrace_make_nop(NULL, rec, ftrace_addr);
-	}
-
-	return 0;
-}
-
-void ftrace_replace_code(int enable)
-{
-	struct ftrace_rec_iter *iter;
-	struct dyn_ftrace *rec;
-	int ret;
-
-	for (iter = ftrace_rec_iter_start(); iter;
-	     iter = ftrace_rec_iter_next(iter)) {
-		rec = ftrace_rec_iter_record(iter);
-		ret = __ftrace_replace_code(rec, enable);
-		if (ret) {
-			ftrace_bug(ret, rec);
-			return;
-		}
-	}
-}
-
 /*
  * Use the default ftrace_modify_all_code, but without
  * stop_machine().
-- 
2.16.2
