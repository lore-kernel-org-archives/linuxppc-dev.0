Message-ID: <001a01c2fe12$e828ce50$020120b0@jockeXP>
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Tom Rini" <trini@kernel.crashing.org>
Cc: "Till Straumann" <strauman@SLAC.Stanford.EDU>,
	"Dan Malek" <dan@embeddededge.com>,
	"Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
References: <IGEFJKJNHJDCBKALBJLLMENAFLAA.joakim.tjernlund@lumentis.se> <IGEFJKJNHJDCBKALBJLLOENKFLAA.joakim.tjernlund@lumentis.se> <20030408181432.GA20785@ip68-0-152-218.tc.ph.cox.net>
Subject: Re: mpc8xx DCBZ (&friends) hw bug. Tests, analysis + conclusions.
Date: Tue, 8 Apr 2003 23:07:42 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
> On Tue, Apr 08, 2003 at 07:25:37PM +0200, Joakim Tjernlund wrote:
> > >
> > > Patch against 2.4.20 devel available on request until I have cleaned it up a little.
> > >
> > >    Jocke
> >
> > Here is the patch, against 2.4.20 devel but I think it will apply
> > against BK HEAD. Comments welcome :-)
>
> Can you let me know if this applies cleanly to the current linux-2.4
> tree (Or, 2.4.21-pre7 tarball)?  If not, can you generate a patch
> against this?  Thanks.
>
> --
> Tom Rini

pulled the latest linuxppc_2_4, patched it and inspected the result.
Current patch will apply with some offset and looks good.

I cannot run standard 2.4 without major patching, so I can't be sure
that it works.

Anyhow here is a version against linuxppc_2_4:

===== arch/ppc/kernel/head_8xx.S 1.33 vs edited =====
--- 1.33/arch/ppc/kernel/head_8xx.S Thu Mar 27 10:05:55 2003
+++ edited/arch/ppc/kernel/head_8xx.S Tue Apr  8 22:49:49 2003
@@ -31,6 +31,24 @@
 #include <asm/ppc_asm.h>
 #include "ppc_defs.h"

+/* These macros are used to tag DAR with a known value so that the
+ * DataTLBError can recognize a buggy dcbx instruction and workaround
+ * the problem.
+ */
+#define TAG_VAL 0xdead
+#define TAG_DAR_R20  \
+ lis r20, TAG_VAL;\
+ mtspr DAR, r20;
+
+/* Macro to make the code more readable. */
+#ifdef CONFIG_8xx_CPU6
+  #define DO_8xx_CPU6(val, reg) \
+ li reg, val; \
+ stw reg, 12(r0); \
+ lwz reg, 12(r0);
+#else
+  #define DO_8xx_CPU6(val, reg)
+#endif
  .text
  .globl _stext
 _stext:
@@ -166,6 +184,7 @@
  . = n;     \
 label:      \
  EXCEPTION_PROLOG;   \
+ TAG_DAR_R20;    \
  addi r3,r1,STACK_FRAME_OVERHEAD; \
  li r20,MSR_KERNEL;   \
  FINISH_EXCEPTION(hdlr)
@@ -188,6 +207,7 @@
  mr r5,r20
  mfspr r4,DAR
  stw r4,_DAR(r21)
+ TAG_DAR_R20
  addi r3,r1,STACK_FRAME_OVERHEAD
  li r20,MSR_KERNEL
  rlwimi r20,r23,0,16,16  /* copy EE bit from saved MSR */
@@ -226,6 +246,7 @@
  EXCEPTION_PROLOG
  mfspr r4,DAR
  stw r4,_DAR(r21)
+ TAG_DAR_R20
  mfspr r5,DSISR
  stw r5,_DSISR(r21)
  addi r3,r1,STACK_FRAME_OVERHEAD
@@ -461,6 +482,7 @@
 #endif
  mtspr MD_RPN, r20 /* Update TLB entry */

