Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vP8F60yYLzDqGv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 19:18:49 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1G8EmdJ145074
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 03:18:47 -0500
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28n65bd17s-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 03:18:47 -0500
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 16 Feb 2017 18:18:44 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id E0F782BB005B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 19:18:41 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1G8IXBH17956894
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 19:18:41 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1G8I8rY005726
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 19:18:09 +1100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] powerpc: kretprobes: override default function entry
 offset
Date: Thu, 16 Feb 2017 13:47:38 +0530
In-Reply-To: <cover.1487232416.git.naveen.n.rao@linux.vnet.ibm.com>
References: <dbb93084a6bc96d44cf7436ab6d5f9c8c72b6a39.1487181941.git.naveen.n.rao@linux.vnet.ibm.com>
 <cover.1487232416.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1487232416.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1487232416.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <a3b56931746e2149b997c0565bf6a579cd286101.1487232416.git.naveen.n.rao@linux.vnet.ibm.com>
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
2.11.0
