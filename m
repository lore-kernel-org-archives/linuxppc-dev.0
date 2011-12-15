Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DAFBF1007D4
 for <linuxppc-dev@ozlabs.org>; Thu, 15 Dec 2011 22:20:10 +1100 (EST)
Message-ID: <4EE9D7C3.8050506@windriver.com>
Date: Thu, 15 Dec 2011 19:19:31 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 3/4] ppc32/kprobe: complete kprobe and migrate exception
 frame
References: <1323679853-31751-1-git-send-email-tiejun.chen@windriver.com>	
 <1323679853-31751-4-git-send-email-tiejun.chen@windriver.com>	
 <1323731987.19891.40.camel@pasglop> <4EE6DA8C.8090107@windriver.com>	
 <4EE72AB8.4090502@windriver.com> <1323909460.21839.42.camel@pasglop>
In-Reply-To: <1323909460.21839.42.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Looks we have to go into 'restore' at last as I said previously. I send v2 based
on your all comments.

>> I assume it may not necessary to reorganize ret_from_except for *ppc32* .
> 
> It might be cleaner but I can do that myself later.
> 

I have this version but I'm not 100% sure if its as you expect :)

#define _TIF_WORK_MASK (_TIF_USER_WORK_MASK | _TIF_EMULATE_STACK_STORE)

======
diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 56212bc..e52b586 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -791,41 +791,29 @@ ret_from_except:
        SYNC                    /* Some chip revs have problems here... */
        MTMSRD(r10)             /* disable interrupts */

-       lwz     r3,_MSR(r1)     /* Returning to user mode? */
-       andi.   r0,r3,MSR_PR
-       beq     resume_kernel
-
 user_exc_return:               /* r10 contains MSR_KERNEL here */
        /* Check current_thread_info()->flags */
        rlwinm  r9,r1,0,0,(31-THREAD_SHIFT)
        lwz     r9,TI_FLAGS(r9)
-       andi.   r0,r9,_TIF_USER_WORK_MASK
-       bne     do_work
+       andi.   r0,r9,_TIF_WORK_MASK
+       beq     restore

-restore_user:
-#if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
-       /* Check whether this process has its own DBCR0 value.  The internal
-          debug mode bit tells us that dbcr0 should be loaded. */
-       lwz     r0,THREAD+THREAD_DBCR0(r2)
-       andis.  r10,r0,DBCR0_IDM@h
-       bnel-   load_dbcr0
-#endif
+       lwz     r3,_MSR(r1)     /* Returning to user mode? */
+       andi.   r0,r3,MSR_PR
+       bne     do_user_work

 #ifdef CONFIG_PREEMPT
-       b       restore
-
 /* N.B. the only way to get here is from the beq following ret_from_except. */
-resume_kernel:
        /* check current_thread_info->preempt_count */
        rlwinm  r9,r1,0,0,(31-THREAD_SHIFT)
        lwz     r0,TI_PREEMPT(r9)
        cmpwi   0,r0,0          /* if non-zero, just restore regs and return */
-       bne     restore
+       bne     2f
        lwz     r0,TI_FLAGS(r9)
        andi.   r0,r0,_TIF_NEED_RESCHED
-       beq+    restore
+       beq+    2f
        andi.   r0,r3,MSR_EE    /* interrupts off? */
-       beq     restore         /* don't schedule if so */
+       beq     2f      /* don't schedule if so */
 #ifdef CONFIG_TRACE_IRQFLAGS
        /* Lockdep thinks irqs are enabled, we need to call
         * preempt_schedule_irq with IRQs off, so we inform lockdep
@@ -844,12 +832,54 @@ resume_kernel:
         */
        bl      trace_hardirqs_on
 #endif
-#else
-resume_kernel:
+2:
 #endif /* CONFIG_PREEMPT */

+       /* check current_thread_info, _TIF_EMULATE_STACK_STORE */
+       rlwinm  r9,r1,0,0,(31-THREAD_SHIFT)
+       lwz     r0,TI_FLAGS(r9)
+       andis.  r0,r0,_TIF_EMULATE_STACK_STORE@h
+       beq+    restore
+
+       addi    r9,r1,INT_FRAME_SIZE    /* Get the kprobed function entry */
+
+       lwz     r3,GPR1(r1)
+       subi    r3,r3,INT_FRAME_SIZE    /* dst: Allocate a trampoline exception
frame */
+       mr      r4,r1                   /* src:  current exception frame */
+       li      r5,INT_FRAME_SIZE       /* size: INT_FRAME_SIZE */
+       mr      r1,r3                   /* Reroute the trampoline frame to r1 */
+       bl      memcpy                  /* Copy from the original to the
trampoline */
+
+       /* Do real store operation to complete stwu */
+       lwz     r5,GPR1(r1)
+       stw     r9,0(r5)
+
+       /* Do real store operation to complete stwu */
+       lwz     r5,GPR1(r1)
+       stw     r9,0(r5)
+
+       /* Clear _TIF_EMULATE_STACK_STORE flag */
+       rlwinm  r9,r1,0,0,(31-THREAD_SHIFT)
+       lis     r11,_TIF_EMULATE_STACK_STORE@h
+       addi    r9,r9,TI_FLAGS
+0:     lwarx   r8,0,r9
+       andc    r8,r8,r11
+#ifdef CONFIG_IBM405_ERR77
+       dcbt    0,r9
+#endif
+       stwcx.  r8,0,r9
+       bne-    0b
+
        /* interrupts are hard-disabled at this point */
 restore:
+#if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
+       lwz     r3,_MSR(r1)     /* Returning to user mode? */
+       andi.   r0,r3,MSR_PR
+       beq     1f
+       /* Check whether this process has its own DBCR0 value.  The internal
+          debug mode bit tells us that dbcr0 should be loaded. */
+       lwz     r0,THREAD+THREAD_DBCR0(r2)
+       andis.  r10,r0,DBCR0_IDM@h
+       bnel-   load_dbcr0
+1:
+#endif
+
 #ifdef CONFIG_44x
 BEGIN_MMU_FTR_SECTION
        b       1f
@@ -1159,7 +1189,7 @@ global_dbcr0:
        .previous
 #endif /* !(CONFIG_4xx || CONFIG_BOOKE) */

-do_work:                       /* r10 contains MSR_KERNEL here */
+do_user_work:                  /* r10 contains MSR_KERNEL here */
        andi.   r0,r9,_TIF_NEED_RESCHED
        beq     do_user_signal

@@ -1184,7 +1214,7 @@ recheck:
        andi.   r0,r9,_TIF_NEED_RESCHED
        bne-    do_resched
        andi.   r0,r9,_TIF_USER_WORK_MASK
-       beq     restore_user
+       beq     restore
 do_user_signal:                        /* r10 contains MSR_KERNEL here */
        ori     r10,r10,MSR_EE
        SYNC

Tiejun

Thanks
Tiejun
