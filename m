Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vNBYn60CfzDqHH
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 05:59:57 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1EIwU67037786
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 13:59:55 -0500
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28kk8p9nvq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 13:59:55 -0500
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 15 Feb 2017 04:59:52 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 706FE2BB0045
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 05:59:49 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1EIxfSa38273188
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 05:59:49 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1EIxGUB005171
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 05:59:17 +1100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/3] powerpc: kprobes: prefer ftrace when probing function
 entry
Date: Wed, 15 Feb 2017 00:28:36 +0530
In-Reply-To: <1cc8a5580ae3a642fea137b7fe9c526402d4af33.1487098440.git.naveen.n.rao@linux.vnet.ibm.com>
References: <1cc8a5580ae3a642fea137b7fe9c526402d4af33.1487098440.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <1cc8a5580ae3a642fea137b7fe9c526402d4af33.1487098440.git.naveen.n.rao@linux.vnet.ibm.com>
References: <1cc8a5580ae3a642fea137b7fe9c526402d4af33.1487098440.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <7163b91def07c9f3f467891070d7535ab0a63584.1487098440.git.naveen.n.rao@linux.vnet.ibm.com>
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
 arch/powerpc/include/asm/kprobes.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/powerpc/include/asm/kprobes.h b/arch/powerpc/include/asm/kprobes.h
index 3305a12286fa..09e74edee625 100644
--- a/arch/powerpc/include/asm/kprobes.h
+++ b/arch/powerpc/include/asm/kprobes.h
@@ -60,12 +60,32 @@ extern kprobe_opcode_t optprobe_template_end[];
 
 #ifdef PPC64_ELF_ABI_v2
 /* PPC64 ABIv2 needs local entry point */
+#ifdef CONFIG_KPROBES_ON_FTRACE
+/*
+ * Per livepatch.h, ftrace location is always within the first 16 bytes
+ * of a function on powerpc with -mprofile-kernel.
+ */
+#define kprobe_lookup_name(name, addr, offset)				\
+{									\
+	addr = (kprobe_opcode_t *)kallsyms_lookup_name(name);		\
+	if (addr && !(offset)) {					\
+		unsigned long faddr;					\
+		faddr = ftrace_location_range((unsigned long)addr,	\
+					      (unsigned long)addr + 16);\
+		if (faddr)						\
+			addr = (kprobe_opcode_t *)faddr;		\
+		else							\
+			addr = (kprobe_opcode_t *)ppc_function_entry(addr);	\
+	}								\
+}
+#else
 #define kprobe_lookup_name(name, addr, offset)				\
 {									\
 	addr = (kprobe_opcode_t *)kallsyms_lookup_name(name);		\
 	if (addr && !(offset))						\
 		addr = (kprobe_opcode_t *)ppc_function_entry(addr);	\
 }
+#endif
 #elif defined(PPC64_ELF_ABI_v1)
 /*
  * 64bit powerpc ABIv1 uses function descriptors:
-- 
2.11.0
