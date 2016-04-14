Return-Path: <duwe@lst.de>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qm49t33QzzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Apr 2016 01:20:34 +1000 (AEST)
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qm49s4v78z9t3n
 for <linuxppc-dev@ozlabs.org>; Fri, 15 Apr 2016 01:20:32 +1000 (AEST)
Date: Thu, 14 Apr 2016 17:20:29 +0200
From: Torsten Duwe <duwe@lst.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
 Josh Poimboeuf <jpoimboe@redhat.com>, linuxppc-dev@ozlabs.org,
 bsingharora@gmail.com, linux-kernel@vger.kernel.org,
 rostedt@goodmis.org, kamalesh@linux.vnet.ibm.com, pmladek@suse.com,
 jeyu@redhat.com, live-patching@vger.kernel.org
Subject: Re: [PATCH 0/5] Live patching for powerpc
Message-ID: <20160414152029.GA24525@lst.de>
References: <1460552003-15409-1-git-send-email-mpe@ellerman.id.au>
 <alpine.LNX.2.00.1604131457180.16586@pobox.suse.cz>
 <alpine.LNX.2.00.1604131508500.27368@cbobk.fhfr.pm>
 <1460616590.2754.6.camel@ellerman.id.au> <20160414125735.GA20296@lst.de>
 <1460639282.21066.5.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1460639282.21066.5.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 14, 2016 at 11:08:02PM +1000, Michael Ellerman wrote:
> On Thu, 2016-04-14 at 14:57 +0200, Torsten Duwe wrote:
> 
> > FTR: then I still have a few ppc64 hunks floating around to support certain consistency
> > models...
> 
> OK. I'm not quite sure what you mean but post them and we'll see I guess :)

It's *roughly* the ppc64 equivalent of Josh Poimboeuf's Mar 25
| [RFC PATCH v1.9 14/14] livepatch: update task universe when exiting kernel
which only considers x86.

It's forward ported from an earlier code base; there's some glue missing,
but here it is, for reference.

Signed-off-by: Torsten Duwe <duwe@suse.de>


diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index b034ecd..3e749f4 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -92,6 +92,7 @@ static inline struct thread_info *current_thread_info(void)
 					   TIF_NEED_RESCHED */
 #define TIF_32BIT		4	/* 32 bit binary */
 #define TIF_RESTORE_TM		5	/* need to restore TM FP/VEC/VSX */
+#define TIF_KLP_NEED_UPDATE	6	/* kGraft patching in progress */
 #define TIF_SYSCALL_AUDIT	7	/* syscall auditing active */
 #define TIF_SINGLESTEP		8	/* singlestepping active */
 #define TIF_NOHZ		9	/* in adaptive nohz mode */
@@ -115,8 +116,10 @@ static inline struct thread_info *current_thread_info(void)
 #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
 #define _TIF_32BIT		(1<<TIF_32BIT)
 #define _TIF_RESTORE_TM		(1<<TIF_RESTORE_TM)
+#define _TIF_KLP_NEED_UPDATE	(1<<TIF_KLP_NEED_UPDATE)
 #define _TIF_SYSCALL_AUDIT	(1<<TIF_SYSCALL_AUDIT)
 #define _TIF_SINGLESTEP		(1<<TIF_SINGLESTEP)
+#define _TIF_NOHZ		(1<<TIF_NOHZ)
 #define _TIF_SECCOMP		(1<<TIF_SECCOMP)
 #define _TIF_RESTOREALL		(1<<TIF_RESTOREALL)
 #define _TIF_NOERROR		(1<<TIF_NOERROR)
@@ -124,7 +127,7 @@ static inline struct thread_info *current_thread_info(void)
 #define _TIF_UPROBE		(1<<TIF_UPROBE)
 #define _TIF_SYSCALL_TRACEPOINT	(1<<TIF_SYSCALL_TRACEPOINT)
 #define _TIF_EMULATE_STACK_STORE	(1<<TIF_EMULATE_STACK_STORE)
-#define _TIF_NOHZ		(1<<TIF_NOHZ)
+
 #define _TIF_SYSCALL_DOTRACE	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
 				 _TIF_SECCOMP | _TIF_SYSCALL_TRACEPOINT | \
 				 _TIF_NOHZ)
@@ -132,7 +135,8 @@ static inline struct thread_info *current_thread_info(void)
 #define _TIF_USER_WORK_MASK	(_TIF_SIGPENDING | _TIF_NEED_RESCHED | \
 				 _TIF_NOTIFY_RESUME | _TIF_UPROBE | \
 				 _TIF_RESTORE_TM)
-#define _TIF_PERSYSCALL_MASK	(_TIF_RESTOREALL|_TIF_NOERROR)
+
+#define _TIF_PERSYSCALL_MASK	(_TIF_RESTOREALL|_TIF_NOERROR|_TIF_KLP_NEED_UPDATE)
 
 /* Bits in local_flags */
 /* Don't move TLF_NAPPING without adjusting the code in entry_32.S */
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 5bbd1bc..17f8a18 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -151,8 +151,8 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
 
 	CURRENT_THREAD_INFO(r11, r1)
 	ld	r10,TI_FLAGS(r11)
-	andi.	r11,r10,_TIF_SYSCALL_DOTRACE
-	bne	syscall_dotrace		/* does not return */
+	andi.	r10,r10,(_TIF_SYSCALL_DOTRACE|_TIF_KLP_NEED_UPDATE)
+	bne-	syscall_precall		/* does not return */
 	cmpldi	0,r0,NR_syscalls
 	bge-	syscall_enosys
 
@@ -245,6 +245,17 @@ syscall_error:
 	neg	r3,r3
 	std	r5,_CCR(r1)
 	b	.Lsyscall_error_cont
+
+syscall_precall:
+	andi.	r10,r10,(_TIF_KLP_NEED_UPDATE)
+	beq+	syscall_dotrace
+
+	addi	r11,r11,TI_FLAGS
+1:	ldarx	r12,0,r11
+	andc	r12,r12,r10
+	stdcx.	r12,0,r11
+	bne-	1b
+	subi	r11,r11,TI_FLAGS
 	
 /* Traced system call support */
 syscall_dotrace:
