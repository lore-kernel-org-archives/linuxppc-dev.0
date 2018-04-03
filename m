Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40G0dN4X0MzF28G
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Apr 2018 06:12:56 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w33KBLtr043913
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Apr 2018 16:12:53 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2h4fun9t1v-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Apr 2018 16:12:52 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 3 Apr 2018 21:12:51 +0100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Steven Rostedt <rostedt@goodmis.org>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@ozlabs.org>,
 Nicholas Piggin <npiggin@gmail.com>, Anton Blanchard <anton@samba.org>,
 sathnaga@linux.vnet.ibm.com
Subject: [PATCH v4 03/10] powerpc64/ftrace: Rearrange #ifdef sections in
 ftrace.h
Date: Wed,  4 Apr 2018 01:42:18 +0530
In-Reply-To: <cover.1522784883.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1522784883.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1522784883.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1522784883.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <a128ea09f5d6f92e348ea4bd4132e7fe6e41f208.1522784883.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Re-arrange the last #ifdef section in preparation for a subsequent
change.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/ftrace.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/ftrace.h b/arch/powerpc/include/asm/ftrace.h
index 9abddde372ab..ebfc0b846bb5 100644
--- a/arch/powerpc/include/asm/ftrace.h
+++ b/arch/powerpc/include/asm/ftrace.h
@@ -68,8 +68,8 @@ struct dyn_arch_ftrace {
 #endif
 #endif
 
-#if defined(CONFIG_FTRACE_SYSCALLS) && !defined(__ASSEMBLY__)
-#ifdef PPC64_ELF_ABI_v1
+#ifndef __ASSEMBLY__
+#if defined(CONFIG_FTRACE_SYSCALLS) && defined(PPC64_ELF_ABI_v1)
 #define ARCH_HAS_SYSCALL_MATCH_SYM_NAME
 static inline bool arch_syscall_match_sym_name(const char *sym, const char *name)
 {
@@ -81,7 +81,7 @@ static inline bool arch_syscall_match_sym_name(const char *sym, const char *name
 	 */
 	return !strcmp(sym + 4, name + 3);
 }
-#endif
-#endif /* CONFIG_FTRACE_SYSCALLS && !__ASSEMBLY__ */
+#endif /* CONFIG_FTRACE_SYSCALLS && PPC64_ELF_ABI_v1 */
+#endif /* !__ASSEMBLY__ */
 
 #endif /* _ASM_POWERPC_FTRACE */
-- 
2.16.2
