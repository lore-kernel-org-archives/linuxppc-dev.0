Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5BE4C1A01ED
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jul 2014 22:48:23 +1000 (EST)
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 24E9B1400AB
 for <linuxppc-dev@ozlabs.org>; Thu, 31 Jul 2014 22:48:23 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Thu, 31 Jul 2014 22:48:20 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 5CC322BB0023
 for <linuxppc-dev@ozlabs.org>; Thu, 31 Jul 2014 22:48:17 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6VCVBLQ55640200
 for <linuxppc-dev@ozlabs.org>; Thu, 31 Jul 2014 22:31:11 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6VCmG9c005851
 for <linuxppc-dev@ozlabs.org>; Thu, 31 Jul 2014 22:48:16 +1000
Subject: [PATCH] powerpc/book3s: Fix endianess issue for HMI handling on
 napping cpus.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>, Anton Blanchard <anton@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 31 Jul 2014 18:17:52 +0530
Message-ID: <20140731124559.14554.65074.stgit@mars>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: preeti@linux.vnet.ibm.com, shreyas@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

(NOTE: This patch depends on upstream HMI handling patchset at
 https://lists.ozlabs.org/pipermail/linuxppc-dev/2014-July/119731.html)

The current HMI handling on napping cpus does not take care of endianess
issue. On LE host kernel when we wake up from nap due to HMI interrupt we
would checkstop while jumping into opal call. There is a similar issue in
case of fast sleep wakeup where the code invokes opal_resync_tb opal call
without handling LE issue. This patch fixes that as well.

With this patch applied, HMIs handling on LE host kernel works fine.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/idle_power7.S |   49 ++++++++++++++++++++++++++++---------
 1 file changed, 37 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kernel/idle_power7.S b/arch/powerpc/kernel/idle_power7.S
index 06305f6..be05841 100644
--- a/arch/powerpc/kernel/idle_power7.S
+++ b/arch/powerpc/kernel/idle_power7.S
@@ -135,6 +135,39 @@ _GLOBAL(power7_sleep)
 	b	power7_powersave_common
 	/* No return */
 
+/*
+ * Make opal call in realmode. This is a generic function to be called
+ * from realmode from reset vector. It handles endianess.
+ *
+ * r13 - paca pointer
+ * r1  - stack pointer
+ * r3  - opal token
+ */
+opal_call_realmode:
+	mflr	r12
+	std	r12,_LINK(r1)
+	ld	r2,PACATOC(r13)
+	/* Set opal return address */
+	LOAD_REG_ADDR(r0,return_from_opal_call)
+	mtlr	r0
+	/* Handle endian-ness */
+	li	r0,MSR_LE
+	mfmsr	r12
+	andc	r12,r12,r0
+	mtspr	SPRN_HSRR1,r12
+	mr	r0,r3			/* Move opal token to r0 */
+	LOAD_REG_ADDR(r11,opal)
+	ld	r12,8(r11)
+	ld	r2,0(r11)
+	mtspr	SPRN_HSRR0,r12
+	hrfid
+
+return_from_opal_call:
+	FIXUP_ENDIAN
+	ld	r0,_LINK(r1)
+	mtlr	r0
+	blr
+
 #define CHECK_HMI_INTERRUPT						\
 	mfspr	r0,SPRN_SRR1;						\
 BEGIN_FTR_SECTION_NESTED(66);						\
@@ -148,12 +181,8 @@ ALT_FTR_SECTION_END_NESTED_IFSET(CPU_FTR_ARCH_207S, 66);		\
 	ld	r2,PACATOC(r13);					\
 	ld	r1,PACAR1(r13);						\
 	std	r3,ORIG_GPR3(r1);	/* Save original r3 */		\
-	li	r0,OPAL_HANDLE_HMI;					\
-	LOAD_REG_ADDR(r11,opal);					\
-	ld	r12,8(r11);						\
-	ld	r2,0(r11);						\
-	mtctr	r12;							\
-	bctrl;								\
+	li	r3,OPAL_HANDLE_HMI;	/* Pass opal token argument*/	\
+	bl	opal_call_realmode;					\
 	ld	r3,ORIG_GPR3(r1);	/* Restore original r3 */	\
 20:	nop;
 
@@ -166,12 +195,8 @@ BEGIN_FTR_SECTION
 	CHECK_HMI_INTERRUPT
 END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
 	/* Time base re-sync */
-	li	r0,OPAL_RESYNC_TIMEBASE
-	LOAD_REG_ADDR(r11,opal);
-	ld	r12,8(r11);
-	ld	r2,0(r11);
-	mtctr	r12
-	bctrl
+	li	r3,OPAL_RESYNC_TIMEBASE
+	bl	opal_call_realmode;
 
 	/* TODO: Check r3 for failure */
 