+ TAG_DAR_R20
  mfspr r20, M_TW /* Restore registers */
  lwz r21, 0(r0)
  mtcr r21
@@ -470,7 +492,17 @@
 #endif
  rfi

-2: mfspr r20, M_TW /* Restore registers */
+2:
+ /* Copy 20 msb from MD_EPN to DAR since the dcxx instructions fails
+  * to update DAR when they cause a DTLB Miss.
+  */
+ mfspr r21, MD_EPN
+ rlwinm r21, r21, 0, 0, 19
+ mfspr r20, DAR
+ rlwinm r20, r20, 0, 20, 31
+ or r20, r20, r21
+ mtspr DAR, r20
+ mfspr r20, M_TW /* Restore registers */
  lwz r21, 0(r0)
  mtcr r21
  lwz r21, 4(r0)
@@ -508,10 +540,18 @@
  stw r20, 0(r0)
  stw r21, 4(r0)

+ /* If DAR contains TAG_VAL implies a buggy dcbx instruction
+  * than did not set DAR.
+  */
+ mfspr r20, DAR
+ lis r21, TAG_VAL
+ cmpw cr0, r20, r21
+ beq- 100f /* Branch if TAG_VAL to dcbx workaround procedure */
+101: /* return from dcbx instruction bug workaround, r20 holds value of DAR */
  /* First, make sure this was a store operation.
  */
- mfspr r20, DSISR
- andis. r21, r20, 0x0200 /* If set, indicates store op */
+ mfspr r21, DSISR
+ andis. r21, r21, 0x0200 /* If set, indicates store op */
  beq 2f

  /* The EA of a data TLB miss is automatically stored in the MD_EPN
@@ -530,7 +570,7 @@
   * are initialized in mapin_ram().  This will avoid the problem,
   * assuming we only use the dcbi instruction on kernel addresses.
   */
- mfspr r20, DAR
+ /* DAR is in r20 already */
  rlwinm r21, r20, 0, 0, 19
  ori r21, r21, MD_EVALID
  mfspr r20, M_CASID
@@ -597,6 +637,7 @@
 #endif
  mtspr MD_RPN, r20 /* Update TLB entry */

+ TAG_DAR_R20
  mfspr r20, M_TW /* Restore registers */
  lwz r21, 0(r0)
  mtcr r21
@@ -633,6 +674,146 @@
  STD_EXCEPTION(0x1f00, Trap_1f, UnknownException)

  . = 0x2000
