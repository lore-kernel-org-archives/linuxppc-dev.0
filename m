Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 2441167B7B
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Jul 2006 15:06:21 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k6J56KfA010158 for <linuxppc-embedded@ozlabs.org>;
	Tue, 18 Jul 2006 22:06:20 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k6J56IFV008048
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Jul 2006 00:06:19 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: reboot on PQ2FADS board.
Date: Wed, 19 Jul 2006 13:06:39 +0800
Message-ID: <4879B0C6C249214CBE7AB04453F84E4D050B0F@zch01exm20.fsl.freescale.net>
In-Reply-To: <f9a7e7a80607172040lcf0a280x5df9f44d10a0b7d6@mail.gmail.com>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Lei Sun" <leisun124@gmail.com>, <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: linuxppc-embedded-bounces+leoli=3Dfreescale.com@ozlabs.org
> [mailto:linuxppc-embedded-bounces+leoli=3Dfreescale.com@ozlabs.org] On
Behalf Of Lei Sun
> Sent: Tuesday, July 18, 2006 11:41 AM
> To: linuxppc-embedded@ozlabs.org
> Subject: reboot on PQ2FADS board.
>=20
> Hi:
>     I have linux 2.4.30 runnning on this board, the "reboot -f"
> command cause machine check and kernel ooops.  The problem seems in
> the "m8260_gorom" in head.S.  The restart() function in m8260_setup.c
> passed 2 parameters to that assembly code, r3 is the bd_info , r4 is
> the warm start address,  I changed it to 0xFF800100, that's where the
> u-boot's _start_warm lives, I have verified that address by typing "g
> ff800100" in u-boot console, which cause the board reset.

Are you sure ff800100 is _start_warm lives?  In latest u-boot
_start_warm is at
EXC_OFF_SYS_RESET + 0x10.  In your case, that will be 0xff800110.
Please try
with the correct address.

>     I assume the m8260_gorom  has been heavily tested for other
> boards. I wonder if anyone got a PQ2FADS-VR board that has the similar
> problem?  I am not familar with the assembly code for PPC.  Any
> suggestions?
>=20
> Thanks
> lei
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
