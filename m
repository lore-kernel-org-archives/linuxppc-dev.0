Return-Path: <leitao@debian.org>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42GMzG3nxBzF3Mm
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2018 02:45:14 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8KGdNFw103142
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2018 12:45:12 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mmd7u6bw4-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2018 12:45:11 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Thu, 20 Sep 2018 10:45:10 -0600
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Breno Leitao <leitao@debian.org>
Subject: [PATCH 1/3] powerpc: Redefine TIF_32BITS thread flag
Date: Thu, 20 Sep 2018 13:45:05 -0300
Message-Id: <1537461907-32003-1-git-send-email-leitao@debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Moving TIF_32BIT to use bit 20 instead of 4 in the task flag field.

This change is making room for an upcoming new task macro
(_TIF_SYSCALL_EMU) which is preferred to set a bit in the lower 16-bits
part of the word.

This upcoming flag macro will take part in a composed macro
(_TIF_SYSCALL_DOTRACE) which will contain other flags as well, and it is
preferred that the whole _TIF_SYSCALL_DOTRACE macro only sets the lower 16
bits of a word, so, it could be handled using immediate operations (as load
immediate, add immediate, ...) where the immediate operand (SI) is limited
to 16-bits.

Another possible solution would be using the LOAD_REG_IMMEDIATE() macro
to load a full 64-bits word immediate, but it takes 5 operations instead of
one.

Having TIF_32BITS being redefined to use an upper bit is not a problem
since there is only one place in the assembly code where TIF_32BIT is being
used, and it could be replaced with an operation with right shift (addis),
since it is used alone, i.e. not being part of a composed macro, which has
different bits set, and would require LOAD_REG_IMMEDIATE().

Tested on a 64 bits Big Endian machine running a 32 bits task.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/powerpc/include/asm/thread_info.h | 2 +-
 arch/powerpc/kernel/entry_64.S         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index 3c0002044bc9..1a52e14ec3ee 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -81,7 +81,6 @@ extern int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src
 #define TIF_SIGPENDING		1	/* signal pending */
 #define TIF_NEED_RESCHED	2	/* rescheduling necessary */
 #define TIF_FSCHECK		3	/* Check FS is USER_DS on return */
-#define TIF_32BIT		4	/* 32 bit binary */
 #define TIF_RESTORE_TM		5	/* need to restore TM FP/VEC/VSX */
 #define TIF_PATCH_PENDING	6	/* pending live patching update */
 #define TIF_SYSCALL_AUDIT	7	/* syscall auditing active */
@@ -100,6 +99,7 @@ extern int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src
 #define TIF_ELF2ABI		18	/* function descriptors must die! */
 #endif
 #define TIF_POLLING_NRFLAG	19	/* true if poll_idle() is polling TIF_NEED_RESCHED */
+#define TIF_32BIT		20	/* 32 bit binary */
 
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 2206912ea4f0..56f7b11d76ec 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -171,7 +171,7 @@ system_call:			/* label this so stack traces look sane */
  * based on caller's run-mode / personality.
  */
 	ld	r11,SYS_CALL_TABLE@toc(2)
-	andi.	r10,r10,_TIF_32BIT
+	andis.	r10,r10,_TIF_32BIT@h
 	beq	15f
 	addi	r11,r11,8	/* use 32-bit syscall entries */
 	clrldi	r3,r3,32
-- 
2.19.0
