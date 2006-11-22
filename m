Return-Path: <SRS0+0ad9d235d7a363f6c08f+1186+infradead.org+dwmw2@canuck.srs.infradead.org>
Received: from canuck.infradead.org (canuck.infradead.org [209.217.80.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 657C5679FD
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Nov 2006 22:03:27 +1100 (EST)
Received: from pmac.infradead.org ([81.187.2.168])
	by canuck.infradead.org with esmtpsa (Exim 4.62 #1 (Red Hat Linux))
	id 1Gmpsv-0006Ei-Ti
	for linuxppc-dev@ozlabs.org; Wed, 22 Nov 2006 06:03:23 -0500
Subject: Re: [RFC] Firefox/PPC64 support
From: David Woodhouse <dwmw2@infradead.org>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <1164182413.19448.108.camel@pmac.infradead.org>
References: <1164182413.19448.108.camel@pmac.infradead.org>
Content-Type: text/plain
Date: Wed, 22 Nov 2006 11:03:18 +0000
Message-Id: <1164193398.19448.113.camel@pmac.infradead.org>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-11-22 at 08:00 +0000, David Woodhouse wrote:
> My understanding of the PPC64 C++ ABI is largely empirical. Could
> someone else glance over the attached patch which adds ppc64 support to
> firefox?

Bug #1: I wasn't ensuring that the stack pointer remained aligned to 16
bytes in XPTC_InvokeByIndex(). Fixed (and use of r28 eliminated since I
didn't use it in the end as I intended to) thus:

(full updated patch at http://david.woodhou.se/firefox-1.5-ppc64.patch)

--- mozilla/xpcom/reflect/xptcall/src/md/unix/xptcinvoke_asm_ppc64_linux.s~	2006-11-21 18:11:30.000000000 +0000
+++ mozilla/xpcom/reflect/xptcall/src/md/unix/xptcinvoke_asm_ppc64_linux.s	2006-11-22 10:43:26.000000000 +0000
@@ -18,6 +18,7 @@
 // Rights Reserved.
 //
 // Contributor(s):
+//   dwmw2@infradead.org (David Woodhouse)
 //   Franz.Sirl-kernel@lauterbach.com (Franz Sirl)
 //   beard@netscape.com (Patrick Beard)
 //   waterson@netscape.com (Chris Waterson)
@@ -58,7 +59,6 @@ XPTC_InvokeByIndex:
         mflr	0
 	std	0,16(r1)
 	
-        std	r28,-32(r1)
         std	r29,-24(r1)
 	std	r30,-16(r1)
         std	r31,-8(r1)
@@ -67,17 +67,19 @@ XPTC_InvokeByIndex:
 	mr	r30,r4			// Save 'methodIndex' in r30
 	mr	r31,r1			// Save old frame
 
-	// Allocate stack frame with space for params
-	
-	sldi	r28,r5,3		// Max. 8 bytes per parameter
-	addi	r28,r28,128+(24*8)	// Standard frame, 15 dwords for GP/FP, 4 for r28-r31
-	neg	r28,r28
-	stdux	r1,r1,r28
+	// Allocate stack frame with space for params. Since at least the
+	// first 7 parameters (not including 'that') will be in registers,
+	// we don't actually need stack space for those. Start by rounding
+	// down to make sure the stack remains 16-byte aligned.
+
+	rldicr	r7,r5,r5,59		// r7 = (r3 << 3) & ~15
+	addi	r7,r7,128+(18*8)	// Standard frame, 7 dwords for GPR,
+					// 13 dwords for FPR, 3 for r29-r31,
+					// less 5 of the extra unused params
+	neg	r7,r7
+	stdux	r1,r1,r7
 
 	
-	addi	r28,r1,112		// Stack parameter area.
-
-
 	// Call invoke_copy_to_stack(PRUint64* gpregs, double* fpregs,
         //			     PRUint32 paramCount, nsXPTCVariant* s, 
         //			     PRUint64* d))
@@ -135,8 +137,7 @@ XPTC_InvokeByIndex:
         ld	r2,40(r1)	// Load our own TOC pointer
         ld	r1,0(r1)	// Revert stack frame
         ld	0,16(r1)	// Reload lr
-        ld	28,-32(r1)	// Restore NVGPRS
-        ld	29,-24(r1)
+        ld	29,-24(r1)	// Restore NVGPRS
         ld	30,-16(r1)
         ld	31,-8(r1)
         mtlr	0


-- 
dwmw2
