Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vSzPB41bmzDqH3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 00:54:06 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1MDnALC187727
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 08:54:04 -0500
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28s5ah8rwp-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 08:54:03 -0500
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 22 Feb 2017 19:24:00 +0530
Received: from d28relay08.in.ibm.com (d28relay08.in.ibm.com [9.184.220.159])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id E1BFDE0024
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 19:25:35 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay08.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1MDqrj126476774
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 19:22:53 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1MDrtKG024571
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 19:23:56 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Masami Hiramatsu <mhiramat@kernel.org>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 1/5] kretprobes: ensure probe location is at function entry
Date: Wed, 22 Feb 2017 19:23:37 +0530
In-Reply-To: <cover.1487770934.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1487770934.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1487770934.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1487770934.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <f1583bc4839a3862cfc2acefcc56f9c8837fa2ba.1487770934.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

kretprobes can be registered by specifying an absolute address or by
specifying offset to a symbol. However, we need to ensure this falls at
function entry so as to be able to determine the return address.

Validate the same during kretprobe registration. By default, there
should not be any offset from a function entry, as determined through a
kallsyms_lookup(). Introduce arch_function_offset_within_entry() as a
way for architectures to override this.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 include/linux/kprobes.h |  1 +
 kernel/kprobes.c        | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 16ddfb8b304a..862f87adcbb4 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -266,6 +266,7 @@ extern int arch_init_kprobes(void);
 extern void show_registers(struct pt_regs *regs);
 extern void kprobes_inc_nmissed_count(struct kprobe *p);
 extern bool arch_within_kprobe_blacklist(unsigned long addr);
+extern bool arch_function_offset_within_entry(unsigned long offset);
 
 extern bool within_kprobe_blacklist(unsigned long addr);
 
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index ebb4dadca66b..524766563896 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1869,12 +1869,25 @@ static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
 }
 NOKPROBE_SYMBOL(pre_handler_kretprobe);
 
+bool __weak arch_function_offset_within_entry(unsigned long offset)
+{
+	return !offset;
+}
+
 int register_kretprobe(struct kretprobe *rp)
 {
 	int ret = 0;
 	struct kretprobe_instance *inst;
 	int i;
 	void *addr;
+	unsigned long offset;
+
+	addr = kprobe_addr(&rp->kp);
+	if (!kallsyms_lookup_size_offset((unsigned long)addr, NULL, &offset))
+		return -EINVAL;
+
+	if (!arch_function_offset_within_entry(offset))
+		return -EINVAL;
 
 	if (kretprobe_blacklist_size) {
 		addr = kprobe_addr(&rp->kp);
-- 
2.11.0
