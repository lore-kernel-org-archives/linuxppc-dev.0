Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40RVNZ5ywyzDqyp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Apr 2018 17:04:46 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3J74UEa126680
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Apr 2018 03:04:44 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2hemtcm67g-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Apr 2018 03:04:43 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 19 Apr 2018 08:04:42 +0100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@ozlabs.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Subject: [PATCH v5 03/10] powerpc64/ftrace: Add helpers to hard disable ftrace
Date: Thu, 19 Apr 2018 12:34:02 +0530
In-Reply-To: <cover.1524121038.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1524121038.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1524121038.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1524121038.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <33b48ff803b0f3e122af491cbfb48841574b2474.1524121038.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add some helpers to enable/disable ftrace through paca->ftrace_enabled.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/ftrace.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/powerpc/include/asm/ftrace.h b/arch/powerpc/include/asm/ftrace.h
index ebfc0b846bb5..3b5e85a72e10 100644
--- a/arch/powerpc/include/asm/ftrace.h
+++ b/arch/powerpc/include/asm/ftrace.h
@@ -82,6 +82,23 @@ static inline bool arch_syscall_match_sym_name(const char *sym, const char *name
 	return !strcmp(sym + 4, name + 3);
 }
 #endif /* CONFIG_FTRACE_SYSCALLS && PPC64_ELF_ABI_v1 */
+
+#ifdef CONFIG_PPC64
+#include <asm/paca.h>
+
+static inline void this_cpu_disable_ftrace(void)
+{
+	get_paca()->ftrace_enabled = 0;
+}
+
+static inline void this_cpu_enable_ftrace(void)
+{
+	get_paca()->ftrace_enabled = 1;
+}
+#else /* CONFIG_PPC64 */
+static inline void this_cpu_disable_ftrace(void) { }
+static inline void this_cpu_enable_ftrace(void) { }
+#endif /* CONFIG_PPC64 */
 #endif /* !__ASSEMBLY__ */
 
 #endif /* _ASM_POWERPC_FTRACE */
-- 
2.17.0
