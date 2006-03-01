Return-Path: <lagrange@fr.oleane.com>
Received: from smtp9.clb.oleane.net (smtp9.clb.oleane.net [213.56.31.31])
	by ozlabs.org (Postfix) with ESMTP id 66C2D679E9
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  1 Mar 2006 22:16:11 +1100 (EST)
From: "Laurent Lagrange" <lagrange@fr.oleane.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: RE: Minor bug in file irq.h
Date: Wed, 1 Mar 2006 12:21:53 +0100
Message-ID: <000901c63d22$58de3da0$5201a8c0@GEG2400>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_000A_01C63D2A.BAA2A5A0"
In-Reply-To: <0B99478F-EAB3-4070-AA8E-81418BF4BFBE@kernel.crashing.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_000A_01C63D2A.BAA2A5A0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

Here is a patch for the 2 bugs in irq.h.

This is the first time, I generate a patch.
I don't know if this is the right method.

Best regards
Laurent

>
> In the ./linux/include/asm-ppc/irq.h file, I encountered a problem with
the
> timer3 interrupt definition :
> #define     SIU_INT_TIMER3          ((uint)0x0e+CPM_IRQ_OFFSET)
>
> This definition generates a compilation error  because is interpreted as

Note that this is not the only such definition. At least this one  is
critical, too:

	#define SIU_INT_PC1             ((uint)0x3e+CPM_IRQ_OFFSET)

Best regards,

Wolfgang Denk

> -----Message d'origine-----
> De : Kumar Gala [mailto:galak@kernel.crashing.org]
> Envoye : mar. 28 fevrier 2006 15:38
> A : Laurent Lagrange
> Cc : linuxppc-embedded@ozlabs.org
> Objet : Re: Minor bug in file irq.h
>
>
>
> On Feb 28, 2006, at 2:50 AM, Laurent Lagrange wrote:
>
> >
> > Hello,
> >
> > I use a Linux 2.6.9 on MPC85xx.
> >
> > In the ./linux/include/asm-ppc/irq.h file, I encountered a problem
> > with the
> > timer3 interrupt definition :
> > #define     SIU_INT_TIMER3          ((uint)0x0e+CPM_IRQ_OFFSET)
> >
> > This definition generates a compilation error  because is
> > interpreted as
> > something like
> > ((uint)0x0(e+CPM_IRQ_OFFSET)) ie 0x0 exponent  + CPM_IRQ_OFFSET.
> >
> > To work around just parenthesis or add a space character between
> > 'e' and '+'
> > #define     SIU_INT_TIMER3          ((uint)0x0e +CPM_IRQ_OFFSET)
>
> Do you mind providing this in patch form with a signed-off-by.  I'll
> include it in the queue of 85xx related patches.
>
> - kumar
>
>

------=_NextPart_000_000A_01C63D2A.BAA2A5A0
Content-Type: application/octet-stream;
	name="irq.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="irq.patch"

--- include/asm-ppc/irq.h.ini	2005-10-05 11:16:51.000000000 +0200
+++ include/asm-ppc/irq.h	2006-03-01 11:48:09.862587552 +0100
@@ -1,3 +1,8 @@
+/*
+ * Fix erroneous syntax 2006/03/01
+ * Replace e+CPM_IRQ_OFFSET by e +CPM_IRQ_OFFSET
+ * Laurent Lagrange [lagrange@fr.oleane.com]
+ */
 #ifdef __KERNEL__
 #ifndef _ASM_IRQ_H
 #define _ASM_IRQ_H
@@ -205,7 +210,7 @@
 #define	SIU_INT_SMC2		((uint)0x05+CPM_IRQ_OFFSET)
 #define	SIU_INT_TIMER1		((uint)0x0c+CPM_IRQ_OFFSET)
 #define	SIU_INT_TIMER2		((uint)0x0d+CPM_IRQ_OFFSET)
-#define	SIU_INT_TIMER3		((uint)0x0e+CPM_IRQ_OFFSET)
+#define	SIU_INT_TIMER3		((uint)0x0e +CPM_IRQ_OFFSET)
 #define	SIU_INT_TIMER4		((uint)0x0f+CPM_IRQ_OFFSET)
 #define	SIU_INT_FCC1		((uint)0x20+CPM_IRQ_OFFSET)
 #define	SIU_INT_FCC2		((uint)0x21+CPM_IRQ_OFFSET)
@@ -230,7 +235,7 @@
 #define	SIU_INT_PC4		((uint)0x3b+CPM_IRQ_OFFSET)
 #define	SIU_INT_PC3		((uint)0x3c+CPM_IRQ_OFFSET)
 #define	SIU_INT_PC2		((uint)0x3d+CPM_IRQ_OFFSET)
-#define	SIU_INT_PC1		((uint)0x3e+CPM_IRQ_OFFSET)
+#define	SIU_INT_PC1		((uint)0x3e +CPM_IRQ_OFFSET)
 #define	SIU_INT_PC0		((uint)0x3f+CPM_IRQ_OFFSET)
 
 static __inline__ int irq_canonicalize(int irq)

------=_NextPart_000_000A_01C63D2A.BAA2A5A0--
