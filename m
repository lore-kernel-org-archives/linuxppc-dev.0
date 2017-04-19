Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7MMD0FHnzDqC2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 22:51:35 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3JCnPwI128313
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 08:51:29 -0400
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29x7283uwg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 08:51:29 -0400
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 19 Apr 2017 18:21:25 +0530
Received: from d28av07.in.ibm.com (d28av07.in.ibm.com [9.184.220.146])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3JCpM1w12321016
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 18:21:22 +0530
Received: from d28av07.in.ibm.com (localhost [127.0.0.1])
 by d28av07.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3JCpL04026759
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 18:21:22 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Ingo Molnar <mingo@kernel.org>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/7] powerpc: kprobes: fix handling of function offsets on
 ABIv2
Date: Wed, 19 Apr 2017 18:21:01 +0530
In-Reply-To: <cover.1492604782.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1492604782.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1492604782.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1492604782.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <77e96021f60d0cebd75bb8c5968e179c32781016.1492604782.git.naveen.n.rao@linux.vnet.ibm.com>
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

Acked-by: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/kprobes.c   | 4 ++--
 arch/powerpc/kernel/optprobes.c | 4 ++--
 include/linux/kprobes.h         | 2 +-
 kernel/kprobes.c                | 7 ++++---
 4 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index 71c30025cc8a..97b5eed1f76d 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -42,14 +42,14 @@ DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
 
 struct kretprobe_blackpoint kretprobe_blacklist[] = {{NULL, NULL}};
 
-kprobe_opcode_t *kprobe_lookup_name(const char *name)
+kprobe_opcode_t *kprobe_lookup_name(const char *name, unsigned int offset)
 {
 	kprobe_opcode_t *addr;
 
 #ifdef PPC64_ELF_ABI_v2
 	/* PPC64 ABIv2 needs local entry point */
 	addr = (kprobe_opcode_t *)kallsyms_lookup_name(name);
-	if (addr)
+	if (addr && !offset)
 		addr = (kprobe_opcode_t *)ppc_function_entry(addr);
 #elif defined(PPC64_ELF_ABI_v1)
 	/*
diff --git a/arch/powerpc/kernel/optprobes.c b/arch/powerpc/kernel/optprobes.c
index aefe076d00e0..ce81a322251c 100644
--- a/arch/powerpc/kernel/optprobes.c
+++ b/arch/powerpc/kernel/optprobes.c
@@ -243,8 +243,8 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *p)
 	/*
 	 * 2. branch to optimized_callback() and emulate_step()
 	 */
-	op_callback_addr = kprobe_lookup_name("optimized_callback");
-	emulate_step_addr = kprobe_lookup_name("emulate_step");
+	op_callback_addr = kprobe_lookup_name("optimized_callback", 0);
+	emulate_step_addr = kprobe_lookup_name("emulate_step", 0);
 	if (!op_callback_addr || !emulate_step_addr) {
 		WARN(1, "kprobe_lookup_name() failed\n");
 		goto error;
diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 16f153c84646..1f82a3db00b1 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -379,7 +379,7 @@ static inline struct kprobe_ctlblk *get_kprobe_ctlblk(void)
 	return this_cpu_ptr(&kprobe_ctlblk);
 }
 
-kprobe_opcode_t *kprobe_lookup_name(const char *name);
+kprobe_opcode_t *kprobe_lookup_name(const char *name, unsigned int offset);
 int register_kprobe(struct kprobe *p);
 void unregister_kprobe(struct kprobe *p);
 int register_kprobes(struct kprobe **kps, int num);
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index f3421b6b47a3..6a128f3a7ed1 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -72,7 +72,8 @@ static struct {
 	raw_spinlock_t lock ____cacheline_aligned_in_smp;
 } kretprobe_table_locks[KPROBE_TABLE_SIZE];
 
-kprobe_opcode_t * __weak kprobe_lookup_name(const char *name)
+kprobe_opcode_t * __weak kprobe_lookup_name(const char *name,
+					unsigned int __unused)
 {
 	return ((kprobe_opcode_t *)(kallsyms_lookup_name(name)));
 }
@@ -1396,7 +1397,7 @@ static kprobe_opcode_t *kprobe_addr(struct kprobe *p)
 		goto invalid;
 
 	if (p->symbol_name) {
-		addr = kprobe_lookup_name(p->symbol_name);
+		addr = kprobe_lookup_name(p->symbol_name, p->offset);
 		if (!addr)
 			return ERR_PTR(-ENOENT);
 	}
@@ -2189,7 +2190,7 @@ static int __init init_kprobes(void)
 		/* lookup the function address from its name */
 		for (i = 0; kretprobe_blacklist[i].name != NULL; i++) {
 			kretprobe_blacklist[i].addr =
-				kprobe_lookup_name(kretprobe_blacklist[i].name);
+				kprobe_lookup_name(kretprobe_blacklist[i].name, 0);
 			if (!kretprobe_blacklist[i].addr)
 				printk("kretprobe: lookup failed: %s\n",
 				       kretprobe_blacklist[i].name);
-- 
2.12.1
