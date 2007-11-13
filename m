Return-Path: <robertlazarski@gmail.com>
Received: from rn-out-0102.google.com (rn-out-0910.google.com [64.233.170.188])
	by ozlabs.org (Postfix) with ESMTP id 01C56DDE09
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Nov 2007 07:17:40 +1100 (EST)
Received: by rn-out-0102.google.com with SMTP id e25so950251rng
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Nov 2007 12:17:39 -0800 (PST)
Message-ID: <f87675ee0711131217q6bb54e06q74f7d16e79b94f19@mail.gmail.com>
Date: Tue, 13 Nov 2007 15:17:37 -0500
From: "robert lazarski" <robertlazarski@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: 85xx Device tree problems: e0024520:02 not found
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

I'm trying to bring up a new 8548 board on 2.6.23.1 . When booting,
Some times I can get as far mounting over nfs. However, it gets stuck
here:

NET: Registered protocol family 1
NET: Registered protocol family 17
e0024520:02 not found
eth2: Could not attach to PHY
IP-Config: Failed to open eth2
IP-Config: Device `eth2' not found.

I can ping and tftp via u-boot just fine over eth2 - which runs
marvells 88E1111 . Here's the relavent part of my device tree:

               mdio@24520 {
                       #address-cells = <1>;
                       #size-cells = <0>;
                       device_type = "mdio";
                       compatible = "gianfar";
                       reg = <24520 20>;
                       phy0: ethernet-phy@0 {
                               interrupt-parent = <&mpic>;
                               interrupts = <0 1>;
                               reg = <0>;
                               device_type = "ethernet-phy";
                       };
                       phy1: ethernet-phy@1 {
                               interrupt-parent = <&mpic>;
                               interrupts = <1 1>;
                               reg = <1>;
                               device_type = "ethernet-phy";
                       };
                       phy2: ethernet-phy@2 {
                               interrupt-parent = <&mpic>;
                               interrupts = <2 1>;
                               reg = <2>;
                               device_type = "ethernet-phy";
                       };
                       phy3: ethernet-phy@3 {
                               interrupt-parent = <&mpic>;
                               interrupts = <3 1>;
                               reg = <3>;
                               device_type = "ethernet-phy";
                       };
               };
               ethernet@24000 {
                       #address-cells = <1>;
                       #size-cells = <0>;
                       device_type = "network";
                       model = "eTSEC";
                       compatible = "gianfar";
                       reg = <24000 1000>;
                       local-mac-address = [ 00 E0 0C 00 73 00 ];
                       interrupts = <d 2 e 2 12 2>;
                       interrupt-parent = <&mpic>;
                       phy-handle = <&phy0>;
               };

               ethernet@25000 {
                       #address-cells = <1>;
                       #size-cells = <0>;
                       device_type = "network";
                       model = "eTSEC";
                       compatible = "gianfar";
                       reg = <25000 1000>;
                       local-mac-address = [ 00 E0 0C 00 73 01 ];
                       interrupts = <13 2 14 2 18 2>;
                       interrupt-parent = <&mpic>;
                       phy-handle = <&phy1>;
               };

               ethernet@26000 {
                       #address-cells = <1>;
                       #size-cells = <0>;
                       device_type = "network";
                       model = "eTSEC";
                       compatible = "gianfar";
                       reg = <26000 1000>;
                       local-mac-address = [ 00 E0 0C 00 73 02 ];
                       interrupts = <f 2 10 2 11 2>;
                       interrupt-parent = <&mpic>;
                       phy-handle = <&phy2>;
               };

               ethernet@27000 {
                       #address-cells = <1>;
                       #size-cells = <0>;
                       device_type = "network";
                       model = "eTSEC";
                       compatible = "gianfar";
                       reg = <27000 1000>;
                       local-mac-address = [ 00 E0 0C 00 73 03 ];
                       interrupts = <15 2 16 2 17 2>;
                       interrupt-parent = <&mpic>;
                       phy-handle = <&phy3>;
               };


Any ideas?
Robert
