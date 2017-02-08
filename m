Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vJFTl3QmGzDqBm
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Feb 2017 19:57:47 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v188vP1I144260
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Feb 2017 03:57:45 -0500
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28fmwr1phq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Feb 2017 03:57:45 -0500
Received: from localhost
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Wed, 8 Feb 2017 14:27:42 +0530
Received: from d28relay07.in.ibm.com (d28relay07.in.ibm.com [9.184.220.158])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id A0C5E125801A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Feb 2017 14:29:30 +0530 (IST)
Received: from d28av07.in.ibm.com (d28av07.in.ibm.com [9.184.220.146])
 by d28relay07.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v188ufac24510502
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Feb 2017 14:26:41 +0530
Received: from d28av07.in.ibm.com (localhost [127.0.0.1])
 by d28av07.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v188vbEf020468
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Feb 2017 14:27:39 +0530
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: ananth@in.ibm.com, naveen.n.rao@linux.vnet.ibm.com, paulus@samba.org,
 srikar@linux.vnet.ibm.com, benh@kernel.crashing.org,
 mpe@ellerman.id.au, hemant@linux.vnet.ibm.com,
 mahesh@linux.vnet.ibm.com, mhiramat@kernel.org, anju@linux.vnet.ibm.com
Subject: [PATCH 3/3] powerpc: kprobes: fixes for kprobe_lookup_name on BE
Date: Wed,  8 Feb 2017 14:27:31 +0530
In-Reply-To: <1486544251-11292-1-git-send-email-anju@linux.vnet.ibm.com>
References: <1486544251-11292-1-git-send-email-anju@linux.vnet.ibm.com>
Message-Id: <1486544251-11292-3-git-send-email-anju@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>

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
index 97b8c1f..77885d8 100644
--- a/arch/powerpc/include/asm/kprobes.h
+++ b/arch/powerpc/include/asm/kprobes.h
@@ -29,6 +29,7 @@
 #include <linux/types.h>
 #include <linux/ptrace.h>
 #include <linux/percpu.h>
+#include <linux/module.h>
 #include <asm/probes.h>
 #include <asm/code-patching.h>
 
@@ -61,7 +62,7 @@ typedef ppc_opcode_t kprobe_opcode_t;
 #define kprobe_lookup_name(name, addr)					\
 {									\
 	char dot_name[MODULE_NAME_LEN + 1 + KSYM_NAME_LEN];		\
-	char *modsym;							\
+	const char *modsym;							\
 	bool dot_appended = false;					\
 	if ((modsym = strchr(name, ':')) != NULL) {			\
 		modsym++;						\
-- 
2.7.4
