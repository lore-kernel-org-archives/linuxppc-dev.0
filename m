Subject: 405LP EBC setup fix
From: Hollis Blanchard <hollis@austin.ibm.com>
To: embedded list <linuxppc-embedded@lists.linuxppc.org>
Date: 17 Dec 2002 12:51:18 -0600
Message-Id: <1040151079.1100.119.camel@granite.austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-GrKr/RkqVBf3ooYs9AcY"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--=-GrKr/RkqVBf3ooYs9AcY
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

EBC0_B0CR should be set as 16-bit; through an ifdef merging typo it is
currently set incorrectly as 8-bit. This prevents 405LP wakeup from
succeeding and needs to be fixed.

Please apply to _2_4_devel and 2.5.

-Hollis
--=20
PowerPC Linux
IBM Linux Technology Center

--=-GrKr/RkqVBf3ooYs9AcY
Content-Disposition: attachment; filename=405LP-EBC0_B0CR-2.4.diff
Content-Type: text/plain; name=405LP-EBC0_B0CR-2.4.diff; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

=3D=3D=3D=3D=3D arch/ppc/platforms/beech.c 1.9 vs edited =3D=3D=3D=3D=3D
--- 1.9/arch/ppc/platforms/beech.c	Thu Dec 12 17:06:37 2002
+++ edited/arch/ppc/platforms/beech.c	Tue Dec 17 11:29:58 2002
@@ -180,7 +180,7 @@
 	    (mfdcri(DCRN_EBC0, BnCR(0)) & EBC0_BnCR_MASK);
 	cr.fields.bs =3D BEECH_BANK0_EBC_SIZE;
 	cr.fields.bu =3D EBC0_BnCR_BU_RW;
-	cr.fields.bw =3D EBC0_BnCR_BW_8;
+	cr.fields.bw =3D EBC0_BnCR_BW_16;
 	mtdcri(DCRN_EBC0, BnCR(0), cr.reg);
=20
 	ap.reg =3D mfdcri(DCRN_EBC0, BnAP(0)) & EBC0_BnAP_MASK;

--=-GrKr/RkqVBf3ooYs9AcY
Content-Disposition: attachment; filename=405LP-EBC0_B0CR-2.5.diff
Content-Type: text/plain; name=405LP-EBC0_B0CR-2.5.diff; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

=3D=3D=3D=3D=3D arch/ppc/platforms/4xx/beech.c 1.9 vs edited =3D=3D=3D=3D=
=3D
--- 1.9/arch/ppc/platforms/4xx/beech.c	Thu Dec 12 17:06:37 2002
+++ edited/arch/ppc/platforms/4xx/beech.c	Tue Dec 17 11:29:58 2002
@@ -180,7 +180,7 @@
 	    (mfdcri(DCRN_EBC0, BnCR(0)) & EBC0_BnCR_MASK);
 	cr.fields.bs =3D BEECH_BANK0_EBC_SIZE;
 	cr.fields.bu =3D EBC0_BnCR_BU_RW;
-	cr.fields.bw =3D EBC0_BnCR_BW_8;
+	cr.fields.bw =3D EBC0_BnCR_BW_16;
 	mtdcri(DCRN_EBC0, BnCR(0), cr.reg);
=20
 	ap.reg =3D mfdcri(DCRN_EBC0, BnAP(0)) & EBC0_BnAP_MASK;

--=-GrKr/RkqVBf3ooYs9AcY--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
