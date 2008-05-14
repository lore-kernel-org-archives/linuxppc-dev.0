Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18474.27384.524310.787499@cargo.ozlabs.ibm.com>
Date: Wed, 14 May 2008 14:30:48 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Defer processing of interrupts when the CPU wakes from sleep
	mode
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This provides a way to defer processing of an interrupt that wakes the
processor out of sleep mode.  On 32-bit platforms that use an
interrupt to wake the processor, we have to have interrupts enabled in
hardware at the point where we go to sleep, otherwise the processor
will never wake up.  However, because interrupts are logically
disabled at this point, we don't want to process the interrupt
straight away.

This is handled by setting the _TLF_SLEEPING flag.  When we get an
interrupt and _TLF_SLEEPING is set, we firstly clear the MSR_EE
(external interrupt enable) bit in the saved MSR value, and secondly
we then return to the address in the link register, like we do for
_TLF_NAPPING, but without actually handling the interrupt.

Note that this is handled somewhat differently on powerbooks, so this
new code will only be used on non-Apple machines.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 84c8686..162500f 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -146,6 +146,7 @@ transfer_to_handler:
 	lwz	r12,TI_LOCAL_FLAGS(r9)
 	mtcrf	0x01,r12
 	bt-	31-TLF_NAPPING,4f
+	bt-	31-TLF_SLEEPING,7f
 #endif /* CONFIG_6xx */
 	.globl transfer_to_handler_cont
 transfer_to_handler_cont:
@@ -163,6 +164,13 @@ transfer_to_handler_cont:
 4:	rlwinm	r12,r12,0,~_TLF_NAPPING
 	stw	r12,TI_LOCAL_FLAGS(r9)
 	b	power_save_6xx_restore
+
+7:	rlwinm	r12,r12,0,~_TLF_SLEEPING
+	stw	r12,TI_LOCAL_FLAGS(r9)
+	lwz	r9,_MSR(r11)		/* if sleeping, clear MSR.EE */
+	rlwinm	r9,r9,0,~MSR_EE
+	lwz	r12,_LINK(r11)		/* and return to address in LR */
+	b	fast_exception_return
 #endif
 
 /*
diff --git a/include/asm-powerpc/thread_info.h b/include/asm-powerpc/thread_info.h
index d030f5c..1cd8c8f 100644
--- a/include/asm-powerpc/thread_info.h
+++ b/include/asm-powerpc/thread_info.h
@@ -147,8 +147,10 @@ static inline struct thread_info *current_thread_info(void)
 /* Bits in local_flags */
 /* Don't move TLF_NAPPING without adjusting the code in entry_32.S */
 #define TLF_NAPPING		0	/* idle thread enabled NAP mode */
+#define TLF_SLEEPING		1	/* suspend code enabled SLEEP mode */
 
 #define _TLF_NAPPING		(1 << TLF_NAPPING)
+#define _TLF_SLEEPING		(1 << TLF_SLEEPING)
 
 #endif /* __KERNEL__ */
 
