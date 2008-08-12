Return-Path: <becky.bruce@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C801CDE506
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Aug 2008 01:57:12 +1000 (EST)
Message-Id: <BB5D4702-C08F-4C91-8FFA-ABE30AA10EFE@freescale.com>
From: Becky Bruce <becky.bruce@freescale.com>
To: "Morrison, Tom" <tmorrison@empirix.com>
In-Reply-To: <BD261180E6D35F4D9D32F3E44FD3D9010DF4EFAF@EMPBEDEX.empirix.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: Does Dev Tree WORK with soc@y_xxxx_0000 <#address/size> = <2/1>
Date: Tue, 12 Aug 2008 10:56:51 -0500
References: <mailman.1745.1218472641.19168.linuxppc-dev@ozlabs.org>
	<BD261180E6D35F4D9D32F3E44FD3D9010DF4EB31@EMPBEDEX.empirix.com>
	<0120619E-B530-4605-B550-15085F7009E2@freescale.com>
	<BD261180E6D35F4D9D32F3E44FD3D9010DF4EFAF@EMPBEDEX.empirix.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 12, 2008, at 10:14 AM, Morrison, Tom wrote:

> Thank you Becky (and Kumar) for all the information....and help!
>
> To answer your questions, yes, we are using 4GB++ of memory
> (and plan more in the near future). But, for the initial bring
> up, I reduced the memory to 2Gig. Further, I have modified u-boot
> to NOT modify the memory reg properties (see below my snippet)...
>
> Question: what other 'devices' does u-boot put down that I care
> about I have modified u-boot to put the correct memory structure?

If you have 4GB of RAM, you need to move *all* devices in u-boot above  
4GB.  The config file for your board should have all the information  
you need about what's out there.

>
>
> Also, are you saying there are additional patches for
> prom parsing code for this to work right - or are you
> talking about in general for the 4Gig memory??

I was talking about in general for 4GB.  The prom parsing code should  
work already. The issue with having 4GB is that there are some devices  
that only recognize 32 bits of physical address.  These devices will  
require bounce buffering a la swiotlb in order to do dmas when the dma  
buffer is somewhere above about 3.5GB (that number depends on your  
board - the reason you can't see the whole 4GB of space is that some  
portion of the PCI space is reserved for PCI-IO). I'm currently  
working through some issues that popped up when I updated to TOT and  
picked up the dma_attrs changes.  I expect to have these patches out  
within a week or so.

>
>
> Here is a dts snippet with some of the interesting parts:
>
> /{	model = "MPC8548_CHEETAH";
> 	compatible = "MPC8548_CHEETAH";
> 	#address-cells = <2>;
> 	#size-cells = <2>;
>
> 	memory { device_type = "memory";
> 		  reg = <0 	00000000 0 80000000>; // 2 GIG @ 0x0
>         	};
>
> 	soc8548@c6df00000 {
> 		#address-cells = <1>;
> 		#size-cells = <1>;
> 		#interrupt-cells = <2>;
> 		device_type = "soc";
> 		ranges = <00001000 00000000c 6df00000 000ff000>;
> 		reg = <0000000C 6df00000 0 001000>;	// CCSRBAR

>
>
> .........
> 		serial@4500 {
> 			device_type = "serial";
> 			compatible = "ns16550";
> 			reg = <4500 100>;	// reg base, size
> 			clock-frequency = <0>;	// should we fill in in
> uboot?
> 			interrupts = <2a 2>;
> 			interrupt-parent = <&mpic>;
> 		};
>
> 		serial@4600 {
> 			device_type = "serial";
> 			compatible = "ns16550";
> 			reg = <4600 100>;	// reg base, size
> 			clock-frequency = <0>;	// should we fill in in
> uboot?
> 			interrupts = <2a 2>;
> 			interrupt-parent = <&mpic>;
> 		};
>
> .........
> };
>
> Now, it looks like I am successfully parsing and translating the
> address to the expected address for the default stdout  
> (0xc_6df0_4600)!

Yeah, this looks OK (other than the fact that you're using an old .dts  
format).

>
>
> FWIW, I have identified that another problem with the code configuring
> the CCSRBAR (and am sure I'll figure that one out soon because we have
> a working solution in the arch/ppc directory).

FWIW, I moved CCSRBAR in u-boot.

>
>
> While I have your expert attention, I'd like to have you comment about
> what potentially could be right/wrong with my definitions for the pci
> express settings...
>
>   a) Do I put those ranges in the ranges for the parent soc device
> (also)?
>
>   b) Do the below correctly define a 2 Gig PCI memory Window starting
>      at 0xC_6F00_0000 (to 0xC_EF00_0000) and PCI IO 16M Window  
> starting
>      at 0xC_6E00_0000 (to 0xC_6F00_0000)?
>
> -----
>  /* PCI Express */
>  pcie@a000 {
> 	compatible = "fsl,mpc8548-pcie";
> 	device_type = "pci";
> 	#interrupt-cells = <1>;
> 	#size-cells = <2>;
> 	#address-cells = <3>;
> 	reg = <a000 1000>;
> 	bus-range = <0 ff>;
> 	ranges = <02000000 0 c 6f000000 c 6f000000 0 80000000
>  		   01000000  0 00000000 0000000c 6E000000 0 01000000>;

This doesn't look right to me, assuming your pcie device is at the  
same tree level as mine.  What's the parent node and what are address- 
cells and size-cells in the parent?  I'm basically at next-to-top  
level, under the platform node.

Here's an example from my working tree:
         model = "MPC8641HPCN";
         compatible = "mpc86xx";
         #address-cells = <2>;
         #size-cells = <2>;
	
	.......

         pci0: pcie@ff8008000 {
                 cell-index = <0>;
                 compatible = "fsl,mpc8641-pcie";
                 device_type = "pci";
                 #interrupt-cells = <1>;
                 #size-cells = <2>;
                 #address-cells = <3>;
                 reg = <0x0f 0xf8008000 0x0 0x1000>;
                 bus-range = <0x0 0xff>;
                 ranges = <0x02000000 0x0 0x80000000 0x0f 0x80000000  
0x0 0x20000000
                           0x01000000 0x0 0x00000000 0x0f 0xe2000000  
0x0 0x00100000>;

I believe you should just need to change the parent bus address field  
in ranges, and you need to update your "reg" property.

>
>
> -----
>
> Thank you for all your help/comments...
>

Have fun :)

Cheers,
Becky
