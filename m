Return-Path: <mahendravarman15@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by ozlabs.org (Postfix) with ESMTP id 05DCCDDED0
	for <linuxppc-embedded@ozlabs.org.>;
	Sat, 23 Feb 2008 00:33:09 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id t39so1361099ugd.6
	for <linuxppc-embedded@ozlabs.org.>;
	Fri, 22 Feb 2008 05:33:07 -0800 (PST)
Message-ID: <4ac2955e0802220533o3eba0e58ybb72326ab0e1a376@mail.gmail.com>
Date: Fri, 22 Feb 2008 19:03:07 +0530
From: "mahendra varman" <mahendravarman15@gmail.com>
To: linuxppc-embedded@ozlabs.org., linux-kernel@vger.kernel.org
Subject: Doubt in Device tree entry for USB on Powerpc based board
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_158_30031233.1203687187235"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_158_30031233.1203687187235
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello All

Iam using Powerpc 7448 processor along with TSI 109 system controller.
On PCI interface of TSI 109 a PCI to PCI bridge(6520) is connected in which
an usb controller(Philips ISP1562) and PMC site is connected.

Iam following the Open Firmware Powerpc architecture and using Linux 2.6.23.
I have framed the device tree for the above architecture with usb entry. But
even though i enable the ohci ppc of in menuconfig the the functions
probe,etc inside ohci ppc of.c are not called when i insert the device in
usb port and hence it is not detecting ohci low/full speed devices.

Please help me in the device tree where to give the device type
compatibility address_cells size cells for the USB (since usb controller is
in pci bridge i have some confusion in where to give the entry for usb)

