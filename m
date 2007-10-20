Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.177])
	by ozlabs.org (Postfix) with ESMTP id DB7F4DDE0D
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Oct 2007 15:38:52 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so591775wag
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 22:38:48 -0700 (PDT)
Message-ID: <fa686aa40710192238y7fe86ea3i7b656385b6b69786@mail.gmail.com>
Date: Fri, 19 Oct 2007 23:38:48 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
Subject: Re: [PATCH v3] Device tree bindings for Xilinx devices
In-Reply-To: <20071019234347.38C1111C006B@mail3-dub.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071018172259.14948.74736.stgit@trillian.cg.shawcable.net>
	<20071018174956.05D7A1AA008D@mail197-blu.bigfish.com>
	<fa686aa40710181112pbe37a18xb21b7c5bcbe973b6@mail.gmail.com>
	<20071018190555.8EE7177805F@mail76-sin.bigfish.com>
	<20071019234347.38C1111C006B@mail3-dub.bigfish.com>
Cc: linuxppc-dev@ozlabs.org, Leonid <Leonid@a-k-a.net>,
	Wolfgang Reissnegger <wre@xilinx.com>,
	Arnd Bergmann <arnd@arndb.de>, microblaze-uclinux@itee.uq.edu.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/19/07, Stephen Neuendorffer <stephen.neuendorffer@xilinx.com> wrote:
>
> Here's a full .dts generated using an updated version of
> gen_mhs_devtree.py, following the proposal.
> It happens to be a microblaze system, but you get the idea.
>
> Grant: Is this pretty what you intend?

Pretty close; comments below on how we still need to change gen_mhs_devtree.py

BTW, thanks for doing this.

Cheers,
g.

