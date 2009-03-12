Return-Path: <Matthias.Lange@beissbarth.com>
Received: from imta1.fe.bosch.de (imta1.fe.bosch.de [139.15.238.164])
	by ozlabs.org (Postfix) with ESMTP id BAFE3DE0E4
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 22:32:30 +1100 (EST)
Received: from smtp2-v.fe.bosch.de (smtp2-v.fe.bosch.de [139.15.237.6])
	by imta1.fe.bosch.de (Postfix) with ESMTP id 0452F3C72B
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 12:24:33 +0100 (CET)
Received: from vsmta3.fe.internet.bosch.com (unknown [10.4.98.30])
	by imta5.fe.bosch.de (Postfix) with ESMTP id 78845140085
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 12:24:29 +0100 (CET)
Received: from fe-imc01.de.bosch.com (vsgw2.fe.internet.bosch.com [10.4.98.13])
	by vsmta3.fe.internet.bosch.com (Postfix) with ESMTP id 0FF2B7B8064
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 12:24:29 +0100 (CET)
From: "EXTERNAL Lange Matthias (AA-DGW/ENG1)" <Matthias.Lange@beissbarth.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Date: Thu, 12 Mar 2009 12:24:26 +0100
Subject: DTS device tree node for dual port RAM
Message-ID: <44C5CFA72BC0E242A53B64DC1E67DEB80A695E6FE2@SI-MBX10.de.bosch.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I am working on a MPC5200-based board. There is a dual port RAM connected t=
o the MPC5200 via the localbus. In my setup one can raise an interrupt at t=
he MPC5200 to signal new that new data has arrived in the dual port RAM. I =
have already found out that the interrupt delivery actually works (do_IRQ g=
ets called when raising the interrupt).

My problem is that my driver (kernel 2.6.24) can not register for the inter=
rupt. Each time I call request_irq I get -ENOSYS. I am suspecting that I ha=
ve done something wrong in my dts defining the dual port RAM. I have define=
d the device as follows

localbus {
        compatible =3D "fsl,orion-localbus",
                     "fsl,mpc5200-localbus",
                     "fsl,pq2-localbus";
        #address-cells =3D <2>;
        #size-cells =3D <1>;
        reg =3D <f0010100 40>;
        ranges =3D <0 0 fe000000 00400000>;

        dpram@40000000 {
                device_type =3D "dpram";
                interrupts =3D <0 0 0>;
                interrupt-parent =3D <&mpc5200_pic>;
        };
};

What am I doing wrong? What am I missing?

Thanks,
Matthias Lange.
