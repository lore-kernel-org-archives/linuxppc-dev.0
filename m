Return-Path: <hugo.villeneuve@lyrtech.com>
Received: from tomts33-srv.bellnexxia.net (tomts33-srv.bellnexxia.net
	[209.226.175.107]) by ozlabs.org (Postfix) with ESMTP id 937C4DE1B4
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Apr 2008 23:19:37 +1000 (EST)
Received: from toip37-bus.srvr.bell.ca ([67.69.240.38])
	by tomts33-srv.bellnexxia.net
	(InterMail vM.5.01.06.13 201-253-122-130-113-20050324) with ESMTP id
	<20080416131935.JWZY1809.tomts33-srv.bellnexxia.net@toip37-bus.srvr.bell.ca>
	for <linuxppc-embedded@ozlabs.org>; Wed, 16 Apr 2008 09:19:35 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: XLlTemac  soft lockup BUG
Date: Wed, 16 Apr 2008 09:19:34 -0400
Message-ID: <42848A5C5A0D1E47B026E644DD49B08E025AA69F@mail>
In-Reply-To: <16711066.post@talk.nabble.com>
References: <16711066.post@talk.nabble.com>
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

linuxppc-embedded-bounces+hugo.villeneuve=3Dlyrtech.com@ozlabs.org =
wrote:
> Hi all,
>=20
> I am trying to switch my design from the PLB Temac to the local link
> temac, and i have a problem when trying to run ifconfig in my init
> script.  It gives me a BUG: soft lockup - CPU#0 stuck for 11s!
> [ifconfig:208] Here is the rest of the dump, thanks for your help in
> advance. [  233.114960] eth0: XLlTemac: Options: 0x3fa  =20
>=20
> [  233.118449] eth0: XLlTemac: allocating interrupt 8 for fifo mode.
>=20
> [  237.135029] eth0: XLlTemac: We renegotiated the speed to: 100
>=20
> [  237.150339] eth0: XLlTemac: speed set to 100Mb/s
>=20
> [  244.792140] BUG: soft lockup - CPU#0 stuck for 11s! [ifconfig:204]

Hi,
we had a similar error message, which was caused by us selecting the =
wrong PHY type in the kernel configuration menu (latest =
linux-2.6-xlnx-git tree). In fact, we had to modify the lltemac driver =
to support our PHY (BCM5466). Once we did that, the error message went =
away.

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
