Message-ID: <006601c2f256$e6ff5e80$020120b0@jockeXP>
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Tom Rini" <trini@kernel.crashing.org>
Cc: "Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>,
	<strauman@SLAC.Stanford.EDU>
References: <IGEFJKJNHJDCBKALBJLLEEGBFLAA.joakim.tjernlund@lumentis.se> <20030324201543.GB14264@ip68-0-152-218.tc.ph.cox.net>
Subject: Re: dcbz works on 862 everywhere!
Date: Mon, 24 Mar 2003 23:44:12 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Can you post a patch which does everything (remove the TLB change bit,
> etc)?  Thanks.
>
> --
> Tom Rini

OK, here it goes. I had do this blind since I am still  on 2.4.20. Let me know
if it does not compile.

 Jocke
===== arch/ppc/kernel/head_8xx.S 1.41 vs edited =====
--- 1.41/arch/ppc/kernel/head_8xx.S Thu Feb 27 20:40:15 2003
+++ edited/arch/ppc/kernel/head_8xx.S Mon Mar 24 23:31:27 2003
@@ -451,6 +451,13 @@
 #endif
  mtspr MD_RPN, r20 /* Update TLB entry */

+ /* The 20 msb of MD_EPN and DAR must be the same when rfi is
+  * executed. The dcxx instructions don't set DAR when they
+  * cause a DTLB Miss so copy them from MD_EPN.
+  */
+ mfspr r20, MD_EPN
+ mtspr DAR, r20
+
  mfspr r20, M_TW /* Restore registers */
  lwz r21, 0(r0)
  mtcr r21
@@ -460,7 +467,18 @@
 #endif
  rfi

-2: mfspr r20, M_TW /* Restore registers */
+2:
+ /* Copy 20 msb from EPN to DAR since the dcxx instuctions fails
+  * update the DAR when they cause a DTLB Miss.
+  */
+ mfspr r21, MD_EPN
+ rlwinm r21, r21, 0, 0, 19
+ mfspr r20, DAR
+ rlwinm r20, r20, 0, 20, 31
+ or r20, r20, r21
+ mtspr DAR, r20
+
+ mfspr r20, M_TW /* Restore registers */
  lwz r21, 0(r0)
  mtcr r21
  lwz r21, 4(r0)
@@ -504,6 +522,9 @@
  andis. r21, r20, 0x0200 /* If set, indicates store op */
  beq 2f

+#if 0
+ /* Maybe this should stay? Time will tell */
+
  /* The EA of a data TLB miss is automatically stored in the MD_EPN
   * register.  The EA of a data TLB error is automatically stored in
   * the DAR, but not the MD_EPN register.  We must copy the 20 most
@@ -531,7 +552,7 @@
  lwz r3, 12(r0)
 #endif
  mtspr MD_EPN, r21
-
+#endif
  mfspr r20, M_TWB /* Get level 1 table entry address */

  /* If we are faulting a kernel address, we have to use the
===== arch/ppc/kernel/misc.S 1.80 vs edited =====
--- 1.80/arch/ppc/kernel/misc.S Thu Mar  6 06:36:05 2003
+++ edited/arch/ppc/kernel/misc.S Mon Mar 24 23:33:53 2003
@@ -664,7 +664,7 @@
 _GLOBAL(clear_page)
  li r0,4096/L1_CACHE_LINE_SIZE
  mtctr r0
-#ifdef CONFIG_8xx
+#ifdef CONFIG_8xx_CPU6
  li r4, 0
 1: stw r4, 0(r3)
  stw r4, 4(r3)
@@ -698,7 +698,7 @@
  addi r4,r4,-4
  li r5,4

-#ifndef CONFIG_8xx
+#ifndef CONFIG_8xx_CPU6
 #if MAX_COPY_PREFETCH > 1
  li r0,MAX_COPY_PREFETCH
  li r11,4
@@ -706,7 +706,7 @@
 11: dcbt r11,r4
  addi r11,r11,L1_CACHE_LINE_SIZE
  bdnz 11b
-#else /* MAX_L1_COPY_PREFETCH == 1 */
+#elif !defined(CONFIG_8xx) /* MAX_L1_COPY_PREFETCH == 1 */
  dcbt r5,r4
  li r11,L1_CACHE_LINE_SIZE+4
 #endif /* MAX_L1_COPY_PREFETCH */
@@ -715,8 +715,10 @@
  li r0,4096/L1_CACHE_LINE_SIZE
  mtctr r0
 1:
+#ifndef CONFIG_8xx_CPU6
 #ifndef CONFIG_8xx
- dcbt r11,r4
+ dcbt r11,r4 /* Makes 8xx slower */
+#endif
  dcbz r5,r3
 #endif
  COPY_16_BYTES
===== arch/ppc/lib/string.S 1.20 vs edited =====
--- 1.20/arch/ppc/lib/string.S Thu Feb 27 20:40:16 2003
+++ edited/arch/ppc/lib/string.S Mon Mar 24 23:34:20 2003
@@ -151,7 +151,7 @@
  bdnz 4b
 3: mtctr r9
  li r7,4
-#if !defined(CONFIG_8xx)
+#if !defined(CONFIG_8xx_CPU6)
 10: dcbz r7,r6
 #else
 10: stw r4, 4(r6)
@@ -253,7 +253,7 @@
  mtctr r0
  beq 63f
 53:
-#if !defined(CONFIG_8xx)
+#if !defined(CONFIG_8xx_CPU6)
  dcbz r11,r6
 #endif
  COPY_16_BYTES
@@ -427,7 +427,7 @@
  li r11,4
  beq 63f

-#if !defined(CONFIG_8xx)
+#if !defined(CONFIG_8xx_CPU6)
  /* Here we decide how far ahead to prefetch the source */
 #if MAX_COPY_PREFETCH > 1
  /* Heuristically, for large transfers we prefetch
@@ -442,7 +442,7 @@
 112: dcbt r3,r4
  addi r3,r3,CACHELINE_BYTES
  bdnz 112b
-#else /* MAX_COPY_PREFETCH == 1 */
+#elif !defined(CONFIG_8xx) /* MAX_COPY_PREFETCH == 1 */
  li r3,CACHELINE_BYTES + 4
  dcbt r11,r4
 #endif /* MAX_COPY_PREFETCH */
@@ -450,8 +450,10 @@

  mtctr r0
 53:
+#if !defined(CONFIG_8xx_CPU6)
 #if !defined(CONFIG_8xx)
- dcbt r3,r4
+ dcbt r3,r4 /* Makes 8xx slower */
+#endif
 54: dcbz r11,r6
 #endif
 /* had to move these to keep extable in order */
@@ -461,7 +463,7 @@
  .long 71b,101f
  .long 72b,102f
  .long 73b,103f
-#if !defined(CONFIG_8xx)
+#if !defined(CONFIG_8xx_CPU6)
  .long 54b,105f
 #endif
  .text


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
