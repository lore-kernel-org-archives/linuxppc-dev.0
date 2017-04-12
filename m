Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w31SB6zWxzDqHG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 21:10:50 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3CB3ogj139768
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 07:10:48 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29scj8rcq2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 07:10:48 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 12 Apr 2017 21:10:45 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3CBAXk143516076
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 21:10:41 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3CBA8Eh001490
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 21:10:08 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/5] powerpc: kprobes: prefer ftrace when probing function
 entry
Date: Wed, 12 Apr 2017 16:39:26 +0530
In-Reply-To: <cover.1491994965.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1491994965.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1491994965.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1491994965.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <fb8a20e46ee2d5737394e2ef0d1b0cee95db423a.1491994966.git.naveen.n.rao@linux.vnet.ibm.com>
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
2.12.1
