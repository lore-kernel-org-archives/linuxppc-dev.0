Subject: 405LP RTC reset
From: Hollis Blanchard <hollis@austin.ibm.com>
To: embedded list <linuxppc-embedded@lists.linuxppc.org>
Cc: Todd Poynor <tpoynor@mvista.com>
Date: 17 Dec 2002 12:43:32 -0600
Message-Id: <1040150612.10740.111.camel@granite.austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-4MD3cV5fN2xhEez1wdKD"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--=-4MD3cV5fN2xhEez1wdKD
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Here's the updated 405LP RTC reset diff (after David's move of the RTC
functions to ibm405lp.c). This patch
a) does a full RTC reset as specified in the docs
b) sets the RTC clock speed in RTC "Register A" DV bits, i.e. it does
not assume the firmware has done this correctly.

Please apply to _2_4_devel.

Before similar changes can be made to 2.5, the non-todc RTC code will
have to be ported there (which Todd says is on his list :).

-Hollis
--=20
PowerPC Linux
IBM Linux Technology Center

--=-4MD3cV5fN2xhEez1wdKD
Content-Disposition: attachment; filename=405LP-rtc-reset.diff
Content-Type: text/plain; name=405LP-rtc-reset.diff; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

=3D=3D=3D=3D=3D arch/ppc/platforms/ibm405lp.h 1.8 vs edited =3D=3D=3D=3D=3D
--- 1.8/arch/ppc/platforms/ibm405lp.h	Tue Dec 17 11:26:06 2002
+++ edited/arch/ppc/platforms/ibm405lp.h	Tue Dec 17 11:52:10 2002
@@ -860,6 +860,11 @@
=20
 #define SLA0_SLPMD_MASK 0x07dfffff	/* AND to clear all non-reserved fields=
 */
=20
+/* these defines are for the DV bits of RTC0_CR0 */
+#define RTC_DVBITS_4MHZ		0	/* 4.194304 MHz */
+#define RTC_DVBITS_1MHZ		1	/* 1.048576 MHz */
+#define RTC_DVBITS_33KHZ	2	/*   32.768 KHz */
+
 /* Several direct-write DCRs on the 405LP have an interlock requirement,
    implemented by a "valid" bit in the low-order bit.  This routine handle=
s the
    handshaking for these registers, by
=3D=3D=3D=3D=3D arch/ppc/platforms/ibm405lp.c 1.4 vs edited =3D=3D=3D=3D=3D
--- 1.4/arch/ppc/platforms/ibm405lp.c	Thu Dec 12 17:06:37 2002
+++ edited/arch/ppc/platforms/ibm405lp.c	Tue Dec 17 11:50:01 2002
@@ -282,12 +282,16 @@
 	/* Make sure clocks are running */
 	if (not_initialized) {
=20
-		/* Reset the core and ensure it's enabled.  We assume
-		   only that the BIOS has set the correct frequency. */
-	=09
-		mtdcr(DCRN_RTC0_WRAP, 0);
+		/* Reset the core and ensure it's enabled. */
+		mtdcr(DCRN_RTC0_WRAP, 0);		/* toggle NRST & NMR */
 		mtdcr(DCRN_RTC0_WRAP, 3);
-		mtdcr(DCRN_RTC0_CR1, mfdcr(DCRN_RTC0_CR1) & 0x7f);
+		mtdcr(DCRN_RTC0_CR0, 0x60);		/* No divider chain, No square wave */
+		mtdcr(DCRN_RTC0_CR1, 0x80);		/* Disable update cycles/interrupts*/
+		mtdcr(DCRN_RTC0_WRAP, 0);       /* toggle NRST & NMR */
+		mtdcr(DCRN_RTC0_WRAP, 3);
+		mtdcr(DCRN_RTC0_CR0, (RTC_DVBITS & 0x7) << 4);		/* input clock */
+		mtdcr(DCRN_RTC0_CR1, mfdcr(DCRN_RTC0_CR1) & 0x7f);	/* allow updates */
+
 		not_initialized =3D 0;
 	}
=20
=3D=3D=3D=3D=3D arch/ppc/platforms/beech.h 1.7 vs edited =3D=3D=3D=3D=3D
--- 1.7/arch/ppc/platforms/beech.h	Thu Dec 12 17:10:24 2002
+++ edited/arch/ppc/platforms/beech.h	Tue Dec 17 11:50:10 2002
@@ -181,6 +181,8 @@
 #define PPC4xx_SERCLK_FREQ		11059200
 #define BASE_BAUD			(PPC4xx_SERCLK_FREQ / 16)
=20
+#define RTC_DVBITS			RTC_DVBITS_1MHZ	/* 1MHz RTC */
+
 #define PPC4xx_MACHINE_NAME		"IBM 405LP Beech"
=20
 #define _IO_BASE        isa_io_base
=3D=3D=3D=3D=3D arch/ppc/platforms/arctic2.h 1.1 vs edited =3D=3D=3D=3D=3D
--- 1.1/arch/ppc/platforms/arctic2.h	Sun Dec 15 19:59:59 2002
+++ edited/arch/ppc/platforms/arctic2.h	Tue Dec 17 11:50:18 2002
@@ -56,6 +56,8 @@
=20
 #define BASE_BAUD (PPC4xx_SERCLK_FREQ / 16)
=20
+#define RTC_DVBITS	RTC_DVBITS_33KHZ	/* 33KHz RTC */
+
 #define PPC4xx_MACHINE_NAME	"IBM Arctic II"
=20
 #endif /* !__ASSEMBLY__ */

--=-4MD3cV5fN2xhEez1wdKD--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
