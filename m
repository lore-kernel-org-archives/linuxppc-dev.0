Return-Path: <Joakim.Tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7A756DDFE1
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Apr 2009 22:55:03 +1000 (EST)
Received: from sesr04.transmode.se (sesr04.transmode.se [192.168.201.15])
	by gw1.transmode.se (Postfix) with ESMTP id 9CE214F168
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Apr 2009 14:54:57 +0200 (CEST)
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Subject: OF PCI howto?
Message-ID: <OF2E7A8F65.EA7B7D26-ONC1257599.004624DB-C1257599.0046F2EB@transmode.se>
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Date: Wed, 15 Apr 2009 14:54:57 +0200
Content-Type: text/plain; charset="US-ASCII"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I have just started to add PCI support to our custom MPC832x board
and I have a hard time figuring out how to describe this in the
dts. Looking at mpc832x_mds.dts I see:

        pci0: pci@e0008500 {
                cell-index = <1>;
                interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
                interrupt-map = <
                                /* IDSEL 0x11 AD17 */
                                 0x8800 0x0 0x0 0x1 &ipic 20 0x8
                                 0x8800 0x0 0x0 0x2 &ipic 21 0x8
                                 0x8800 0x0 0x0 0x3 &ipic 22 0x8
                                 0x8800 0x0 0x0 0x4 &ipic 23 0x8

                                /* IDSEL 0x12 AD18 */
                                 0x9000 0x0 0x0 0x1 &ipic 22 0x8
                                 0x9000 0x0 0x0 0x2 &ipic 23 0x8
                                 0x9000 0x0 0x0 0x3 &ipic 20 0x8
                                 0x9000 0x0 0x0 0x4 &ipic 21 0x8

                                /* IDSEL 0x13 AD19 */
                                 0x9800 0x0 0x0 0x1 &ipic 23 0x8
                                 0x9800 0x0 0x0 0x2 &ipic 20 0x8
                                 0x9800 0x0 0x0 0x3 &ipic 21 0x8
                                 0x9800 0x0 0x0 0x4 &ipic 22 0x8

                                /* IDSEL 0x15 AD21*/
                                 0xa800 0x0 0x0 0x1 &ipic 20 0x8
                                 0xa800 0x0 0x0 0x2 &ipic 21 0x8
                                 0xa800 0x0 0x0 0x3 &ipic 22 0x8
                                 0xa800 0x0 0x0 0x4 &ipic 23 0x8

                                /* IDSEL 0x16 AD22*/
                                 0xb000 0x0 0x0 0x1 &ipic 23 0x8
                                 0xb000 0x0 0x0 0x2 &ipic 20 0x8
                                 0xb000 0x0 0x0 0x3 &ipic 21 0x8
                                 0xb000 0x0 0x0 0x4 &ipic 22 0x8

                                /* IDSEL 0x17 AD23*/
                                 0xb800 0x0 0x0 0x1 &ipic 22 0x8
                                 0xb800 0x0 0x0 0x2 &ipic 23 0x8
                                 0xb800 0x0 0x0 0x3 &ipic 20 0x8
                                 0xb800 0x0 0x0 0x4 &ipic 21 0x8

                                /* IDSEL 0x18 AD24*/
                                 0xc000 0x0 0x0 0x1 &ipic 21 0x8
                                 0xc000 0x0 0x0 0x2 &ipic 22 0x8
                                 0xc000 0x0 0x0 0x3 &ipic 23 0x8
                                 0xc000 0x0 0x0 0x4 &ipic 20 0x8>;
                interrupt-parent = <&ipic>;
                interrupts = <66 0x8>;
                bus-range = <0x0 0x0>;
                ranges = <0x02000000 0x0 0x90000000 0x90000000 0x0 
0x10000000
                          0x42000000 0x0 0x80000000 0x80000000 0x0 
0x10000000
                          0x01000000 0x0 0x00000000 0xd0000000 0x0 
0x00100000>;
                clock-frequency = <0>;
                #interrupt-cells = <1>;
                #size-cells = <2>;
                #address-cells = <3>;
                reg = <0xe0008500 0x100         /* internal registers */
                       0xe0008300 0x8>;         /* config space access 
registers */
                compatible = "fsl,mpc8349-pci";
                device_type = "pci";
        };

But I can't figure out what all this mean.
The board will have one PCI device connected directly to the CPU. Is the 
above
dts fragment correct for my setup? If not, is there a better example I can 
look at?

   Jocke
