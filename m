Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vPCh12sjbzDqGj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 21:53:53 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1GArXGN098632
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 05:53:51 -0500
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28n6nyt1wb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 05:53:49 -0500
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 16 Feb 2017 20:53:47 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id D19AA2BB0045
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 21:53:44 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1GAraXp8585392
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 21:53:44 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1GArCd1005554
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 21:53:12 +1100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/5] kprobes: convert kprobe_lookup_name() to a function
Date: Thu, 16 Feb 2017 16:22:40 +0530
In-Reply-To: <49dae0da9b7cee3f1747b116cd59854ece84bf02.1487239680.git.naveen.n.rao@linux.vnet.ibm.com>
References: <49dae0da9b7cee3f1747b116cd59854ece84bf02.1487239680.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <49dae0da9b7cee3f1747b116cd59854ece84bf02.1487239680.git.naveen.n.rao@linux.vnet.ibm.com>
References: <49dae0da9b7cee3f1747b116cd59854ece84bf02.1487239680.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <646f0f76098bf1f9284f6005a6e2109b0aa69ee3.1487239680.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The macro is now pretty long and ugly on powerpc. In the light of
further changes needed here, convert it to a __weak variant to be
over-ridden with a nicer looking function.

Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/kprobes.h | 53 ----------------------------------
 arch/powerpc/kernel/kprobes.c      | 58 ++++++++++++++++++++++++++++++++++++++
 include/linux/kprobes.h            |  1 +
 kernel/kprobes.c                   | 20 ++++++-------
 4 files changed, 67 insertions(+), 65 deletions(-)

diff --git a/arch/powerpc/include/asm/kprobes.h b/arch/powerpc/include/asm/kprobes.h
index d821835ade86..ab5bd200bb48 100644
--- a/arch/powerpc/include/asm/kprobes.h
+++ b/arch/powerpc/include/asm/kprobes.h
@@ -58,59 +58,6 @@ extern kprobe_opcode_t optprobe_template_end[];
 #define MAX_OPTINSN_SIZE	(optprobe_template_end - optprobe_template_entry)
 #define RELATIVEJUMP_SIZE	sizeof(kprobe_opcode_t)	/* 4 bytes */
 
-#ifdef PPC64_ELF_ABI_v2
-/* PPC64 ABIv2 needs local entry point */
-#define kprobe_lookup_name(name, addr)					\
-{									\
-	addr = (kprobe_opcode_t *)kallsyms_lookup_name(name);		\
-	if (addr)							\
-		addr = (kprobe_opcode_t *)ppc_function_entry(addr);	\
-}
-#elif defined(PPC64_ELF_ABI_v1)
-/*
- * 64bit powerpc ABIv1 uses function descriptors:
- * - Check for the dot variant of the symbol first.
- * - If that fails, try looking up the symbol provided.
- *
- * This ensures we always get to the actual symbol and not the descriptor.
- * Also handle <module:symbol> format.
- */
-#define kprobe_lookup_name(name, addr)					\
-{									\
-	char dot_name[MODULE_NAME_LEN + 1 + KSYM_NAME_LEN];		\
-	const char *modsym;							\
-	bool dot_appended = false;					\
-	if ((modsym = strchr(name, ':')) != NULL) {			\
-		modsym++;						\
-		if (*modsym != '\0' && *modsym != '.') {		\
-			/* Convert to <module:.symbol> */		\
-			strncpy(dot_name, name, modsym - name);		\
-			dot_name[modsym - name] = '.';			\
-			dot_name[modsym - name + 1] = '\0';		\
-			strncat(dot_name, modsym,			\
-				sizeof(dot_name) - (modsym - name) - 2);\
-			dot_appended = true;				\
-		} else {						\
-			dot_name[0] = '\0';				\
-			strncat(dot_name, name, sizeof(dot_name) - 1);	\
-		}							\
-	} else if (name[0] != '.') {					\
-		dot_name[0] = '.';					\
-		dot_name[1] = '\0';					\
-		strncat(dot_name, name, KSYM_NAME_LEN - 2);		\
-		dot_appended = true;					\
-	} else {							\
-		dot_name[0] = '\0';					\
-		strncat(dot_name, name, KSYM_NAME_LEN - 1);		\
-	}								\
-	addr = (kprobe_opcode_t *)kallsyms_lookup_name(dot_name);	\
-	if (!addr && dot_appended) {					\
-		/* Let's try the original non-dot symbol lookup	*/	\
-		addr = (kprobe_opcode_t *)kallsyms_lookup_name(name);	\
-	}								\
-}
-#endif
-
 #define flush_insn_slot(p)	do { } while (0)
 #define kretprobe_blacklist_size 0
 
diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index 331751701fed..a7aa7394954d 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -42,6 +42,64 @@ DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
 
 struct kretprobe_blackpoint kretprobe_blacklist[] = {{NULL, NULL}};
 
