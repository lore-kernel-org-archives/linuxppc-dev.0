Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.181])
	by ozlabs.org (Postfix) with ESMTP id BCF45DDF16
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 00:01:20 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so1903483wag
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 07:01:19 -0700 (PDT)
Message-ID: <fa686aa40710230701j297a7aa9ubd90ff46d073ffd@mail.gmail.com>
Date: Tue, 23 Oct 2007 08:01:19 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Michal Simek" <Monstr@seznam.cz>
Subject: Re: [microblaze-uclinux] Re: [microblaze-uclinux] RE: [PATCH v3]
	Device tree bindings for Xilinx devices
In-Reply-To: <1815.2979-14673-964852328-1193124877@seznam.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071023043443.GM31839@localhost.localdomain>
	<1815.2979-14673-964852328-1193124877@seznam.cz>
Cc: microblaze-uclinux@itee.uq.edu.au, linuxppc-dev@ozlabs.org,
	Wolfgang Reissnegger <wre@xilinx.com>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/23/07, Michal Simek <Monstr@seznam.cz> wrote:
> Hi David,
> I remove some labels from my generator. I created fake system with some peripherals.
> There are 3 buses and 3 bridges.
> Can you check it and tell me what is wrong?
>
> Thanks,
> Michal Simek
>
> / {
>         model = "mONStR";

You should have a board-level compatible property here

>         chosen {
>                 bootargs = "root=/dev/xsysace/disc0/part2";
>         } ;
>         cpus {
>                 #size-cells = <0>;
>                 #cpus = < 0 >;
>                 #address-cells = <1>;
>                 microblaze_0,5.00.c@0 {

Simply microblaze@0 will do.

>                         device_type = "cpu";
>                         reg = <0>;
>                         clock-frequency = <5f5e1000>;
>                         timebase-frequency = <1FCA055>;
>                         i-cache-line-size = <2000>;
>                         i-cache-size = <10>;
>                         d-cache-line-size = <2000>;
>                         d-cache-size = <10>;
>                         xilinx,pvr = <0>;

use 'xlnx,' for the prefix; this is a comment that I received on the
binding document that the stock ticker is an appropriate appreviation.

>                         xilinx,debug-enabled = <1>;
>                         xilinx,fsl-links = <0>;
>                 } ;
>         } ;
>

You should have a parent 'plb' bus node for all these devices to be children of.

>         ethernet@10060000 {
>                 compatible = "opb_ethernet_1.04.a","opb_ethernet";

- add manufacture prefix
- convert underscores to dashes
- drop "opb_ethernet"; there's no such thing

Just "xlnx,opb-ethernet-1.04.a" will do; or something like
"xlnx,opb-ethernet-1.04b","xlnx,opb-ethernet-1.04a" works too.

>                 interrupts = < 3 0 >;
>                 reg = < 10060000 10000 >;
>                 device_type = "network";
>                 xilinx,cam-exist = <0>;
>                 xilinx,dev-blk-id = <1>;
>                 xilinx,dev-mir-enable = <1>;
>                 xilinx,dma-present = <1>;
>                 xilinx,include-dev-pencoder = <1>;
>                 xilinx,ipif-rdfifo-depth = <8000>;
>                 xilinx,ipif-wrfifo-depth = <8000>;
>                 xilinx,mii-exist = <1>;

use 'xlnx,' for prefix.

>         } ;
>         memory@20000000 {
>                 memreg:reg = < 20000000 10000000 >;
>                 device_type = "memory";
>         } ;
>         serial@10030000 {
>                 compatible = "opb_uart16550_1.00.d","opb_uart16550";

'opb_uart16550' is bogus non-device; Always specify a version for IP
core compatible fields.  There was some talk about defining a
'sparse16550' or some such value to reflect things that were almost a
16550 but had a different register layout; but in the mean time leave
it out.

- change '_' to '-', add 'xlnx,'; etc.

>                 reg = < 10030000 10000 >;
>                 device_type = "serial";
>         } ;
>         opb_timer@10020000 {
>                 compatible = "opb_timer_1.00.b","opb_timer";

ditto

>                 interrupts = < 0 0 >;
>                 reg = < 10020000 10000 >;
>                 xilinx,count-width = <20>;
>                 xilinx,one-timer-only = <0>;
>         } ;
>         opb_opb_lite@30000000 {

- change '_' to '-'

>                 ranges = < 0 30000000 10000000 >;
>                 opb_gpio@30020000 {

Since you're bus uses the ranges property value to translate; the
device address should reflect the offset off the base of the bus:
opb_gpio@20000

If instead your ranges property was empty then the full address still
works.  Address translation makes sense for the opb-opb-lite because
it's only got one translation range.  However, the plb-opb bridge
covers multiple ranges so it's probably easier to leave out the
translation.

>                         compatible = "opb_gpio_3.01.b","opb_gpio";
>                         reg = < 30020000 10000 >;

Same comment as above; reg = <20000 10000>;  These comments go for all
the nodes below.

>                         xilinx,gpio-width = <4>;
>                         xilinx,is-dual = <0>;
>                 } ;
>                 i2c@30030000 {
>                         compatible = "opb_iic_1.02.a","opb_iic";
>                         reg = < 30030000 10000 >;
>                         device_type = "i2c";
>                 } ;
>
>                 opb_gpio@30010000 {
>                         compatible = "opb_gpio_3.01.b","opb_gpio";
>                         reg = < 30010000 10000 >;
>                         xilinx,gpio-width = <20>;
>                         xilinx,is-dual = <0>;
>                 } ;
>                 ethernet@30040000 {
>                         compatible = "opb_ethernetlite_1.01.b","opb_ethernetlite";
>                         reg = < 30040000 10000 >;
>                         device_type = "network";
>                         xilinx,duplex = <1>;
>                         xilinx,rx-ping-pong = <0>;
>                         xilinx,tx-ping-pong = <0>;
>                 } ;
>                 opb_sysace@30050000 {
>                         compatible = "opb_sysace_1.00.c","opb_sysace";
>                         reg = < 30050000 10000 >;
>                         xilinx,mem-width = <10>;
>                 } ;
>                 opb_ps2_dual_ref@30060000 {
>                         compatible = "opb_ps2_dual_ref_1.00.a","opb_ps2_dual_ref";
>                         interrupts = < 2 0 >;
>                         interrupts = < 1 0 >;
>                         reg = < 30060000 10000 >;
>                 } ;
>         };
>         opb_intc@10010000 {
>                 compatible = "opb_intc_1.00.c","opb_intc";
>                 reg = < 10010000 10000 >;
>         } ;
>         opb_mdm@10050000 {
>                 compatible = "opb_mdm_2.00.a","opb_mdm";
>                 reg = < 10050000 10000 >;
>                 xilinx,mb-dbg-ports = <1>;
>                 xilinx,uart-width = <8>;
>                 xilinx,use-uart = <1>;
>         } ;
>         serial@10040000 {
>                 compatible = "opb_uartlite_1.00.b","opb_uartlite";
>                 interrupts = < 4 0 >;
>                 reg = < 10040000 10000 >;
>                 device_type = "serial";
>                 xilinx,baudrate = <2580>;
>                 xilinx,data-bits = <8>;
>                 xilinx,clk-freq = <5f5e100>;
>                 xilinx,odd-parity = <0>;
>                 xilinx,use-parity = <0>;

My patch to booting-without-of says that you should have a
'current-speed' property (instead of xlnx,baudrate) because it's a
standard property; but 'xlnx,baudrate' might be a suitable alternative
because this is a fixed speed device.  Segher, David; what say you?

>         } ;
>         opb2plb_bridge@80000000 {
>                 ranges = < 0 80000000 80000000 >;
>                 serial@a0020000 {
>                         compatible = "plb_uart16550_1.00.c","plb_uart16550";
>                         reg = < a0020000 10000 >;
>                         device_type = "serial";
>                 } ;
>                 plb_gpio@a0010000 {
>                         compatible = "plb_gpio_1.00.b","plb_gpio";
>                         reg = < a0010000 10000 >;
>                         xilinx,gpio-width = <20>;
>                         xilinx,is-dual = <0>;
>                 } ;
>                 ethernet@a0000000 {
>                         compatible = "plb_ethernet_1.01.a","plb_ethernet";
>                         reg = < a0000000 10000 >;
>                         device_type = "network";
>                 } ;
>                 plb2opb_bridge@10000000 {
>                         ranges = < 0 10000000 10000000 >;
>                         ranges = < 1 20000000 10000000 >;
>                 };

There are no nodes on this bus.  What is the intended usage?  Also,
you cannot have two properties with the same name, I think the syntax
you want is:
ranges = <0 10000000 10000000 2 20000000 10000000>;

Also, these values won't work.  They state that you've got two address
range translations.  The first translates from address 10000000 to
address 0 (which makes sense).  The second translates from address
20000000 to address 1 (which overlaps the first region, only offset by
1 byte).

>                 cpus {
>                         #size-cells = <0>;
>                         #cpus = < 1 >;
>                         #address-cells = <1>;
>                         ppc405_0,405@1 {
>                                 device_type = "cpu";
>                                 reg = <0>;
>                                 clock-frequency = <5f5e1000>;
>                                 timebase-frequency = <1FCA055>;
>                         } ;
>                 } ;

This is weird.  Is this representing a design with both a ppc and a
microblaze?  If so; I would generate 2 device trees.  One for each
processor.

>         };
> } ;
>

BTW, Thanks for all this work
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
