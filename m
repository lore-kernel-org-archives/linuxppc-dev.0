Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40cstZ17MlzDqlR
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 May 2018 23:14:45 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w44DBp0A102807
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 May 2018 09:14:40 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2hrnmqpggb-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 May 2018 09:14:40 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 4 May 2018 14:14:37 +0100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 1/2] powerpc/trace elfv1: Update syscall name matching logic
Date: Fri,  4 May 2018 18:44:24 +0530
Message-Id: <c50df60c9ca8309df56e0eb9a00072c154897764.1525439237.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On powerpc64 ABIv1, we are enabling syscall tracing for only ~20
syscalls. This is due to commit e145242ea0df6 ("syscalls/core,
syscalls/x86: Clean up syscall stub naming convention") which has
changed the syscall entry wrapper prefix from "SyS" to "__se_sys".

Update the logic for ABIv1 to not just skip the initial dot, but also
the "__se_sys" prefix.

Fixes: commit e145242ea0df6 ("syscalls/core, syscalls/x86: Clean up syscall stub naming convention")
Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/ftrace.h | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/ftrace.h b/arch/powerpc/include/asm/ftrace.h
index f7a23c2dce74..731cb4314a42 100644
--- a/arch/powerpc/include/asm/ftrace.h
+++ b/arch/powerpc/include/asm/ftrace.h
@@ -71,13 +71,9 @@ struct dyn_arch_ftrace {
 #define ARCH_HAS_SYSCALL_MATCH_SYM_NAME
 static inline bool arch_syscall_match_sym_name(const char *sym, const char *name)
 {
-	/*
-	 * Compare the symbol name with the system call name. Skip the .sys or .SyS
-	 * prefix from the symbol name and the sys prefix from the system call name and
-	 * just match the rest. This is only needed on ppc64 since symbol names on
-	 * 32bit do not start with a period so the generic function will work.
-	 */
-	return !strcmp(sym + 4, name + 3);
+	/* We need to skip past the initial dot, and the __se_sys alias */
+	return !strcmp(sym + 1, name) ||
+		(!strncmp(sym, ".__se_sys", 9) && !strcmp(sym + 6, name));
 }
 #endif
 #endif /* CONFIG_FTRACE_SYSCALLS && !__ASSEMBLY__ */
-- 
2.17.0
