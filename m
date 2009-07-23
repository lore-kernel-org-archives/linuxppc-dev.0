Return-Path: <benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 0B36CB7079
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 23 Jul 2009 15:59:50 +1000 (EST)
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 23 Jul 2009 15:59:38 +1000
Subject: [PATCH 2/20] powerpc/of: Remove useless register save/restore when
	calling OF back
Message-Id: <20090723055949.F1844DDD1B@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

enter_prom() used to save and restore registers such as CTR, XER etc..
which are volatile, or SRR0,1... which we don't care about. This
removes a bunch of useless code and while at it turns an mtmsrd into
an MTMSRD macro which will be useful to Book3E.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/entry_64.S |   38 ++++++--------------------------------
 1 file changed, 6 insertions(+), 32 deletions(-)

--- linux-work.orig/arch/powerpc/kernel/entry_64.S	2009-07-22 15:20:26.000000000 +1000
+++ linux-work/arch/powerpc/kernel/entry_64.S	2009-07-22 15:22:44.000000000 +1000
@@ -823,30 +823,17 @@ _GLOBAL(enter_prom)
 	 * of all registers that it saves.  We therefore save those registers
 	 * PROM might touch to the stack.  (r0, r3-r13 are caller saved)
    	 */
-	SAVE_8GPRS(2, r1)
+	SAVE_GPR(2, r1)
 	SAVE_GPR(13, r1)
 	SAVE_8GPRS(14, r1)
 	SAVE_10GPRS(22, r1)
-	mfcr	r4
-	std	r4,_CCR(r1)
-	mfctr	r5
-	std	r5,_CTR(r1)
-	mfspr	r6,SPRN_XER
-	std	r6,_XER(r1)
-	mfdar	r7
-	std	r7,_DAR(r1)
-	mfdsisr	r8
-	std	r8,_DSISR(r1)
-	mfsrr0	r9
-	std	r9,_SRR0(r1)
-	mfsrr1	r10
-	std	r10,_SRR1(r1)
+	mfcr	r10
 	mfmsr	r11
+	std	r10,_CCR(r1)
 	std	r11,_MSR(r1)
 
 	/* Get the PROM entrypoint */
-	ld	r0,GPR4(r1)
-	mtlr	r0
+	mtlr	r4
 
 	/* Switch MSR to 32 bits mode
 	 */
@@ -860,8 +847,7 @@ _GLOBAL(enter_prom)
         mtmsrd  r11
         isync
 
-	/* Restore arguments & enter PROM here... */
-	ld	r3,GPR3(r1)
+	/* Enter PROM here... */
 	blrl
 
 	/* Just make sure that r1 top 32 bits didn't get
@@ -871,7 +857,7 @@ _GLOBAL(enter_prom)
 
 	/* Restore the MSR (back to 64 bits) */
 	ld	r0,_MSR(r1)
-	mtmsrd	r0
+	MTMSRD(r0)
         isync
 
 	/* Restore other registers */
@@ -881,18 +867,6 @@ _GLOBAL(enter_prom)
 	REST_10GPRS(22, r1)
 	ld	r4,_CCR(r1)
 	mtcr	r4
-	ld	r5,_CTR(r1)
-	mtctr	r5
-	ld	r6,_XER(r1)
-	mtspr	SPRN_XER,r6
-	ld	r7,_DAR(r1)
-	mtdar	r7
-	ld	r8,_DSISR(r1)
-	mtdsisr	r8
-	ld	r9,_SRR0(r1)
-	mtsrr0	r9
-	ld	r10,_SRR1(r1)
-	mtsrr1	r10
 	
         addi	r1,r1,PROM_FRAME_SIZE
 	ld	r0,16(r1)
