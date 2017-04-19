Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7MPy2PbMzDqJL
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 22:53:58 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3JCrqpD081439
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 08:53:56 -0400
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29x752uq67-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 08:53:55 -0400
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 19 Apr 2017 18:22:51 +0530
Received: from d28av08.in.ibm.com (d28av08.in.ibm.com [9.184.220.148])
 by d28relay10.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3JCpOS220774936
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 18:21:24 +0530
Received: from d28av08.in.ibm.com (localhost [127.0.0.1])
 by d28av08.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3JCqllJ020294
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 18:22:47 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 6/6] powerpc: kprobes: prefer ftrace when probing function
 entry
Date: Wed, 19 Apr 2017 18:22:28 +0530
In-Reply-To: <cover.1492605029.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1492605029.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1492606062.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1492606062.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <53ebcc66e4a7ccf1c22cd1703afb0e4738f981ea.1492606062.git.naveen.n.rao@linux.vnet.ibm.com>
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
index df963c6e47b1..d5d6fbd1d788 100644
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
2.12.1
