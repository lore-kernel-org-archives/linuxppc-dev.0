Return-Path: <mike_timmons@trimble.com>
Received: from snvl-smtp1.trimble.com (snvl-smtp1.trimble.com [155.63.64.31])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "snvl-smtp1.trimble.com", Issuer "Trimble CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 7FFD4DDDFB
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 Jun 2008 03:09:22 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Question on assigning interrupts in a dts
Date: Thu, 12 Jun 2008 10:09:17 -0700
Message-ID: <161B3BAD77161449A144FF054231C3D6022FDF8A@uss-am-xch-01.am.trimblecorp.net>
In-Reply-To: <48512EB9.3080307@ruggedcom.com>
References: <48512EB9.3080307@ruggedcom.com>
From: "Mike Timmons" <mike_timmons@trimble.com>
To: "Michael Galea" <michaelgalea@ruggedcom.com>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Michael,
I'm familiar with the powerpc 5200 scheme. Under Documents there is a
mpc52xx-device-tree-bindings.txt. In the section titled, "Interrupt
mapping" there is a description of the interrupt values in the dts.

I'm not too familiar with the 8360. The 5200 has different "categories"
(main, crit, perph, and SDMA) of interupts and then numbers within each
category. To support this the 52xx DTS uses a triplet to represent
interrupts in the dts: <L1 L2 L3>.

Taking a quick look at the MPC8360E PowerQUICC II reference manual (Rev
2) I can at least map some of the fields in mpc836x_mds.dts to valuel in
the datasheet (The IPIC looks a little flat compared to the pic in the
5200 so it looks like this is why you don't need the triplet format).

For example, the i2c on-chip peripherals in the dts (i2c@3000 and
i2c@3100) specify interrupts=3D<e 8> and <f 8>, respectively. The 'e' =
and
the 'f' agree with the interrupt ID numbers associated with these I2C
peripherals on page 8-10 of the reference manual.

The '8' could be some sort of interrupt 'level' spec for the devices
that rely on the ipic (note that most of the devices that rely on ipic
as the interrupt-parent specify the '8' after the interrupt ID number).

So, I think we're close to understanding how to specify interrupts under
ipic (so long as you figure out what 8 means), but I don't think it
directly addresses your question. As for your device snippet below,
those look like devices on the QUICC Engine port. In the Reference
manual I do see this at ipic interrupt ID 32 and 33 which agrees.

It looks like the qeic is an interrupt controller beneath the ipic
controller: below you specify qeic as an interrupt controller and assign
the ipic interrupt ids to it (again, I see 32 and 33 in the reference
manual).

In your dts, do you have devices that specify =
interrupt-parent=3D<&qeic>?
I see a few of them in mpc836x_mds.dts. In turn, these devices indicate
only a single value for "interrupts" (interrupts=3D<21>, for example).

I think this must be the bit position for whatever QUICC interrupt port
is associated with the device. Look around in section 8.5 of the
reference manual and see if you can make sense of it.

I decoded the device tree syntax by finding drivers for devices in the
tree, refering to the reference manual(s), and identifying how the
device tree mapped to the chip. Although I'm not well versed on the
8360, just the few minutes I spent above got me pretty close to making
sense of the syntax below. Dig in this direction and it will become
clear.

-Mike



-----Original Message-----
From: linuxppc-embedded-bounces+mike_timmons=3Dtrimble.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+mike_timmons=3Dtrimble.com@ozlabs.org]
On Behalf Of Michael Galea
Sent: Thursday, June 12, 2008 9:12 AM
To: linuxppc-embedded@ozlabs.org
Subject: Question on assigning interrupts in a dts

Hi All,
     I'm building a dts for a custom 8360 based board.  I'm looking at=20
the mpc8360_mds and mpc8360_rdk dts files, trying to figure out how the=20
UCCs (and all peripherals in general) got the values of their=20
"interrupts" properties chosen.  And is there any relationship between=20
the choice of interrupts for ucc1 and the qeic controller..  Can anyone=20
point me some docs for this?

             enet0: ucc@2000 {
                 device_type =3D "network";
                 compatible =3D "ucc_geth";
                 cell-index =3D <1>;
                 reg =3D <0x2000 0x200>;
                 interrupts =3D <32>;
         ..
             };

              enet1: ucc@3000 {
                 device_type =3D "network";
                 compatible =3D "ucc_geth";
                 cell-index =3D <2>;
                 reg =3D <0x3000 0x200>;
                 interrupts =3D <33>;
         ..
             };

             qeic: interrupt-controller@80 {
                 #address-cells =3D <0>;
                 #interrupt-cells =3D <1>;
                 compatible =3D "fsl,qe-ic";
                 interrupt-controller;
                 reg =3D <0x80 0x80>;
                 big-endian;
                 interrupts =3D <32 8 33 8>;
                 interrupt-parent =3D <&ipic>;
             };

Thanks

--=20
Michael Galea

_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
