Message-ID: <000b01c2f261$292427a0$020120b0@jockeXP>
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Dan Malek" <dan@embeddededge.com>
Cc: "Tom Rini" <trini@kernel.crashing.org>,
	"Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>,
	<strauman@SLAC.Stanford.EDU>
References: <IGEFJKJNHJDCBKALBJLLEEGBFLAA.joakim.tjernlund@lumentis.se> <20030324201543.GB14264@ip68-0-152-218.tc.ph.cox.net> <006601c2f256$e6ff5e80$020120b0@jockeXP> <3E7F9017.2000900@embeddededge.com>
Subject: Re: dcbz works on 862 everywhere!
Date: Tue, 25 Mar 2003 00:57:38 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Joakim Tjernlund wrote:
>
> > OK, here it goes.
>
> No, this isn't correct......
>
>
> > + /* The 20 msb of MD_EPN and DAR must be the same when rfi is
> > +  * executed. The dcxx instructions don't set DAR when they
> > +  * cause a DTLB Miss so copy them from MD_EPN.
>
> No, don't be screwing around with these registers.

Did you read my mails? This is the key.
What harm can it do? This is much less intrusive than the
"copy DAR to MD_EPN" part in the TLB Error handler.

>
>
>
> > -#ifdef CONFIG_8xx
> > +#ifdef CONFIG_8xx_CPU6
>
> What is this all about?  The CPU6 errata is a clearly defined
> problem on well known silicon revisions.  Don't be using it where
> it isn't intended.

OK, I have removed all CONFIG_8xx_CPU6 and CONFIG_8xx
I restored the "copy DAR to MD_EPN"  in the TLB Error hanler as well.

>
> Please try again..........thanks.


Here it is:
===== arch/ppc/kernel/head_8xx.S 1.41 vs edited =====
--- 1.41/arch/ppc/kernel/head_8xx.S Thu Feb 27 20:40:15 2003
+++ edited/arch/ppc/kernel/head_8xx.S Tue Mar 25 00:43:39 2003
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
===== arch/ppc/kernel/misc.S 1.80 vs edited =====
--- 1.80/arch/ppc/kernel/misc.S Thu Mar  6 06:36:05 2003
+++ edited/arch/ppc/kernel/misc.S Tue Mar 25 00:41:16 2003
@@ -664,15 +664,7 @@
 _GLOBAL(clear_page)
  li r0,4096/L1_CACHE_LINE_SIZE
  mtctr r0
-#ifdef CONFIG_8xx
- li r4, 0
-1: stw r4, 0(r3)
- stw r4, 4(r3)
- stw r4, 8(r3)
- stw r4, 12(r3)
-#else
 1: dcbz 0,r3
-#endif
  addi r3,r3,L1_CACHE_LINE_SIZE
  bdnz 1b
  blr
@@ -698,7 +690,6 @@
  addi r4,r4,-4
  li r5,4

-#ifndef CONFIG_8xx
 #if MAX_COPY_PREFETCH > 1
  li r0,MAX_COPY_PREFETCH
  li r11,4
@@ -706,7 +697,7 @@
 11: dcbt r11,r4
  addi r11,r11,L1_CACHE_LINE_SIZE
  bdnz 11b
-#else /* MAX_L1_COPY_PREFETCH == 1 */
+#elif !defined(CONFIG_8xx) /* MAX_L1_COPY_PREFETCH == 1 */
  dcbt r5,r4
  li r11,L1_CACHE_LINE_SIZE+4
 #endif /* MAX_L1_COPY_PREFETCH */
@@ -716,9 +707,10 @@
  mtctr r0
 1:
 #ifndef CONFIG_8xx
- dcbt r11,r4
- dcbz r5,r3
+ dcbt r11,r4 /* Makes 8xx slower */
 #endif
+ dcbz r5,r3
+
  COPY_16_BYTES
 #if L1_CACHE_LINE_SIZE >= 32
  COPY_16_BYTES
===== arch/ppc/lib/string.S 1.20 vs edited =====
--- 1.20/arch/ppc/lib/string.S Thu Feb 27 20:40:16 2003
+++ edited/arch/ppc/lib/string.S Tue Mar 25 00:42:56 2003
@@ -151,14 +151,7 @@
  bdnz 4b
 3: mtctr r9
  li r7,4
-#if !defined(CONFIG_8xx)
 10: dcbz r7,r6
-#else
-10: stw r4, 4(r6)
- stw r4, 8(r6)
- stw r4, 12(r6)
- stw r4, 16(r6)
-#endif
  addi r6,r6,CACHELINE_BYTES
  bdnz 10b
  clrlwi r5,r8,32-LG_CACHELINE_BYTES
@@ -253,9 +246,8 @@
  mtctr r0
  beq 63f
 53:
-#if !defined(CONFIG_8xx)
  dcbz r11,r6
-#endif
+
  COPY_16_BYTES
 #if L1_CACHE_LINE_SIZE >= 32
  COPY_16_BYTES
@@ -427,7 +419,6 @@
  li r11,4
  beq 63f

-#if !defined(CONFIG_8xx)
  /* Here we decide how far ahead to prefetch the source */
 #if MAX_COPY_PREFETCH > 1
  /* Heuristically, for large transfers we prefetch
@@ -442,7 +433,7 @@
 112: dcbt r3,r4
  addi r3,r3,CACHELINE_BYTES
  bdnz 112b
-#else /* MAX_COPY_PREFETCH == 1 */
+#elif !defined(CONFIG_8xx) /* MAX_COPY_PREFETCH == 1 */
  li r3,CACHELINE_BYTES + 4
  dcbt r11,r4
 #endif /* MAX_COPY_PREFETCH */
@@ -451,9 +442,9 @@
  mtctr r0
 53:
 #if !defined(CONFIG_8xx)
- dcbt r3,r4
-54: dcbz r11,r6
+ dcbt r3,r4 /* Makes 8xx slower */
 #endif
+54: dcbz r11,r6
 /* had to move these to keep extable in order */
  .section __ex_table,"a"
  .align 2
@@ -461,9 +452,7 @@
  .long 71b,101f
  .long 72b,102f
  .long 73b,103f
-#if !defined(CONFIG_8xx)
  .long 54b,105f
-#endif
  .text
 /* the main body of the cacheline loop */
  COPY_16_BYTES_WITHEX(0)


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
