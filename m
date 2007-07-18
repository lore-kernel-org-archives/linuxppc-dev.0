Return-Path: <ma.alvarez@usyscom.com>
Received: from correo.ziv.es (correo.ziv.es [212.55.31.237])
	by ozlabs.org (Postfix) with ESMTP id 469ADDDE2C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 18 Jul 2007 21:51:59 +1000 (EST)
Message-ID: <469DFC03.9080201@ziv.es>
Date: Wed, 18 Jul 2007 13:39:47 +0200
From: "Miguel Angel Alvarez" <ma.alvarez@ziv.es>
MIME-Version: 1.0
To: <linuxppc-embedded@ozlabs.org>
Subject: mpc52xx: Correct calculation of FEC RX errors???
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1"
Cc: tnt@246tNt.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi

We are showing figures of more than 4 billion error frames in our=20
ethernet interfaces. We have tested that the problem is in a=20
substraction (the number of errors decrements with the number of =
frames).

So... looking in the fec driver (fec.c) for the calculations we have=20
seen that the number of multicast packets is added to the number of=20
correct frames in order to get the frame errors...

But the interesting thing is that we have checked that this calculation=20
is something that we have added with a patch by Grzegorz Bernacki in=20
this list.

So... The funny thing is... Why a patch that solves the problem for=20
Grzegorz produces "the same problem" for us?

And... by the way... I have seen IEEE802.3, and when they talk about=20
aFramesReceivedOK (which I suppose is the ieee_r_frame_ok in the=20
driver), and they do not say a word about not including multicast=20
packets in it...

Any comment will be appreciate.

Miguel =C1ngel =C1lvarez
**=20
=20
----------------------------------------- PLEASE NOTE =
-------------------------------------------
This message, along with any attachments, may be confidential or legally =
privileged.=20
It is intended only for the named person(s), who is/are the only =
authorized recipients.
If this message has reached you in error, kindly destroy it without =
review and notify the sender immediately.
Thank you for your help.
ZIV uses virus scanning software but excludes any liability for viruses =
contained in any attachment.
=20
------------------------------------ ROGAMOS LEA ESTE TEXTO =
-------------------------------
Este mensaje y sus anexos pueden contener informaci=F3n confidencial y/o =
con derecho legal.=20
Est=E1 dirigido =FAnicamente a la/s persona/s o entidad/es rese=F1adas =
como =FAnico destinatario autorizado.
Si este mensaje le hubiera llegado por error, por favor elim=EDnelo sin =
revisarlo ni reenviarlo y notif=EDquelo inmediatamente al remitente. =
Gracias por su colaboraci=F3n. =20
ZIV utiliza software antivirus, pero no se hace responsable de los virus =
contenidos en los ficheros anexos.
