Message-Id: <200009031303.PAA00901@piglet.grunz.lu>
Date: Sun, 3 Sep 2000 15:03:40 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: PATCH: improved processor config for G3s
To: paulus@linuxcare.com.au
cc: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: MULTIPART/mixed; BOUNDARY="134458388-846930886-967986227=:867"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--134458388-846930886-967986227=:867
Content-Type: TEXT/plain; charset=us-ascii

Hi Paul,

It's patch day today ;-)

Attached is my try at improving the processor configuration for G3/G4
processors in head.S. Instead of leaving some config bits at what they
were set by the formware, I've tried to set all availbale faetures to
their 'optimum' value. Patch is against your 2.4 rsync tree as of today.
This patch, as well as the same thing against a 2.2 source, are also
posted on sourceforge.

Those where I see no problem are:

 * Branch History Table (BHTE), Branch Target ICache (BTIC), Dynamic
   Power Management (DPM) and Store Gathering (SGE) all on,
 * Instruction Cache Throttling Control (ICTC) off.

These were not touched before, but might be worth a discussion:

 * Speculative Cache Access Disable (SPD) cleared, Address Brodcast
   (ABE) enabled

Clearing SPD makes sense since some processor upgrade cards come with an
OF patch that sets this bit (due to ROM problems... we don't care once
Linux is up).

I'm running these processor settings without a problem for some time
now. If all the processor config in head.S doesn't look clean to some, I
agree, and I propose we change that setup a bit for 2.5, separating the
cache enable stuff from the processor configuration.

Cheers

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


--134458388-846930886-967986227=:867
Content-Type: TEXT/plain; CHARSET=US-ASCII
Content-Disposition: attachment; filename="processor.diff"

diff -uNr linux-2.4.paul/arch/ppc/kernel/head.S linux/arch/ppc/kernel/head.S
--- linux-2.4.paul/arch/ppc/kernel/head.S	Sun Aug 27 12:33:12 2000
+++ linux/arch/ppc/kernel/head.S	Sat Sep  2 11:26:12 2000
@@ -1347,13 +1347,17 @@
 4:
 	cror	14,14,18
 	bne	3,6f
-	/* We should add ABE here if we want to use Store Gathering
-	 * and other nifty bridge features
+	/* for G3/G4:
+	 * enable Store Gathering (SGE), Address Brodcast (ABE),
+	 * Branch History Table (BHTE), Branch Target ICache (BTIC)
 	 */
-	ori	r11,r11,HID0_SGE|HID0_BHTE|HID0_BTIC /* for g3/g4, enable */
+	ori	r11,r11,HID0_SGE | HID0_ABE | HID0_BHTE | HID0_BTIC
+	oris	r11,r11,HID0_DPM>>16	/* enable dynamic power mgmt */
+	li	r3,HID0_SPD
+	andc	r11,r11,r3		/* clear SPD: enable speculative */
  	li	r3,0
- 	mtspr	ICTC,r3
-5:	mtspr	HID0,r11		/* superscalar exec & br history tbl */
+ 	mtspr	ICTC,r3			/* Instruction Cache Throttling off */
+5:	mtspr	HID0,r11
 6:	blr

 /*

--134458388-846930886-967986227=:867--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
