Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B608C04AA5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 18:59:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFEE5208D9
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 18:59:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFEE5208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Ynmf4qFTzF3Nb
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 05:59:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=naveen.n.rao@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Ynkf28T9zF38b
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2018 05:57:45 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w9FIsVoM050364
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 14:57:43 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2n50h4888r-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 14:57:43 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Mon, 15 Oct 2018 19:57:41 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 15 Oct 2018 19:57:38 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w9FIvb7D3014922
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 15 Oct 2018 18:57:37 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E96474C046;
 Mon, 15 Oct 2018 21:57:10 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BA5234C040;
 Mon, 15 Oct 2018 21:57:09 +0100 (BST)
Received: from naverao1-tp.ibm.com (unknown [9.77.214.234])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 15 Oct 2018 21:57:09 +0100 (BST)
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 mikey@linux.ibm.com
Subject: [PATCH RFC] powerpc/ftrace: Handle large kernel configs
Date: Tue, 16 Oct 2018 00:27:25 +0530
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18101518-0020-0000-0000-000002D46A6C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101518-0021-0000-0000-00002123703C
Message-Id: <20181015185725.425-1-naveen.n.rao@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-15_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810150163
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
kernel configs, we see functions farther than 32MB of ftrace_caller()
causing ftrace_init() to bail.

One way to solve this is by adding additional trampolines around .text,
.init.text and any other sections with profiled functions.  However,
such trampolines only help if a section does not exceed 64MB.  With
allyesconfig, .text section alone can grow upwards of 100MB, which will
then require us to insert trampolines in the middle of .text... somehow.

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
trampolines go to ftrace_caller() instead. On powerpc, we don't support
!CONFIG_DYNAMIC_FTRACE anymore. As such, we can simply patch mcount() to
branch to ftrace_caller() (or to ftrace_regs_caller() on
-mprofile-kernel) allowing us to use those gcc-generated trampolines for
ftrace.

We note down all the existing gcc-generated trampolines during
ftrace_init() and patch branches to those if ftrace_caller() is not
reachable.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
The one aspect I am not entirely sure about is if the plt_branch is fine 
for -mprofile-kernel as it depends on r2 being properly setup. If it 
isn't, we will have to setup separate trampolines just for 
-mprofile-kernel.

- Naveen


 arch/powerpc/kernel/trace/ftrace.c | 131 ++++++++++++++++++++++++++++-
 1 file changed, 129 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/trace/ftrace.c b/arch/powerpc/kernel/trace/ftrace.c
index 4bfbb54dee51..5fcc05866a23 100644
--- a/arch/powerpc/kernel/trace/ftrace.c
+++ b/arch/powerpc/kernel/trace/ftrace.c
@@ -30,6 +30,10 @@
 
 
 #ifdef CONFIG_DYNAMIC_FTRACE
