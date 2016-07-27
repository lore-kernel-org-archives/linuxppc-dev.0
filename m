Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rzmsW4jH9zDr17
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 17:32:15 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id h186so1342490pfg.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 00:32:15 -0700 (PDT)
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] Make system_reset_pSeries relocatable
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, paulus@samba.org,
 npiggin@gmail.com, svaidy@linux.vnet.ibm.com
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <48aad8b6-a27f-44c5-2b0b-f276595e9c04@gmail.com>
Date: Wed, 27 Jul 2016 17:32:06 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


From: Balbir Singh <bsingharora@gmail.com>

Currently the power management bits are broken w.r.t. relocation.
There are direct branches from system_reset_pSeries to
power7_wakeup_*. The correct way to do it is to do what
the slb miss handler does, which is jump to a small stub within
the first 64k of the relocated address and then jump to the
actual location.

The code has been lightly tested (not the kvm bits), I would highly
appreciate a review of the code. I suspect there might be easy
to find bugs :)

Cc: benh@kernel.crashing.org
Cc: mpe@ellerman.id.au
Cc: paulus@samba.org
Cc: npiggin@gmail.com
Cc: svaidy@linux.vnet.ibm.com

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 82 ++++++++++++++++++++++--------------
 1 file changed, 51 insertions(+), 31 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 8bcc1b4..64f9650 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -118,39 +118,21 @@ BEGIN_FTR_SECTION
 	cmpwi	cr4,r5,1
 	mtspr	SPRN_HSPRG0,r13
 
-	lbz	r0,PACA_THREAD_IDLE_STATE(r13)
-	cmpwi   cr2,r0,PNV_THREAD_NAP
-	bgt     cr2,8f				/* Either sleep or Winkle */
-
-	/* Waking up from nap should not cause hypervisor state loss */
-	bgt	cr3,.
-
-	/* Waking up from nap */
-	li	r0,PNV_THREAD_RUNNING
-	stb	r0,PACA_THREAD_IDLE_STATE(r13)	/* Clear thread state */
-
-#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
-	li	r0,KVM_HWTHREAD_IN_KERNEL
-	stb	r0,HSTATE_HWTHREAD_STATE(r13)
-	/* Order setting hwthread_state vs. testing hwthread_req */
-	sync
-	lbz	r0,HSTATE_HWTHREAD_REQ(r13)
-	cmpwi	r0,0
-	beq	1f
-	b	kvm_start_guest
-1:
+#ifndef CONFIG_RELOCATABLE
+	b	power7_wakeup_common
+#else
+	/*
+	 * We can't just use a direct branch to power7_wakeup_common
+	 * because the distance from here to there depends on where
+	 * the kernel ends up being put.
+	 */
+	mfctr	r11
+	ld	r10, PACAKBASE(r13)
+	LOAD_HANDLER(r10, power7_wakeup_common)
+	mtctr	r10
+	bctr
 #endif
 
-	/* Return SRR1 from power7_nap() */
-	mfspr	r3,SPRN_SRR1
-	beq	cr3,2f
-	b	power7_wakeup_noloss
-2:	b	power7_wakeup_loss
-
-	/* Fast Sleep wakeup on PowerNV */
-8:	GET_PACA(r13)
-	b 	power7_wakeup_tb_loss
-
 9:
 END_FTR_SECTION_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_206)
 #endif /* CONFIG_PPC_P7_NAP */
@@ -1448,6 +1430,44 @@ power4_fixup_nap:
 	blr
 #endif
 
+	.align 7
+_GLOBAL(power7_wakeup_common)
+#ifdef CONFIG_RELOCATABLE
+	mtctr	r11
+#endif
+	lbz	r0,PACA_THREAD_IDLE_STATE(r13)
+	cmpwi   cr2,r0,PNV_THREAD_NAP
+	bgt     cr2,8f				/* Either sleep or Winkle */
+
+	/* Waking up from nap should not cause hypervisor state loss */
+	bgt	cr3,.
+
+	/* Waking up from nap */
+	li	r0,PNV_THREAD_RUNNING
+	stb	r0,PACA_THREAD_IDLE_STATE(r13)	/* Clear thread state */
+
+#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
+	li	r0,KVM_HWTHREAD_IN_KERNEL
+	stb	r0,HSTATE_HWTHREAD_STATE(r13)
+	/* Order setting hwthread_state vs. testing hwthread_req */
+	sync
+	lbz	r0,HSTATE_HWTHREAD_REQ(r13)
+	cmpwi	r0,0
+	beq	1f
+	b	kvm_start_guest
+1:
+#endif
+
+	/* Return SRR1 from power7_nap() */
+	mfspr	r3,SPRN_SRR1
+	beq	cr3,2f
+	b	power7_wakeup_noloss
+2:	b	power7_wakeup_loss
+
+	/* Fast Sleep wakeup on PowerNV */
+8:	GET_PACA(r13)
+	b 	power7_wakeup_tb_loss
+
 /*
  * Hash table stuff
  */
-- 
2.5.5
