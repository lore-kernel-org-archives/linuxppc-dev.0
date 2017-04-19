Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7QvB19lwzDqFr
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 01:31:01 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3JFTFF7001053
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 11:30:59 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29x77d3473-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 11:30:59 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 20 Apr 2017 01:30:56 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3JFUktH1573312
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 01:30:54 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3JFUHUw026906
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 01:30:18 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] powerpc: kprobes: blacklist exception handlers
Date: Wed, 19 Apr 2017 20:59:51 +0530
In-Reply-To: <cover.1492614257.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1492614257.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1492614257.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1492614257.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <1ec8a69d73b38e365347f0c4b6329407d8861afa.1492614257.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Introduce __head_end to mark end of the early fixed sections and use the
same to blacklist all exception handlers from kprobes.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/sections.h | 1 +
 arch/powerpc/kernel/kprobes.c       | 9 +++++++++
 arch/powerpc/kernel/vmlinux.lds.S   | 2 ++
 3 files changed, 12 insertions(+)

diff --git a/arch/powerpc/include/asm/sections.h b/arch/powerpc/include/asm/sections.h
index 7dc006b58369..5d0c5b103302 100644
--- a/arch/powerpc/include/asm/sections.h
+++ b/arch/powerpc/include/asm/sections.h
@@ -10,6 +10,7 @@
 
 extern char __start_interrupts[];
 extern char __end_interrupts[];
+extern char __head_end[];
 
 extern char __prom_init_toc_start[];
 extern char __prom_init_toc_end[];
diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index 71286dfd76a0..59159337a097 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -35,6 +35,7 @@
 #include <asm/code-patching.h>
 #include <asm/cacheflush.h>
 #include <asm/sstep.h>
+#include <asm/sections.h>
 #include <linux/uaccess.h>
 
 DEFINE_PER_CPU(struct kprobe *, current_kprobe) = NULL;
@@ -112,6 +113,14 @@ kprobe_opcode_t *kprobe_lookup_name(const char *name, unsigned int offset)
 	return addr;
 }
 
+bool arch_within_kprobe_blacklist(unsigned long addr)
+{
+	return  (addr >= (unsigned long)__kprobes_text_start &&
+		 addr < (unsigned long)__kprobes_text_end) ||
+		(addr >= (unsigned long)_stext &&
+		 addr < (unsigned long)__head_end);
+}
+
 int arch_prepare_kprobe(struct kprobe *p)
 {
 	int ret = 0;
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 7394b770ae1f..f6eee507e0b9 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -77,6 +77,8 @@ SECTIONS
 #endif
 	} :kernel
 
+	__head_end = .;
+
 	/*
 	 * If the build dies here, it's likely code in head_64.S is referencing
 	 * labels it can't reach, and the linker inserting stubs without the
-- 
2.12.1
