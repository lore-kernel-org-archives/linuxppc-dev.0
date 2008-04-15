Return-Path: <hugo.villeneuve@lyrtech.com>
Received: from toq2-srv.bellnexxia.net (toq2.bellnexxia.net [209.226.175.121])
	by ozlabs.org (Postfix) with ESMTP id 56E71DE2B0
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Apr 2008 00:37:48 +1000 (EST)
Received: from toip35-bus.srvr.bell.ca ([67.69.240.36])
	by tomts47-srv.bellnexxia.net
	(InterMail vM.5.01.06.13 201-253-122-130-113-20050324) with ESMTP id
	<20080415135714.ZPDH1673.tomts47-srv.bellnexxia.net@toip35-bus.srvr.bell.ca>
	for <linuxppc-embedded@ozlabs.org>; Tue, 15 Apr 2008 09:57:14 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: [PATCH] LLTEMAC resource end address
Date: Tue, 15 Apr 2008 09:57:13 -0400
Message-ID: <42848A5C5A0D1E47B026E644DD49B08E025AA4D8@mail>
From: "Hugo Villeneuve" <hugo.villeneuve@lyrtech.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,
We have a design with LLTEMAC0 using channels 0 & 1, and LLTEMAC1 using =
channel 0. When the Linux kernel boots, we had the following error =
message:

---
Registering device xilinx_lltemac:0
Registering device xilinx_lltemac:1
xilinx_lltemac.1: failed to claim resource 0
cannot register dev xilinx_lltemac:1
Registering device xilinx_lltemac:2
---

We found out that the two channels of a LLTEMAC interface are each using =
0x40 bytes in length, and are contiguous. The following patch took care =
of the problem for us (against the linux-2.6-xlnx-git tree):

---
diff --git a/arch/ppc/syslib/virtex_devices.c =
b/arch/ppc/syslib/virtex_devices.c
index 457e1bd..7f731e4 100644
--- a/arch/ppc/syslib/virtex_devices.c
+++ b/arch/ppc/syslib/virtex_devices.c
@@ -202,7 +202,7 @@
        .resource =3D (struct resource[]) { \
                { \
                        .start =3D XPAR_LLTEMAC_##num##_BASEADDR, \
-                       .end =3D XPAR_LLTEMAC_##num##_BASEADDR + 0x1000, =
\
+                       .end =3D XPAR_LLTEMAC_##num##_BASEADDR + 0x003F, =
\
                        .flags =3D IORESOURCE_MEM \
                }, \
                { \
---

Hugo V.


Hugo Villeneuve
Hardware developer | Concepteur mat=E9riel
Lyrtech
Phone/T=E9l. : (1) (418) 877-4644 #2395
Toll-free/Sans frais - Canada & USA : (1) (888) 922-4644 #2395
Fax/T=E9l=E9c. : (1) (418) 877-7710
www.lyrtech.com
Infinite possibilities...TM

THIS MESSAGE AND ALL ATTACHED DOCUMENTS ARE EXCLUSIVELY INTENDED
TO THE INDICATED RECIPIENTS AND ITS CONTENTS MAY BE CONFIDENTIAL.
IT IS STRICTLY FORBIDDEN TO ANYONE TO TAKE COGNIZANCE, USE, OR
DIVULGE THE INFORMATION CONTAINED HEREIN. IF YOU MISTAKENLY
RECEIVE THIS MESSAGE, IMMEDIATELY INFORM LYRTECH AND DESTROY THE
MESSAGE AND ATTACHMENTS FORTHWITH.THANK YOU.

LE PRESENT MESSAGE ET LES DOCUMENTS QUI Y SONT JOINTS S'ADRESSENT
EXCLUSIVEMENT AU(X)DESTINATAIRE(S) INDIQUE(S) ET LEUR TENEUR PEUT
ETRE CONFIDENTIELLE. IL EST STRICTEMENT INTERDIT A QUICONQUE D'EN
PRENDRE CONNAISSANCE, DE LES UTILISER OU DE LES DIVULGUER. SI
VOUS RECEVEZ LE PRESENT MESSAGE PAR ERREUR, VEUILLEZ EN AVISER
LYRTECH IMMEDIATEMENT ET DETRUIRE LE MESSAGE SEANCE TENANTE,
AINSI QUE LES DOCUMENTS QUI Y SONT JOINTS.
