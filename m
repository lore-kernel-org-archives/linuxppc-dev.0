Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 0DC54DDEFB
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Apr 2007 09:19:18 +1000 (EST)
Date: Sun, 22 Apr 2007 18:38:21 -0500
To: paulus@samba.org
Subject: [PATCH] [v2] powerpc: save trap number in bad_stack
Message-ID: <20070422233821.GB28479@lixom.net>
References: <20070416062347.GA20196@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070416062347.GA20196@lixom.net>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Save the trap number in the case of getting a bad stack in an exception
handler. It is sometimes useful to know what exception it was that caused
this to happen. Without this, no trap is reported.

Signed-off-by: Olof Johansson <olof@lixom.net>

---

Changes since last time: Reduce to a u16 and move it.

Index: powerpc/arch/powerpc/kernel/asm-offsets.c
===================================================================
--- powerpc.orig/arch/powerpc/kernel/asm-offsets.c
+++ powerpc/arch/powerpc/kernel/asm-offsets.c
@@ -139,6 +139,7 @@ int main(void)
 	DEFINE(PACA_SYSTEM_TIME, offsetof(struct paca_struct, system_time));
 	DEFINE(PACA_SLBSHADOWPTR, offsetof(struct paca_struct, slb_shadow_ptr));
 	DEFINE(PACA_DATA_OFFSET, offsetof(struct paca_struct, data_offset));
+	DEFINE(PACA_TRAP_SAVE, offsetof(struct paca_struct, trap_save));
 
 	DEFINE(SLBSHADOW_STACKVSID,
 	       offsetof(struct slb_shadow, save_area[SLB_NUM_BOLTED - 1].vsid));
Index: powerpc/include/asm-powerpc/paca.h
===================================================================
--- powerpc.orig/include/asm-powerpc/paca.h
+++ powerpc/include/asm-powerpc/paca.h
@@ -68,6 +68,7 @@ struct paca_struct {
 	void *emergency_sp;		/* pointer to emergency stack */
 	u64 data_offset;		/* per cpu data offset */
 	s16 hw_cpu_id;			/* Physical processor number */
+	u16 trap_save;			/* Used when bad stack is encountered */
 	u8 cpu_start;			/* At startup, processor spins until */
 					/* this becomes non-zero. */
 	struct slb_shadow *slb_shadow_ptr;
Index: powerpc/arch/powerpc/kernel/head_64.S
===================================================================
--- powerpc.orig/arch/powerpc/kernel/head_64.S
+++ powerpc/arch/powerpc/kernel/head_64.S
@@ -278,8 +278,12 @@ exception_marker:
 	beq-	1f;							   \
 	ld	r1,PACAKSAVE(r13);	/* kernel stack to use		*/ \
 1:	cmpdi	cr1,r1,0;		/* check if r1 is in userspace	*/ \
-	bge-	cr1,bad_stack;		/* abort if it is		*/ \
-	std	r9,_CCR(r1);		/* save CR in stackframe	*/ \
+	bge-	cr1,2f;			/* abort if it is		*/ \
+	b	3f;							   \
+2:	li	r1,(n);			/* will be reloaded later	*/ \
+	stw	r1,PACA_TRAP_SAVE(r13);					   \
+	b	bad_stack;						   \
+3:	std	r9,_CCR(r1);		/* save CR in stackframe	*/ \
 	std	r11,_NIP(r1);		/* save SRR0 in stackframe	*/ \
 	std	r12,_MSR(r1);		/* save SRR1 in stackframe	*/ \
 	std	r10,0(r1);		/* make stack chain pointer	*/ \
@@ -940,6 +944,8 @@ bad_stack:
 	SAVE_2GPRS(7,r1)
 	SAVE_10GPRS(12,r1)
 	SAVE_10GPRS(22,r1)
+	lwz	r12,PACA_TRAP_SAVE(r13)
+	std	r12,_TRAP(r1)
 	addi	r11,r1,INT_FRAME_SIZE
 	std	r11,0(r1)
 	li	r12,0
