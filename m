Return-Path: <walsh.benj@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.30])
	by ozlabs.org (Postfix) with ESMTP id B5EE5DDD0C
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Nov 2008 01:50:52 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so555725yxg.39
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Nov 2008 06:50:50 -0800 (PST)
Message-ID: <cb298a870811280650h48cee9es97f97ac23e43c831@mail.gmail.com>
Date: Fri, 28 Nov 2008 09:50:50 -0500
From: "Benjamin Walsh" <walsh.benj@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: Repost from linuxppc-embedded: NMI and AMD8131/8111 on Maple board
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

I am reposting this from linuxppc-embedded, as I might get more answers here.
Anything that can move this case forward is greatly appreciated. Thanks.

Here is the current thread:

Benjamin Walsh wrote:
> > Hi all,
> >
> > I've written EDAC support for the AMD8131/8111 chips that are present on a
> > Maple board (PPC970FX with IBM CPC925 memory controller/bridge), currently
> > running in poll mode. I am now trying to get this to work in interrupt mode.
> > These two chipsets have a feature that enables triggering an NMI when an
> > error is detected (PERR and SERR). How can this be hooked into the interrupt
> > system on a PPC board ?
> >
> > From what I understand from the doc for these chipsets, the NMI will
> > delivered as a HT message to the CPC925 on this board. What I don't get is
> > how will this be delivered to the CPU, and on what interrupt line ? The HT
> > message sent to the CPC925 is the following:
> >
> > MT = NMI
> > TM = edge
> > DM = physical
> > INTRDEST = 'hFF (all)
> > VECTOR = 'h00 (does not matter)
> >
>
> The AMD8131/8130 can generate an NMI to the CPC925. There is an interrupt
> controller resided in the CPC925. And you know the CPC925 is attached the
> PowerPC PPC970FX. The interrupt controller collects and distributes system
> interrupts from the PCI Express and HyperTransport blocks. So you should get the
> map connection based on the system in detail. Often these information should be
> defined in the corresponding dtc.
>
> Best Regards
> Tiejun

The only DTS I have is the one I extracted from a running target. This
is part of the entry for the 8111:

        ht@0 {
                ranges = <0x81000000 0x0 0x0 0x0 0xf4000000 0x0
0x400000 0x82000000 0x0 0x80000000 0x0 0x80000000 0x0 0x70000000>;
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

And I think this is the part of the LPC bridge entry on the 8111:

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

The LPC bridge is supposed to be able to generate an NMI on error. Am
I right in saying that the 0x3000 entry in the ht@0 interrupt-map
corresponds to the LPC bridge ? If so, the mapping I can read from
there is 0->0. 0 is an internal interrupt of the CPC925, so this does
not make sense. Or I am reading this wrong ?

Any insights ?

Thanks,
Ben
