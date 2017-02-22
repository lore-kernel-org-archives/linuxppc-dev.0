Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vSzPC0YbczDqHB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 00:54:06 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1MDq8Tr078122
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 08:54:04 -0500
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28s5ksfvhp-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 08:54:04 -0500
Received: from localhost
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 22 Feb 2017 19:24:01 +0530
Received: from d28relay09.in.ibm.com (d28relay09.in.ibm.com [9.184.220.160])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 59382E005A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 19:25:38 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay09.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1MDrxs627590696
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 19:23:59 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1MDrwMT024604
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 19:23:59 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Masami Hiramatsu <mhiramat@kernel.org>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 2/5] powerpc: kretprobes: override default function entry
 offset
Date: Wed, 22 Feb 2017 19:23:38 +0530
In-Reply-To: <cover.1487770934.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1487770934.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1487770934.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1487770934.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <e27a624a724f1b00d09e769cbce24abdb27d8688.1487770934.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With ABIv2, we offset 8 bytes into a function to get at the local entry
point.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/kprobes.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index 735ff3d3f77d..e37b76b8b6b2 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -131,6 +131,15 @@ static void __kprobes set_current_kprobe(struct kprobe *p, struct pt_regs *regs,
 	kcb->kprobe_saved_msr = regs->msr;
 }
 
+bool arch_function_offset_within_entry(unsigned long offset)
+{
+#ifdef PPC64_ELF_ABI_v2
+	return offset <= 8;
+#else
+	return !offset;
+#endif
+}
+
 void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
 				      struct pt_regs *regs)
 {
-- 
2.11.0
