Subject: 405LP RTC warning patch
From: Hollis Blanchard <hollis@austin.ibm.com>
To: embedded list <linuxppc-embedded@lists.linuxppc.org>
Content-Type: multipart/mixed; boundary="=-1qlWo5PSWT/XrlgTwHHY"
Date: 19 Dec 2002 11:31:14 -0600
Message-Id: <1040319075.30597.143.camel@granite.austin.ibm.com>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--=-1qlWo5PSWT/XrlgTwHHY
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

As David suggested, this patch warns the user if the RTC frequency is
altered by Linux (at least a little time will have been lost during
firmware boot).

Please apply to _2_4_devel.

-Hollis
--
PowerPC Linux
IBM Linux Technology Center

--=-1qlWo5PSWT/XrlgTwHHY
Content-Disposition: attachment; filename=405LP-rtc-warn.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=405LP-rtc-warn.diff; charset=ISO-8859-1

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux 2.4 for PowerPC development tree
# This patch format is intended for GNU patch command version 2.5 or higher=
.
# This patch includes the following deltas:
#	           ChangeSet	1.1179  -> 1.1180=20
#	arch/ppc/platforms/ibm405lp.c	1.5     -> 1.6   =20
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/12/19	hollis@granite.austin.ibm.com	1.1180
# print a warning message if RTC frequency is altered
# --------------------------------------------
#
diff -Nru a/arch/ppc/platforms/ibm405lp.c b/arch/ppc/platforms/ibm405lp.c
--- a/arch/ppc/platforms/ibm405lp.c	Thu Dec 19 11:27:45 2002
+++ b/arch/ppc/platforms/ibm405lp.c	Thu Dec 19 11:27:45 2002
@@ -288,7 +288,14 @@
 		mtdcr(DCRN_RTC0_CR1, 0x80);		/* Disable update cycles/interrupts*/
 		mtdcr(DCRN_RTC0_WRAP, 0);       /* toggle NRST & NMR */
 		mtdcr(DCRN_RTC0_WRAP, 3);
-		mtdcr(DCRN_RTC0_CR0, (RTC_DVBITS & 0x7) << 4);		/* input clock */
+
+		/* if necessary, set the input clock frequency */
+		if ((mfdcr(DCRN_RTC0_CR0) >> 4) !=3D RTC_DVBITS) {
+			printk(KERN_WARNING "Warning: RTC frequency was incorrect\n");
+			mtdcr(DCRN_RTC0_CR0,
+					 ((RTC_DVBITS & 0x7) << 4) | (mfdcr(DCRN_RTC0_CR0) & 0xf));
+		}
+
 		mtdcr(DCRN_RTC0_CR1, mfdcr(DCRN_RTC0_CR1) & 0x7f);	/* allow updates */
=20
 		not_initialized =3D 0;

--=-1qlWo5PSWT/XrlgTwHHY--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