>
> Steve
>
> / {
>         #address-cells = <1>;
>         #size-cells = <1>;
>         compatible = "ibm,plb4";

Not quite; the bus itself needs to be one level deeper.  Compatible
here is refering to the platform itself, not the bus and so should be
the actual board name or something similar.  Maybe something like:
"xlnx,ml403","xlnx,generic-virtex4";

All devices should be children or grandchildren of a 'plb' node.

>         model = "system.mhs";
Should be the model name of the board in the form "<mfg>,<model>".  It
might be appropriate to also have a property which describes the
version of the FPGA build or some other way to identify where this
FPGA bitstream came from.  I'll need to think about this some more.

>         Ethernet_MAC {
>                 compatible =
> "xilinx,opb-ethernet-1.04.a\0xilinx,opb-ethernet";

Yes; this is the idea; but I don't like "xilinx,opb-ethernet".  I
think we should always specify specific versions and not try to guess
what the 'generic' device compatible interface is.

Also, dtc now accepts the form "string1","string2".  the embedded '\0'
is no longer needed.

>                 device_type = "opb_ethernet";
device_type = "network";

>                 interrupt-parent = <101>;
interrupt-parent = <&opb_intc0>;   (and a label needs to be added to
the interrupt node).

>                 interrupts = < 1 0 >;
>                 reg = < 40c00000 10000 >;
>                 xilinx,cam-exist = <0>;
>                 xilinx,dev-blk-id = <0>;
>                 xilinx,dev-mir-enable = <0>;
>                 xilinx,dma-present = <1>;
>                 xilinx,include-dev-pencoder = <0>;
>                 xilinx,ipif-rdfifo-depth = <4000>;
>                 xilinx,ipif-wrfifo-depth = <4000>;
>                 xilinx,jumbo-exist = <0>;
>                 xilinx,mac-fifo-depth = <10>;
>                 xilinx,mii-exist = <1>;
>                 xilinx,opb-clk-period-ps = <2710>;
>                 xilinx,reset-present = <1>;
>                 xilinx,rx-dre-type = <0>;
>                 xilinx,rx-include-csum = <0>;
>                 xilinx,tx-dre-type = <0>;
>                 xilinx,tx-include-csum = <0>;

I got a comment from one of the ppc folks that we should use the stock
ticker abbreviation 'xlnx,' here instead of 'xilinx,'

>         } ;
>         IIC_EEPROM {

Node name needs to be unique.  Convention is to use the form
device@address.  We could either use the instance name or the IP core
name here; I'm not sure which is best.

>                 compatible = "xilinx,opb-iic-1.02.a\0xilinx,opb-iic";
>                 device_type = "opb_iic";

device_type needs to be dropped from this node because i2c is not a
standard device type.

>                 interrupt-parent = <101>;
>                 interrupts = < 2 0 >;
>                 reg = < 40800000 10000 >;
>                 xilinx,clk-freq = <5f5e100>;
>                 xilinx,iic-freq = <186a0>;
>                 xilinx,ten-bit-adr = <0>;

i2c devices can optionally be listed as sub-nodes here; but of course
gen-mhs-devtree doesn't know about these.

>         } ;
>         RS232_Uart_1 {
>                 compatible =
> "xilinx,opb-uartlite-1.00.b\0xilinx,opb-uartlite";
>                 device_type = "opb_uartlite";
device_type = serial;

>                 interrupt-parent = <101>;
>                 interrupts = < 3 0 >;
>                 reg = < 40600000 10000 >;
>                 xilinx,baudrate = <2580>;
should be 'current-speed = <2580>' because this is standard device
type 'serial'.

>                 xilinx,clk-freq = <5f5e100>;
It might be better for this to be 'clock-frequency'; one of the
standard properties in serial devices

>                 xilinx,data-bits = <8>;
>                 xilinx,odd-parity = <0>;
>                 xilinx,use-parity = <0>;
>         } ;
>         chosen {
>                 bootargs = "root=/dev/xsysace/disc0/part2";
>                 interrupt-controller = <101>;
interrupt-controller doesn't belong here.

>                 linux,platform = <600>;
What's 'linux,platform' for?

>         } ;
>         cpus {
>                 #address-cells = <1>;
>                 #cpus = <1>;
I don't think this property is necessary.

>                 #size-cells = <0>;
>                 microblaze_0,6.00. {
>                         32-bit;
>                         clock-frequency = <5f5e1000>;
dtc now accepts the form <d#value> for decimal values; might be better
for readability here.

>                         d-cache-line-size = <10>;
>                         d-cache-size = <4000>;
>                         device_type = "cpu";
>                         i-cache-line-size = <10>;
>                         i-cache-size = <4000>;
>                         linux,boot-cpu;
>                         reg = <0>;
>                         timebase-frequency = <1fca055>;
>                         xilinx,cache-byte-size = <4000>;
>                         xilinx,dcache-baseaddr = <50000000>;
>                         xilinx,dcache-byte-size = <4000>;
>                         xilinx,dcache-highaddr = <5fffffff>;
>                         xilinx,debug-enabled = <1>;
>                         xilinx,div-zero-exception = <1>;
>                         xilinx,dopb-bus-exception = <1>;
>                         xilinx,fpu-exception = <1>;
>                         xilinx,icache-baseaddr = <50000000>;
>                         xilinx,icache-highaddr = <5fffffff>;
>                         xilinx,ill-opcode-exception = <1>;
>                         xilinx,iopb-bus-exception = <1>;
>                         xilinx,number-of-pc-brk = <2>;
>                         xilinx,pvr = <2>;
>                         xilinx,unaligned-exceptions = <1>;
>                         xilinx,use-barrel = <1>;
>                         xilinx,use-dcache = <1>;
>                         xilinx,use-div = <1>;
>                         xilinx,use-fpu = <1>;
>                         xilinx,use-icache = <1>;
>                         xilinx,use-msr-instr = <1>;
>                         xilinx,use-pcmp-instr = <1>;
>                 } ;
>         } ;
>         debug_module {
>                 compatible = "xilinx,opb-mdm-2.00.a\0xilinx,opb-mdm";
>                 device_type = "opb_mdm";
>                 reg = < 41400000 10000 >;
>                 xilinx,mb-dbg-ports = <1>;
>                 xilinx,uart-width = <8>;
>                 xilinx,use-uart = <1>;
>         } ;
>         memory@50000000 {
>                 device_type = "memory";
>                 edk_name = "DDR2_SDRAM_32Mx32";
xlnx,edk_name perhaps?  Might be better to embed this in the node name.

>                 memreg:reg = < 50000000 10000000 >;
>         } ;
>         opb_hwicap_0 {
>                 compatible =
> "xilinx,opb-hwicap-1.10.a\0xilinx,opb-hwicap";
>                 device_type = "opb_hwicap";
Drop device type for this node; it's non-standard.

>                 reg = < 41300000 10000 >;
>         } ;
>         opb_intc_0 {
>                 #interrupt-cells = <2>;
>                 compatible = "xilinx,opb-intc-1.00.c\0xilinx,opb-intc";
>                 device_type = "opb_intc";
>                 interrupt-controller;
>                 linux,phandle = <101>;
You can drop this property and add the label 'opb_intc_0' to this node instead.
>                 reg = < 41200000 10000 >;
>         } ;
>         opb_timer_1 {
>                 compatible =
> "xilinx,opb-timer-1.00.b\0xilinx,opb-timer";
>                 device_type = "opb_timer";
Again, device_type needs to be dropped

>                 interrupt-parent = <101>;
>                 interrupts = < 0 0 >;
>                 reg = < 41c00000 10000 >;
>                 xilinx,count-width = <20>;
>                 xilinx,one-timer-only = <1>;
>         } ;
> } ;
>


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
