Return-Path: <Dan.Geer@faa.gov>
Received: from relay1.faa.gov (relay1.faa.gov [204.108.10.6])
	by ozlabs.org (Postfix) with ESMTP id A8CF4B7D0C
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  2 Feb 2010 05:09:02 +1100 (EST)
MIME-Version: 1.0
In-Reply-To: 
References: 
Subject: Re: BSE-IP
To: Scott Wood <scottwood@freescale.com>
Message-ID: <OF7C180968.43598D84-ON852576BD.006286D6-852576BD.0063AC38@faa.gov>
From: Dan.Geer@faa.gov
Date: Mon, 1 Feb 2010 13:08:41 -0500
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


I'm hoping someone can offer some advice on this:

I'm working with an embedded platform that does not pass anything from
firmware. I'm just trying to get some activity out the serial console at
this stage.  simpleImage.bseip compiled with the following bseip.dts seems
to freeze before anything is written to the console.  I'm assuming the
standard 8xx code will pickup this device tree, and work from there.  Is
this correct?  Shouldn't I see some output?


/dts-v1/;

/ {
             model = "BSEIP";
             compatible = "fsl,bseip";
             #address-cells = <1>;
             #size-cells = <1>;

             cpus {
                         #address-cells = <1>;
                         #size-cells = <0>;

                         PowerPC,823@0 {
                                     compatible = "PowerPC,8xx";
                                     device_type = "cpu";
                                     reg = <0x0>;
                                     d-cache-line-size = <8>;		 // 8 bytes
per line
                                     i-cache-line-size = <8>;		 // 8 bytes
per line
                                     d-cache-size = <0x0400>;		 // L1, 1K
                                     i-cache-size = <0x0800>;		 // L1, 2K
                                     timebase-frequency = <48000000>;
                                     bus-frequency = <48000000>;
                                     clock-frequency = <48000000>;
                                     interrupts = <15 2>;
 // decrementer interrupt
                                     interrupt-parent = <&PIC>;
                         };
             };

             memory {
                         device_type = "memory";
                         reg = <0 0x1000000>;
             };

             soc@ff000000 {
                         compatible = "fsl,mpc823", "fsl,pq1-soc";
                         #address-cells = <1>;
                         #size-cells = <1>;
                         device_type = "soc";
                         ranges = <0 0xff000000 0x00004000>;
                         reg = <0xff000000 0x4000>;
                         bus-frequency = <48000000>;

                         PIC: interrupt-controller@0 {
                                     interrupt-controller;
                                     #interrupt-cells = <2>;
                                     reg = <0 0x24>;
                                     compatible = "fsl,mpc823-pic",
"fsl,pq1-pic";
                         };

                         pcmcia@80 {
                                     #address-cells = <3>;
                                     #interrupt-cells = <1>;
                                     #size-cells = <2>;
                                     compatible = "fsl,pq-pcmcia";
                                     device_type = "pcmcia";
                                     reg = <0x80 0x80>;
                                     interrupt-parent = <&PIC>;
                                     interrupts = <13 1>;
                         };

                         cpm@9c0 {
                                     #address-cells = <1>;
                                     #size-cells = <1>;
                                     compatible = "fsl,mpc823-cpm",
"fsl,cpm1";
                                     command-proc = <0x9c0>;
                                     interrupts = <0>;		 // cpm error
interrupt
                                     interrupt-parent = <&CPM_PIC>;
                                     reg = <0x9c0 0x40>;
                                     ranges;

                                     muram@2000 {
                                                 #address-cells = <1>;
                                                 #size-cells = <1>;
                                                 ranges = <0 0x2000
0x2000>;

                                                 data@0 {
                                                             compatible =
"fsl,cpm-muram-data";
                                                             reg = <0
0x1c00>;
                                                 };
                                     };

                                     brg@9f0 {
                                                 compatible =
"fsl,mpc823-brg",

"fsl,cpm1-brg",

"fsl,cpm-brg";
                                                 reg = <0x9f0 0x10>;
                                                 clock-frequency =
<48000000>;
                                     };

                                     CPM_PIC: interrupt-controller@930 {
                                                 interrupt-controller;
                                                 #interrupt-cells = <1>;
                                                 interrupts = <5 2 0 2>;
                                                 interrupt-parent = <&PIC>;
                                                 reg = <0x930 0x20>;
                                                 compatible =
"fsl,mpc823-cpm-pic",

"fsl,cpm1-pic";
                                     };

                                     serial@a80 {
                                                 device_type = "serial";
                                                 compatible =
"fsl,mpc823-smc-uart",

"fsl,cpm1-smc-uart";
                                                 reg = <0xa80 0x10 0x3e80
0x40>;
                                                 interrupts = <4>;
                                                 interrupt-parent =
<&CPM_PIC>;
                                                 fsl,cpm-brg = <1>;
                                                 fsl,cpm-command = <0x90>;
                                                 current-speed = <9600>;
                                     };

                                     serial@a90 {
                                                 device_type = "serial";
                                                 compatible =
"fsl,mpc823-smc-uart",

"fsl,cpm1-smc-uart";
                                                 reg = <0xa90 0x10 0x3f80
0x40>;
                                                 interrupts = <3>;
                                                 interrupt-parent =
<&CPM_PIC>;
                                                 fsl,cpm-brg = <2>;
                                                 fsl,cpm-command = <0xd0>;
                                                 current-speed = <9600>;
                                     };

                                     ethernet@a20 {
                                                 device_type = "network";
                                                 compatible =
"fsl,mpc823-scc-enet",

"fsl,cpm1-scc-enet";
                                                 reg = <0xa20 0x18 0x3c00
0x100>;
                                                 local-mac-address = [ 00
00 00 00 00 00 ];
                                                 interrupts = <30>;
                                                 interrupt-parent =
<&CPM_PIC>;
                                                 fsl,cpm-command = <0x80>;
                                                 linux,network-index = <1>;
                                     };
                         };
             };

             chosen {
                         linux,stdout-path = "/soc/cpm/serial@a80";
             };
};
