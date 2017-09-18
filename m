Return-Path: <santosh@fossix.org>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xwgYH5DlKzDr3H
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Sep 2017 19:23:47 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id v82so4954819pgb.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Sep 2017 02:23:47 -0700 (PDT)
From: Santosh Sivaraj <santosh@fossix.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <fweisbec@gmail.com>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: [PATCH 1/2] powerpc/vdso64: Coarse timer support preparatory patch
Date: Mon, 18 Sep 2017 14:53:35 +0530
Message-Id: <20170918092336.21912-1-santosh@fossix.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Reorganize code to make it easy to introduce CLOCK_REALTIME_COARSE and
CLOCK_MONOTONIC_COARSE timer support.

Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
---
 arch/powerpc/kernel/vdso64/gettimeofday.S | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/vdso64/gettimeofday.S b/arch/powerpc/kernel/vdso64/gettimeofday.S
index 382021324883..a0b4943811db 100644
--- a/arch/powerpc/kernel/vdso64/gettimeofday.S
+++ b/arch/powerpc/kernel/vdso64/gettimeofday.S
@@ -60,18 +60,20 @@ V_FUNCTION_END(__kernel_gettimeofday)
  */
 V_FUNCTION_BEGIN(__kernel_clock_gettime)
   .cfi_startproc
+	mr	r11,r4			/* r11 saves tp */
+	mflr	r12			/* r12 saves lr */
+	lis	r7,NSEC_PER_SEC@h	/* want nanoseconds */
+	ori	r7,r7,NSEC_PER_SEC@l
+
 	/* Check for supported clock IDs */
 	cmpwi	cr0,r3,CLOCK_REALTIME
 	cmpwi	cr1,r3,CLOCK_MONOTONIC
 	cror	cr0*4+eq,cr0*4+eq,cr1*4+eq
-	bne	cr0,99f
+	beq	cr0,49f
 
-	mflr	r12			/* r12 saves lr */
+	b	99f		/* Fallback to syscall */
   .cfi_register lr,r12
-	mr	r11,r4			/* r11 saves tp */
-	bl	V_LOCAL_FUNC(__get_datapage)	/* get data page */
-	lis	r7,NSEC_PER_SEC@h	/* want nanoseconds */
-	ori	r7,r7,NSEC_PER_SEC@l
+49:	bl	V_LOCAL_FUNC(__get_datapage)	/* get data page */
 50:	bl	V_LOCAL_FUNC(__do_get_tspec)	/* get time from tb & kernel */
 	bne	cr1,80f			/* if not monotonic, all done */
 
-- 
2.13.5
