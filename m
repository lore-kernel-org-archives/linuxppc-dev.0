Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vCJZq2BVwzDq8b
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 19:00:03 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0V7weQd120369
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 03:00:00 -0500
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28ahnmh7ep-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 03:00:00 -0500
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 31 Jan 2017 17:59:57 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 4A6AB3578056
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 18:59:55 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v0V7xle329229110
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 18:59:55 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v0V7xMM5030939
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 18:59:23 +1100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Anju T Sudhakar <anju@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, ananth@in.ibm.com, mhiramat@kernel.org,
 mahesh@linux.vnet.ibm.com
Subject: [PATCH] powerpc: kprobes: fixes for kprobe_lookup_name on BE
Date: Tue, 31 Jan 2017 13:29:01 +0530
In-Reply-To: <878tpswa6g.fsf@concordia.ellerman.id.au>
References: <878tpswa6g.fsf@concordia.ellerman.id.au>
Message-Id: <20170131075901.18824-1-naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix two issues with kprobes.h on BE which were exposed with the optprobes work:
- one, having to do with a missing include for linux/module.h for
MODULE_NAME_LEN -- this didn't show up previously since the only users of
kprobe_lookup_name were in kprobes.c, which included linux/module.h
through other headers, and
- two, with a missing const qualifier for a local variable which ends up
referring a string literal. Again, this is unique to how
kprobe_lookup_name is being invoked in optprobes.c

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/kprobes.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/kprobes.h b/arch/powerpc/include/asm/kprobes.h
index 5fc728af9260..d821835ade86 100644
--- a/arch/powerpc/include/asm/kprobes.h
+++ b/arch/powerpc/include/asm/kprobes.h
@@ -29,6 +29,7 @@
 #include <linux/types.h>
 #include <linux/ptrace.h>
 #include <linux/percpu.h>
+#include <linux/module.h>
 #include <asm/probes.h>
 #include <asm/code-patching.h>
 
@@ -77,7 +78,7 @@ extern kprobe_opcode_t optprobe_template_end[];
 #define kprobe_lookup_name(name, addr)					\
 {									\
 	char dot_name[MODULE_NAME_LEN + 1 + KSYM_NAME_LEN];		\
-	char *modsym;							\
+	const char *modsym;							\
 	bool dot_appended = false;					\
 	if ((modsym = strchr(name, ':')) != NULL) {			\
 		modsym++;						\
-- 
2.11.0
