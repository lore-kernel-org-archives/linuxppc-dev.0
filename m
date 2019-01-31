Return-Path: <SRS0=ULCe=QH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6D3C169C4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 10:29:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F91620869
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 10:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="M6jsOQzj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F91620869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43qxKl3QnvzDqX1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 21:28:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="M6jsOQzj"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43qwtp5NykzDqT2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jan 2019 21:09:06 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43qwtk4CHlz9tyxF;
 Thu, 31 Jan 2019 11:09:02 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=M6jsOQzj; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id Hcsw1GvO1CXc; Thu, 31 Jan 2019 11:09:02 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43qwtk38vKz9tyx9;
 Thu, 31 Jan 2019 11:09:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1548929342; bh=hVjK/MF3Hc5p9MN1ZxIhqr5H11q0ZLvAMSBdtHgzqB0=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=M6jsOQzjJBBRA3QFREpNAtD1Q2Nk4FEanw8qcNX29c94ZwyL+Ck9OssMQqhDfDaJj
 Rsutci1KvTmG9VasWZbFFD6YOXPiwWPsrvSzndx/MNiLUCNoq5VWgtEK9SS/eZjzZw
 qdKSOkwqfkdf92X1Yz/57MDsOnlmWv1KhALbGRLI=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 870E38B814;
 Thu, 31 Jan 2019 11:09:03 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id gX0MLJuygYoG; Thu, 31 Jan 2019 11:09:03 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 48B4B8B78D;
 Thu, 31 Jan 2019 11:09:03 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id C968072E14; Thu, 31 Jan 2019 10:09:02 +0000 (UTC)
Message-Id: <82b8fecc7f97cf7ded84905d3723cb78f4e9ce5d.1548852243.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1548852242.git.christophe.leroy@c-s.fr>
References: <cover.1548852242.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v15 10/13] powerpc: 'current_set' is now a table of
 task_struct pointers
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>
Date: Thu, 31 Jan 2019 10:09:02 +0000 (UTC)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The table of pointers 'current_set' has been used for retrieving
the stack and current. They used to be thread_info pointers as
they were pointing to the stack and current was taken from the
'task' field of the thread_info.

Now, the pointers of 'current_set' table are now both pointers
to task_struct and pointers to thread_info.

As they are used to get current, and the stack pointer is
retrieved from current's stack field, this patch changes
their type to task_struct, and renames secondary_ti to
secondary_current.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/asm-prototypes.h |  4 ++--
 arch/powerpc/kernel/head_32.S             |  6 +++---
 arch/powerpc/kernel/head_44x.S            |  4 ++--
 arch/powerpc/kernel/head_fsl_booke.S      |  4 ++--
 arch/powerpc/kernel/smp.c                 | 10 ++++------
 5 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/asm-prototypes.h b/arch/powerpc/include/asm/asm-prototypes.h
index 1d911f68a23b..1484df6779ab 100644
--- a/arch/powerpc/include/asm/asm-prototypes.h
+++ b/arch/powerpc/include/asm/asm-prototypes.h
@@ -23,8 +23,8 @@
 #include <uapi/asm/ucontext.h>
 
 /* SMP */
-extern struct thread_info *current_set[NR_CPUS];
-extern struct thread_info *secondary_ti;
+extern struct task_struct *current_set[NR_CPUS];
+extern struct task_struct *secondary_current;
 void start_secondary(void *unused);
 
 /* kexec */
diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index 309a45779ad5..146385b1c2da 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -846,9 +846,9 @@ __secondary_start:
 #endif /* CONFIG_PPC_BOOK3S_32 */
 
 	/* get current's stack and current */
-	lis	r1,secondary_ti@ha
-	tophys(r1,r1)
-	lwz	r2,secondary_ti@l(r1)
+	lis	r2,secondary_current@ha
+	tophys(r2,r2)
+	lwz	r2,secondary_current@l(r2)
 	tophys(r1,r2)
 	lwz	r1,TASK_STACK(r1)
 
diff --git a/arch/powerpc/kernel/head_44x.S b/arch/powerpc/kernel/head_44x.S
index f94a93b6c2f2..37117ab11584 100644
--- a/arch/powerpc/kernel/head_44x.S
+++ b/arch/powerpc/kernel/head_44x.S
@@ -1020,8 +1020,8 @@ _GLOBAL(start_secondary_47x)
 	/* Now we can get our task struct and real stack pointer */
 
 	/* Get current's stack and current */
-	lis	r1,secondary_ti@ha
-	lwz	r2,secondary_ti@l(r1)
+	lis	r2,secondary_current@ha
+	lwz	r2,secondary_current@l(r2)
 	lwz	r1,TASK_STACK(r2)
 
 	/* Current stack pointer */
diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 11f38adbe020..4ed2a7c8e89b 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -1091,8 +1091,8 @@ __secondary_start:
 	bl	call_setup_cpu
 
 	/* get current's stack and current */
-	lis	r1,secondary_ti@ha
-	lwz	r2,secondary_ti@l(r1)
+	lis	r2,secondary_current@ha
+	lwz	r2,secondary_current@l(r2)
 	lwz	r1,TASK_STACK(r2)
 
 	/* stack */
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index aa4517686f90..a41fa8924004 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -76,7 +76,7 @@
 static DEFINE_PER_CPU(int, cpu_state) = { 0 };
 #endif
 
-struct thread_info *secondary_ti;
+struct task_struct *secondary_current;
 bool has_big_cores;
 
 DEFINE_PER_CPU(cpumask_var_t, cpu_sibling_map);
@@ -664,7 +664,7 @@ void smp_send_stop(void)
 }
 #endif /* CONFIG_NMI_IPI */
 
-struct thread_info *current_set[NR_CPUS];
+struct task_struct *current_set[NR_CPUS];
 
 static void smp_store_cpu_info(int id)
 {
@@ -929,7 +929,7 @@ void smp_prepare_boot_cpu(void)
 	paca_ptrs[boot_cpuid]->__current = current;
 #endif
 	set_numa_node(numa_cpu_lookup_table[boot_cpuid]);
-	current_set[boot_cpuid] = task_thread_info(current);
+	current_set[boot_cpuid] = current;
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -1014,15 +1014,13 @@ static bool secondaries_inhibited(void)
 
 static void cpu_idle_thread_init(unsigned int cpu, struct task_struct *idle)
 {
-	struct thread_info *ti = task_thread_info(idle);
-
 #ifdef CONFIG_PPC64
 	paca_ptrs[cpu]->__current = idle;
 	paca_ptrs[cpu]->kstack = (unsigned long)task_stack_page(idle) +
 				 THREAD_SIZE - STACK_FRAME_OVERHEAD;
 #endif
 	idle->cpu = cpu;
-	secondary_ti = current_set[cpu] = ti;
+	secondary_current = current_set[cpu] = idle;
 }
 
 int __cpu_up(unsigned int cpu, struct task_struct *tidle)
-- 
2.13.3

