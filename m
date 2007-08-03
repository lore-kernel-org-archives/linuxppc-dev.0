Return-Path: <tmorrison@empirix.com>
Received: from empbedex1.empirix.com (empbedex1.empirix.com [12.38.203.54])
	by ozlabs.org (Postfix) with ESMTP id 9C606DDDFA
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Aug 2007 08:54:14 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Trying to use Device Tree...and getting continuous interrupts from
	attached 88e1145
Date: Fri, 3 Aug 2007 18:54:05 -0400
Message-ID: <BD261180E6D35F4D9D32F3E44FD3D90108BE44C2@EMPBEDEX.empirix.com>
From: "Morrison, Tom" <tmorrison@empirix.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

All,

Connected to eth1 (etsec2) of my mpc8548 cpu is a 88E1145 and I=20
am trying to get the core functionality running with the device tree
paradigm - I know the sense of the 88E1145 is active-low for my=20
mpc8548 board and have it working with an older 2.6.11++ kernel. =20

I built this new kernel with the marvell driver - it seemingly=20
does all the same things we did in the 2.6.11 kernel in separate=20
spots...

Here is the appropriate parts of my device tree for this part of the
core...

>>		mdio@24520 {
>>			#address-cells =3D <1>;
>>			#size-cells =3D <0>;
>>			device_type =3D "mdio";
>>			compatible =3D "gianfar";=09
>>			reg =3D <24520 20>;
>>			phy1: ethernet-phy@1 {
>>				interrupt-parent =3D <&mpic>;
>>				interrupts =3D <37 1>;
>>				reg =3D <11>;
>>				device_type =3D "ethernet-phy";
>>			};
>>		};=09
>>		ethernet@25000 {
>>			#address-cells =3D <1>;
>>			#size-cells =3D <0>;
>>			device_type =3D "network";
>>			model =3D "eTSEC";
>>			compatible =3D "gianfar";
>>			reg =3D <25000 1000>;
>>			local-mac-address =3D [ 00 00 00 00 00 00 ];
>>			interrupts =3D <23 2 24 2 28 2>;
>>			interrupt-parent =3D <&mpic>;
>>			phy-handle =3D <&phy1>;
>>		};
>>		mpic: pic@40000 {
>>			clock-frequency =3D <0>;
>>			interrupt-controller;
>>			#address-cells =3D <0>;
>>			#interrupt-cells =3D <2>;
>>			reg =3D <40000 40000>;
>>			built-in;
>>			compatible =3D "chrp,open-pic";
>>			device_type =3D "open-pic";
>>                        big-endian;
>>		};

The device tree seems to be parsed OK:

>> of_irq_map_one: dev=3D/soc8548@e0000000/mdio@24520/ethernet-phy@1,
index=3D0
>>  	intsize=3D2 intlen=3D2
>> of_irq_map_raw: =
par=3D/soc8548@e0000000/pic@40000,intspec=3D[0x00000037
>>  	0x00000001...],ointsize=3D2
>> of_irq_map_raw: ipar=3D/soc8548@e0000000/pic@40000, size=3D2
>> mpic: xlate (2 cells: 0x00000037 0x00000001) to line 0x37 sense 0x8

Now, that looks OK! Those are what I would expect. And when the=20
mdio/phy are probed, configured, and the 88E1145 interrupt (EXT7=20
(0x37H)) is enabled, the interrupt never (seemingly) gets cleared,
and basically hangs the entire box up and eventually it panics!

I don't even have an external phy(SFP) connected to this 88e1148 phy..

I am at a lost - is there something I am missing in device tree?=20
Help mr. wizard (Kumar?)...

Tom