+
+#define	NUM_FTRACE_TRAMPS	8
+static unsigned long ftrace_cc_tramps[NUM_FTRACE_TRAMPS];
+
 static unsigned int
 ftrace_call_replace(unsigned long ip, unsigned long addr, int link)
 {
@@ -270,6 +274,52 @@ __ftrace_make_nop(struct module *mod,
 #endif /* PPC64 */
 #endif /* CONFIG_MODULES */
 
+static void add_ftrace_cc_tramp(unsigned long tramp)
+{
+	int i;
+
+	for (i = 0; i < NUM_FTRACE_TRAMPS; i++)
+		if (!ftrace_cc_tramps[i]) {
+			ftrace_cc_tramps[i] = tramp;
+			return;
+		} else if (ftrace_cc_tramps[i] == tramp)
+			return;
+
+	WARN(1, "No ftrace cc tramp slots available");
+}
+
+static int __ftrace_make_nop_kernel(struct dyn_ftrace *rec, unsigned long addr)
+{
+	unsigned long tramp, ip = rec->ip;
+	unsigned int op;
+
+	/* read where this goes */
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
+	/* lets find where the pointer goes */
+	tramp = find_bl_target(ip, op);
+
+	pr_devel("ip:%lx jumps to %lx", ip, tramp);
+
+	add_ftrace_cc_tramp(tramp);
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
@@ -286,7 +336,8 @@ int ftrace_make_nop(struct module *mod,
 		old = ftrace_call_replace(ip, addr, 1);
 		new = PPC_INST_NOP;
 		return ftrace_modify_code(ip, old, new);
-	}
+	} else if (core_kernel_text(ip))
+		return __ftrace_make_nop_kernel(rec, addr);
 
 #ifdef CONFIG_MODULES
 	/*
@@ -456,6 +507,40 @@ __ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 #endif /* CONFIG_PPC64 */
 #endif /* CONFIG_MODULES */
 
+static int __ftrace_make_call_kernel(struct dyn_ftrace *rec, unsigned long addr)
+{
+	unsigned int op, i;
+	void *ip = (void *)rec->ip;
+
+	/* read where this goes */
+	if (probe_kernel_read(&op, ip, sizeof(op)))
+		return -EFAULT;
+
+	if (op != PPC_INST_NOP) {
+		pr_err("Unexpected call sequence at %p: %x\n", ip, op);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < NUM_FTRACE_TRAMPS; i++) {
+		if (!ftrace_cc_tramps[i])
+			break;
+
+		if (!create_branch(ip, ftrace_cc_tramps[i], BRANCH_SET_LINK))
+			continue;
+
+		if (patch_branch(ip, ftrace_cc_tramps[i], BRANCH_SET_LINK)) {
+			pr_err("Error patching branch to ftrace tramp!\n");
+			return -EINVAL;
+		}
+
+		return 0;
+	}
+
+	pr_err("No trampolines are reachable from %p\n", ip);
+
+	return -EINVAL;
+}
+
 int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 {
 	unsigned long ip = rec->ip;
@@ -471,7 +556,8 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 		old = PPC_INST_NOP;
 		new = ftrace_call_replace(ip, addr, 1);
 		return ftrace_modify_code(ip, old, new);
-	}
+	} else if (core_kernel_text(ip))
+		return __ftrace_make_call_kernel(rec, addr);
 
 #ifdef CONFIG_MODULES
 	/*
@@ -603,6 +689,12 @@ int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
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
@@ -654,8 +746,43 @@ void arch_ftrace_update_code(int command)
 	ftrace_modify_all_code(command);
 }
 
+/*
+ * Patch _mcount() to jump to ftrace_caller/ftrace_regs_caller for catching
+ * ftrace entry from far functions in a large kernel.
+ */
 int __init ftrace_dyn_arch_init(void)
 {
+	unsigned long ip = ppc_global_function_entry((void *)_mcount);
+	unsigned long ftrace_call_entry;
+	unsigned int op;
+
+#ifdef CONFIG_MPROFILE_KERNEL
+	ftrace_call_entry = (unsigned long)ftrace_regs_caller;
+#else
+	ftrace_call_entry = ppc_global_function_entry((void *)ftrace_caller);
+#endif
+
+	if (probe_kernel_read(&op, (void *)ip, MCOUNT_INSN_SIZE)) {
+		pr_err("Fetching instruction at %lx failed.\n", ip);
+		return -EFAULT;
+	}
+
+	/* We expect either a mflr r0 (ppc32), or a mflr r12 (ppc64) */
+	if ((op & 0xfc1fffff) != PPC_INST_MFLR) {
+		pr_err("Unexpected instruction %08x in _mcount()\n", op);
+		return -EINVAL;
+	}
+
+	if (!create_branch((unsigned int *)ip, ftrace_call_entry, 0)) {
+		pr_err("Branch out of range\n");
+		return -EINVAL;
+	}
+
+	if (patch_branch((unsigned int *)ip, ftrace_call_entry, 0)) {
+		pr_err("REL24 out of range!\n");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 #endif /* CONFIG_DYNAMIC_FTRACE */
-- 
2.19.1

