Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vctfZ580pzDqYR
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Mar 2017 21:48:06 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v27AhtgB017534
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Mar 2017 05:47:55 -0500
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2917gpjaty-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Mar 2017 05:47:55 -0500
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 7 Mar 2017 16:17:52 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 3F134394005C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Mar 2017 16:17:50 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v27AloVQ14221414
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Mar 2017 16:17:50 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v27Alm77020248
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Mar 2017 16:17:49 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [RESEND PATCH 2/6] powerpc: kretprobes: override default function
 entry offset
Date: Tue,  7 Mar 2017 16:17:37 +0530
In-Reply-To: <cover.1488881988.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1488881988.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1488881988.git.naveen.n.rao@linux.vnet.ibm.com>
References: <20170306220638.e7db155d44e14325c5c0174b@kernel.org>
 <cover.1488881988.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <5bbe691087d5d13481228037756da54fa1730a80.1488881988.git.naveen.n.rao@linux.vnet.ibm.com>
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

Acked-by: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/kprobes.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index fce05a38851c..331751701fed 100644
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
2.11.1