+kprobe_opcode_t *kprobe_lookup_name(const char *name)
+{
+	kprobe_opcode_t *addr;
+
+#ifdef PPC64_ELF_ABI_v2
+	/* PPC64 ABIv2 needs local entry point */
+	addr = (kprobe_opcode_t *)kallsyms_lookup_name(name);
+	if (addr)
+		addr = (kprobe_opcode_t *)ppc_function_entry(addr);
+#elif defined(PPC64_ELF_ABI_v1)
+	/*
+	 * 64bit powerpc ABIv1 uses function descriptors:
+	 * - Check for the dot variant of the symbol first.
+	 * - If that fails, try looking up the symbol provided.
+	 *
+	 * This ensures we always get to the actual symbol and not
+	 * the descriptor.
+	 *
+	 * Also handle <module:symbol> format.
+	 */
+	char dot_name[MODULE_NAME_LEN + 1 + KSYM_NAME_LEN];
+	const char *modsym;
+	bool dot_appended = false;
+	if ((modsym = strchr(name, ':')) != NULL) {
+		modsym++;
+		if (*modsym != '\0' && *modsym != '.') {
+			/* Convert to <module:.symbol> */
+			strncpy(dot_name, name, modsym - name);
+			dot_name[modsym - name] = '.';
+			dot_name[modsym - name + 1] = '\0';
+			strncat(dot_name, modsym,
+				sizeof(dot_name) - (modsym - name) - 2);
+			dot_appended = true;
+		} else {
+			dot_name[0] = '\0';
+			strncat(dot_name, name, sizeof(dot_name) - 1);
+		}
+	} else if (name[0] != '.') {
+		dot_name[0] = '.';
+		dot_name[1] = '\0';
+		strncat(dot_name, name, KSYM_NAME_LEN - 2);
+		dot_appended = true;
+	} else {
+		dot_name[0] = '\0';
+		strncat(dot_name, name, KSYM_NAME_LEN - 1);
+	}
+	addr = (kprobe_opcode_t *)kallsyms_lookup_name(dot_name);
+	if (!addr && dot_appended) {
+		/* Let's try the original non-dot symbol lookup	*/
+		addr = (kprobe_opcode_t *)kallsyms_lookup_name(name);
+	}
+#else
+	addr = (kprobe_opcode_t *)kallsyms_lookup_name(dot_name);
+#endif
+
+	return addr;
+}
+
 int __kprobes arch_prepare_kprobe(struct kprobe *p)
 {
 	int ret = 0;
diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 0c2489435117..34b7d00765d2 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -364,6 +364,7 @@ static inline struct kprobe_ctlblk *get_kprobe_ctlblk(void)
 	return this_cpu_ptr(&kprobe_ctlblk);
 }
 
+kprobe_opcode_t *kprobe_lookup_name(const char *name);
 int register_kprobe(struct kprobe *p);
 void unregister_kprobe(struct kprobe *p);
 int register_kprobes(struct kprobe **kps, int num);
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index ab35ed802389..30f1d732dd74 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -58,15 +58,6 @@
 #define KPROBE_TABLE_SIZE (1 << KPROBE_HASH_BITS)
 
 
-/*
- * Some oddball architectures like 64bit powerpc have function descriptors
- * so this must be overridable.
- */
-#ifndef kprobe_lookup_name
-#define kprobe_lookup_name(name, addr) \
-	addr = ((kprobe_opcode_t *)(kallsyms_lookup_name(name)))
-#endif
-
 static int kprobes_initialized;
 static struct hlist_head kprobe_table[KPROBE_TABLE_SIZE];
 static struct hlist_head kretprobe_inst_table[KPROBE_TABLE_SIZE];
@@ -81,6 +72,11 @@ static struct {
 	raw_spinlock_t lock ____cacheline_aligned_in_smp;
 } kretprobe_table_locks[KPROBE_TABLE_SIZE];
 
+kprobe_opcode_t * __weak kprobe_lookup_name(const char *name)
+{
+	return ((kprobe_opcode_t *)(kallsyms_lookup_name(name)));
+}
+
 static raw_spinlock_t *kretprobe_table_lock_ptr(unsigned long hash)
 {
 	return &(kretprobe_table_locks[hash].lock);
@@ -1365,7 +1361,7 @@ static kprobe_opcode_t *kprobe_addr(struct kprobe *p)
 		goto invalid;
 
 	if (p->symbol_name) {
-		kprobe_lookup_name(p->symbol_name, addr);
+		addr = kprobe_lookup_name(p->symbol_name);
 		if (!addr)
 			return ERR_PTR(-ENOENT);
 	}
@@ -2170,8 +2166,8 @@ static int __init init_kprobes(void)
 	if (kretprobe_blacklist_size) {
 		/* lookup the function address from its name */
 		for (i = 0; kretprobe_blacklist[i].name != NULL; i++) {
-			kprobe_lookup_name(kretprobe_blacklist[i].name,
-					   kretprobe_blacklist[i].addr);
+			kretprobe_blacklist[i].addr =
+				kprobe_lookup_name(kretprobe_blacklist[i].name);
 			if (!kretprobe_blacklist[i].addr)
 				printk("kretprobe: lookup failed: %s\n",
 				       kretprobe_blacklist[i].name);
-- 
2.11.0
