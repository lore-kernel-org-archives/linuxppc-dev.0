Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp05.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C789B2C00C0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Apr 2013 18:18:00 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Mon, 29 Apr 2013 18:12:51 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 8A2342CE804A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Apr 2013 18:17:55 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3T8HmW123396602
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Apr 2013 18:17:49 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3T8HslS002335
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Apr 2013 18:17:54 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: Fix missing doorbell IPIs during nap power saving
Date: Mon, 29 Apr 2013 18:17:40 +1000
Message-Id: <1367223460-4931-1-git-send-email-imunsie@au1.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Ian Munsie <imunsie@au1.ibm.com>,
 stable@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

If a doorbell IPI comes in while a thread is in nap power saving, the
doorbell interrupt won't be replayed by the hardware since it is edge
sensitive. Currently we are not replaying these interrupts in software,
which can cause threads to miss IPIs that come in during power saving
and eventually will result in an RCU warning from rcu_sched that it has
detected a stalled CPU.

This patch fixes the issue by testing if a doorbell caused the thread to
come out of power saving and sets the corresponding bit in the paca to
indicate a doorbell happened, which will then be handled by the existing
interrupt replay code.

This is not an issue with other interrupts that can wake a thread
(external, decrementer) as they are level sensitive and will continue to
be asserted by the hardware.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 arch/powerpc/include/asm/reg.h    |    5 ++++-
 arch/powerpc/kernel/idle_power7.S |   23 +++++++++++++++++++----
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 5c6fbe2..dd8a071 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -549,14 +549,17 @@
 #define   SRR1_ISI_NOPT		0x40000000 /* ISI: Not found in hash */
 #define   SRR1_ISI_N_OR_G	0x10000000 /* ISI: Access is no-exec or G */
 #define   SRR1_ISI_PROT		0x08000000 /* ISI: Other protection fault */
-#define   SRR1_WAKEMASK		0x00380000 /* reason for wakeup */
+#define   SRR1_WAKEMASK		0x003c0000 /* reason for wakeup [42:45] */
+#define   SRR1_WAKESHIFT	18
 #define   SRR1_WAKESYSERR	0x00300000 /* System error */
 #define   SRR1_WAKEEE		0x00200000 /* External interrupt */
 #define   SRR1_WAKEMT		0x00280000 /* mtctrl */
 #define	  SRR1_WAKEHMI		0x00280000 /* Hypervisor maintenance */
 #define   SRR1_WAKEDEC		0x00180000 /* Decrementer interrupt */
+#define   SRR1_WAKEDBELLP	0x00140000 /* Privileged Doorbell */
 #define   SRR1_WAKETHERM	0x00100000 /* Thermal management interrupt */
 #define	  SRR1_WAKERESET	0x00100000 /* System reset */
+#define   SRR1_WAKEDBELLH	0x000c0000 /* Hypervisor Doorbell */
 #define	  SRR1_WAKESTATE	0x00030000 /* Powersave exit mask [46:47] */
 #define	  SRR1_WS_DEEPEST	0x00030000 /* Some resources not maintained,
 					  * may not be recoverable */
diff --git a/arch/powerpc/kernel/idle_power7.S b/arch/powerpc/kernel/idle_power7.S
index e11863f..c80bb4b 100644
--- a/arch/powerpc/kernel/idle_power7.S
+++ b/arch/powerpc/kernel/idle_power7.S
@@ -108,9 +108,7 @@ _GLOBAL(power7_wakeup_loss)
 	ld	r5,_NIP(r1)
 	addi	r1,r1,INT_FRAME_SIZE
 	mtcr	r3
-	mtspr	SPRN_SRR1,r4
-	mtspr	SPRN_SRR0,r5
-	rfid
+	b	power7_wakeup_common
 
 _GLOBAL(power7_wakeup_noloss)
 	lbz	r0,PACA_NAPSTATELOST(r13)
@@ -120,6 +118,23 @@ _GLOBAL(power7_wakeup_noloss)
 	ld	r4,_MSR(r1)
 	ld	r5,_NIP(r1)
 	addi	r1,r1,INT_FRAME_SIZE
-	mtspr	SPRN_SRR1,r4
+	/* Fall through */
+
+power7_wakeup_common:
+BEGIN_FTR_SECTION
+	mfspr	r3,SPRN_SRR1
+	extrdi	r3,r3,4,42 /* Extract SRR1_WAKEMASK */
+	cmpwi	r3,SRR1_WAKEDBELLH >> SRR1_WAKESHIFT
+	beq	1f
+	cmpwi	r3,SRR1_WAKEDBELLP >> SRR1_WAKESHIFT
+	bne	2f
+
+1:	/* Woken by a doorbell, set doorbell happened in paca */
+	lbz	r3,PACAIRQHAPPENED(r13)
+	ori	r3,r3,PACA_IRQ_DBELL
+	stb	r3,PACAIRQHAPPENED(r13)
+END_FTR_SECTION_IFSET(CPU_FTR_DBELL)
+
+2:	mtspr   SPRN_SRR1,r4
 	mtspr	SPRN_SRR0,r5
 	rfid
-- 
1.7.10.4
