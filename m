Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vSQrY0sQCzDqGG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 03:27:24 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1LGO0Jn068669
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 11:27:22 -0500
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28rp4p95rj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 11:27:22 -0500
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 22 Feb 2017 02:27:19 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id E63C22CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 03:27:15 +1100 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1LGR70756229962
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 03:27:15 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1LGQhvE012459
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 03:26:43 +1100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 5/5] powerpc: kprobes: prefer ftrace when probing function
 entry
Date: Tue, 21 Feb 2017 21:56:06 +0530
In-Reply-To: <657c6623953f6cce52f929a93cc250b7ee76d7cc.1487692624.git.naveen.n.rao@linux.vnet.ibm.com>
References: <657c6623953f6cce52f929a93cc250b7ee76d7cc.1487692624.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <657c6623953f6cce52f929a93cc250b7ee76d7cc.1487692624.git.naveen.n.rao@linux.vnet.ibm.com>
References: <657c6623953f6cce52f929a93cc250b7ee76d7cc.1487692624.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <0c28885eafe70b3dc76433f33719d96fc46cbfe4.1487692624.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

KPROBES_ON_FTRACE avoids much of the overhead with regular kprobes as it
eliminates the need for a trap, as well as the need to emulate or
single-step instructions.

Though OPTPROBES provides us with similar performance, we have limited
optprobes trampoline slots. As such, when asked to probe at a function
entry, default to using the ftrace infrastructure.

With:
	# cd /sys/kernel/debug/tracing
	# echo 'p _do_fork' > kprobe_events

before patch:
	# cat ../kprobes/list
	c0000000000daf08  k  _do_fork+0x8    [DISABLED]
	c000000000044fc0  k  kretprobe_trampoline+0x0    [OPTIMIZED]

and after patch:
	# cat ../kprobes/list
	c0000000000d074c  k  _do_fork+0xc    [DISABLED][FTRACE]
	c0000000000412b0  k  kretprobe_trampoline+0x0    [OPTIMIZED]

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/kprobes.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index b78b274e1d6e..23d19678a56f 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -49,8 +49,21 @@ kprobe_opcode_t *kprobe_lookup_name(const char *name, unsigned int offset)
 #ifdef PPC64_ELF_ABI_v2
 	/* PPC64 ABIv2 needs local entry point */
 	addr = (kprobe_opcode_t *)kallsyms_lookup_name(name);
-	if (addr && !offset)
-		addr = (kprobe_opcode_t *)ppc_function_entry(addr);
+	if (addr && !offset) {
+#ifdef CONFIG_KPROBES_ON_FTRACE
+		unsigned long faddr;
+		/*
+		 * Per livepatch.h, ftrace location is always within the first
+		 * 16 bytes of a function on powerpc with -mprofile-kernel.
+		 */
+		faddr = ftrace_location_range((unsigned long)addr,
+					      (unsigned long)addr + 16);
+		if (faddr)
+			addr = (kprobe_opcode_t *)faddr;
+		else
+#endif
+			addr = (kprobe_opcode_t *)ppc_function_entry(addr);
+	}
 #elif defined(PPC64_ELF_ABI_v1)
 	/*
 	 * 64bit powerpc ABIv1 uses function descriptors:
-- 
2.11.0
