Date: Fri, 14 Nov 2003 09:24:14 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: linuxppc-dev@lists.linuxppc.org, paulus@samba.org
Subject: Re: New 745x errata
Message-ID: <20031114162414.GD13003@ip68-0-152-218.tc.ph.cox.net>
References: <1068721518.23764.84.camel@newt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1068721518.23764.84.camel@newt>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Nov 13, 2003 at 11:05:17AM +0000, Adrian Cox wrote:
>
> Since October there are new errata on Motorola's website for the 745x
> family processors. The following patch against linuxppc-2.4-devel
> contains workarounds to two problems:
>
> 1) The BTIC doesn't work reliably: it can cause execution of corrupted
> instructions. (This is listed in the errata for the 7450 and 7457, but
> not for the 7455. I'll only believe that the 7455 escaped this bug if I
> hear confirmation out of Motorola.)

I've done the opposite in something I've been waiting for 2.4.24-pre to
come out to fix.  But I agree that it is odd that it's not listed on the
7455.

diff -Nru a/arch/ppc/kernel/cpu_setup_6xx.S b/arch/ppc/kernel/cpu_setup_6xx.S
--- a/arch/ppc/kernel/cpu_setup_6xx.S	Fri Nov 14 09:23:24 2003
+++ b/arch/ppc/kernel/cpu_setup_6xx.S	Fri Nov 14 09:23:24 2003
@@ -104,8 +104,8 @@

 /* 7400 <= rev 2.7 and 7410 rev = 1.0 suffer from some
  * erratas we work around here.
- * Moto MPC710CE.pdf describes them, those are errata
- * #3, #4 and #5
+ * Moto MPC7410CE.pdf describes them, those are errata
+ * #3, #4 and #5 (7400 erratas #13, #14 and #15).
  * Note that we assume the firmware didn't choose to
  * apply other workarounds (there are other ones documented
  * in the .pdf). It appear that Apple firmware only works
@@ -155,7 +155,20 @@
 BEGIN_FTR_SECTION
 	oris	r11,r11,HID0_DPM@h	/* enable dynamic power mgmt */
 END_FTR_SECTION_IFCLR(CPU_FTR_NO_DPM)
-	li	r3,HID0_SPD
+
+	/* 7400 Errata #7, don't enable SGE on < Rev 2.1 */
+	mfpvr	r10
+	rlwinm	r3,r10,16,16,31
+	cmplwi	r3,0x000c
+	bne	1f			/* Not a 7400. */
+	andi	r3,r10,0x0f0f
+	cmpwi	0,r3,0x0200
+	bgt	1f			/* Rev >= 2.1 */
+	li	r3,HID0_SGE		/* 7400 rev < 2.1, clear SGE. */
+	b	2f
+
+1:	li	r3,0			/* Don't clear SGE. */
+2:	ori	r3,r3,HID0_SPD
 	andc	r11,r11,r3		/* clear SPD: enable speculative */
  	li	r3,0
  	mtspr	ICTC,r3			/* Instruction Cache Throttling off */
@@ -223,9 +236,17 @@
 	oris	r11,r11,HID0_DPM@h	/* enable dynamic power mgmt */
 END_FTR_SECTION_IFCLR(CPU_FTR_NO_DPM)

+	/* We only want to enable BTIC on 7455's */
+	mfpvr	r3
+	rlwinm	r3,r3,16,16,31
+	cmplwi	r3,0x8001
+	li	r3,HID0_BTIC		/* Assume we want to clear BTIC. */
+	bne	2f			/* Not a 7455. */
+	li	r3,0			/* 7455, don't clear BTIC. */
+
 	/* All of the bits we have to clear....
 	 */
-	li	r3,HID0_SPD | HID0_NOPDST | HID0_NOPTI
+2:	ori	r3,r3,HID0_SPD | HID0_NOPDST | HID0_NOPTI
 	andc	r11,r11,r3		/* clear SPD: enable speculative */
  	li	r3,0

diff -Nru a/arch/ppc/kernel/cputable.c b/arch/ppc/kernel/cputable.c
--- a/arch/ppc/kernel/cputable.c	Fri Nov 14 09:23:24 2003
+++ b/arch/ppc/kernel/cputable.c	Fri Nov 14 09:23:24 2003
@@ -202,6 +202,15 @@
 	32, 32,
 	__setup_cpu_7410
     },
+    {	/* 7450 1.x - no doze/nap */
+    	0xffffff00, 0x80000100, "7450",
+    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
+	CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
+	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450,
+	COMMON_PPC | PPC_FEATURE_HAS_ALTIVEC,
+	32, 32,
+	__setup_cpu_745x
+    },
     {	/* 7450 2.0 - no doze/nap */
     	0xffffffff, 0x80000200, "7450",
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
