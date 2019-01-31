Return-Path: <SRS0=ULCe=QH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C04EC169C4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 10:32:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB1C0218AC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 10:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="q0oZ5qXI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB1C0218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43qxPy5SBpzDq9p
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 21:32:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="q0oZ5qXI"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43qwtt5gPBzDqPj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jan 2019 21:09:10 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43qwtp4Wb7z9tyxC;
 Thu, 31 Jan 2019 11:09:06 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=q0oZ5qXI; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id Zj1V-Cg4VXQ5; Thu, 31 Jan 2019 11:09:06 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43qwtp3Sj2z9tyx9;
 Thu, 31 Jan 2019 11:09:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1548929346; bh=BR2vQybDnfHro2/s5Vvd4A64gVHkoTrpg8svOc24cSY=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=q0oZ5qXIn/9nhkymQIJkWrZzy1opcBCYaTIRW/+H0B0zIH4nwaKPc8BgOxnZ7++Lz
 uYO6sObD3dtCHQkQAGQsyCOjqCpvsVNWiy/9Tu8yCkLPzyr0IsWAfaVkC6WlNZnT3c
 8tkVxVcEvJzilFb8MgUzu4yHN9tHZnAg5CPpSsDo=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 9C9D58B814;
 Thu, 31 Jan 2019 11:09:07 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id dg3CvERG7_ls; Thu, 31 Jan 2019 11:09:07 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 58F508B78D;
 Thu, 31 Jan 2019 11:09:07 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id D86B972E14; Thu, 31 Jan 2019 10:09:06 +0000 (UTC)
Message-Id: <d1e29495eb1d0263755e26869245a8fa509cd079.1548852243.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1548852242.git.christophe.leroy@c-s.fr>
References: <cover.1548852242.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v15 12/13] powerpc/64: Remove CURRENT_THREAD_INFO
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>
Date: Thu, 31 Jan 2019 10:09:06 +0000 (UTC)
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

Now that current_thread_info is located at the beginning of 'current'
task struct, CURRENT_THREAD_INFO macro is not really needed any more.

This patch replaces it by loads of the value at PACACURRENT(r13).

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/exception-64s.h       |  4 ++--
 arch/powerpc/include/asm/thread_info.h         |  4 ----
 arch/powerpc/kernel/entry_64.S                 | 10 +++++-----
 arch/powerpc/kernel/exceptions-64e.S           |  2 +-
 arch/powerpc/kernel/exceptions-64s.S           |  2 +-
 arch/powerpc/kernel/idle_book3e.S              |  2 +-
 arch/powerpc/kernel/idle_power4.S              |  2 +-
 arch/powerpc/kernel/trace/ftrace_64_mprofile.S |  6 +++---
 8 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 3b4767ed3ec5..dd6a5ae7a769 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -671,7 +671,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 
 #define RUNLATCH_ON				\
 BEGIN_FTR_SECTION				\
-	CURRENT_THREAD_INFO(r3, r1);		\
+	ld	r3, PACACURRENT(r13);		\
 	ld	r4,TI_LOCAL_FLAGS(r3);		\
 	andi.	r0,r4,_TLF_RUNLATCH;		\
 	beql	ppc64_runlatch_on_trampoline;	\
@@ -721,7 +721,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_CTRL)
 #ifdef CONFIG_PPC_970_NAP
 #define FINISH_NAP				\
 BEGIN_FTR_SECTION				\
-	CURRENT_THREAD_INFO(r11, r1);		\
+	ld	r11, PACACURRENT(r13);		\
 	ld	r9,TI_LOCAL_FLAGS(r11);		\
 	andi.	r10,r9,_TLF_NAPPING;		\
 	bnel	power4_fixup_nap;		\
diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index c959b8d66cac..8e1d0195ac36 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -17,10 +17,6 @@
 
 #define THREAD_SIZE		(1 << THREAD_SHIFT)
 
-#ifdef CONFIG_PPC64
-#define CURRENT_THREAD_INFO(dest, sp)	stringify_in_c(ld dest, PACACURRENT(r13))
-#endif
-
 #ifndef __ASSEMBLY__
 #include <linux/cache.h>
 #include <asm/processor.h>
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 01d0706d873f..83bddacd7a17 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -166,7 +166,7 @@ system_call:			/* label this so stack traces look sane */
 	li	r10,IRQS_ENABLED
 	std	r10,SOFTE(r1)
 
-	CURRENT_THREAD_INFO(r11, r1)
+	ld	r11, PACACURRENT(r13)
 	ld	r10,TI_FLAGS(r11)
 	andi.	r11,r10,_TIF_SYSCALL_DOTRACE
 	bne	.Lsyscall_dotrace		/* does not return */
@@ -213,7 +213,7 @@ system_call:			/* label this so stack traces look sane */
 	ld	r3,RESULT(r1)
 #endif
 
-	CURRENT_THREAD_INFO(r12, r1)
+	ld	r12, PACACURRENT(r13)
 
 	ld	r8,_MSR(r1)
 #ifdef CONFIG_PPC_BOOK3S