I have attached the device tree below
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
{    model = "CTP7448";
    compatible = "mpc74xx";
    #address-cells = <1>;
    #size-cells = <1>;

    cpus {
        #address-cells = <1>;
        #size-cells =<0>;

        PowerPC,7448@0 {
            device_type = "cpu";
            reg = <0>;
            d-cache-line-size = <20>;    // 32 bytes
            i-cache-line-size = <20>;    // 32 bytes
            d-cache-size = <8000>;        // L1, 32K bytes
            i-cache-size = <8000>;        // L1, 32K bytes
            timebase-frequency = <0>;    // 33 MHz, from uboot
            clock-frequency = <0>;        // From U-Boot
            bus-frequency = <0>;        // From U-Boot
            32-bit;
        };
    };

    memory{
        device_type = "memory";
        reg = <00000000 10000000>;    // DDR2   512M at 0
    };

      tsi108@c0000000 {
        #address-cells = <1>;
        #size-cells = <1>;
        #interrupt-cells = <2>;
        device_type = "tsi-bridge";
        ranges = <00000000 c0000000 00010000
                00000000 f0000000 00008000
                00000000 f1000000 01000000
                00000000 f8000000 01000000>;
        reg = <c0000000 00010000>;
        bus-frequency = <0>;

        rtc@f0000000 {
            device_type = "rtc";
             compatible  = "st,m48t59";
            reg = <f0000000 8000>;

        };
        i2c@7000 {
            interrupt-parent = <&mpic>;
            interrupts = <E 0>;
            reg = <7000 400>;
            device_type = "i2c";
            compatible  = "tsi108-i2c";
        };

        MDIO: mdio@6000 {
            device_type = "mdio";
            compatible = "tsi108-mdio";
            reg = <6000 50>;
            #address-cells = <1>;
            #size-cells = <0>;

            phy1: ethernet-phy@1 {
                interrupt-parent = <&mpic>;
                interrupts = <0 0>;
                reg = <1>;
                device_type = "ethernet-phy";
            };

            phy8: ethernet-phy@8 {
                interrupt-parent = <&mpic>;
                interrupts = <1 0>;
                reg = <8>;
                device_type = "ethernet-phy";
            };

        };
        ethernet@6200 {
            #size-cells = <0>;
            device_type = "network";
            compatible = "tsi108-ethernet";
            reg = <6000 200>;
            address = [ 00 03 23 00 00 01 ];
            interrupts = <10 0>;
            interrupt-parent = <&mpic>;
            mdio-handle = <&MDIO>;
            phy-handle = <&phy1>;
        };

        ethernet@6600 {
            #address-cells = <1>;
            #size-cells = <0>;
            device_type = "network";
            compatible = "tsi108-ethernet";
            reg = <6400 200>;
            address = [ 00 03 23 00 00 02 ];
            interrupts = <11 2>;
            interrupt-parent = <&mpic>;
            mdio-handle = <&MDIO>;
            phy-handle = <&phy8>;
        };

        serial@7808 {
            device_type = "serial";
            compatible = "ns16550";
            reg = <7808 200>;
            clock-frequency = <3f6b5a00>;
            interrupts = <c 0>;
            interrupt-parent = <&mpic>;
        };

        serial@7c08 {
            device_type = "serial";
            compatible = "ns16550";
            reg = <7c08 200>;
            clock-frequency = <3f6b5a00>;
            interrupts = <d 0>;
            interrupt-parent = <&mpic>;
        };

          mpic: pic@7400 {
            clock-frequency = <0>;
            interrupt-controller;
            #address-cells = <0>;
            #interrupt-cells = <2>;
            reg = <7400 400>;
            built-in;
            compatible = "chrp,open-pic";
            device_type = "open-pic";
                           big-endian;
        };
        pci@1000 {
            compatible = "tsi108-pci";
            device_type = "pci";
            #interrupt-cells = <1>;
            #size-cells = <2>;
            #address-cells = <3>;
            reg = <1000 1000>;
            bus-range = <0 0>;
            ranges = <02000000 0 e0000000 e0000000 0 10000000
                        01000000 0 00000000 f2000000 0 01000000>;
            clock-frequency = <3ef1480>;
            interrupt-parent = <&mpic>;
            interrupts = <17 2>;
            interrupt-map-mask = <f800 0 0 7>;
            interrupt-map = <
                /* IDSEL 0x10 */
                 00000 0 0 1 &RT0 24 0

                /* IDSEL 0x11 */
                00800 0 0 1 &RT0 25 0

                       /* IDSEL 0x12 */
                1000 0 0 1 &RT0 24 0
                1000 0 0 2 &RT0 25 0
                1000 0 0 3 &RT0 26 0
                1000 0 0 4 &RT0 27 0 >;

                      pci_bridge@12 {
                interrupt-map-mask = <f800 0 0 7>;
                interrupt-map = <

                    /* IDSEL 0x13 (PMC Site) */
                    1800 0 0 1 &RT0 24 0
                    1800 0 0 2 &RT0 25 0
                    1800 0 0 3 &RT0 26 0
                    1800 0 0 4 &RT0 27 0

                    /* IDSEL 0x14 (USB chip) */
                      2000 0 0 1 &RT0 27 0
                      2000 0 0 2 &RT0 27 0
                      2000 0 0 3 &RT0 27 0
                      2000 0 0 4 &RT0 27 0
>;

                reg = <1000 0 0 0 0>;
                #interrupt-cells = <1>;
                #size-cells = <2>;
                #address-cells = <3>;
                ranges = <02000000 0 e0000000 e0000000 0 10000000 01000000 0
00000000 fa000000 0 00010000>;
                clock-frequency = <1f78a40>;

            RT0: router@1180 {
                clock-frequency = <0>;
                interrupt-controller;
                device_type = "pic-router";
                #address-cells = <0>;
                #interrupt-cells = <2>;
                built-in;
                big-endian;
                interrupts = <17 2>;
                interrupt-parent = <&mpic>;
                                      };
              };

        };
    };

};

