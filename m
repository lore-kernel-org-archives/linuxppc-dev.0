Message-Id: <200010032044.WAA16188@piglet.grunz.lu>
Date: Tue, 3 Oct 2000 22:44:10 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: l2cr function corrections for G4 (attached now)
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: MULTIPART/mixed; BOUNDARY="134458388-1804289383-970605857=:749"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--134458388-1804289383-970605857=:749
Content-Type: TEXT/plain; charset=us-ascii

'scuse me...

Files really attached, this time.

I guess it's time to get some sleep...

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "

--134458388-1804289383-970605857=:749
Content-Type: TEXT/plain; CHARSET=US-ASCII
Content-Disposition: attachment; filename="2.4-l2cr.diff"

--- /mnt/r4/usr/src/linux-2.4.paul/arch/ppc/kernel/misc.S	Tue Sep 26 06:30:58 2000
+++ linux-2.4.0-test9/arch/ppc/kernel/misc.S	Sat Sep 30 09:11:57 2000
@@ -825,13 +825,13 @@
 */

 _GLOBAL(_set_L2CR)
-	/* Make sure this is a 750 chip */
+	/* Make sure this is a 750 or 7400 chip */
 	mfspr	r4,PVR
 	rlwinm	r4,r4,16,16,31
 	cmplwi	r4,0x0008
 	beq	thisIs750
 	cmplwi	r4,0x000c
-	beq thisIs750
+	beq	thisIs750
 	li	r3,-1
 	blr

@@ -922,12 +922,13 @@
 	blr

 _GLOBAL(_get_L2CR)
-	/* Make sure this is a 750 chip */
+	/* Make sure this is a 750 or 7400 chip */
 	mfspr	r3,PVR
 	rlwinm	r3,r3,16,16,31
 	cmplwi	r3,0x0008
 	beq	1f
 	cmplwi	r3,0x000c
+	beq	1f
 	li	r3,0
 	bnelr
 1:

--134458388-1804289383-970605857=:749
Content-Type: TEXT/plain; CHARSET=US-ASCII
Content-Disposition: attachment; filename="2.2-l2cr.diff"

--- linux-2.2.17-pristine/arch/ppc/kernel/misc.S	Thu Sep  7 20:35:29 2000
+++ linux/arch/ppc/kernel/misc.S	Sat Sep 30 09:08:44 2000
@@ -564,13 +564,13 @@
 */

 _GLOBAL(_set_L2CR)
-	/* Make sure this is a 750 chip */
+	/* Make sure this is a 750 or 7400 chip */
 	mfspr	r4,PVR
 	rlwinm	r4,r4,16,16,31
-	cmplwi	r4,0x0008
+	cmplwi	r4,0x0008	/* 750? */
+	beq	thisIs750
+	cmplwi	r4,0x000c	/* 7400? */
 	beq	thisIs750
-	cmplwi	r4,0x000c
-	beq thisIs750
 	li	r3,-1
 	blr

@@ -661,12 +661,13 @@
 	blr

 _GLOBAL(_get_L2CR)
-	/* Make sure this is a 750 chip */
+	/* Make sure this is a 750 or 7400 chip */
 	mfspr	r3,PVR
 	rlwinm	r3,r3,16,16,31
 	cmplwi	r3,0x0008
 	beq	1f
 	cmplwi	r3,0x000c
+	beq	1f
 	li	r3,0
 	bnelr
 1:

--134458388-1804289383-970605857=:749--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
