Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vMwmR4p96zDq8t
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 19:38:15 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1E8SuV2095063
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 03:38:13 -0500
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28kx6v8tf2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 03:38:13 -0500
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 14 Feb 2017 14:08:10 +0530
Received: from d28relay09.in.ibm.com (d28relay09.in.ibm.com [9.184.220.160])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 6335CE0024
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 14:09:39 +0530 (IST)
Received: from d28av08.in.ibm.com (d28av08.in.ibm.com [9.184.220.148])
 by d28relay09.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1E8c7tM11272240
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 14:08:07 +0530
Received: from d28av08.in.ibm.com (localhost [127.0.0.1])
 by d28av08.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1E8c6xX011230
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 14:08:07 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/3] powerpc: kprobes: fix handling of function offsets on
 ABIv2
Date: Tue, 14 Feb 2017 14:08:01 +0530
Message-Id: <1b7d5ea08a7e11fbf1fb08dd3536219c94b13591.1487060527.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

commit 239aeba76409 ("perf powerpc: Fix kprobe and kretprobe handling
with kallsyms on ppc64le") changed how we use the offset field in struct
kprobe on ABIv2. perf now offsets from the GEP (Global entry point) if an
offset is specified and otherwise chooses the LEP (Local entry point).

Fix the same in kernel for kprobe API users. We do this by extending
kprobe_lookup_name() to accept an additional parameter to indicate the
offset specified with the kprobe registration. If offset is 0, we return
the local function entry and return the global entry point otherwise.

With:
	# cd /sys/kernel/debug/tracing/
	# echo "p _do_fork" >> kprobe_events
	# echo "p _do_fork+0x10" >> kprobe_events

before this patch:
	# cat ../kprobes/list
	c0000000000d0748  k  _do_fork+0x8    [DISABLED]
	c0000000000d0758  k  _do_fork+0x18    [DISABLED]
	c0000000000412b0  k  kretprobe_trampoline+0x0    [OPTIMIZED]

and after:
	# cat ../kprobes/list
	c0000000000d04c8  k  _do_fork+0x8    [DISABLED]
	c0000000000d04d0  k  _do_fork+0x10    [DISABLED]
	c0000000000412b0  k  kretprobe_trampoline+0x0    [OPTIMIZED]

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/kprobes.h | 6 +++---
 arch/powerpc/kernel/optprobes.c    | 4 ++--
 kernel/kprobes.c                   | 6 +++---
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/kprobes.h b/arch/powerpc/include/asm/kprobes.h
index d821835ade86..e7ada061aa12 100644
--- a/arch/powerpc/include/asm/kprobes.h
+++ b/arch/powerpc/include/asm/kprobes.h
@@ -60,10 +60,10 @@ extern kprobe_opcode_t optprobe_template_end[];
 
 #ifdef PPC64_ELF_ABI_v2
 /* PPC64 ABIv2 needs local entry point */
-#define kprobe_lookup_name(name, addr)					\
+#define kprobe_lookup_name(name, addr, offset)				\
 {									\
 	addr = (kprobe_opcode_t *)kallsyms_lookup_name(name);		\
-	if (addr)							\
+	if (addr && !(offset))						\
 		addr = (kprobe_opcode_t *)ppc_function_entry(addr);	\
 }
 #elif defined(PPC64_ELF_ABI_v1)
@@ -75,7 +75,7 @@ extern kprobe_opcode_t optprobe_template_end[];
  * This ensures we always get to the actual symbol and not the descriptor.
  * Also handle <module:symbol> format.
  */
-#define kprobe_lookup_name(name, addr)					\
+#define kprobe_lookup_name(name, addr, offset)				\
 {									\
 	char dot_name[MODULE_NAME_LEN + 1 + KSYM_NAME_LEN];		\
 	const char *modsym;							\
diff --git a/arch/powerpc/kernel/optprobes.c b/arch/powerpc/kernel/optprobes.c
index 2282bf4e63cd..e51a045f3d3b 100644
--- a/arch/powerpc/kernel/optprobes.c
+++ b/arch/powerpc/kernel/optprobes.c
@@ -243,8 +243,8 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *p)
 	/*
 	 * 2. branch to optimized_callback() and emulate_step()
 	 */
-	kprobe_lookup_name("optimized_callback", op_callback_addr);
-	kprobe_lookup_name("emulate_step", emulate_step_addr);
+	kprobe_lookup_name("optimized_callback", op_callback_addr, 0);
+	kprobe_lookup_name("emulate_step", emulate_step_addr, 0);
 	if (!op_callback_addr || !emulate_step_addr) {
 		WARN(1, "kprobe_lookup_name() failed\n");
 		goto error;
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 83ad7e440417..9bc433575d98 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -63,7 +63,7 @@
  * so this must be overridable.
  */
 #ifndef kprobe_lookup_name
-#define kprobe_lookup_name(name, addr) \
+#define kprobe_lookup_name(name, addr, offset) \
 	addr = ((kprobe_opcode_t *)(kallsyms_lookup_name(name)))
 #endif
 
@@ -1365,7 +1365,7 @@ static kprobe_opcode_t *kprobe_addr(struct kprobe *p)
 		goto invalid;
 
 	if (p->symbol_name) {
-		kprobe_lookup_name(p->symbol_name, addr);
+		kprobe_lookup_name(p->symbol_name, addr, p->offset);
 		if (!addr)
 			return ERR_PTR(-ENOENT);
 	}
@@ -2161,7 +2161,7 @@ static int __init init_kprobes(void)
 		/* lookup the function address from its name */
 		for (i = 0; kretprobe_blacklist[i].name != NULL; i++) {
 			kprobe_lookup_name(kretprobe_blacklist[i].name,
-					   kretprobe_blacklist[i].addr);
+					   kretprobe_blacklist[i].addr, 0);
 			if (!kretprobe_blacklist[i].addr)
 				printk("kretprobe: lookup failed: %s\n",
 				       kretprobe_blacklist[i].name);
-- 
2.11.0
