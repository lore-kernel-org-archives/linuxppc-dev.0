Date: Mon, 24 Mar 2003 12:01:46 +0100
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: RE: dcbz works on 862 everywhere!
In-reply-to: <IGEFJKJNHJDCBKALBJLLEEGBFLAA.joakim.tjernlund@lumentis.se>
To: joakim.tjernlund@lumentis.se,
	"Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
Cc: strauman@SLAC.Stanford.EDU
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLCEGCFLAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Does this make any sense to anyone?
> I can prepare a patch if somebody is interested to try it on their 8xx CPU.
>
>  Jocke

I forgot:
Why is the Guarded flag set in DTLB Miss handler for the pte?
Won't performance degrade?

 Jocke

PS.
  Here is the patch if anyone wants to test. Please report your results.
  Don't forget to enable dcbz in arch/ppc/kernel/misc.S and arch/ppc/lib/string.S
  for 8xx.

Index: arch/ppc/kernel/head_8xx.S
===================================================================
RCS file: /home/cvsadmin/cvsroot/kernel/linuxppc/arch/ppc/kernel/head_8xx.S,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 head_8xx.S
--- arch/ppc/kernel/head_8xx.S	1 Nov 2002 13:44:02 -0000	1.1.1.1
+++ arch/ppc/kernel/head_8xx.S	24 Mar 2003 10:46:22 -0000
@@ -407,6 +407,13 @@
 	rlwinm.	r20, r21,0,0,19	/* Extract page descriptor page address */
 	beq	2f		/* If zero, don't try to find a pte */

+	/* For some reason the 20 msb of MD_EPN and DAR must be the same when
+	 * MD_RPN is written. The dcxx instructions don't set DAR when they
+	 * cause a DTLB Miss so copy them from MD_EPN.
+	 */
+	mfspr	r20, MD_EPN
+	mtspr	DAR, r20
+
 	/* We have a pte table, so load fetch the pte from the table.
 	 */
 	tophys(r21, r21)
@@ -463,7 +470,18 @@
 #endif
 	rfi

-2:	mfspr	r20, M_TW	/* Restore registers */
+2:
+	/* Copy 20 msb from EPN to DAR since the dcxx instuctions fails
+	 * update the DAR when they cause a DTLB Miss.
+	 */
+	mfspr	r21, MD_EPN
+	rlwinm	r21, r21, 0, 0, 19
+	mfspr	r20, DAR
+	rlwinm	r20, r20, 0, 20, 31
+	or	r20, r20, r21
+	mtspr	DAR, r20
+
+	mfspr	r20, M_TW	/* Restore registers */
 	lwz	r21, 0(r0)
 	mtcr	r21
 	lwz	r21, 4(r0)


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
