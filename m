Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40cstc6HNGzDqnn
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 May 2018 23:14:48 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w44DAZAY039650
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 May 2018 09:14:45 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2hrpsgkw7v-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 May 2018 09:14:44 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 4 May 2018 14:14:42 +0100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 2/2] powerpc/trace: Update syscall name matching logic to
 account for ppc_ prefix
Date: Fri,  4 May 2018 18:44:25 +0530
In-Reply-To: <c50df60c9ca8309df56e0eb9a00072c154897764.1525439237.git.naveen.n.rao@linux.vnet.ibm.com>
References: <c50df60c9ca8309df56e0eb9a00072c154897764.1525439237.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <c50df60c9ca8309df56e0eb9a00072c154897764.1525439237.git.naveen.n.rao@linux.vnet.ibm.com>
References: <c50df60c9ca8309df56e0eb9a00072c154897764.1525439237.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <18ce8ce6346984f8c10d798d5244d8c6181306a8.1525439237.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some syscall entry functions on powerpc are prefixed with
ppc_/ppc32_/ppc64_ rather than the usual sys_/__se_sys prefix. fork(),
clone(), swapcontext() are some examples of syscalls with such entry
points. We need to match against these names when initializing ftrace
syscall tracing.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
Tracing fork() and clone() was working so far since those had "ppc_" 
prefix and we were jumping past the initial 3 characters to account for 
"SyS_" prefix. We were not enabling tracing for ppc32_/ppc64_ prefixed 
syscall entry points so far.

- Naveen

 arch/powerpc/include/asm/ftrace.h | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/ftrace.h b/arch/powerpc/include/asm/ftrace.h
index 731cb4314a42..331b17b2e46e 100644
--- a/arch/powerpc/include/asm/ftrace.h
+++ b/arch/powerpc/include/asm/ftrace.h
@@ -67,13 +67,30 @@ struct dyn_arch_ftrace {
 #endif
 
 #if defined(CONFIG_FTRACE_SYSCALLS) && !defined(__ASSEMBLY__)
-#ifdef PPC64_ELF_ABI_v1
+/*
+ * Some syscall entry functions on powerpc start with "ppc_" (fork and clone,
+ * for instance) or ppc32_/ppc64_. We should also match the sys_ variant with
+ * those.
+ */
 #define ARCH_HAS_SYSCALL_MATCH_SYM_NAME
+#ifdef PPC64_ELF_ABI_v1
 static inline bool arch_syscall_match_sym_name(const char *sym, const char *name)
 {
 	/* We need to skip past the initial dot, and the __se_sys alias */
 	return !strcmp(sym + 1, name) ||
-		(!strncmp(sym, ".__se_sys", 9) && !strcmp(sym + 6, name));
+		(!strncmp(sym, ".__se_sys", 9) && !strcmp(sym + 6, name)) ||
+		(!strncmp(sym, ".ppc_", 5) && !strcmp(sym + 5, name + 4)) ||
+		(!strncmp(sym, ".ppc32_", 7) && !strcmp(sym + 7, name + 4)) ||
+		(!strncmp(sym, ".ppc64_", 7) && !strcmp(sym + 7, name + 4));
+}
+#else
+static inline bool arch_syscall_match_sym_name(const char *sym, const char *name)
+{
+	return !strcmp(sym, name) ||
+		(!strncmp(sym, "__se_sys", 8) && !strcmp(sym + 5, name)) ||
+		(!strncmp(sym, "ppc_", 4) && !strcmp(sym + 4, name + 4)) ||
+		(!strncmp(sym, "ppc32_", 6) && !strcmp(sym + 6, name + 4)) ||
+		(!strncmp(sym, "ppc64_", 6) && !strcmp(sym + 6, name + 4));
 }
 #endif
 #endif /* CONFIG_FTRACE_SYSCALLS && !__ASSEMBLY__ */
-- 
2.17.0