------=_Part_158_30031233.1203687187235
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello All<br><br>Iam using Powerpc 7448 processor along with TSI 109 system controller.<br>On
PCI interface of TSI 109 a PCI to PCI bridge(6520) is connected in
which an usb controller(Philips ISP1562) and PMC site is connected.<br><br>Iam following the Open Firmware Powerpc architecture and using Linux 2.6.23.<br>I have framed the device tree for the above architecture with usb entry. But even though i enable the ohci ppc of in menuconfig the the functions probe,etc inside ohci ppc of.c are not called when i insert the device in usb port and hence it is not detecting ohci low/full speed devices.<br>
<br>Please help me in the device tree where to give the device type compatibility address_cells size cells for the USB (since usb controller is in pci bridge i have some confusion in where to give the entry for usb)<br><br>
I have attached the device tree below <br>-----------------------------------------------------------------------------------------------------------------------------------------------------------------<br>{&nbsp;&nbsp;&nbsp; model = &quot;CTP7448&quot;;<br>
&nbsp;&nbsp;&nbsp; compatible = &quot;mpc74xx&quot;;<br>&nbsp;&nbsp;&nbsp; #address-cells = &lt;1&gt;;<br>&nbsp;&nbsp;&nbsp; #size-cells = &lt;1&gt;;<br><br>&nbsp;&nbsp;&nbsp; cpus {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; #address-cells = &lt;1&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; #size-cells =&lt;0&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; PowerPC,7448@0 {<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; device_type = &quot;cpu&quot;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; reg = &lt;0&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; d-cache-line-size = &lt;20&gt;;&nbsp;&nbsp;&nbsp; // 32 bytes<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; i-cache-line-size = &lt;20&gt;;&nbsp;&nbsp;&nbsp; // 32 bytes<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; d-cache-size = &lt;8000&gt;;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; // L1, 32K bytes<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; i-cache-size = &lt;8000&gt;;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; // L1, 32K bytes<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; timebase-frequency = &lt;0&gt;;&nbsp;&nbsp;&nbsp; // 33 MHz, from uboot<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; clock-frequency = &lt;0&gt;;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; // From U-Boot<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; bus-frequency = &lt;0&gt;;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; // From U-Boot<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 32-bit;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; };<br>&nbsp;&nbsp;&nbsp; };<br><br>&nbsp;&nbsp;&nbsp; memory{<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; device_type = &quot;memory&quot;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; reg = &lt;00000000 10000000&gt;;&nbsp;&nbsp;&nbsp; // DDR2&nbsp;&nbsp; 512M at 0<br>&nbsp;&nbsp;&nbsp; };<br><br>&nbsp; &nbsp;&nbsp;&nbsp; tsi108@c0000000 {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; #address-cells = &lt;1&gt;;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; #size-cells = &lt;1&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; #interrupt-cells = &lt;2&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; device_type = &quot;tsi-bridge&quot;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ranges = &lt;00000000 c0000000 00010000<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 00000000 f0000000 00008000<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00000000 f1000000 01000000<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 00000000 f8000000 01000000&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; reg = &lt;c0000000 00010000&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; bus-frequency = &lt;0&gt;;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rtc@f0000000 {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_type = &quot;rtc&quot;;<br>
&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; compatible&nbsp; = &quot;st,m48t59&quot;;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg = &lt;f0000000 8000&gt;;<br>&nbsp; &nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; i2c@7000 {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; interrupt-parent = &lt;&amp;mpic&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; interrupts = &lt;E 0&gt;;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; reg = &lt;7000 400&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; device_type = &quot;i2c&quot;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; compatible&nbsp; = &quot;tsi108-i2c&quot;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; };<br><br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; MDIO: mdio@6000 {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; device_type = &quot;mdio&quot;;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; compatible = &quot;tsi108-mdio&quot;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; reg = &lt;6000 50&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; #address-cells = &lt;1&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; #size-cells = &lt;0&gt;;<br><br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; phy1: ethernet-phy@1 {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; interrupt-parent = &lt;&amp;mpic&gt;;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; interrupts = &lt;0 0&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; reg = &lt;1&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; device_type = &quot;ethernet-phy&quot;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; };<br><br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; phy8: ethernet-phy@8 {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; interrupt-parent = &lt;&amp;mpic&gt;;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; interrupts = &lt;1 0&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; reg = &lt;8&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; device_type = &quot;ethernet-phy&quot;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; };<br><br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; };<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ethernet@6200 {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; #size-cells = &lt;0&gt;;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; device_type = &quot;network&quot;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; compatible = &quot;tsi108-ethernet&quot;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; reg = &lt;6000 200&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; address = [ 00 03 23 00 00 01 ];<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; interrupts = &lt;10 0&gt;;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; interrupt-parent = &lt;&amp;mpic&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; mdio-handle = &lt;&amp;MDIO&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; phy-handle = &lt;&amp;phy1&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; };<br><br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ethernet@6600 {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; #address-cells = &lt;1&gt;;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; #size-cells = &lt;0&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; device_type = &quot;network&quot;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; compatible = &quot;tsi108-ethernet&quot;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; reg = &lt;6400 200&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; address = [ 00 03 23 00 00 02 ];<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; interrupts = &lt;11 2&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; interrupt-parent = &lt;&amp;mpic&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; mdio-handle = &lt;&amp;MDIO&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; phy-handle = &lt;&amp;phy8&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; };<br><br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; serial@7808 {<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; device_type = &quot;serial&quot;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; compatible = &quot;ns16550&quot;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; reg = &lt;7808 200&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; clock-frequency = &lt;3f6b5a00&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; interrupts = &lt;c 0&gt;;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; interrupt-parent = &lt;&amp;mpic&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; };<br><br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; serial@7c08 {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; device_type = &quot;serial&quot;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; compatible = &quot;ns16550&quot;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; reg = &lt;7c08 200&gt;;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; clock-frequency = &lt;3f6b5a00&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; interrupts = &lt;d 0&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; interrupt-parent = &lt;&amp;mpic&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; };<br><br>&nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp; mpic: pic@7400 {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; clock-frequency = &lt;0&gt;;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; interrupt-controller;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; #address-cells = &lt;0&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; #interrupt-cells = &lt;2&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; reg = &lt;7400 400&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; built-in;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; compatible = &quot;chrp,open-pic&quot;;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; device_type = &quot;open-pic&quot;;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; big-endian;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; };<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; pci@1000 {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; compatible = &quot;tsi108-pci&quot;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; device_type = &quot;pci&quot;;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; #interrupt-cells = &lt;1&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; #size-cells = &lt;2&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; #address-cells = &lt;3&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; reg = &lt;1000 1000&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; bus-range = &lt;0 0&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ranges = &lt;02000000 0 e0000000 e0000000 0 10000000 <br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 01000000 0 00000000 f2000000 0 01000000&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; clock-frequency = &lt;3ef1480&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; interrupt-parent = &lt;&amp;mpic&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; interrupts = &lt;17 2&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; interrupt-map-mask = &lt;f800 0 0 7&gt;;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; interrupt-map = &lt;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; /* IDSEL 0x10 */<br>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 00000 0 0 1 &amp;RT0 24 0<br><br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; /* IDSEL 0x11 */<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 00800 0 0 1 &amp;RT0 25 0<br>&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;/* IDSEL 0x12 */<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 1000 0 0 1 &amp;RT0 24 0<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 1000 0 0 2 &amp;RT0 25 0<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 1000 0 0 3 &amp;RT0 26 0<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 1000 0 0 4 &amp;RT0 27 0 &gt;;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_bridge@12 {<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; interrupt-map-mask = &lt;f800 0 0 7&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; interrupt-map = &lt;<br><br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; /* IDSEL 0x13 (PMC Site) */<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 1800 0 0 1 &amp;RT0 24 0<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 1800 0 0 2 &amp;RT0 25 0<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 1800 0 0 3 &amp;RT0 26 0<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 1800 0 0 4 &amp;RT0 27 0<br><br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; /* IDSEL 0x14 (USB chip) */<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; 2000 0 0 1 &amp;RT0 27 0 <br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; 2000 0 0 2 &amp;RT0 27 0&nbsp; <br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; 2000 0 0 3 &amp;RT0 27 0&nbsp; <br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; 2000 0 0 4 &amp;RT0 27 0&nbsp; &gt;;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br><br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; reg = &lt;1000 0 0 0 0&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; #interrupt-cells = &lt;1&gt;;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; #size-cells = &lt;2&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; #address-cells = &lt;3&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ranges = &lt;02000000 0 e0000000 e0000000 0 10000000 01000000 0 00000000 fa000000 0 00010000&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; clock-frequency = &lt;1f78a40&gt;;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
&nbsp;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; RT0: router@1180 {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; clock-frequency = &lt;0&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; interrupt-controller;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; device_type = &quot;pic-router&quot;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; #address-cells = &lt;0&gt;;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; #interrupt-cells = &lt;2&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; built-in;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; big-endian;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; interrupts = &lt;17 2&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; interrupt-parent = &lt;&amp;mpic&gt;;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br><br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; };<br>&nbsp;&nbsp;&nbsp; };<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>};<br><br><br><br><br>
<br><br>

------=_Part_158_30031233.1203687187235--
