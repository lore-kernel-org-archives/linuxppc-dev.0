Return-Path: <smitha.vanga@wipro.com>
Received: from wipro-blr-out02.wipro.com (wipro-blr-out02.wipro.com
	[203.91.198.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0328FB6F62
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  8 Aug 2011 15:53:11 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: FW: Ethernet driver WR linux
Date: Mon, 8 Aug 2011 11:23:02 +0530
Message-ID: <07ACDFB8ECA8EF47863A613BC01BBB220344E6CD@HYD-MKD-MBX02.wipro.com>
In-Reply-To: <4E3C3270.2010705@freescale.com>
From: <smitha.vanga@wipro.com>
To: <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

 
Hi Scott,

Below is the .dts file. My board is based on mpc8247. Currently using
FCC1.

/*
 * MPC8272 EPN412 Device Tree Source
 *
 * Copyright 2005 Freescale Semiconductor Inc.
 *
 * This program is free software; you can redistribute  it and/or modify
it
 * under  the terms of  the GNU General  Public License as published by
the
 * Free Software Foundation;  either version 2 of the  License, or (at
your
 * option) any later version.
 */

/ {
       model =3D "MPC8247 EPN412";
       compatible =3D "MPC82XX";
       #address-cells =3D <1>;
       #size-cells =3D <1>;
       linux,phandle =3D <100>;

       cpus {
               #cpus =3D <1>;
               #address-cells =3D <1>;
               #size-cells =3D <0>;
               linux,phandle =3D <200>;

               PowerPC,8247@0 {
                       device_type =3D "cpu";
                       reg =3D <0>;
                       d-cache-line-size =3D <20>;       // 32 bytes
                       i-cache-line-size =3D <20>;       // 32 bytes
                       d-cache-size =3D <4000>;          // L1, 16K
                       i-cache-size =3D <4000>;          // L1, 16K
                       timebase-frequency =3D <0>;
                       bus-frequency =3D <0>;
                       clock-frequency =3D <0>;
                       32-bit;
                       linux,phandle =3D <201>;
               };
       };

       interrupt-controller@f8200000 {
               linux,phandle =3D <f8200000>;
               #address-cells =3D <0>;
               #interrupt-cells =3D <2>;
               interrupt-controller;
               reg =3D <f8200000 f8200004>;
               built-in;
               device_type =3D "pci-pic";
       };

       memory {
               device_type =3D "memory";
               linux,phandle =3D <300>;
               reg =3D <00000000 4000000>;
       };


       soc8272@f0000000 {
               #address-cells =3D <1>;
               #size-cells =3D <1>;
               #interrupt-cells =3D <2>;
               device_type =3D "soc";
               ranges =3D <00000000 f0000000 00053000>;
               reg =3D <f0000000 10000>;

               cpm@119c0{
                       linux,phandle =3D <f0000000>;
                       #address-cells =3D <1>;
                       #size-cells =3D <1>;
                       #interrupt-cells =3D <2>;
                       device_type =3D "cpm";
                       model =3D "CPM2";
                       ranges =3D <00000000 00000000 20000>;
                       reg =3D <0 20000>;
                       command-proc =3D <119c0>;
                       brg-frequency =3D <FE70B8>;
                       cpm_clk =3D <7F385C0>;

                       scc@11a00 {
                               device_type =3D "serial";
                               compatible =3D "cpm_uart";
                               model =3D "SCC";
                               device-id =3D <1>;
                               reg =3D <11a00 20 8000 100>;
                               current-speed =3D <2580>;
                               interrupts =3D <28 2>;
                               interrupt-parent =3D <10c00>;
                               clock-setup =3D <0 00ffffff>;
                               rx-clock =3D <1>;
                               tx-clock =3D <1>;
                       };

			mdio@10d40 {
                       device_type =3D "mdio";
                       compatible =3D "fs_enet";
                       reg =3D <0 0>;
                       linux,phandle =3D <24520>;
                       #address-cells =3D <1>;
                       #size-cells =3D <0>;
                       ethernet-phy@0 {
                               linux,phandle =3D <2452000>;
                               interrupt-parent =3D <10c00>;
                               interrupts =3D <17 4>;
                               reg =3D <0>;
                               bitbang =3D [ 12 12 13 02 02 01 ];
                               device_type =3D "ethernet-phy";
                       };
                      
               };
			ethernet@11300 {
                       #address-cells =3D <1>;
                       #size-cells =3D <0>;
                       device_type =3D "network";
                       device-id =3D <1>;
                       compatible =3D "fs_enet";
                       model =3D "FCC";
                       reg =3D <11300 20 8400 100 11380 30>;
                       mac-address =3D [ 00 e0 ee 00 05 2e ];
                       interrupts =3D <20 2>;
                       interrupt-parent =3D <10c00>;
                       phy-handle =3D <2452000>;
                       rx-clock =3D <13>;
                       tx-clock =3D <12>;
               };


 			                      

               };
               interrupt-controller@10c00 {
                       linux,phandle =3D <10c00>;
                       #address-cells =3D <0>;
                       #interrupt-cells =3D <2>;
                       interrupt-controller;
                       reg =3D <10c00 80>;
                       built-in;
                       device_type =3D "cpm-pic";
		       compatible =3D "CPM2";
               };

               flash@fe000000 {
			                device_type =3D "rom";
			                compatible =3D "direct-mapped";
			                probe-type =3D "CFI";
			                reg =3D <fe000000 00800000>;
			                bank-width =3D <1>;
			                partitions =3D <00780000 00080000
			                              00770000 00010000
			                              00760000 00010000
			                              00750000
00010000>;
			                partition-names =3D
"u-boot\0u-boot env1\0u-boot env2\0id data";
		};

               


       };
};

Regards,
Smitha

Please do not print this email unless it is absolutely necessary. =0A=
=0A=
The information contained in this electronic message and any attachments to=
 this message are intended for the exclusive use of the addressee(s) and may=
 contain proprietary, confidential or privileged information. If you are not=
 the intended recipient, you should not disseminate, distribute or copy this=
 e-mail. Please notify the sender immediately and destroy all copies of this=
 message and any attachments. =0A=
=0A=
WARNING: Computer viruses can be transmitted via email. The recipient should=
 check this email and any attachments for the presence of viruses. The compa=
ny accepts no liability for any damage caused by any virus transmitted by th=
is email. =0A=
=0A=
www.wipro.com
