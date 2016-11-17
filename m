Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tKPfs52MkzDvxN
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 02:09:25 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAHF8hrq078450
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 10:09:23 -0500
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26sdm1chba-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 10:09:22 -0500
Received: from localhost
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 17 Nov 2016 20:39:19 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 2D39AE0060
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 20:39:27 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAHF9EXI41812156
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 20:39:14 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAHF99cS004747
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 20:39:13 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>, Anton Blanchard <anton@samba.org>,
 linuxppc-dev@lists.ozlabs.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: [RFC PATCH 1/4] powerpc: asm: introduce new macros for assembly
 globals
Date: Thu, 17 Nov 2016 20:38:30 +0530
In-Reply-To: <cover.1479394571.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1479394571.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1479394571.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1479394571.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <e4e5fb867e0190aea3f30591fb5025b55bb8f2c5.1479394571.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

- Introduce _GLOBAL_SYM() for global symbols in assembly. This helps
reduce verbosity of assembly files.
- Introduce NOKPROBE variants of _GLOBAL() and _GLOBAL_SYM(). These are
used subsequently to blacklist certain assembly functions and symbols
from kprobe.
- Fix a small typo in kprobe comment and re-format it, to make it
clearer.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/ppc_asm.h | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index 025833b..2443545 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -254,13 +254,19 @@ GLUE(.,name):
 
 #endif
 
+#define _GLOBAL_SYM(name)	\
+	.globl name;		\
+name:
+
 /*
  * __kprobes (the C annotation) puts the symbol into the .kprobes.text
  * section, which gets emitted at the end of regular text.
  *
  * _ASM_NOKPROBE_SYMBOL and NOKPROBE_SYMBOL just adds the symbol to
- * a blacklist. The former is for core kprobe functions/data, the
- * latter is for those that incdentially must be excluded from probing
+ * a blacklist.
+ *
+ * The former (__kprobes) is for core kprobe functions/data, the
+ * latter is for those that incidentally must be excluded from probing
  * and allows them to be linked at more optimal location within text.
  */
 #ifdef CONFIG_KPROBES
@@ -272,6 +278,15 @@ GLUE(.,name):
 #define _ASM_NOKPROBE_SYMBOL(entry)
 #endif
 
+#define _GLOBAL_NOKPROBE(name)				\
+	_GLOBAL(name);					\
+	_ASM_NOKPROBE_SYMBOL(name)
+
+#define _GLOBAL_SYM_NOKPROBE(name)			\
+	_GLOBAL_SYM(name);				\
+	_ASM_NOKPROBE_SYMBOL(name)
+
+
 #define FUNC_START(name)	_GLOBAL(name)
 #define FUNC_END(name)
 
-- 
2.10.2