+/* This is the workaround procedure to calculate the data EA for a buggy dcbx instruction
+ * by decoding the registers used by the dcbx instruction and adding them.
+ * DAR is set to the calculated address and r20 also holds the EA on exit.
+ */
+139:/* fetch instruction from userspace memory */
+ DO_8xx_CPU6(0x3780, r3)
+ mtspr MD_EPN, r20 /* Have to use MD_EPN for walk, MI_EPN can't */
+ mfspr r21, M_TWB /* Get level 1 table entry address */
+ lwz r21, 0(r21) /* Get the level 1 entry */
+ tophys  (r21, r21)
+ DO_8xx_CPU6(0x3b80, r3)
+ mtspr MD_TWC, r21 /* Load pte table base address */
+ mfspr r21, MD_TWC /* ....and get the pte address */
+ lwz r21, 0(r21) /* Get the pte */
+ /* concat physical page address and page offset */
+ rlwinm r21, r21, 0, 0, 19
+ rlwinm r20, r20, 0, 20, 31
+ or r21, r20, r21
+ b 140f
+100:/* Entry point for dcbx workaround. */
+    /* fetch instruction from memory. */
+ mfspr r20,SRR0
+ andis. r21, r20, 0x8000
+ beq- 139b  /* Branch if user space address */
+ tophys  (r21, r20)
+140: lwz r21,0(r21)
+#if DEBUG_DCBX_INSTRUCTIONS
+/* Check if it really is a dcbx instruction */
+ rlwinm r20,r21,0,21,30
+ cmpwi cr0,r20,940 /* Is dcbi? */
+ bc 12,2,142f
+ cmpwi cr0,r20,2028 /* Is dcbz? */
+ bc 12,2,142f
+ cmpwi cr0,r20,492 /* Is dcbtst? */
+ bc 12,2,142f
+ cmpwi cr0,r20,556 /* Is dcbt? */
+ bc 12,2,142f
+ cmpwi cr0,r20,108 /* Is dcbst? */
+ bc 12,2,142f
+ cmpwi cr0,r20,172 /* Is dcbf? */
+ bc 12,2,142f
+
+141: b 141b /* Stop here if no dcbx instruction */
+142: /* continue, it was a dcbx instruction. */
+#endif
+
+#ifdef CONFIG_8xx_CPU6
+ lwz r3, 8(r0)  /* restore r3 from memory */
+#endif
+ mfctr r20
+ mtdar r20   /* save ctr reg in DAR */
+ rlwinm r20, r21, 24, 24, 28 /* offset into jump table for reg RB */
+ addi r20, r20, 150f@l /* add start of table */
+ mtctr r20   /* load ctr with jump address */
+ xor r20, r20, r20  /* sum starts at zero */
+ bctr    /* jump into table */
+150:
+ add r20, r20, r0
+ b 151f
+ add r20, r20, r1
+ b 151f
+ add r20, r20, r2
+ b 151f
+ add r20, r20, r3
+ b 151f
+ add r20, r20, r4
+ b 151f
+ add r20, r20, r5
+ b 151f
+ add r20, r20, r6
+ b 151f
+ add r20, r20, r7
+ b 151f
+ add r20, r20, r8
+ b 151f
+ add r20, r20, r9
+ b 151f
+ add r20, r20, r10
+ b 151f
+ add r20, r20, r11
+ b 151f
+ add r20, r20, r12
+ b 151f
+ add r20, r20, r13
+ b 151f
+ add r20, r20, r14
+ b 151f
+ add r20, r20, r15
+ b 151f
+ add r20, r20, r16
+ b 151f
+ add r20, r20, r17
+ b 151f
+ add r20, r20, r18
+ b 151f
+ add r20, r20, r19
+ b 151f
+ mtctr r21 /* reg 20 needs special handling */
+ b 154f
+ mtctr r21 /* reg 21 needs special handling */
+ b 153f
+ add r20, r20, r22
+ b 151f
+ add r20, r20, r23
+ b 151f
+ add r20, r20, r24
+ b 151f
+ add r20, r20, r25
+ b 151f
+ add r20, r20, r25
+ b 151f
+ add r20, r20, r27
+ b 151f
+ add r20, r20, r28
+ b 151f
+ add r20, r20, r29
+ b 151f
+ add r20, r20, r30
+ b 151f
+ add r20, r20, r31
+151:
+ rlwinm. r21,r21,19,24,28 /* offset into jump table for reg RA */
+ bc 12,2,152f  /* if reg RA is zero, don't add it */
+ addi r21, r21, 150b@l /* add start of table */
+ mtctr r21   /* load ctr with jump address */
+ rlwinm r21,r21,0,16,10  /* make sure we don't execute this more than once */
+ bctr    /* jump into table */
+152:
+ mfdar r21
+ mtctr r21   /* restore ctr reg from DAR */
+ mtdar r20   /* save fault EA to DAR */
+ b 101b   /* Go back to normal TLB handling */
+
+ /* special handling for r20,r21 since these are modified already */
+153: lwz r21, 4(r0) /* load r21 from memory */
+ b 155f
+154: mfspr r21, M_TW /* load r20 from M_TW */
+155: add r20, r20, r21 /* add it */
+ mfctr r21  /* restore r21 */
+ b 151b

 /*
  * This code finishes saving the registers to the exception frame


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
