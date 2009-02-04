Return-Path: <tobias.knutsson@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.173])
	by ozlabs.org (Postfix) with ESMTP id 23533DDDF0
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Feb 2009 03:53:33 +1100 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so2677269wfg.15
	for <linuxppc-dev@ozlabs.org>; Wed, 04 Feb 2009 08:53:32 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 4 Feb 2009 17:53:32 +0100
Message-ID: <ccb913ac0902040853o395a7f25x855b477453c76c33@mail.gmail.com>
Subject: MPC5200 PCI Issues
From: Tobias Knutsson <tobias.knutsson@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I am currently trying to get an MPC5200-based board to run Linux
2.6.28. Most of the devices are working, however i have some issues
with the PCI-bus. More precisely, the issue is that all of
the cards' IO-regions are mapped to address 0x0.

In my device tree I have the following:

       pci@f0000d00 {
               #interrupt-cells =3D <1>;
               #size-cells =3D <2>;
               #address-cells =3D <3>;
               device_type =3D "pci";
               compatible =3D "fsl,mpc5200b-pci","fsl,mpc5200-pci";
               reg =3D <0xf0000d00 0x100>;
               interrupt-map-mask =3D <0xf800 0 0 7>;
               interrupt-map =3D <0xb000 0 0 1 &mpc5200_pic 0 0 3 // MPC520=
0
                                0xb000 0 0 2 &mpc5200_pic 0 0 3
                                0xb000 0 0 3 &mpc5200_pic 0 0 3
                                0xb000 0 0 4 &mpc5200_pic 0 0 3

                                0xb800 0 0 1 &mpc5200_pic 1 1 3 // c64x0
                                0xb800 0 0 2 &mpc5200_pic 1 1 3
                                0xb800 0 0 3 &mpc5200_pic 1 1 3
                                0xb800 0 0 4 &mpc5200_pic 1 1 3

                                0xc000 0 0 1 &mpc5200_pic 1 1 3 // c64x1
                                0xc000 0 0 2 &mpc5200_pic 1 1 3
                                0xc000 0 0 3 &mpc5200_pic 1 1 3
                                0xc000 0 0 4 &mpc5200_pic 1 1 3

                                0xc800 0 0 1 &mpc5200_pic 1 1 3 // c64x2
                                0xc800 0 0 2 &mpc5200_pic 1 1 3
                                0xc800 0 0 3 &mpc5200_pic 1 1 3
                                0xc800 0 0 4 &mpc5200_pic 1 1 3

                                0xd000 0 0 1 &mpc5200_pic 1 1 3 // c64x3
                                0xd000 0 0 2 &mpc5200_pic 1 1 3
                                0xd000 0 0 3 &mpc5200_pic 1 1 3
                                0xd000 0 0 4 &mpc5200_pic 1 1 3

                                0xd800 0 0 1 &mpc5200_pic 1 1 3 // c64x4
                                0xd800 0 0 2 &mpc5200_pic 1 1 3
                                0xd800 0 0 3 &mpc5200_pic 1 1 3
                                0xd800 0 0 4 &mpc5200_pic 1 1 3>;

               clock-frequency =3D <0x1e84800>;  //<0>; // From boot loader
               interrupts =3D <2 8 0 2 9 0 2 10 0>;
               interrupt-parent =3D <&mpc5200_pic>;
               bus-range =3D <0 0>;
               ranges =3D <0x02000000 0 0x50000000 0x50000000 0 0x10000000
                         0x01000000 0 0x00000000 0x60000000 0 0x01000000>;
       };

The cards' memory regions are mapped out fine to different addresses
in the 0x50000000-0x60000000 range. However, the IO regions are all mapped
to zero.

Do you have any idea on what could be wrong or in which direction I
should be looking?


--=20

H=E4lsningar/Regards
Tobias Knutsson
