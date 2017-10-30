Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yQdJT4bc5zDrcf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Oct 2017 02:12:41 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9UF8HRR142765
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Oct 2017 11:12:35 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dx5c2nr88-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Oct 2017 11:12:35 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Mon, 30 Oct 2017 15:12:32 -0000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Chandan Rajendra <chandan@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] powerpc/kprobes: Dereference function pointers only if
 the address does not belong to kernel text
Date: Mon, 30 Oct 2017 20:42:09 +0530
In-Reply-To: <cover.1509374094.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1509374094.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1509374094.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1509374094.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <6935a132af2cbfe21de0976ad29601b4dd54a4a6.1509374094.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This makes the changes introduced in commit 83e840c770f2c5
("powerpc64/elfv1: Only dereference function descriptor for non-text
symbols") to be specific to the kprobe subsystem.

We previously changed ppc_function_entry() to always check the provided
address to confirm if it needed to be dereferenced. This is actually
only an issue for kprobe blacklisted asm labels (through use of
_ASM_NOKPROBE_SYMBOL) and can cause other issues with ftrace. Also, the
additional checks are not really necessary for our other uses.

As such, move this check to the kprobes subsystem.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/kprobes.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index bbb4795660f8..ca5d5a081e75 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -598,7 +598,12 @@ NOKPROBE_SYMBOL(kprobe_fault_handler);
 
 unsigned long arch_deref_entry_point(void *entry)
 {
-	return ppc_global_function_entry(entry);
+#ifdef PPC64_ELF_ABI_v1
+	if (!kernel_text_address((unsigned long)entry))
+		return ppc_global_function_entry(entry);
+	else
+#endif
+		return (unsigned long)entry;
 }
 NOKPROBE_SYMBOL(arch_deref_entry_point);
 
-- 
2.14.2