@@ -348,7 +348,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 
 	/* Repopulate r9 and r10 for the syscall path */
 	addi	r9,r1,STACK_FRAME_OVERHEAD
-	CURRENT_THREAD_INFO(r10, r1)
+	ld	r10, PACACURRENT(r13)
 	ld	r10,TI_FLAGS(r10)
 
 	cmpldi	r0,NR_syscalls
@@ -746,7 +746,7 @@ _GLOBAL(ret_from_except_lite)
 	mtmsrd	r10,1		  /* Update machine state */
 #endif /* CONFIG_PPC_BOOK3E */
 
-	CURRENT_THREAD_INFO(r9, r1)
+	ld	r9, PACACURRENT(r13)
 	ld	r3,_MSR(r1)
 #ifdef CONFIG_PPC_BOOK3E
 	ld	r10,PACACURRENT(r13)
@@ -860,7 +860,7 @@ resume_kernel:
 1:	bl	preempt_schedule_irq
 
 	/* Re-test flags and eventually loop */
-	CURRENT_THREAD_INFO(r9, r1)
+	ld	r9, PACACURRENT(r13)
 	ld	r4,TI_FLAGS(r9)
 	andi.	r0,r4,_TIF_NEED_RESCHED
 	bne	1b
diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 20f14996281d..04ee24789f80 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -493,7 +493,7 @@ exc_##n##_bad_stack:							    \
  * interrupts happen before the wait instruction.
  */
 #define CHECK_NAPPING()							\
-	CURRENT_THREAD_INFO(r11, r1);					\
+	ld	r11, PACACURRENT(r13);					\
 	ld	r10,TI_LOCAL_FLAGS(r11);				\
 	andi.	r9,r10,_TLF_NAPPING;					\
 	beq+	1f;							\
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 9e253ce27e08..c7c4e2d6f98f 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1629,7 +1629,7 @@ do_hash_page:
 	ori	r0,r0,DSISR_BAD_FAULT_64S@l
 	and.	r0,r4,r0		/* weird error? */
 	bne-	handle_page_fault	/* if not, try to insert a HPTE */
-	CURRENT_THREAD_INFO(r11, r1)
+	ld	r11, PACACURRENT(r13)
 	lwz	r0,TI_PREEMPT(r11)	/* If we're in an "NMI" */
 	andis.	r0,r0,NMI_MASK@h	/* (i.e. an irq when soft-disabled) */
 	bne	77f			/* then don't call hash_page now */
diff --git a/arch/powerpc/kernel/idle_book3e.S b/arch/powerpc/kernel/idle_book3e.S
index 4e0d94d02030..31e732c378ad 100644
--- a/arch/powerpc/kernel/idle_book3e.S
+++ b/arch/powerpc/kernel/idle_book3e.S
@@ -63,7 +63,7 @@ _GLOBAL(\name)
 1:	/* Let's set the _TLF_NAPPING flag so interrupts make us return
 	 * to the right spot
 	*/
-	CURRENT_THREAD_INFO(r11, r1)
+	ld	r11, PACACURRENT(r13)
 	ld	r10,TI_LOCAL_FLAGS(r11)
 	ori	r10,r10,_TLF_NAPPING
 	std	r10,TI_LOCAL_FLAGS(r11)
diff --git a/arch/powerpc/kernel/idle_power4.S b/arch/powerpc/kernel/idle_power4.S
index a09b3c7ca176..61ac89fd0a05 100644
--- a/arch/powerpc/kernel/idle_power4.S
+++ b/arch/powerpc/kernel/idle_power4.S
@@ -68,7 +68,7 @@ BEGIN_FTR_SECTION
 	DSSALL
 	sync
 END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
-	CURRENT_THREAD_INFO(r9, r1)
+	ld	r9, PACACURRENT(r13)
 	ld	r8,TI_LOCAL_FLAGS(r9)	/* set napping bit */
 	ori	r8,r8,_TLF_NAPPING	/* so when we take an exception */
 	std	r8,TI_LOCAL_FLAGS(r9)	/* it will return to our caller */
diff --git a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
index 32476a6e4e9c..202bec086e3b 100644
--- a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
+++ b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
@@ -229,7 +229,7 @@ ftrace_call:
 	 *  - r0, r11 & r12 are free
 	 */
 livepatch_handler:
-	CURRENT_THREAD_INFO(r12, r1)
+	ld	r12, PACACURRENT(r13)
 
 	/* Allocate 3 x 8 bytes */
 	ld	r11, TI_livepatch_sp(r12)
@@ -256,7 +256,7 @@ livepatch_handler:
 	 * restore it.
 	 */
 
-	CURRENT_THREAD_INFO(r12, r1)
+	ld	r12, PACACURRENT(r13)
 
 	ld	r11, TI_livepatch_sp(r12)
 
@@ -273,7 +273,7 @@ livepatch_handler:
 	ld	r2,  -24(r11)
 
 	/* Pop livepatch stack frame */
-	CURRENT_THREAD_INFO(r12, r1)
+	ld	r12, PACACURRENT(r13)
 	subi	r11, r11, 24
 	std	r11, TI_livepatch_sp(r12)
 
-- 
2.13.3

