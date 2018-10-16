Return-Path: <SRS0=rnOA=M4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF46C5ACCC
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 20:27:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61AF12098A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 20:27:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61AF12098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42ZRgr09tZzF3VB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 07:27:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=naveen.n.rao@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42ZRdL5yBczF3KB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2018 07:25:26 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w9GKJ3ie043867
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2018 16:25:24 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2n5n2svw7r-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2018 16:25:24 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 16 Oct 2018 21:25:22 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 16 Oct 2018 21:25:18 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w9GKPIgg62259272
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 16 Oct 2018 20:25:18 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E1F56AE051;
 Tue, 16 Oct 2018 20:25:17 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8F054AE045;
 Tue, 16 Oct 2018 20:25:16 +0000 (GMT)
Received: from naverao1-tp.ibm.com (unknown [9.124.221.233])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 16 Oct 2018 20:25:16 +0000 (GMT)
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Nicholas Piggin <npiggin@gmail.com>, Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] powerpc/ftrace: Handle large kernel configs
Date: Wed, 17 Oct 2018 01:55:00 +0530
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18101620-0020-0000-0000-000002D50C20
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101620-0021-0000-0000-000021241A51
Message-Id: <20181016202500.28039-1-naveen.n.rao@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-16_14:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810160169
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Currently, we expect to be able to reach ftrace_caller() from all
ftrace-enabled functions through a single relative branch. With large
kernel configs, we see functions outside of 32MB of ftrace_caller()
causing ftrace_init() to bail.

In such configurations, gcc/ld emits two types of trampolines for mcount():
1. A long_branch, which has a single branch to mcount() for functions that
   are one hop away from mcount():
	c0000000019e8544 <00031b56.long_branch._mcount>:
	c0000000019e8544:	4a 69 3f ac 	b       c00000000007c4f0 <._mcount>

2. A plt_branch, for functions that are farther away from mcount():
	c0000000051f33f8 <0008ba04.plt_branch._mcount>:
	c0000000051f33f8:	3d 82 ff a4 	addis   r12,r2,-92
	c0000000051f33fc:	e9 8c 04 20 	ld      r12,1056(r12)
	c0000000051f3400:	7d 89 03 a6 	mtctr   r12
	c0000000051f3404:	4e 80 04 20 	bctr

We can reuse those trampolines for ftrace if we can have those
trampolines go to ftrace_caller() instead. However, with ABIv2, we
cannot depend on r2 being valid. As such, we use only the long_branch
trampolines by patching those to instead branch to ftrace_caller or
ftrace_regs_caller.

In addition, we add additional trampolines around .text and .init.text
to catch locations that are covered by the plt branches. This allows
ftrace to work with most large kernel configurations.

For now, we always patch the trampolines to go to ftrace_regs_caller,
which is slightly inefficient. This can be optimized further at a later
point.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
Since RFC:
- Change to patch long_branch to go to ftrace_caller, rather than 
  patching mcount()
- Stop using plt_branch since it can't be relied on for ABIv2
- Add trampolines around .text and .init.text to catch remaining 
  locations

- Naveen

 arch/powerpc/kernel/trace/ftrace.c    | 261 +++++++++++++++++++++++++-
 arch/powerpc/kernel/trace/ftrace_64.S |  12 ++
 arch/powerpc/kernel/vmlinux.lds.S     |  13 +-
 3 files changed, 281 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/trace/ftrace.c b/arch/powerpc/kernel/trace/ftrace.c
index 4bfbb54dee51..4bf051d3e21e 100644
--- a/arch/powerpc/kernel/trace/ftrace.c
+++ b/arch/powerpc/kernel/trace/ftrace.c
@@ -30,6 +30,16 @@
 
 
 #ifdef CONFIG_DYNAMIC_FTRACE
+
+/*
+ * We generally only have a single long_branch tramp and at most 2 or 3 plt
+ * tramps generated. But, we don't use the plt tramps currently. We also allot
+ * 2 tramps after .text and .init.text. So, we only end up with around 3 usable
+ * tramps in total. Set aside 8 just to be sure.
+ */
+#define	NUM_FTRACE_TRAMPS	8
+static unsigned long ftrace_tramps[NUM_FTRACE_TRAMPS];
+
 static unsigned int
 ftrace_call_replace(unsigned long ip, unsigned long addr, int link)
 {
@@ -85,13 +95,16 @@ static int test_24bit_addr(unsigned long ip, unsigned long addr)
 	return create_branch((unsigned int *)ip, addr, 0);
 }
 
