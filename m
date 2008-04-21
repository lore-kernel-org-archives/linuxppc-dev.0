Return-Path: <hugo.villeneuve@lyrtech.com>
Received: from tomts23-srv.bellnexxia.net (tomts23-srv.bellnexxia.net
	[209.226.175.185]) by ozlabs.org (Postfix) with ESMTP id 57E60DE043
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Apr 2008 01:19:10 +1000 (EST)
Received: from toip38-bus.srvr.bell.ca ([67.69.240.39])
	by tomts23-srv.bellnexxia.net
	(InterMail vM.5.01.06.13 201-253-122-130-113-20050324) with ESMTP id
	<20080421151909.RGZD1531.tomts23-srv.bellnexxia.net@toip38-bus.srvr.bell.ca>
	for <linuxppc-embedded@ozlabs.org>; Mon, 21 Apr 2008 11:19:09 -0400
Subject: RE: XLlTemac  soft lockup BUG
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Mon, 21 Apr 2008 11:19:08 -0400
Message-ID: <42848A5C5A0D1E47B026E644DD49B08E025F4396@mail>
In-reply-to: <48076ABA.1030500@conceptxdesign.com>
References: <16711066.post@talk.nabble.com>
	<42848A5C5A0D1E47B026E644DD49B08E025AA69F@mail>
	<48076ABA.1030500@conceptxdesign.com>
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

Brian Silverman wrote:
> Hugo,
> We have a design with the BCM5482, and will be trying it out shortly.
> Any chance you could post a patch of your BCM5466 mods?=20

Hi,
The main issue here is that you need to tell the LLTEMAC interface about =
the speed of your PHY. You can do this by adding this code example in =
the function=20
set_mac_speed():

---
#define BROADCOM_BCM5466_RGMII_AUX_STATUS 0x19

#define BCM5466_SPEED_1000BASE_T_FULL_DUPLEX 7
#define BCM5466_SPEED_1000BASE_T_HALF_DUPLEX 6
#define BCM5466_SPEED_100BASE_T_FULL_DUPLEX  5
#define BCM5466_SPEED_100BASE_T4             4
#define BCM5466_SPEED_100BASE_T_HALF_DUPLEX  3
#define BCM5466_SPEED_10BASE_T_FULL_DUPLEX   2
#define BCM5466_SPEED_10BASE_T_HALF_DUPLEX   1
#define BCM5466_SPEED_AN_NOT_COMPLETE        0

        u16 RegValue;

        _XLlTemac_PhyRead(&lp->Emac, lp->gmii_addr, =
BROADCOM_BCM5466_RGMII_AUX_STATUS, &RegValue);
        phylinkspeed =3D ( RegValue & 0x0700 ) >> 8; /* Keeping only =
bits 10-8 */

        /* Update TEMAC speed accordingly */
        switch (phylinkspeed) {
        case BCM5466_SPEED_1000BASE_T_FULL_DUPLEX:
        case BCM5466_SPEED_1000BASE_T_HALF_DUPLEX:
                lp->cur_speed =3D 1000;
                break;
        case BCM5466_SPEED_100BASE_T_FULL_DUPLEX:
        case BCM5466_SPEED_100BASE_T_HALF_DUPLEX:
        case BCM5466_SPEED_100BASE_T4:
                lp->cur_speed =3D 100;
                break;
        case BCM5466_SPEED_10BASE_T_FULL_DUPLEX:
        case BCM5466_SPEED_10BASE_T_HALF_DUPLEX:
                lp->cur_speed =3D 10;
                break;
        default:
                lp->cur_speed =3D 1000;
                break;
        }

        _XLlTemac_SetOperatingSpeed(&lp->Emac, lp->cur_speed);
---

Hope it helps, Hugo.


> Hugo Villeneuve wrote:
>=20
> 	linuxppc-embedded-bounces+hugo.villeneuve=3Dlyrtech.com@ozlabs.org
> wrote:=20
>=20
>=20
> 		Hi all,
>=20
> 		I am trying to switch my design from the PLB Temac to the local link
> 		temac, and i have a problem when trying to run ifconfig in my init
> 		script.  It gives me a BUG: soft lockup - CPU#0 stuck for 11s!
> 		[ifconfig:208] Here is the rest of the dump, thanks for your help in
> 		advance. [  233.114960] eth0: XLlTemac: Options: 0x3fa
>=20
> 		[  233.118449] eth0: XLlTemac: allocating interrupt 8 for fifo mode.
>=20
> 		[  237.135029] eth0: XLlTemac: We renegotiated the speed to: 100
>=20
> 		[  237.150339] eth0: XLlTemac: speed set to 100Mb/s
>=20
> 		[  244.792140] BUG: soft lockup - CPU#0 stuck for 11s!
> [ifconfig:204]=20
>=20
>=20
>=20
> 	Hi,
> 	we had a similar error message, which was caused by us selecting the
> wrong PHY type in the kernel configuration menu (latest
> linux-2.6-xlnx-git tree). In fact, we had to modify the lltemac
> driver to support our PHY (BCM5466). Once we did that, the error
> message went away.   =20
>=20
> 	Hugo V.
>=20
>=20
> 	Hugo Villeneuve
> 	Hardware developer | Concepteur mat=E9riel
> 	Lyrtech
> 	Phone/T=E9l. : (1) (418) 877-4644 #2395
> 	Toll-free/Sans frais - Canada & USA : (1) (888) 922-4644 #2395
> 	Fax/T=E9l=E9c. : (1) (418) 877-7710
> 	www.lyrtech.com
> 	Infinite possibilities...TM
>=20
> 	THIS MESSAGE AND ALL ATTACHED DOCUMENTS ARE EXCLUSIVELY INTENDED
> 	TO THE INDICATED RECIPIENTS AND ITS CONTENTS MAY BE CONFIDENTIAL.
> 	IT IS STRICTLY FORBIDDEN TO ANYONE TO TAKE COGNIZANCE, USE, OR
> 	DIVULGE THE INFORMATION CONTAINED HEREIN. IF YOU MISTAKENLY
> 	RECEIVE THIS MESSAGE, IMMEDIATELY INFORM LYRTECH AND DESTROY THE
> 	MESSAGE AND ATTACHMENTS FORTHWITH.THANK YOU.
>=20
> 	LE PRESENT MESSAGE ET LES DOCUMENTS QUI Y SONT JOINTS S'ADRESSENT
> 	EXCLUSIVEMENT AU(X)DESTINATAIRE(S) INDIQUE(S) ET LEUR TENEUR PEUT
> 	ETRE CONFIDENTIELLE. IL EST STRICTEMENT INTERDIT A QUICONQUE D'EN
> 	PRENDRE CONNAISSANCE, DE LES UTILISER OU DE LES DIVULGUER. SI
> 	VOUS RECEVEZ LE PRESENT MESSAGE PAR ERREUR, VEUILLEZ EN AVISER
> 	LYRTECH IMMEDIATEMENT ET DETRUIRE LE MESSAGE SEANCE TENANTE,
> 	AINSI QUE LES DOCUMENTS QUI Y SONT JOINTS.
> 	_______________________________________________
> 	Linuxppc-embedded mailing list
> 	Linuxppc-embedded@ozlabs.org
> 	https://ozlabs.org/mailman/listinfo/linuxppc-embedded



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
