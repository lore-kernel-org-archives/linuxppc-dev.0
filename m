Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vPCgx3ZwwzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 21:53:49 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1GArU7F079738
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 05:53:47 -0500
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28n6rc9sc0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 05:53:44 -0500
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 16 Feb 2017 20:53:42 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 86B673578053
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 21:53:39 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1GArVEl8061032
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 21:53:39 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1GAr73P005221
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 21:53:07 +1100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/5] powerpc: introduce a new helper to obtain function entry
 points
Date: Thu, 16 Feb 2017 16:22:39 +0530
Message-Id: <49dae0da9b7cee3f1747b116cd59854ece84bf02.1487239680.git.naveen.n.rao@linux.vnet.ibm.com>
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
 arch/powerpc/include/asm/code-patching.h | 37 ++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/optprobes.c          |  6 +++---
 2 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/code-patching.h b/arch/powerpc/include/asm/code-patching.h
index 8ab937771068..3e994f404434 100644
--- a/arch/powerpc/include/asm/code-patching.h
+++ b/arch/powerpc/include/asm/code-patching.h
@@ -12,6 +12,8 @@
 
 #include <asm/types.h>
 #include <asm/ppc-opcode.h>
+#include <linux/string.h>
+#include <linux/kallsyms.h>
 
 /* Flags for create_branch:
  * "b"   == create_branch(addr, target, 0);
@@ -99,6 +101,41 @@ static inline unsigned long ppc_global_function_entry(void *func)
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
+	if (name[0] != '.') {
+		dot_name[0] = '.';
+		dot_name[1] = '\0';
+		strncat(dot_name, name, KSYM_NAME_LEN - 2);
+		dot_appended = true;
+	} else {
+		dot_name[0] = '\0';
+		strncat(dot_name, name, KSYM_NAME_LEN - 1);
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
index 2282bf4e63cd..ec60ed0d4aad 100644
--- a/arch/powerpc/kernel/optprobes.c
+++ b/arch/powerpc/kernel/optprobes.c
@@ -243,10 +243,10 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *p)
 	/*
 	 * 2. branch to optimized_callback() and emulate_step()
 	 */
-	kprobe_lookup_name("optimized_callback", op_callback_addr);
-	kprobe_lookup_name("emulate_step", emulate_step_addr);
+	op_callback_addr = (kprobe_opcode_t *)ppc_kallsyms_lookup_name("optimized_callback");
+	emulate_step_addr = (kprobe_opcode_t *)ppc_kallsyms_lookup_name("emulate_step");
 	if (!op_callback_addr || !emulate_step_addr) {
-		WARN(1, "kprobe_lookup_name() failed\n");
+		WARN(1, "Unable to lookup optimized_callback()/emulate_step()\n");
 		goto error;
 	}
 
-- 
2.11.0
