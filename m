Return-Path: <albrecht.dress@arcor.de>
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net
	[151.189.21.47])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 78D9BDE138
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 00:13:16 +1000 (EST)
Received: from mail-in-08-z2.arcor-online.net (mail-in-08-z2.arcor-online.net
	[151.189.8.20]) by mx.arcor.de (Postfix) with ESMTP id A298D3CAC26
	for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2009 16:13:05 +0200 (CEST)
Received: from mail-in-08.arcor-online.net (mail-in-08.arcor-online.net
	[151.189.21.48])
	by mail-in-08-z2.arcor-online.net (Postfix) with ESMTP id AFC03212FA9
	for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2009 16:13:05 +0200 (CEST)
Received: from webmail10.arcor-online.net (webmail10.arcor-online.net
	[151.189.8.93])
	by mail-in-08.arcor-online.net (Postfix) with ESMTP id 8E7DD2AF3F9
	for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2009 16:13:05 +0200 (CEST)
Message-ID: <14558983.1242828785546.JavaMail.ngmail@webmail10.arcor-online.net>
Date: Wed, 20 May 2009 16:13:05 +0200 (CEST)
From: "Albrecht Dreﬂ" <albrecht.dress@arcor.de>
To: linuxppc-dev@ozlabs.org
Subject: Weird 5200/mtd-ram problem
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

I ran into a weird problem when I tried to access a static (NV) ram attache=
d to the localbus of a '5200 using Wolfram's mtd-ram OF driver (on a stock =
2.6.29.1 kernel).  The 512k ram chip is connected in 16-bit mode to cs1.  t=
he of entry reads

nvram@1,0 {
=09compatible =3D "mtd-ram";
=09reg =3D <1 0x0 0x00080000>;      // 512 kB
=09bank-width =3D <2>;
=09device-width =3D <2>;
=09#size-cells =3D <1>;
=09#address-cells =3D <1>;
=09};

For the test I created a "pattern file" which is filled with the unsigned l=
ong 0x0055aaff.  Using the Abatron BDI3000, I can write the pattern file to=
 the ram and re-read it without problems.  The same applies to u-boot (writ=
e ram via tftp, dump contents).

In Linux, when I write the file to /dev/mtdx, the last dword of each block =
is broken, e.g. when running "dd if=3Dpattern of=3D/dev/mtd5 bs=3D512" the =
dword's at offset 0x1fc, 0x3fc, ... are 0x0000aaaa (instead of 0x0055aaff),=
 if I use bs=3D1024 the dwords at 0x3fc, 0x7fc, ... show this value, if I u=
se bs=3D4096 the dword at 0xffc shows this value, etc.  I looked at the CS/=
WR lines with a scope, and I couldn't see anything special.  The timing sho=
uld be fine, as u-boot uses the same as Linux.

Any idea what goes wrong here?  I guessed I missed something in the LPB set=
up...

Thanks in advance,
Albrecht.

Arcor.de Gaming Area - kostenfrei daddeln bis der Arzt kommt!
Jetzt checken und aus =FCber 80 Spielen w=E4hlen!
http://www.arcor.de/footer-gaming/
