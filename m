Return-Path: <petermendham@computing.dundee.ac.uk>
Received: from uncle.computing.dundee.ac.uk (unknown [134.36.36.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E8B53E0B10
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 26 Jun 2008 23:24:02 +1000 (EST)
Received: from mailex.computing.dundee.ac.uk (mailex.computing.dundee.ac.uk
	[134.36.36.15])
	by uncle.computing.dundee.ac.uk (8.13.1/8.13.1) with ESMTP id
	m5QDNpAR022643
	for <linuxppc-embedded@ozlabs.org>; Thu, 26 Jun 2008 14:23:51 +0100
Message-ID: <48639871.9020204@computing.dundee.ac.uk>
Date: Thu, 26 Jun 2008 14:24:01 +0100
From: Peter Mendham <petermendham@computing.dundee.ac.uk>
MIME-Version: 1.0
To: John Linn <John.Linn@xilinx.com>
Subject: Re: Linux on Virtex board with ARCH=powerpc
References: <4860B81F.6070205@computing.dundee.ac.uk>
	<20080624140532.E77E333006C@mail5-sin.bigfish.com>
	<48614927.8020406@computing.dundee.ac.uk>
	<20080624195027.01963640077@mail214-sin.bigfish.com>
	<48626FAC.2070904@computing.dundee.ac.uk>
	<20080625203435.D3C46778055@mail212-sin.bigfish.com>
In-Reply-To: <20080625203435.D3C46778055@mail212-sin.bigfish.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Hi John,

OK, I've given in and I'm using the xilinx git code now :)  It now shows 
some signs of life, thanks, but the sysace driver is not happy.  My root 
fs is on cf and I'm not using initrd.  The driver loads then gets stuck, 
repeatedly saying:

xsysace 80030000.sysace: kicking stalled fsm; state=2 task=0 iter=1 dc=0

I notice from the driver source that state 2 is the driver attempting to 
acquire the mpu lock.  I have tried the standard xilinx sysace selftest 
code which just acquires and frees the lock (which is fine) so the 
hardware should be OK (I hope).  I have the sysace hooked up to an irq 
(the only one), I have no idea whether the dts is correct but it seems 
to compare favourably with the ml405 one; mine says (the important bits):

        intc: interrupt-controller@80010000 {
            #interrupt-cells = <2>;
            compatible = "xlnx,xps-intc-1.00.a";
            interrupt-controller ;
            reg = < 80010000 10000 >;
            xlnx,num-intr-inputs = <1>;
        } ;
        sysace: sysace@80030000 {
            compatible = "xlnx,xps-sysace-1.00.a";
            interrupt-parent = <&intc>;
            interrupts = < 0 2 >;
            reg = < 80030000 10000 >;
            xlnx,family = "virtex4";
            xlnx,mem-width = <10>;
        } ;

Do you have any ideas?

Thanks,
-- Peter

John Linn wrote:
> Hi Peter,
>
> To some extent I think you're trying to re-invent the wheel here, but I
> understand why.
>
> Ideally, you would be able to pull from the mainline kernel to build
> this, but Xilinx hasn't got our code into the mainline.  We are working
> on it more proactively now.
>
> So, in the meantime, it would be easier for you to pull from the Xilinx
> git tree as we have solved the problems you are solving I believe.
>
> Git://git.xilinx.com/linux-2.6-xlnx or http://git.xilinx.com/... 
>
> We supply the device tree files and kernel configurations for the ML405
> and ML507 boards to help get started.
>
> Thanks and sorry for the inconvenience,
> John
>
> -----Original Message-----
> From: Peter Mendham [mailto:petermendham@computing.dundee.ac.uk] 
> Sent: Wednesday, June 25, 2008 10:18 AM
> To: John Linn
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: Linux on Virtex board with ARCH=powerpc
>
> OK, this is all new to me, so please bear with me if I've made a major 
> mistake.  I ran the kernel until it didn't give me anymore output and 
> then told xmd to "stop", mrd from any location gave me exactly the same 
> 32-bit word of garbage.  I then reset the processor and mrd would give 
> me what looked like reasonable values.  I found the __log_buf symbol in 
> the System.map file (0xc024a108) and tried mrd on what I assume is the 
> corresponding physical address of 0x0024a108.  I get the following:
>
> <6>Using Xilinx Virtex machine description
> <5>Linux version 2.6.26-rc6 (peter@eris) (gcc version 4.2.4) #9 PREEMPT 
> Wed Jun 25 16:27:33 BST 2008
> <7>Entering add_active_range(0, 0, 131072) 0 entries of 256 used
> <7>Top of RAM: 0x20000000, Total RAM: 0x20000000
> <7>Memory hole size: 0MB
> <4>Zone PFN ranges:
> <4>  DMA             0 ->   131072
> <4>  Normal     131072 ->   131072
> <4>Movable zone start PFN for each node
> <4>early_node_map[1] active PFN ranges
> <4>    0:        0 ->   131072
> <7>On node 0 totalpages: 131072
> <7>  DMA zone: 1024 pages used for memmap
> <7>  DMA zone: 0 pages reserved
> <7>  DMA zone: 130048 pages, LIFO batch:31
> <7>  Normal zone: 0 pages used for memmap
> <7>  Movable zone: 0 pages used for memmap
> <4>Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 
> 130048
> <5>Kernel command line: console=ttyUL0 root=/dev/xsa2 rw
> <6>Xilinx intc at 0xFDFFF000C025CFFC mapped to 0x0000025d
> <4>PID hash table entries: 2048 (order: 11, 8192 bytes)
>
> xmd tells me that the processor stopped at 0xc000fe50, and subsequent 
> "con" and "stop" sequences do no move this on (it reports the same each 
> time). Below is a choice excerpt of my System.map:
>
> c000fdc4 t src_error
> c000fddc t dst_error
> c000fdf4 T __div64_32
> c000fe94 T cacheable_memzero
> c000ff38 T memset
>
> So I guess that means it's in __div64_32?
>
> Any ideas?
>
> Thanks in advance,
> -- Peter
>
> John Linn wrote:
>   
>> Sounds like the bootstrap loader has loaded the kernel and passed off
>> execution to it, but there's no console working on the kernel.
>>
>> You can confirm that since you have a probe as you can dump the
>> __log_buf by getting the address of it using objdump on the elf image.
>> It's a pain to convert to readable form, but can help to see that
>>     
> things
>   
>> are indeed running. Stop the processor, then do the memory read
>>     
> command,
>   
>> mrd, in xmd. 
>>
>> For the console to work with UART Lite, CONFIG_OF must be on in the
>> kernel configuration, I would check that.
>>
>> The file, arch/powerpc/boot/virtex.c, has the startup code for the
>> virtex specific processing.  It checks to make sure there is
>>     
> compatible
>   
>> hardware based on the device tree.  If your device tree doesn't match
>> that hardware you could have a problem.  I have not found the powerup
>>     
> of
>   
>> the kernel to be very informative if the device tree is wrong.
>>
>> I pasted in our ML405 device tree below to allow you to compare to it.
>>
>> Hope that helps,
>> John
>>
>>
>>
>> /*
>>  * (C) Copyright 2007 Michal Simek
>>  *
>>  * Michal SIMEK <monstr@monstr.eu>
>>  *
>>  * This program is free software; you can redistribute it and/or
>>  * modify it under the terms of the GNU General Public License as
>>  * published by the Free Software Foundation; either version 2 of
>>  * the License, or (at your option) any later version.
>>  *
>>
>>  * This program is distributed in the hope that it will be useful,
>>  * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>>  * GNU General Public License for more details.
>>  *
>>  * You should have received a copy of the GNU General Public License
>>  * along with this program; if not, write to the Free Software
>>  * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
>>  * MA 02111-1307 USA
>>  *
>>  * CAUTION: This file is automatically generated by libgen.
>>  * Version: Xilinx EDK 10.1.1 EDK_K_SP1.1
>>  */
>>
>> / {
>> 	#address-cells = <1>;
>> 	#size-cells = <1>;
>> 	compatible = "xlnx,virtex";
>> 	model = "testing";
>> 	DDR_SDRAM: memory@0 {
>> 		device_type = "memory";
>> 		reg = < 0 8000000 >;
>> 	} ;
>> 	chosen {
>> 		bootargs = "console=ttyS0 ip=on root=/dev/ram";
>> 		linux,stdout-path = "/plb@0/serial@83e00000";
>> 	} ;
>> 	cpus {
>> 		#address-cells = <1>;
>> 		#cpus = <1>;
>>
>> 		#size-cells = <0>;
>> 		ppc405_0: cpu@0 {
>> 			clock-frequency = <11e1a300>;
>> 			compatible = "PowerPC,405", "ibm,ppc405";
>>
>> 			d-cache-line-size = <20>;
>> 			d-cache-size = <4000>;
>> 			device_type = "cpu";
>> 			i-cache-line-size = <20>;
>>
>> 			i-cache-size = <4000>;
>> 			model = "PowerPC,405";
>> 			reg = <0>;
>> 			timebase-frequency = <11e1a300>;
>> 			xlnx,apu-control = <de00>;
>> 			xlnx,apu-udi-1 = <a18983>;
>> 			xlnx,apu-udi-2 = <a38983>;
>> 			xlnx,apu-udi-3 = <a589c3>;
>> 			xlnx,apu-udi-4 = <a789c3>;
>> 			xlnx,apu-udi-5 = <a98c03>;
>> 			xlnx,apu-udi-6 = <ab8c03>;
>> 			xlnx,apu-udi-7 = <ad8c43>;
>> 			xlnx,apu-udi-8 = <af8c43>;
>> 			xlnx,deterministic-mult = <0>;
>> 			xlnx,disable-operand-forwarding = <1>;
>> 			xlnx,fastest-plb-clock = "DPLB0";
>> 			xlnx,generate-plb-timespecs = <1>;
>> 			xlnx,mmu-enable = <1>;
>> 			xlnx,pvr-high = <0>;
>> 			xlnx,pvr-low = <0>;
>> 		} ;
>> 	} ;
>> 	plb: plb@0 {
>> 		#address-cells = <1>;
>> 		#size-cells = <1>;
>> 		compatible = "xlnx,plb-v46-1.02.a";
>> 		ranges ;
>> 		IIC_EEPROM: i2c@81600000 {
>> 			compatible = "xlnx,xps-iic-2.00.a";
>> 			interrupt-parent = <&xps_intc_0>;
>> 			interrupts = < 4 2 >;
>> 			reg = < 81600000 10000 >;
>> 			xlnx,clk-freq = <5f5e100>;
>> 			xlnx,family = "virtex4";
>> 			xlnx,gpo-width = <1>;
>> 			xlnx,iic-freq = <186a0>;
>> 			xlnx,scl-inertial-delay = <0>;
>> 			xlnx,sda-inertial-delay = <0>;
>> 			xlnx,ten-bit-adr = <0>;
>> 		} ;
>> 		LEDs_4Bit: gpio@81400000 {
>> 			compatible = "xlnx,xps-gpio-1.00.a";
>> 			interrupt-parent = <&xps_intc_0>;
>> 			interrupts = < 5 2 >;
>> 			reg = < 81400000 10000 >;
>> 			xlnx,all-inputs = <0>;
>> 			xlnx,all-inputs-2 = <0>;
>> 			xlnx,dout-default = <0>;
>> 			xlnx,dout-default-2 = <0>;
>> 			xlnx,family = "virtex4";
>> 			xlnx,gpio-width = <4>;
>> 			xlnx,interrupt-present = <1>;
>> 			xlnx,is-bidir = <1>;
>> 			xlnx,is-bidir-2 = <1>;
>> 			xlnx,is-dual = <0>;
>> 			xlnx,tri-default = <ffffffff>;
>> 			xlnx,tri-default-2 = <ffffffff>;
>> 		} ;
>> 		RS232_Uart: serial@83e00000 {
>> 			compatible = "ns16550";
>> 			device_type = "serial";
>> 			interrupt-parent = <&xps_intc_0>;
>> 			interrupts = < 6 2 >;
>> 			reg = < 83e00000 10000 >;
>> 			reg-offset = <3>;
>> 			reg-shift = <2>; 
>> 			clock-frequency = <05f5e100>;
>> 			xlnx,family = "virtex4";
>> 			xlnx,has-external-rclk = <0>;
>> 			xlnx,has-external-xin = <0>;
>> 			xlnx,is-a-16550 = <1>;
>> 		} ;
>> 		SysACE_CompactFlash: sysace@83600000 {
>> 			compatible = "xlnx,xps-sysace-1.00.a";
>> 			interrupt-parent = <&xps_intc_0>;
>> 			interrupts = < 3 2 >;
>> 			reg = < 83600000 10000 >;
>> 			xlnx,family = "virtex4";
>> 			xlnx,mem-width = <10>;
>> 		} ;
>> 		TriMode_MAC_GMII: xps-ll-temac@81c00000 {
>> 			#address-cells = <1>;
>> 			#size-cells = <1>;
>> 			compatible = "xlnx,compound";
>> 			ethernet@81c00000 {
>> 				compatible = "xlnx,xps-ll-temac-1.01.a";
>> 				device_type = "network";
>> 				interrupt-parent = <&xps_intc_0>;
>> 				interrupts = < 2 2 >;
>> 				llink-connected = <&PIM2>;
>> 				local-mac-address = [ 02 00 00 00 00 01
>> ];
>> 				reg = < 81c00000 40 >;
>> 				xlnx,bus2core-clk-ratio = <1>;
>> 				xlnx,phy-type = <1>;
>> 				xlnx,phyaddr = <1>;
>> 				xlnx,rxcsum = <0>;
>> 				xlnx,rxfifo = <1000>;
>> 				xlnx,temac-type = <1>;
>> 				xlnx,txcsum = <0>;
>> 				xlnx,txfifo = <1000>;
>> 			} ;
>> 		} ;
>> 		mpmc@0 {
>> 			#address-cells = <1>;
>> 			#size-cells = <1>;
>> 			compatible = "xlnx,mpmc-4.00.a";
>> 			PIM2: sdma@84600100 {
>> 				compatible = "xlnx,ll-dma-1.00.a";
>> 				interrupt-parent = <&xps_intc_0>;
>> 				interrupts = < 1 2 0 2 >;
>> 				reg = < 84600100 80 >;
>> 			} ;
>> 		} ;
>> 		xps_bram_if_cntlr_1: xps-bram-if-cntlr@ffffe000 {
>> 			compatible = "xlnx,xps-bram-if-cntlr-1.00.a";
>> 			reg = < ffffe000 2000 >;
>> 			xlnx,family = "virtex4";
>> 		} ;
>> 		xps_intc_0: interrupt-controller@81800000 {
>> 			#interrupt-cells = <2>;
>> 			compatible = "xlnx,xps-intc-1.00.a";
>> 			interrupt-controller ;
>> 			reg = < 81800000 10000 >;
>> 			xlnx,num-intr-inputs = <7>;
>> 		} ;
>> 	} ;
>> 	ppc405_0_dplb1: plb@1 {
>> 		#address-cells = <1>;
>> 		#size-cells = <1>;
>> 		compatible = "xlnx,plb-v46-1.02.a";
>> 		ranges ;
>> 	} ;
>> }  ;
>>
>>
>>
>>
>>
>> -----Original Message-----
>> From: Peter Mendham [mailto:petermendham@computing.dundee.ac.uk] 
>> Sent: Tuesday, June 24, 2008 1:21 PM
>> To: John Linn
>> Cc: linuxppc-embedded@ozlabs.org
>> Subject: Re: Linux on Virtex board with ARCH=powerpc
>>
>> Hi John,
>>
>> Thanks for your reply, that's really helpful.  I'm actually using the 
>> mainline kernel, rather than the one from the xilinx git tree, but
>>     
> your 
>   
>> information has really moved me on.  My first problem was that the 
>> Xilinx utility (from the git tree) for device tree dts generation
>>     
> didn't
>   
>> insert a "linux,stdout-path" node under "chosen".  I spotted that the 
>> ml403 example had this, so after adding it I got early console 
>> messages.  Everything now grinds to a halt after I get the message
>>     
> "flat
>   
>> tree at 0x40ad60" which is just before it calls the kernel, so I
>>     
> assume 
>   
>> it's that call that is killing it.  I have "console=ttyUL0" for my 
>> uartlite, so I should be getting messages, shouldn't I?  Do you know 
>> where the next execution point is?  Maybe I could find out where it's 
>> getting stuck.
>>
>> I haven't managed to generate an ACE file, I'm just loading the kernel
>>     
>
>   
>> image from xmd ATM, genace won't play ball for me, it complains about 
>> -board user not being valid, it won't even run on the examples copied 
>> directly from the user manual.  Anyway, I think genace is a bit OT,
>>     
> and 
>   
>> I can manage with xmd for now.
>>
>> Thanks,
>> -- Peter
>>
>> John Linn wrote:
>>   
>>     
>>> Hi Peter,
>>>
>>> I'm not up on what can be done with the simple image you refer to in
>>>     
>>>       
>> 1.
>>   
>>     
>>> I'm sure I should be, but there's a lot to learn.
>>>
>>> With regards to 2, the elf image, zImage (without the elf extension),
>>>     
>>>       
>> is
>>   
>>     
>>> located in arch/powerpc/boot.
>>>
>>> You can make a SystemACE file from that elf image just as you did in
>>> arch/ppc.  We have a default device tree file, ml405.dts, in the
>>> arch/powerpc/boot/dts directory for our ml405 board. The kernel
>>> configuration has a config, DEVICE_TREE, that specifies the name of
>>>     
>>>       
>> the
>>   
>>     
>>> device tree file. I normally compile the device tree into the kernel
>>> which is the default build, make ARCH=powerpc zImage. That image does
>>> not require a boot loader.
>>>
>>> I inserted the text below from a document that I have about building
>>>     
>>>       
>> the
>>   
>>     
>>> arch/ppc and arch/powerpc kernels.
>>>
>>> Hope that helps,
>>> John
>>>
>>>
>>> Notation
>>>
>>> The phrase "<ppc or powerpc>" is used throughput the text and means
>>>     
>>>       
>> that
>>   
>>     
>>> one or the other, "ppc" or "powerpc" is to be typed depending on the
>>> architecture you are building.
>>>
>>> Commands that are used in a bash shell are preceded by ">".
>>>
>>> Getting Ready To Build the Kernel
>>>
>>> This assumes you installed the ELDK tools and assumes you'll be using
>>>     
>>>       
>> a
>>   
>>     
>>> bash shell.
>>>
>>>   
>>>     
>>>       
>>>> bash
>>>> export CROSS_COMPILE=ppc_4xx-
>>>>     
>>>>       
>>>>         
>>> Setting Up the Kernel Tree
>>>
>>> If you have previously built this kernel for another architecture,
>>>       
> ppc
>   
>>> or powerpc, then the tree needs to be setup correctly for the new
>>> architecture.  Assuming you have not previously built it, this does
>>>     
>>>       
>> not
>>   
>>     
>>> need to be done.
>>>
>>>   
>>>     
>>>       
>>>> make ARCH=<ppc or powerpc> mrproper
>>>>     
>>>>       
>>>>         
>>> Configuring the Kernel
>>>
>>> The kernel should be configured to run on the ML405 or ML507 board
>>>     
>>>       
>> from
>>   
>>     
>>> Xilinx. 
>>> 	
>>>   
>>>     
>>>       
>>>> make ARCH=<ppc or powerpc>  ml405_defconfig
>>>>     
>>>>       
>>>>         
>>> or 
>>>
>>>   
>>>     
>>>       
>>>> make ARCH=<ppc or powerpc> ml507_defconfig
>>>>     
>>>>       
>>>>         
>>> Building the Kernel
>>>
>>> The following command will build the Linux kernel assuming you are in
>>> the root directory of the kernel.  The root directory of the kernel
>>>     
>>>       
>> from
>>   
>>     
>>> the Xilinx Git tree is linux-2.6-xlnx. An elf file, zImage.elf, is
>>> created in the arch/ppc/boot/images directory for ppc architecture.
>>>       
> An
>   
>>> elf file, zImage, is created in the the arch/powerpc/boot directory
>>>     
>>>       
>> for
>>   
>>     
>>> the powerpc architecture.
>>>
>>>   
>>>     
>>>       
>>>> make ARCH=<ppc or powerpc> zImage
>>>>     
>>>>       
>>>>         
>>> 	
>>> Building the Kernel With Ramdisk
>>>
>>> A ram disk image, a file named *.gz, must be placed into the
>>> arch/ppc/boot/images or arch/powerpc/boot directory, depending on the
>>> architecture, prior to building the kernel.
>>>
>>>   
>>>     
>>>       
>>>> make ARCH=<ppc or powerpc> zImage.initrd
>>>>     
>>>>       
>>>>         
>>> An elf file, zImage.initrd.elf, is created in arch/ppc/boot/images
>>> directory for the ppc architecture. An elf file file, zImage.initrd,
>>>     
>>>       
>> is
>>   
>>     
>>> created in arch/powerpc/boot directory for the powerpc architecture.
>>>
>>> Generating An Ace File
>>>
>>> The elf file generated for the kernel and the bit stream can be
>>>     
>>>       
>> combined
>>   
>>     
>>> to create an ACE file for compact flash.  The following assumes a
>>>       
> bash
>   
>>> shell where XMD is accessible and a xilinx probe attached to the
>>>       
> board
>   
>>> for which you are generating an ace file.
>>>
>>>   
>>>     
>>>       
>>>> xmd -tcl genace.tcl -jprog -target ppc_hw -hw <bit file name> -elf
>>>>       
>>>>         
>> <elf
>>   
>>     
>>>>     
>>>>       
>>>>         
>>> file name> -board <ml405 or ml507> -ace <desired ace file name>
>>>
>>> -----Original Message-----
>>> From: linuxppc-embedded-bounces+john.linn=xilinx.com@ozlabs.org
>>> [mailto:linuxppc-embedded-bounces+john.linn=xilinx.com@ozlabs.org] On
>>> Behalf Of Peter Mendham
>>> Sent: Tuesday, June 24, 2008 3:02 AM
>>> To: linuxppc-embedded@ozlabs.org
>>> Subject: Linux on Virtex board with ARCH=powerpc
>>>
>>> Dear all,
>>>
>>> I'm trying to boot a 2.6.26-rc6 kernel on a custom Virtex 4 board.  I
>>>       
>
>   
>>> have used the Xilinx utility to generate a device tree and now want
>>>       
> to
>   
>>>     
>>>       
>>   
>>     
>>> generate an image for throwing onto CF for use with a SystemACE (just
>>>       
>
>   
>>> like on the the ML3/4xx boards).  I don't want to use a bootloader (I
>>>       
>
>   
>>> don't really need one).  I saw something on this list about
>>>     
>>>       
>> simpleImage,
>>   
>>     
>>> "simple" sounded good to me so I thought I'd try that (or did I 
>>> misinterpret what this is for?).  I also don't want the image to be
>>>     
>>>       
>> too 
>>   
>>     
>>> big, I always used to use a zImage under ARCH=ppc. So, two questions,
>>>       
>
>   
>>> which hopefully are easy ones:
>>> 1. I did what Grant said in a post to this list about simpleImage,
>>>       
> and
>   
>>>     
>>>       
>>   
>>     
>>> dumped my dts into arch/powerpc/boot/dts and I called it system.dts
>>>     
>>>       
>> (for
>>   
>>     
>>> now).  I then tried to do make simpleImage.system which ran right 
>>> through to final link then moaned about a missing simpleboot-system.
>>>       
>
>   
>>> Where is this supposed to come from?  What am I doing wrong?  I
>>>     
>>>       
>> naively 
>>   
>>     
>>> tried copying simpleboot.o to simpleboot-system.o and the error went 
>>> away.  Hmm.
>>> 2. I need an ELF to give to my SystemACE file generator.  This used
>>>       
> to
>   
>>>     
>>>       
>>   
>>     
>>> pop up in arch/ppc/boot/images and be called zImage.elf, which made 
>>> sense to me.  What's the deal now with powerpc?  What should I be
>>>     
>>>       
>> using?
>>   
>>     
>>> Finally, can anyone give me a heads-up on any gotchas with what I'm 
>>> trying to do.  As you can tell, I don't entirely know what I'm doing,
>>>     
>>>       
>> so
>>   
>>     
>>> any pointers would be gratefully received.
>>>
>>> Thanks,
>>> -- Peter
>>>
>>>
>>> The University of Dundee is a Scottish Registered Charity, No.
>>>     
>>>       
>> SC015096.
>>   
>>     
>>> _______________________________________________
>>> Linuxppc-embedded mailing list
>>> Linuxppc-embedded@ozlabs.org
>>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>>
>>>
>>> This email and any attachments are intended for the sole use of the
>>>     
>>>       
>> named recipient(s) and contain(s) confidential information that may be
>> proprietary, privileged or copyrighted under applicable law. If you
>>     
> are
>   
>> not the intended recipient, do not read, copy, or forward this email
>> message or any attachments. Delete this email message and any
>> attachments immediately.
>>   
>>     
>>>   
>>>     
>>>       
>> The University of Dundee is a Scottish Registered Charity, No.
>>     
> SC015096.
>   
>>
>>
>> This email and any attachments are intended for the sole use of the
>>     
> named recipient(s) and contain(s) confidential information that may be
> proprietary, privileged or copyrighted under applicable law. If you are
> not the intended recipient, do not read, copy, or forward this email
> message or any attachments. Delete this email message and any
> attachments immediately.
>   
>>   
>>     
>
>
> The University of Dundee is a Scottish Registered Charity, No. SC015096.
>
>
>
>
> This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
>
>
>   


The University of Dundee is a Scottish Registered Charity, No. SC015096.
