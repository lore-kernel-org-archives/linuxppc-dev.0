Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17471.62187.774127.783000@cargo.ozlabs.ibm.com>
Date: Fri, 14 Apr 2006 12:07:23 -0700
From: Paul Mackerras <paulus@samba.org>
To: Becky Bruce <Becky.Bruce@freescale.com>
Subject: Re: 7447A strange problem with MSR:POW (WAS: can't boot 2.6.17-rc1)
In-Reply-To: <21F7D7D8-B9BC-44EB-B07B-F888D89DCF25@freescale.com>
References: <Pine.LNX.4.44.0604071010290.18017-100000@zirkon.biophys.uni-duesseldorf.de>
	<1144408805.30891.42.camel@localhost.localdomain>
	<17463.9759.442768.685153@cargo.ozlabs.ibm.com>
	<1144923633.4935.11.camel@localhost.localdomain>
	<21F7D7D8-B9BC-44EB-B07B-F888D89DCF25@freescale.com>
Cc: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
	debian-powerpc@lists.debian.org,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Becky Bruce writes:

> Actually, I think the problem is that the code linux is using to turn  
> on nap mode is not guaranteed to put the processor in nap mode by the  
> time the blr in ppc6xx_idle occurs.

Thanks, Becky.

This patch fixes it for me.  Comments, anyone?

Paul.

diff -urN powerpc-merge/arch/powerpc/kernel/idle_6xx.S pmac-2.6.17-rc1/arch/powerpc/kernel/idle_6xx.S
--- powerpc-merge/arch/powerpc/kernel/idle_6xx.S	2006-04-04 23:09:16.000000000 -0700
+++ pmac-2.6.17-rc1/arch/powerpc/kernel/idle_6xx.S	2006-04-14 10:29:54.000000000 -0700
@@ -151,41 +151,47 @@
 	isync
 	mtmsr	r7
 	isync
-	sync
-	blr
+1:	b	1b
 	
 /*
  * Return from NAP/DOZE mode, restore some CPU specific registers,
  * we are called with DR/IR still off and r2 containing physical
- * address of current.
+ * address of current.  R11 and CR contain HID0.  We have to preserve
+ * r10 and r12.
  */
 _GLOBAL(power_save_6xx_restore)
+	tophys(r11, r1)		/* Make the idle task do a blr */
+	lwz	r9,_LINK(r11)
+	stw	r9,_NIP(r11)
 	mfspr	r11,SPRN_HID0
-	rlwinm.	r11,r11,0,10,8	/* Clear NAP & copy NAP bit !state to cr1 EQ */
-	cror	4*cr1+eq,4*cr0+eq,4*cr0+eq
+	rlwinm	r11,r11,0,10,8	/* Clear NAP */
 BEGIN_FTR_SECTION
 	rlwinm	r11,r11,0,9,7	/* Clear DOZE */
 END_FTR_SECTION_IFSET(CPU_FTR_CAN_DOZE)
 	mtspr	SPRN_HID0, r11
 
 #ifdef DEBUG
-	beq	cr1,1f
+	bf	9,1f
 	lis	r11,(nap_return_count-KERNELBASE)@ha
 	lwz	r9,nap_return_count@l(r11)
 	addi	r9,r9,1
 	stw	r9,nap_return_count@l(r11)
 1:
 #endif
-	
+
+#ifdef CONFIG_SMP
 	rlwinm	r9,r1,0,0,18
 	tophys(r9,r9)
 	lwz	r11,TI_CPU(r9)
 	slwi	r11,r11,2
+#else
+	li	r11,0
+#endif
 	/* Todo make sure all these are in the same page
-	 * and load r22 (@ha part + CPU offset) only once
+	 * and load r11 (@ha part + CPU offset) only once
 	 */
 BEGIN_FTR_SECTION
-	beq	cr1,1f
+	bf	9,1f
 	addis	r9,r11,(nap_save_msscr0-KERNELBASE)@ha
 	lwz	r9,nap_save_msscr0@l(r9)
 	mtspr	SPRN_MSSCR0, r9