-#ifdef CONFIG_MODULES
-
 static int is_bl_op(unsigned int op)
 {
 	return (op & 0xfc000003) == 0x48000001;
 }
 
+static int is_b_op(unsigned int op)
+{
+	return (op & 0xfc000003) == 0x48000000;
+}
+
 static unsigned long find_bl_target(unsigned long ip, unsigned int op)
 {
 	static int offset;
@@ -104,6 +117,7 @@ static unsigned long find_bl_target(unsigned long ip, unsigned int op)
 	return ip + (long)offset;
 }
 
+#ifdef CONFIG_MODULES
 #ifdef CONFIG_PPC64
 static int
 __ftrace_make_nop(struct module *mod,
@@ -270,6 +284,146 @@ __ftrace_make_nop(struct module *mod,
 #endif /* PPC64 */
 #endif /* CONFIG_MODULES */
 
+static unsigned long find_ftrace_tramp(unsigned long ip)
+{
+	int i;
+
+	/*
+	 * We have the compiler generated long_branch tramps at the end
+	 * and we prefer those
+	 */
+	for (i = NUM_FTRACE_TRAMPS - 1; i >= 0; i--)
+		if (!ftrace_tramps[i])
+			continue;
+		else if (create_branch((void *)ip, ftrace_tramps[i], 0))
+			return ftrace_tramps[i];
+
+	return 0;
+}
+
+static int add_ftrace_tramp(unsigned long tramp)
+{
+	int i;
+
+	for (i = 0; i < NUM_FTRACE_TRAMPS; i++)
+		if (!ftrace_tramps[i]) {
+			ftrace_tramps[i] = tramp;
+			return 0;
+		}
+
+	return -1;
+}
+
+/*
+ * If this is a compiler generated long_branch trampoline (essentially, a
+ * trampoline that has a branch to _mcount()), we re-write the branch to
+ * instead go to ftrace_[regs_]caller() and note down the location of this
+ * trampoline.
+ */
+static int setup_mcount_compiler_tramp(unsigned long tramp)
+{
+	int i, op;
+	unsigned long ptr;
+	static unsigned long ftrace_plt_tramps[NUM_FTRACE_TRAMPS];
+
+	/* Is this a known long jump tramp? */
+	for (i = 0; i < NUM_FTRACE_TRAMPS; i++)
+		if (!ftrace_tramps[i])
+			break;
+		else if (ftrace_tramps[i] == tramp)
+			return 0;
+
+	/* Is this a known plt tramp? */
+	for (i = 0; i < NUM_FTRACE_TRAMPS; i++)
+		if (!ftrace_plt_tramps[i])
+			break;
+		else if (ftrace_plt_tramps[i] == tramp)
+			return -1;
+
+	/* New trampoline -- read where this goes */
+	if (probe_kernel_read(&op, (void *)tramp, sizeof(int))) {
+		pr_debug("Fetching opcode failed.\n");
+		return -1;
+	}
+
+	/* Is this a 24 bit branch? */
+	if (!is_b_op(op)) {
+		pr_debug("Trampoline is not a long branch tramp.\n");
+		return -1;
+	}
+
+	/* lets find where the pointer goes */
+	ptr = find_bl_target(tramp, op);
+
+	if (ptr != ppc_global_function_entry((void *)_mcount)) {
+		pr_debug("Trampoline target %p is not _mcount\n", (void *)ptr);
+		return -1;
+	}
+
+	/* Let's re-write the tramp to go to ftrace_[regs_]caller */
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+	ptr = ppc_global_function_entry((void *)ftrace_regs_caller);
+#else
+	ptr = ppc_global_function_entry((void *)ftrace_caller);
+#endif
+	if (!create_branch((void *)tramp, ptr, 0)) {
+		pr_debug("%ps is not reachable from existing mcount tramp\n",
+				(void *)ptr);
+		return -1;
+	}
+
+	if (patch_branch((unsigned int *)tramp, ptr, 0)) {
+		pr_debug("REL24 out of range!\n");
+		return -1;
+	}
+
+	if (add_ftrace_tramp(tramp)) {
+		pr_debug("No tramp locations left\n");
+		return -1;
+	}
+
+	return 0;
+}
+
+static int __ftrace_make_nop_kernel(struct dyn_ftrace *rec, unsigned long addr)
+{
+	unsigned long tramp, ip = rec->ip;
+	unsigned int op;
+
+	/* Read where this goes */
+	if (probe_kernel_read(&op, (void *)ip, sizeof(int))) {
+		pr_err("Fetching opcode failed.\n");
+		return -EFAULT;
+	}
+
+	/* Make sure that that this is still a 24bit jump */
+	if (!is_bl_op(op)) {
+		pr_err("Not expected bl: opcode is %x\n", op);
+		return -EINVAL;
+	}
+
+	/* Let's find where the pointer goes */
+	tramp = find_bl_target(ip, op);
+
+	pr_devel("ip:%lx jumps to %lx", ip, tramp);
+
+	if (setup_mcount_compiler_tramp(tramp)) {
+		/* Are other trampolines reachable? */
+		if (!find_ftrace_tramp(ip)) {
+			pr_err("No ftrace trampolines reachable from %ps\n",
+					(void *)ip);
+			return -EINVAL;
+		}
+	}
+
+	if (patch_instruction((unsigned int *)ip, PPC_INST_NOP)) {
+		pr_err("Patching NOP failed.\n");
+		return -EPERM;
+	}
+
+	return 0;
+}
+
 int ftrace_make_nop(struct module *mod,
 		    struct dyn_ftrace *rec, unsigned long addr)
 {
@@ -286,7 +440,8 @@ int ftrace_make_nop(struct module *mod,
 		old = ftrace_call_replace(ip, addr, 1);
 		new = PPC_INST_NOP;
 		return ftrace_modify_code(ip, old, new);
-	}
+	} else if (core_kernel_text(ip))
+		return __ftrace_make_nop_kernel(rec, addr);
 
 #ifdef CONFIG_MODULES
 	/*
@@ -456,6 +611,53 @@ __ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 #endif /* CONFIG_PPC64 */
 #endif /* CONFIG_MODULES */
 
+static int __ftrace_make_call_kernel(struct dyn_ftrace *rec, unsigned long addr)
+{
+	unsigned int op;
+	void *ip = (void *)rec->ip;
+	unsigned long tramp, entry, ptr;
+
+	/* Make sure we're being asked to patch branch to a known ftrace addr */
+	entry = ppc_global_function_entry((void *)ftrace_caller);
+	ptr = ppc_global_function_entry((void *)addr);
+
+	if (ptr != entry) {
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+		entry = ppc_global_function_entry((void *)ftrace_regs_caller);
+		if (ptr != entry) {
+#endif
+			pr_err("Unknown ftrace addr to patch: %ps\n", (void *)ptr);
+			return -EINVAL;
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+		}
+#endif
+	}
+
+	/* Make sure we have a nop */
+	if (probe_kernel_read(&op, ip, sizeof(op))) {
+		pr_err("Unable to read ftrace location %p\n", ip);
+		return -EFAULT;
+	}
+
+	if (op != PPC_INST_NOP) {
+		pr_err("Unexpected call sequence at %p: %x\n", ip, op);
+		return -EINVAL;
+	}
+
+	tramp = find_ftrace_tramp((unsigned long)ip);
+	if (!tramp) {
+		pr_err("No ftrace trampolines reachable from %ps\n", ip);
+		return -EINVAL;
+	}
+
+	if (patch_branch(ip, tramp, BRANCH_SET_LINK)) {
+		pr_err("Error patching branch to ftrace tramp!\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 {
 	unsigned long ip = rec->ip;
@@ -471,7 +673,8 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 		old = PPC_INST_NOP;
 		new = ftrace_call_replace(ip, addr, 1);
 		return ftrace_modify_code(ip, old, new);
-	}
+	} else if (core_kernel_text(ip))
+		return __ftrace_make_call_kernel(rec, addr);
 
 #ifdef CONFIG_MODULES
 	/*
@@ -603,6 +806,12 @@ int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
 		old = ftrace_call_replace(ip, old_addr, 1);
 		new = ftrace_call_replace(ip, addr, 1);
 		return ftrace_modify_code(ip, old, new);
+	} else if (core_kernel_text(ip)) {
+		/*
+		 * We always patch out of range locations to go to the regs
+		 * variant, so there is nothing to do here
+		 */
+		return 0;
 	}
 
 #ifdef CONFIG_MODULES
@@ -654,10 +863,54 @@ void arch_ftrace_update_code(int command)
 	ftrace_modify_all_code(command);
 }
 
+#ifdef CONFIG_PPC64
+#define PACATOC offsetof(struct paca_struct, kernel_toc)
+
+#define PPC_LO(v) ((v) & 0xffff)
+#define PPC_HI(v) (((v) >> 16) & 0xffff)
+#define PPC_HA(v) PPC_HI ((v) + 0x8000)
+
+extern unsigned int ftrace_tramp_text[], ftrace_tramp_init[];
+
+int __init ftrace_dyn_arch_init(void)
+{
+	int i;
+	unsigned int *tramp[] = { ftrace_tramp_text, ftrace_tramp_init };
+	u32 stub_insns[] = {
+		0xe98d0000 | PACATOC,	/* ld      r12,PACATOC(r13)	*/
+		0x3d8c0000,		/* addis   r12,r12,<high>	*/
+		0x398c0000,		/* addi    r12,r12,<low>	*/
+		0x7d8903a6,		/* mtctr   r12			*/
+		0x4e800420,		/* bctr				*/
+	};
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+	unsigned long addr = ppc_global_function_entry((void *)ftrace_regs_caller);
+#else
+	unsigned long addr = ppc_global_function_entry((void *)ftrace_caller);
+#endif
+	long reladdr = addr - kernel_toc_addr();
+
+	if (reladdr > 0x7FFFFFFF || reladdr < -(0x80000000L)) {
+		pr_err("Address of %ps out of range of kernel_toc.\n",
+				(void *)addr);
+		return -1;
+	}
+
+	for (i = 0; i < 2; i++) {
+		memcpy(tramp[i], stub_insns, sizeof(stub_insns));
+		tramp[i][1] |= PPC_HA(reladdr);
+		tramp[i][2] |= PPC_LO(reladdr);
+		add_ftrace_tramp((unsigned long)tramp[i]);
+	}
+
+	return 0;
+}
+#else
 int __init ftrace_dyn_arch_init(void)
 {
 	return 0;
 }
+#endif
 #endif /* CONFIG_DYNAMIC_FTRACE */
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
diff --git a/arch/powerpc/kernel/trace/ftrace_64.S b/arch/powerpc/kernel/trace/ftrace_64.S
index e25f77c10a72..1782af2d1496 100644
--- a/arch/powerpc/kernel/trace/ftrace_64.S
+++ b/arch/powerpc/kernel/trace/ftrace_64.S
@@ -14,6 +14,18 @@
 #include <asm/ppc-opcode.h>
 #include <asm/export.h>
 
+.pushsection ".tramp.ftrace.text","aw",@progbits;
+.globl ftrace_tramp_text
+ftrace_tramp_text:
+	.space 64
+.popsection
+
+.pushsection ".tramp.ftrace.init","aw",@progbits;
+.globl ftrace_tramp_init
+ftrace_tramp_init:
+	.space 64
+.popsection
+
 _GLOBAL(mcount)
 _GLOBAL(_mcount)
 EXPORT_SYMBOL(_mcount)
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 07ae018e550e..b9045abea1b7 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -99,6 +99,9 @@ SECTIONS
 #endif
 		/* careful! __ftr_alt_* sections need to be close to .text */
 		*(.text.hot TEXT_MAIN .text.fixup .text.unlikely .fixup __ftr_alt_* .ref.text);
+#ifdef CONFIG_PPC64
+		*(.tramp.ftrace.text);
+#endif
 		SCHED_TEXT
 		CPUIDLE_TEXT
 		LOCK_TEXT
@@ -181,7 +184,15 @@ SECTIONS
  */
 	. = ALIGN(STRICT_ALIGN_SIZE);
 	__init_begin = .;
-	INIT_TEXT_SECTION(PAGE_SIZE) :kernel
+	. = ALIGN(PAGE_SIZE);
+	.init.text : AT(ADDR(.init.text) - LOAD_OFFSET) {
+		_sinittext = .;
+		INIT_TEXT
+		_einittext = .;
+#ifdef CONFIG_PPC64
+		*(.tramp.ftrace.init);
+#endif
+	} :kernel
 
 	/* .exit.text is discarded at runtime, not link time,
 	 * to deal with references from __bug_table
-- 
2.19.1

