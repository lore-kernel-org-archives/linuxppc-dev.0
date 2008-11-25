Return-Path: <walsh.benj@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.30])
	by ozlabs.org (Postfix) with ESMTP id 29106DDDE3
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Nov 2008 09:22:38 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so107143yxg.39
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 25 Nov 2008 14:22:37 -0800 (PST)
From: "Benjamin Walsh" <walsh.benj@gmail.com>
To: "Chen, Tiejun" <Tiejun.Chen@windriver.com>
References: <DF6C7BC3780EE44B83430A9F756D43B6086F5441@SJEXCH03.ds.jdsu.net>	<113760FDF39C3E40AAB8DE6E6C64D0A781B747@zch01exm26.fsl.freescale.net>
	<012201c94e74$3dbb55b0$e693e080@corp.ad.wrs.com>
	<492BD099.9000903@windriver.com>
Subject: RE: NMI and AMD8131/8111 on Maple board
Date: Tue, 25 Nov 2008 17:22:25 -0500
Message-ID: <013801c94f4c$51d25f20$e693e080@corp.ad.wrs.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <492BD099.9000903@windriver.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> The AMD8131/8130 can generate an NMI to the CPC925. There is 
> an interrupt
> controller resided in the CPC925. And you know the CPC925 is 
> attached the
> PowerPC PPC970FX. The interrupt controller collects and 
> distributes system
> interrupts from the PCI Express and HyperTransport blocks. So 
> you should get the
> map connection based on the system in detail. Often these 
> information should be
> defined in the corresponding dtc.

The only DTS I have is the one I extracted from a running target. This is
part of the entry for the 8111:

        ht@0 {  
                ranges = <0x81000000 0x0 0x0 0x0 0xf4000000 0x0 0x400000
0x82000000 0x0 0x80000000 0x0 0x80000000 0x0 0x70000000>;
                reg = <0x0 0xf2000000 0x3000000>;
                device_type = "ht";
                bus-range = <0x0 0x5>;
                compatible = "u3-ht";
                interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
                interrupt-map = <
                        0x0900 0x0 0x0 0x0 0x6103fa00 0x00 0x1
                        0x1100 0x0 0x0 0x0 0x6103fa00 0x00 0x1
                        0x1900 0x0 0x0 0x0 0x6103fa00 0x00 0x1
                        0x2100 0x0 0x0 0x0 0x6103fa00 0x00 0x1
                        0x3000 0x0 0x0 0x0 0x6103fa00 0x00 0x1
                        0x3200 0x0 0x0 0x4 0x6103fa00 0x19 0x1
                        0x3300 0x0 0x0 0x0 0x6103fa00 0x00 0x1
                        0x3400 0x0 0x0 0x3 0x6103fa00 0xff 0x1
                        0x3500 0x0 0x0 0x2 0x6103fa00 0x17 0x1
                        0x3600 0x0 0x0 0x2 0x6103fa00 0x17 0x1
                        0x3700 0x0 0x0 0x0 0x6103fa00 0x00 0x1>;
                #address-cells = <0x3>;
                linux,phandle = <0x61043600>;
                name = "ht";
                #interrupt-cells = <0x1>;
                #size-cells = <0x2>; 

And this is the CPC925, with its interrupt controller:

        hostbridge@f8000000 {
                reg = <0xf8000000 0x1000000>;
                device_type = "memory-controller";
                compatible = "u3";
                #address-cells = <0x1>;
                linux,phandle = <0x61044000>;
                name = "hostbridge";
                #size-cells = <0x1>;

                dart@f8033000 {
                        reg = <0xf8033000 0x7000>;
                        device_type = "dart";
                        compatible = "u3-dart", "dart";
                        linux,phandle = <0x61045e00>;
                        name = "dart";
                };

                interrupt-controller@f8040000 {
                        reg = <0xf8040000 0x40000>;
                        device_type = "open-pic";
                        interrupt-controller;
                        compatible = "open-pic";
                        big-endian;
                        built-in;
                        #address-cells = <0x0>;
                        linux,phandle = <0x6103fa00>;
                        name = "interrupt-controller";
                        clock-frequency = <0x0>;
                        #interrupt-cells = <0x2>;
                };

And I think this is the part of the LPC bridge entry:

                isa@6 { 
                        min-grant = <0x0>;
                        ranges = <0x1 0x0 0x1003000 0x0 0x0 0x10000>;
                        reg = <0x3000 0x0 0x0 0x0 0x0>;
                        device_type = "isa";
                        revision-id = <0x5>;
                        66mhz-capable;
                        max-latency = <0x0>;
                        class-code = <0x60100>;
                        vendor-id = <0x1022>;
                        linux,phandle = <0x610dfa00>;
                        name = "isa";
                        device-id = <0x7468>;

The LPC bridge is supposed to be able to generate an NMI on error. Am I
right in saying that the 0x3000 entry in the ht@0 interrupt-map corresponds
to the LPC bridge ? If so, the mapping I can read from there is 0->0. 0 is
an internal interrupt of the CPC925, so this does not make sense. Or I am
reading this wrong.

Any insights ?

Thanks,
Ben
