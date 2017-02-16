Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vPCh66lmpzDqGj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 21:53:58 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1GArTu4132261
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 05:53:56 -0500
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28n7cqrhv2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 05:53:56 -0500
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 16 Feb 2017 20:53:53 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 5ED7B3578057
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 21:53:50 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1GArgWA19857570
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 21:53:50 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1GArH0n005653
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 21:53:18 +1100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/5] powerpc: kprobes: fix handling of function offsets on
 ABIv2
Date: Thu, 16 Feb 2017 16:22:41 +0530
In-Reply-To: <49dae0da9b7cee3f1747b116cd59854ece84bf02.1487239680.git.naveen.n.rao@linux.vnet.ibm.com>
References: <49dae0da9b7cee3f1747b116cd59854ece84bf02.1487239680.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <49dae0da9b7cee3f1747b116cd59854ece84bf02.1487239680.git.naveen.n.rao@linux.vnet.ibm.com>
References: <49dae0da9b7cee3f1747b116cd59854ece84bf02.1487239680.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <06108356dcc40d735a3d54687a39598ad83fb57e.1487239680.git.naveen.n.rao@linux.vnet.ibm.com>
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
 arch/powerpc/kernel/kprobes.c | 4 ++--
 include/linux/kprobes.h       | 2 +-
 kernel/kprobes.c              | 7 ++++---
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index a7aa7394954d..0732a0291ace 100644
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
diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 34b7d00765d2..442ecaeddebe 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -364,7 +364,7 @@ static inline struct kprobe_ctlblk *get_kprobe_ctlblk(void)
 	return this_cpu_ptr(&kprobe_ctlblk);
 }
 
-kprobe_opcode_t *kprobe_lookup_name(const char *name);
+kprobe_opcode_t *kprobe_lookup_name(const char *name, unsigned int offset);
 int register_kprobe(struct kprobe *p);
 void unregister_kprobe(struct kprobe *p);
 int register_kprobes(struct kprobe **kps, int num);
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 30f1d732dd74..fbc7a70ff33e 100644
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
@@ -1361,7 +1362,7 @@ static kprobe_opcode_t *kprobe_addr(struct kprobe *p)
 		goto invalid;
 
 	if (p->symbol_name) {
-		addr = kprobe_lookup_name(p->symbol_name);
+		addr = kprobe_lookup_name(p->symbol_name, p->offset);
 		if (!addr)
 			return ERR_PTR(-ENOENT);
 	}
@@ -2167,7 +2168,7 @@ static int __init init_kprobes(void)
 		/* lookup the function address from its name */
 		for (i = 0; kretprobe_blacklist[i].name != NULL; i++) {
 			kretprobe_blacklist[i].addr =
-				kprobe_lookup_name(kretprobe_blacklist[i].name);
+				kprobe_lookup_name(kretprobe_blacklist[i].name, 0);
 			if (!kretprobe_blacklist[i].addr)
 				printk("kretprobe: lookup failed: %s\n",
 				       kretprobe_blacklist[i].name);
-- 
2.11.0
