Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7MPk43jtzDqB7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 22:53:46 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3JCrhXJ085885
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 08:53:43 -0400
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29x74mku5v-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 08:53:43 -0400
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 19 Apr 2017 18:22:49 +0530
Received: from d28av08.in.ibm.com (d28av08.in.ibm.com [9.184.220.148])
 by d28relay08.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3JCpN6U16187498
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 18:21:23 +0530
Received: from d28av08.in.ibm.com (localhost [127.0.0.1])
 by d28av08.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3JCqk8j020278
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 18:22:46 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/6] powerpc: introduce a new helper to obtain function
 entry points
Date: Wed, 19 Apr 2017 18:22:27 +0530
In-Reply-To: <cover.1492605029.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1492605029.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1492606062.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1492606062.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <7c3fcc090894c7d180274a17a7dfa09ca14df51f.1492606062.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

kprobe_lookup_name() is specific to the kprobe subsystem and may not
always return the function entry point (in a subsequent patch for
KPROBES_ON_FTRACE). For looking up function entry points, introduce a
separate helper and use the same in optprobes.c

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/code-patching.h | 41 ++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/optprobes.c          |  6 ++---
 2 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/code-patching.h b/arch/powerpc/include/asm/code-patching.h
index 8ab937771068..abef812de7f8 100644
--- a/arch/powerpc/include/asm/code-patching.h
+++ b/arch/powerpc/include/asm/code-patching.h
@@ -12,6 +12,8 @@
 
 #include <asm/types.h>
 #include <asm/ppc-opcode.h>
+#include <linux/string.h>
+#include <linux/kallsyms.h>
 
 /* Flags for create_branch:
  * "b"   == create_branch(addr, target, 0);
@@ -99,6 +101,45 @@ static inline unsigned long ppc_global_function_entry(void *func)
 #endif
 }
 
+/*
+ * Wrapper around kallsyms_lookup() to return function entry address:
+ * - For ABIv1, we lookup the dot variant.
+ * - For ABIv2, we return the local entry point.
+ */
+static inline unsigned long ppc_kallsyms_lookup_name(const char *name)
+{
+	unsigned long addr;
+#ifdef PPC64_ELF_ABI_v1
+	/* check for dot variant */
+	char dot_name[1 + KSYM_NAME_LEN];
+	bool dot_appended = false;
+
+	if (strnlen(name, KSYM_NAME_LEN) >= KSYM_NAME_LEN)
+		return 0;
+
+	if (name[0] != '.') {
+		dot_name[0] = '.';
+		dot_name[1] = '\0';
+		strlcat(dot_name, name, sizeof(dot_name));
+		dot_appended = true;
+	} else {
+		dot_name[0] = '\0';
+		strlcat(dot_name, name, sizeof(dot_name));
+	}
+	addr = kallsyms_lookup_name(dot_name);
+	if (!addr && dot_appended)
+		/* Let's try the original non-dot symbol lookup	*/
+		addr = kallsyms_lookup_name(name);
+#elif defined(PPC64_ELF_ABI_v2)
+	addr = kallsyms_lookup_name(name);
+	if (addr)
+		addr = ppc_function_entry((void *)addr);
+#else
+	addr = kallsyms_lookup_name(name);
+#endif
+	return addr;
+}
+
 #ifdef CONFIG_PPC64
 /*
  * Some instruction encodings commonly used in dynamic ftracing
diff --git a/arch/powerpc/kernel/optprobes.c b/arch/powerpc/kernel/optprobes.c
index ce81a322251c..ec60ed0d4aad 100644
--- a/arch/powerpc/kernel/optprobes.c
+++ b/arch/powerpc/kernel/optprobes.c
@@ -243,10 +243,10 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *p)
 	/*
 	 * 2. branch to optimized_callback() and emulate_step()
 	 */
-	op_callback_addr = kprobe_lookup_name("optimized_callback", 0);
-	emulate_step_addr = kprobe_lookup_name("emulate_step", 0);
+	op_callback_addr = (kprobe_opcode_t *)ppc_kallsyms_lookup_name("optimized_callback");
+	emulate_step_addr = (kprobe_opcode_t *)ppc_kallsyms_lookup_name("emulate_step");
 	if (!op_callback_addr || !emulate_step_addr) {
-		WARN(1, "kprobe_lookup_name() failed\n");
+		WARN(1, "Unable to lookup optimized_callback()/emulate_step()\n");
 		goto error;
 	}
 
-- 
2.12.1
