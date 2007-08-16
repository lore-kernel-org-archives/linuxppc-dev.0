Return-Path: <robertlazarski@gmail.com>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.233])
	by ozlabs.org (Postfix) with ESMTP id 2D4C2DDDFF
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Aug 2007 00:51:17 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id l1so105376nzf
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Aug 2007 07:51:16 -0700 (PDT)
Message-ID: <f87675ee0708160751u14f96dbcs3ad35a147b70a3f3@mail.gmail.com>
Date: Thu, 16 Aug 2007 10:51:15 -0400
From: "robert lazarski" <robertlazarski@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: external IRQ's
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

Hi all, can someone help me with my external interrupts for the
mpc8548e ? I need to define these interrupts our hardware engineer has
defined:

IRQ0 : PHY 0 - TSEC 1 (P0 of the 88E1121R)
IRQ1 : PHY 1 - TSEC 2 (P1 of the 88E1121R)
IRQ2 : PHY 2 - TSEC 3 (88E1111)
IRQ3 : PHY 3 - TSEC 4 (88E1111)

My questions for kernel 2.6.22 and arch powerpc are:

1) Do I need to define those external IRQ's in both a device tree file
under arch/powerpc/boot/dts and also in C code under
arch/powerpc/platforms/85xx ?

2) I've been told on another list that "External interrupts start at
zero (internal interrupt numbers have 0x10 added to them), so the
first cell should correspond to the external IRQ
number."  I'm having a hard time applying that advice to a MDIO node
and ethernet node in the device tree. For example, the CDS board for
8548 has the following:

mdio@24520 {
                        #address-cells = <1>;
                        #size-cells = <0>;
                        device_type = "mdio";
                        compatible = "gianfar";
                        reg = <24520 20>;
                        phy0: ethernet-phy@0 {
                                interrupt-parent = <&mpic>;
                                interrupts = <35 0>;
                                reg = <0>;
                                device_type = "ethernet-phy";
                        };
                        ...
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

I believe for the 8548 there are 11 external interrupts and 48
software interrupts. So in the mdio example above has the first cell
as '35' - is this a software interrupt?

interrupts = <35 0>;

Can I do the following assuming the same second cell sense and level for PHY0 ?

interrupts = <0 0>;

I'm also not getting the ethernet interrupts in the above cds example:

interrupts = <d 2 e 2 12 2>;

Why start with 'd' and 'e' ?  I noticed many if not all boards do that.

3) For the C code in arch/powerpc/platforms/85xx , I see where 0x10
makes sense for internal interrupts. In my case, can I just do:

mpic = mpic_alloc(np, r.start,
                        MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
                        4, 0, " OpenPIC  ");
        BUG_ON(mpic == NULL);

        /* Return the mpic node */
        of_node_put(np);

        /* External Interrupts */
        mpic_assign_isu(mpic, 0, r.start + 0x00000);
        mpic_assign_isu(mpic, 1, r.start + 0x00080);
        mpic_assign_isu(mpic, 2, r.start + 0x00100);
        mpic_assign_isu(mpic, 3, r.start + 0x00180);

Please help!
Robert
