Return-Path: <bounces@nabble.com>
Received: from sam.nabble.com (sam.nabble.com [216.139.236.26])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9BD0EB6F86
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Jun 2011 18:56:11 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <bounces@nabble.com>) id 1QZJEE-0007DM-G0
	for linuxppc-dev@ozlabs.org; Wed, 22 Jun 2011 01:56:06 -0700
Message-ID: <31901492.post@talk.nabble.com>
Date: Wed, 22 Jun 2011 01:56:06 -0700 (PDT)
From: Vasanth Ragavendran <ragavendrapec@yahoo.co.in>
To: linuxppc-dev@ozlabs.org
Subject: GPIO MPC8315 board
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi
=20
I am using a MPC8315ERDB board. For this i've an external button which is
connected to GPIO pin 7 of the board. And if this button is pressed then
certain files have to be deleted. Browsing through the internet i found tha=
t
GPIO drivers have to be included into the kernel and hence i set a 'y' to
CONFIG_MPC8xxx_GPIO, CONFIG_GPIO_SYSFS and CONFIG_ARCH_WANT_OPTIONAL_GPIOLI=
B
etc. And the dts file has be modified to include the following lines=20
=20
gpio1: gpio-controller@c00 {               =20
#gpio-cells =3D <2>;               =20
compatible =3D "fsl,mpc8315-gpio", "fsl,mpc8349-gpio";               =20
reg =3D <0xc00 0x100>;               =20
interrupts =3D <74 0x8>;               =20
interrupt-parent =3D <&ipic>;               =20
gpio-controller;         };         =20
=20
this is included under immr@e0000000.
=20
further i included
=20
erase-button@0 {
compatible =3D "erase-button";
interrupts =3D <7 2>;
interrupt-parent =3D <&gpio1>;
};
=20
am i right in including this? coz after compiling the kernel i get a folder
under /sys/class/gpio. I did an export using
=20
echo 224 > /sys/class/gpio/export.
=20
224 was the number appearing in gpiochip224/base.
=20
It created another folder gpio224.
=20
However i'm not able to set the value in them nor the direction.
=20
echo 1 > /sys/class/gpio/gpio224/value
cat /sys/class/gpio/gpio224/value=EF=BB=BF
returns a value of 0 only.
=20
however the direction is "in"
cat /sys/class/gpio/gpio224/direction
in

Am i doing it correctly? How to check it programatically if the button is
pressed and take the corresponding action! Plz help!
=20
My kernel version is 2.6.35.9.
=20
Thanking you in advance.
--=20
View this message in context: http://old.nabble.com/GPIO-MPC8315-board-tp31=
901492p31901492.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
