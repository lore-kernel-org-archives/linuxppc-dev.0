Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tKPfy2SpDzDvwl
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 02:09:30 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAHF8dm8065303
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 10:09:27 -0500
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26sc761a4m-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 10:09:27 -0500
Received: from localhost
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 17 Nov 2016 20:39:23 +0530
Received: from d28relay10.in.ibm.com (d28relay10.in.ibm.com [9.184.220.161])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 92BB5125804F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 20:40:15 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay10.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAHF8pT626804288
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 20:38:51 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAHF9HkQ005173
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 20:39:20 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>, Anton Blanchard <anton@samba.org>,
 linuxppc-dev@lists.ozlabs.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: [RFC PATCH 2/4] powerpc: kprobe: add arch specific blacklist
Date: Thu, 17 Nov 2016 20:38:31 +0530
In-Reply-To: <cover.1479394571.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1479394571.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1479394571.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1479394571.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <e34af1637b3c190cc0f2e41131f2524e75720ed3.1479394571.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add symbol to mark end of entry_*.S and use the same to blacklist all
addresses from kernel start (_stext) to entry code from kprobes. Much of
this code is early exception handling where we can't really take a trap.

Reported-by: Anton Blanchard <anton@samba.org>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/entry_32.S |  2 ++
 arch/powerpc/kernel/entry_64.S |  2 ++
 arch/powerpc/kernel/kprobes.c  | 10 ++++++++++
 3 files changed, 14 insertions(+)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 3841d74..de1ed6e 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -1410,3 +1410,5 @@ _GLOBAL(return_to_handler)
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
 
 #endif /* CONFIG_FUNCTION_TRACER */
+
+_GLOBAL_SYM(__entry_text_end)
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 6432d4b..f5f99920 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -1551,3 +1551,5 @@ _GLOBAL(return_to_handler)
 	blr
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
 #endif /* CONFIG_FUNCTION_TRACER */
+
+_GLOBAL_SYM(__entry_text_end)
diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index 9479d8e..b5173d6 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -36,12 +36,22 @@
 #include <asm/cacheflush.h>
 #include <asm/sstep.h>
 #include <asm/uaccess.h>
+#include <asm/sections.h>
 
 DEFINE_PER_CPU(struct kprobe *, current_kprobe) = NULL;
 DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
 
 struct kretprobe_blackpoint kretprobe_blacklist[] = {{NULL, NULL}};
 
+bool arch_within_kprobe_blacklist(unsigned long addr)
+{
+	/* The __kprobes marked functions and entry code must not be probed */
+	return (addr >= (unsigned long)__kprobes_text_start &&
+	        addr < (unsigned long)__kprobes_text_end) ||
+	       (addr >= (unsigned long)_stext &&
+		addr < (unsigned long)__entry_text_end);
+}
+
 int __kprobes arch_prepare_kprobe(struct kprobe *p)
 {
 	int ret = 0;
-- 
2.10.2
