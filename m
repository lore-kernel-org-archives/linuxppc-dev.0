Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 88E571A01ED
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jul 2014 23:10:20 +1000 (EST)
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DC3631400B5
 for <linuxppc-dev@ozlabs.org>; Tue, 29 Jul 2014 23:10:19 +1000 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Tue, 29 Jul 2014 18:40:18 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 95770125804F
 for <linuxppc-dev@ozlabs.org>; Tue, 29 Jul 2014 18:40:12 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6TDAZ3g23331030
 for <linuxppc-dev@ozlabs.org>; Tue, 29 Jul 2014 18:40:35 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6TDAERI020216
 for <linuxppc-dev@ozlabs.org>; Tue, 29 Jul 2014 18:40:14 +0530
Subject: [PATCH 3/3] powerpc/book3s: handle HMIs for cpus in nap mode.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 29 Jul 2014 18:40:13 +0530
Message-ID: <20140729131012.13492.75311.stgit@mars>
In-Reply-To: <20140729130900.13492.85976.stgit@mars>
References: <20140729130900.13492.85976.stgit@mars>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

HMIs are thread specific and can come while thread is in sleep/nap mode.
Hence with SMT=off mode we can receive HMIs on sleeping threads. For
interrupt received in nap mode, cpu wakes up at system reset vector, clears
the interrupt and go back to nap mode again. But HMIs are sticky and they
keep happening until we clear reason bits from HMER. Hence add a special
check for HMI in reset vector (through power7_wakeup_* functions) and
invoke opal call to handle HMI.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/idle_power7.S |   32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/powerpc/kernel/idle_power7.S b/arch/powerpc/kernel/idle_power7.S
index 5cf3d36..06305f6 100644
--- a/arch/powerpc/kernel/idle_power7.S
+++ b/arch/powerpc/kernel/idle_power7.S
@@ -135,10 +135,36 @@ _GLOBAL(power7_sleep)
 	b	power7_powersave_common
 	/* No return */
 
+#define CHECK_HMI_INTERRUPT						\
+	mfspr	r0,SPRN_SRR1;						\
+BEGIN_FTR_SECTION_NESTED(66);						\
+	rlwinm	r0,r0,45-31,0xf;  /* extract wake reason field (P8) */	\
+FTR_SECTION_ELSE_NESTED(66);						\
+	rlwinm	r0,r0,45-31,0xe;  /* P7 wake reason field is 3 bits */	\
+ALT_FTR_SECTION_END_NESTED_IFSET(CPU_FTR_ARCH_207S, 66);		\
+	cmpwi	r0,0xa;			/* Hypervisor maintenance ? */	\
+	bne	20f;							\
+	/* Invoke opal call to handle hmi */				\
+	ld	r2,PACATOC(r13);					\
+	ld	r1,PACAR1(r13);						\
+	std	r3,ORIG_GPR3(r1);	/* Save original r3 */		\
+	li	r0,OPAL_HANDLE_HMI;					\
+	LOAD_REG_ADDR(r11,opal);					\
+	ld	r12,8(r11);						\
+	ld	r2,0(r11);						\
+	mtctr	r12;							\
+	bctrl;								\
+	ld	r3,ORIG_GPR3(r1);	/* Restore original r3 */	\
+20:	nop;
+
+
 _GLOBAL(power7_wakeup_tb_loss)
 	ld	r2,PACATOC(r13);
 	ld	r1,PACAR1(r13)
 
+BEGIN_FTR_SECTION
+	CHECK_HMI_INTERRUPT
+END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
 	/* Time base re-sync */
 	li	r0,OPAL_RESYNC_TIMEBASE
 	LOAD_REG_ADDR(r11,opal);
@@ -163,6 +189,9 @@ _GLOBAL(power7_wakeup_tb_loss)
 
 _GLOBAL(power7_wakeup_loss)
 	ld	r1,PACAR1(r13)
+BEGIN_FTR_SECTION
+	CHECK_HMI_INTERRUPT
+END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
 	REST_NVGPRS(r1)
 	REST_GPR(2, r1)
 	ld	r3,_CCR(r1)
@@ -178,6 +207,9 @@ _GLOBAL(power7_wakeup_noloss)
 	lbz	r0,PACA_NAPSTATELOST(r13)
 	cmpwi	r0,0
 	bne	power7_wakeup_loss
+BEGIN_FTR_SECTION
+	CHECK_HMI_INTERRUPT
+END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
 	ld	r1,PACAR1(r13)
 	ld	r4,_MSR(r1)
 	ld	r5,_NIP(r1)
