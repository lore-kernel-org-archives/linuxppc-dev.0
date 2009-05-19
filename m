Return-Path: <albrecht.dress@arcor.de>
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net
	[151.189.21.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1CED3DE128
	for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2009 21:59:18 +1000 (EST)
Received: from mail-in-02-z2.arcor-online.net (mail-in-02-z2.arcor-online.net
	[151.189.8.14]) by mx.arcor.de (Postfix) with ESMTP id 553482BACF6
	for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2009 13:59:00 +0200 (CEST)
Received: from mail-in-16.arcor-online.net (mail-in-16.arcor-online.net
	[151.189.21.56])
	by mail-in-02-z2.arcor-online.net (Postfix) with ESMTP id 493311140B2
	for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2009 13:59:00 +0200 (CEST)
Received: from webmail15.arcor-online.net (webmail15.arcor-online.net
	[151.189.8.68])
	by mail-in-16.arcor-online.net (Postfix) with ESMTP id 374B22572F3
	for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2009 13:59:00 +0200 (CEST)
Message-ID: <5023288.1242734340173.JavaMail.ngmail@webmail15.arcor-online.net>
Date: Tue, 19 May 2009 13:59:00 +0200 (CEST)
From: "Albrecht Dreﬂ" <albrecht.dress@arcor.de>
To: linuxppc-dev@ozlabs.org
Subject: Q: MTD RAM in OF Device Tree
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

is there a standard way to define a ram chip (in my case a battery-buffered=
 nv ram, attached to the 5200's Local Bus) in the OF tree, and are there an=
y drivers (on 2.6.29.1) which pick up the chip/partition specification for =
mtd?  Does such a driver exist, or do I have to write one (probably based o=
n plat-ram.c?)?  I think of something like

localbus {
=09[...]
=09ranges =3D < 0 0 0xfe000000 0x02000000
=09=09   1 0 0xfc000000 0x00080000>;

        flash@0,0 {
=09=09[flash definition & partitions]
=09};

=09nvram@1,0 {
=09=09compatible =3D "mtd-ram";
=09=09reg =3D <1 0x0 0x00080000>;
=09=09bank-width =3D <2>;
=09=09device-width =3D <2>;
=09=09#size-cells =3D <1>;
=09=09#address-cells =3D <1>;
=09=09part@0 {
=09=09=09label =3D "pdata";
=09=09=09reg =3D <0x00000000 0x00080000>;
=09=09};
=09};
};

Thanks,
Albrecht.

Arcor.de Gaming Area - kostenfrei daddeln bis der Arzt kommt!
Jetzt checken und aus =FCber 80 Spielen w=E4hlen!
http://www.arcor.de/footer-gaming/
