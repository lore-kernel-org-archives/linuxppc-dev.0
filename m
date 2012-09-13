Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 32D242C00C0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2012 21:00:14 +1000 (EST)
Message-ID: <5051B749.5040606@windriver.com>
Date: Thu, 13 Sep 2012 18:36:57 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [v3][PATCH 2/3] ppc/kprobe: complete kprobe and migrate exception
 frame
References: <1347330053-27039-1-git-send-email-tiejun.chen@windriver.com>
 <1347330053-27039-2-git-send-email-tiejun.chen@windriver.com>
 <1347342718.2603.38.camel@pasglop> <505049FE.8060204@windriver.com>
 <1347439382.2603.97.camel@pasglop> <50504DEE.6060903@windriver.com>
 <1347446296.2276.0.camel@pasglop>
In-Reply-To: <1347446296.2276.0.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/12/2012 06:38 PM, Benjamin Herrenschmidt wrote:
> On Wed, 2012-09-12 at 16:55 +0800, tiejun.chen wrote:
>>> to worry about nor stack frame to create etc...
>>
>> If you don't like this v4, let me know and then I can go back memcpy
>> for next
>> version.
>
> Just open code the whole copy. It should be easy really. As I said, you
> have the src and dst already in registers and you know they are aligned,
> so just put the size of the frame in a register (divided by 4), do an
> mtctr and do a little load_update/store_update loop to do the copy, all
> in the asm.

Is the following Okay?

---
  arch/powerpc/kernel/entry_32.S |   55 +++++++++++++++++++++++++++++++++++-----
  arch/powerpc/kernel/entry_64.S |   45 ++++++++++++++++++++++++++++++++
  2 files changed, 94 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index ead5016..3b56bba 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -32,6 +32,7 @@
  #include <asm/unistd.h>
  #include <asm/ftrace.h>
  #include <asm/ptrace.h>
+#include <asm/cache.h>

  #undef SHOW_SYSCALLS
  #undef SHOW_SYSCALLS_TASK
@@ -831,19 +832,63 @@ restore_user:
  	bnel-	load_dbcr0
  #endif

-#ifdef CONFIG_PREEMPT
  	b	restore

  /* N.B. the only way to get here is from the beq following ret_from_except. */
  resume_kernel:
-	/* check current_thread_info->preempt_count */
+	/* check current_thread_info, _TIF_EMULATE_STACK_STORE */
  	CURRENT_THREAD_INFO(r9, r1)
+	lwz	r8,TI_FLAGS(r9)
+	andis.	r8,r8,_TIF_EMULATE_STACK_STORE@h
+	beq+	1f
+
+	addi	r8,r1,INT_FRAME_SIZE	/* Get the kprobed function entry */
+
+	lwz	r3,GPR1(r1)
+	subi	r3,r3,INT_FRAME_SIZE	/* dst: Allocate a trampoline exception frame */
+	mr	r4,r1			/* src:  current exception frame */
+	li	r5,INT_FRAME_SIZE	/* size: INT_FRAME_SIZE */
+	li	r6,0			/* start offset: 0 */
+	mr	r1,r3			/* Reroute the trampoline frame to r1 */
+
+	/* Copy from the original to the trampoline. */
+	addi	r5,r5,-4
+	addi	r6,r6,-4
+4:	li	r0,L1_CACHE_BYTES/4
+	mtctr	r0
+3:	addi	r6,r6,4			/* copy a cache line */
+	lwzx	r0,r6,r4
+	stwx	r0,r6,r3
+	bdnz	3b
+	dcbst	r6,r3			/* write it to memory */
+	sync
+	cmplw	0,r6,r5
+	blt	4b
+
+	/* Do real store operation to complete stwu */
+	lwz	r5,GPR1(r1)
+	stw	r8,0(r5)
+
+	/* Clear _TIF_EMULATE_STACK_STORE flag */
+	lis	r11,_TIF_EMULATE_STACK_STORE@h
+	addi	r5,r9,TI_FLAGS
+0:	lwarx	r8,0,r5
+	andc	r8,r8,r11
+#ifdef CONFIG_IBM405_ERR77
+	dcbt	0,r5
+#endif
+	stwcx.	r8,0,r5
+	bne-	0b
+1:
+
+#ifdef CONFIG_PREEMPT
+	/* check current_thread_info->preempt_count */
  	lwz	r0,TI_PREEMPT(r9)
  	cmpwi	0,r0,0		/* if non-zero, just restore regs and return */
  	bne	restore
-	lwz	r0,TI_FLAGS(r9)
-	andi.	r0,r0,_TIF_NEED_RESCHED
+	andi.	r8,r8,_TIF_NEED_RESCHED
  	beq+	restore
+	lwz	r3,_MSR(r1)
  	andi.	r0,r3,MSR_EE	/* interrupts off? */
  	beq	restore		/* don't schedule if so */
  #ifdef CONFIG_TRACE_IRQFLAGS
@@ -864,8 +909,6 @@ resume_kernel:
  	 */
  	bl	trace_hardirqs_on
  #endif
-#else
-resume_kernel:
  #endif /* CONFIG_PREEMPT */

  	/* interrupts are hard-disabled at this point */
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index b40e0b4..cc43b64 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -593,6 +593,51 @@ _GLOBAL(ret_from_except_lite)
  	b	.ret_from_except

  resume_kernel:
+	/* check current_thread_info, _TIF_EMULATE_STACK_STORE */
+	CURRENT_THREAD_INFO(r9, r1)
+	ld	r8,TI_FLAGS(r9)
+	andis.	r8,r8,_TIF_EMULATE_STACK_STORE@h
+	beq+	1f
+
+	addi	r8,r1,INT_FRAME_SIZE	/* Get the kprobed function entry */
+
+	lwz	r3,GPR1(r1)
+	subi	r3,r3,INT_FRAME_SIZE	/* dst: Allocate a trampoline exception frame */
+	mr	r4,r1			/* src:  current exception frame */
+	li	r5,INT_FRAME_SIZE	/* size: INT_FRAME_SIZE */
+	li	r6,0			/* start offset: 0 */
+	mr	r1,r3			/* Reroute the trampoline frame to r1 */
+
+	/* Copy from the original to the trampoline. */
+	addi	r5,r5,-8
+	addi	r6,r6,-8
+4:	li	r0,8
+	mtctr	r0	
+3:	addi	r6,r6,8			/* copy a cache line		*/
+	ldx	r0,r6,r4
+	stdx	r0,r6,r3
+	bdnz	3b
+	dcbst	r6,r3			/* write it to memory		*/
+	sync
+	cmpld	0,r6,r5
+	blt	4b
+	sync
+
+	bl	.copy_and_flush
+
+	/* Do real store operation to complete stwu */
+	lwz	r5,GPR1(r1)
+	std	r8,0(r5)
+
+	/* Clear _TIF_EMULATE_STACK_STORE flag */
+	lis	r11,_TIF_EMULATE_STACK_STORE@h
+	addi	r5,r9,TI_FLAGS
+	ldarx	r4,0,r5
+	andc	r4,r4,r11
+	stdcx.	r4,0,r5
+	bne-	0b
+1:
+
  #ifdef CONFIG_PREEMPT
  	/* Check if we need to preempt */
  	andi.	r0,r4,_TIF_NEED_RESCHED
-- 
1.7.9.5

Tiejun
