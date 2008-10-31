Return-Path: <duykynguyen@hotmail.com>
Received: from bay0-omc2-s10.bay0.hotmail.com (bay0-omc2-s10.bay0.hotmail.com
	[65.54.246.146]) by ozlabs.org (Postfix) with ESMTP id 06B47DDDE3
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  1 Nov 2008 08:29:42 +1100 (EST)
Message-ID: <BLU119-DAV645CD008897C8C7315077BB200@phx.gbl>
From: "Duy-Ky Nguyen" <duykynguyen@hotmail.com>
To: <linuxppc-embedded@ozlabs.org>
References: <mailman.4676.1225390307.3127.linuxppc-embedded@ozlabs.org>
Subject: How to use eth0 of MPC8313E
Date: Fri, 31 Oct 2008 14:29:35 -0700
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

It appears to me that the FreeScale Eva Board MPC8313E-RDB has 2 ethernet 
controllers TSEC1 and TSEC2 for 6 ethernet connectors G0 ~ G5. The TSEC1 is 
connected to Vistesse L2 switch VSC for G0 ~ G4. The TSEC2 is for G5.

I've been using G5 as eth1 only as I have to use firmware for using the 
others.

Now I have my own prototype using only TSEC1 while TSEC2 pins used as 
GPIO's.
I'm able to do u-boot but eth0 is not working as I'm not able to ping from 
u-boot to the host. I have correct PhyAddr for the PHY chip.

I'm really appreciate your time and help..

Best Regards,

Duy-Ky

----- Original Message ----- 
From: <linuxppc-embedded-request@ozlabs.org>
To: <linuxppc-embedded@ozlabs.org>
Sent: Thursday, October 30, 2008 11:11 AM
Subject: Linuxppc-embedded Digest, Vol 50, Issue 47


> Send Linuxppc-embedded mailing list submissions to
> linuxppc-embedded@ozlabs.org
>
> To subscribe or unsubscribe via the World Wide Web, visit
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> or, via email, send a message with subject or body 'help' to
> linuxppc-embedded-request@ozlabs.org
>
> You can reach the person managing the list at
> linuxppc-embedded-owner@ozlabs.org
>
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of Linuxppc-embedded digest..."
>
>
> Today's Topics:
>
>   1. Linux 2.6 boot failure on xup virtex II ppc405 (saadia)
>   2. RE: Linux 2.6 boot failure on xup virtex II ppc405
>      (Stephen Neuendorffer)
>
>
> ----------------------------------------------------------------------
>
> Message: 1
> Date: Thu, 30 Oct 2008 10:56:36 -0700 (PDT)
> From: saadia <saadia_dhouib@yahoo.fr>
> Subject: Linux 2.6 boot failure on xup virtex II ppc405
> To: linuxppc-embedded@ozlabs.org
> Message-ID: <20252128.post@talk.nabble.com>
> Content-Type: text/plain; charset=us-ascii
>
>
> Hi,
> I have downloaded the latest linux kernel linux-2.6-xlnx.git from
> http://git.xilinx.com/ .
> Than I have downloaded the device tree generator  device-tree.git from the
> same site.
> I launched edk 8.2.02, I designed a system with two powerpc cores:
> ppc_405_0, ppc_405_1, and opb bus , a plb bus, and the following devices
> with their memory map:
>
> BASE         HIGH            MODULE
> 0x00000000 0x0FFFFFFF DDR_256MB_32MX64_rank1_row13_col10_cl2_5
> 0x40600000 0x4060FFFF RS232_Uart_1
> 0x40C00000 0x40C0FFFF Ethernet_MAC
> 0x41200000 0x4120FFFF opb_intc_0
> 0x41800000 0x4180FFFF SysACE_CompactFlash
>
> I generated the bitsteam system.bit.
> After getting the device tree generator from
> git://git.xilinx.com/device-tree.git, I have copied the 'bsp' directory 
> and
> contents so that it can be used by edk XPS. Then I selected 'device-tree' 
> in
> the pull down menu labeled 'OS' in the Software Platform Settings dialog
> box.
> Then selected 'OS and Libraries' on the left, and entered the values for
> 'console device' and  'bootargs' (respectively
> 'RS232_Uart_1' and 'console=ttyS0,9600 root=/dev/xsysace/disc0/part3 
> ip=on'
> ).
> Then I generated libraries and  BSP, in the edk_project directory and not 
> in
> the linux src directory.
> There were those warnings:
> *******************************************************************************************************************
> --- device tree generator version: v1.1 ---
> generating xilinx.dts
> Clock Port Summary:
> ppc405_0.CPMC405CLOCK connected to proc_clk_s:
>    CLK_FREQ_HZ = WARNING: no frequency found!
> ppc405_0.PLBCLK connected to sys_clk_s:
>    CLK_FREQ_HZ = WARNING: no frequency found!
> reset_block.Slowest_sync_clk connected to sys_clk_s:
>    CLK_FREQ_HZ = WARNING: no frequency found!
> plb.PLB_Clk connected to sys_clk_s:
>    CLK_FREQ_HZ = WARNING: no frequency found!
> opb.OPB_Clk connected to sys_clk_s:
>    CLK_FREQ_HZ = WARNING: no frequency found!
>
> plb2opb.PLB_Clk connected to sys_clk_s:
>    CLK_FREQ_HZ = WARNING: no frequency found!
> plb2opb.OPB_Clk connected to sys_clk_s:
>    CLK_FREQ_HZ = WARNING: no frequency found!
> RS232_Uart_1.OPB_Clk connected to sys_clk_s:
>    CLK_FREQ_HZ = WARNING: no frequency found!
> Ethernet_MAC.OPB_Clk connected to sys_clk_s:
>    CLK_FREQ_HZ = WARNING: no frequency found!
> SysACE_CompactFlash.OPB_Clk connected to sys_clk_s:
>    CLK_FREQ_HZ = WARNING: no frequency found!
> DDR_256MB_32MX64_rank1_row13_col10_cl2_5.PLB_Clk connected to sys_clk_s:
>    CLK_FREQ_HZ = WARNING: no frequency found!
> plb_bram_if_cntlr_1.plb_clk connected to sys_clk_s:
>    CLK_FREQ_HZ = WARNING: no frequency found!
> plb_bram_if_cntlr_1_bram.BRAM_Clk_A connected to
> plb_bram_if_cntlr_1_port_BRAM_Clk:
>    CLK_FREQ_HZ = WARNING: no frequency found!
> opb_intc_0.OPB_Clk connected to sys_clk_s:
>    CLK_FREQ_HZ = WARNING: no frequency found!
> dcm_0.CLKIN connected to dcm_clk_s:
>    CLK_FREQ_HZ = WARNING: no frequency found!
> dcm_0.CLK0 connected to sys_clk_s:
>    CLK_FREQ_HZ = WARNING: no frequency found!
>    CLK_INPORT = CLKIN
>    CLK_FACTOR = 1
> dcm_0.CLK90 connected to clk_90_s:
>    CLK_FREQ_HZ = WARNING: no frequency found!
>    CLK_INPORT = CLKIN
>    CLK_FACTOR = 1
> dcm_0.CLKFX connected to proc_clk_s:
>    CLK_FREQ_HZ = WARNING: no frequency found!
>    CLK_INPORT = CLKIN
>    CLK_FACTOR = C_CLKFX_MULTIPLY / C_CLKFX_DIVIDE
> dcm_1.CLKIN connected to ddr_feedback_s:
>    CLK_FREQ_HZ = WARNING: no frequency found!
> dcm_1.CLK0 connected to dcm_1_FB:
>    CLK_FREQ_HZ = WARNING: no frequency found!
>    CLK_INPORT = CLKIN
>    CLK_FACTOR = 1
> dcm_1.CLK90 connected to ddr_clk_90_s:
>    CLK_FREQ_HZ = WARNING: no frequency found!
>    CLK_INPORT = CLKIN
>    CLK_FACTOR = 1
> Clock Frequency: 300000000
> IP connected to bus: plb
> -master DPLB plb ppc405_0
> -master IPLB plb ppc405_0
> -slave SPLB plb plb2opb
> -slave SPLB plb DDR_256MB_32MX64_rank1_row13_col10_cl2_5
> -slave SPLB plb plb_bram_if_cntlr_1
> IP connected to bus: opb
> -master MOPB opb plb2opb
> -slave SOPB opb RS232_Uart_1
> -slave SOPB opb Ethernet_MAC
> -slave SOPB opb SysACE_CompactFlash
> -slave SOPB opb opb_intc_0
>
> WARNING:MDT - Search path /home/dhouib/xupv2p/ directly contains pcores
>   directory. Search path should point to a directory two levels above
> pcores.
> WARNING:MDT - Search path /home/dhouib/xupv2p/ directly contains pcores
>   directory. Search path should point to a directory two levels above
> pcores.
>    CLK_FREQ_HZ = WARNING: no frequency found!
>
>    CLK_FREQ_HZ = WARNING: no frequency found!
>
>    CLK_FREQ_HZ = WARNING: no frequency found!
>
>    CLK_FREQ_HZ = WARNING: no frequency found!
> opb.OPB_Clk connected to sys_clk_s:
>    CLK_FREQ_HZ = WARNING: no frequency found!
> plb2opb.PLB_Clk connected to sys_clk_s:
>    CLK_FREQ_HZ = WARNING: no frequency found!
>
> plb2opb.OPB_Clk connected to sys_clk_s:
>    CLK_FREQ_HZ = WARNING: no frequency found!
> RS232_Uart_1.OPB_Clk connected to sys_clk_s:
>    CLK_FREQ_HZ = WARNING: no frequency found!
>
> Ethernet_MAC.OPB_Clk connected to sys_clk_s:
>    CLK_FREQ_HZ = WARNING: no frequency found!
> SysACE_CompactFlash.OPB_Clk connected to sys_clk_s:
>    CLK_FREQ_HZ = WARNING: no frequency found!
> DDR_256MB_32MX64_rank1_row13_col10_cl2_5.PLB_Clk connected to sys_clk_s:
>    CLK_FREQ_HZ = WARNING: no frequency found!
>
> plb_bram_if_cntlr_1.plb_clk connected to sys_clk_s:
>    CLK_FREQ_HZ = WARNING: no frequency found!
> plb_bram_if_cntlr_1_bram.BRAM_Clk_A connected to
> plb_bram_if_cntlr_1_port_BRAM_Clk:
>    CLK_FREQ_HZ = WARNING: no frequency found!
> opb_intc_0.OPB_Clk connected to sys_clk_s:
>    CLK_FREQ_HZ = WARNING: no frequency found!
> dcm_0.CLKIN connected to dcm_clk_s:
>    CLK_FREQ_HZ = WARNING: no frequency found!
> dcm_0.CLK0 connected to sys_clk_s:
>    CLK_FREQ_HZ = WARNING: no frequency found!
>    CLK_INPORT = CLKIN
>    CLK_FACTOR = 1
> dcm_0.CLK90 connected to clk_90_s:
>    CLK_FREQ_HZ = WARNING: no frequency found!
>    CLK_INPORT = CLKIN
>    CLK_FACTOR = 1
>
> dcm_0.CLKFX connected to proc_clk_s:
>    CLK_FREQ_HZ = WARNING: no frequency found!
>    CLK_INPORT = CLKIN
>    CLK_FACTOR = C_CLKFX_MULTIPLY / C_CLKFX_DIVIDE
> dcm_1.CLKIN connected to ddr_feedback_s:
>    CLK_FREQ_HZ = WARNING: no frequency found!
> dcm_1.CLK0 connected to dcm_1_FB:
>    CLK_FREQ_HZ = WARNING: no frequency found!
>    CLK_INPORT = CLKIN
>    CLK_FACTOR = 1
> dcm_1.CLK90 connected to ddr_clk_90_s:
>    CLK_FREQ_HZ = WARNING: no frequency found!
>    CLK_INPORT = CLKIN
>    CLK_FACTOR = 1
> Clock Frequency: 300000000
> IP connected to bus: plb
> ***************************************************************************************************************
> ***************************************************************************************************************
>
> I copied  <edk_project_path>/ppc_405_0/libsrc/device-tree/xilinx.dts to
> <linux_path>/arch/powerpc/boot/dts/virtex405-ml405.dts .
> the device tree file looks like this:
> ****************************************************************************************************
> ****************************************************************************************************
> /*
> * Device Tree Generator version: 1.1
> *
> * (C) Copyright 2007-2008 Xilinx, Inc.
> * (C) Copyright 2007-2008 Michal Simek
> *
> * Michal SIMEK <monstr@monstr.eu>
> *
> * This program is free software; you can redistribute it and/or
> * modify it under the terms of the GNU General Public License as
> * published by the Free Software Foundation; either version 2 of
> * the License, or (at your option) any later version.
> *
> * This program is distributed in the hope that it will be useful,
> * but WITHOUT ANY WARRANTY; without even the implied warranty of
> * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> * GNU General Public License for more details.
> *
> * You should have received a copy of the GNU General Public License
> * along with this program; if not, write to the Free Software
> * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
> * MA 02111-1307 USA
> *
> * CAUTION: This file is automatically generated by libgen.
> * Version: Xilinx EDK 8.2.02 EDK_Im_Sp2.4
> *
> * XPS project directory: edk_300_100_linux_2-6
> */
>
> /dts-v1/;
> / {
> #address-cells = <1>;
> #size-cells = <1>;
> compatible = "xlnx,virtex405", "xlnx,virtex";
> model = "testing";
> DDR_256MB_32MX64_rank1_row13_col10_cl2_5: memory@0 {
> device_type = "memory";
> reg = < 0x0 0x10000000 >;
> } ;
> chosen {
> bootargs = "console=ttyS0,9600 root=/dev/xsysace/disc0/part3 ip=on";
> linux,stdout-path = "/plb@0/opb@40000000/serial@40600000";
> } ;
> cpus {
> #address-cells = <1>;
> #cpus = <0x1>;
> #size-cells = <0>;
> ppc405_0: cpu@0 {
> clock-frequency = <300000000>;
> compatible = "PowerPC,405", "ibm,ppc405";
> d-cache-line-size = <0x20>;
> d-cache-size = <0x4000>;
> dcr-access-method = "native";
> dcr-controller ;
> device_type = "cpu";
> i-cache-line-size = <0x20>;
> i-cache-size = <0x4000>;
> model = "PowerPC,405";
> reg = <0>;
> timebase-frequency = <300000000>;
> xlnx,dcr-resync = <0x0>;
> xlnx,deterministic-mult = <0x0>;
> xlnx,disable-operand-forwarding = <0x1>;
> xlnx,mmu-enable = <0x1>;
> } ;
> } ;
> plb: plb@0 {
> #address-cells = <1>;
> #size-cells = <1>;
> compatible = "xlnx,plb-v34-1.02.a", "simple-bus";
> ranges ;
> opb: opb@40000000 {
> #address-cells = <1>;
> #size-cells = <1>;
> compatible = "xlnx,opb-v20-1.10.c", "simple-bus";
> ranges = < 0x40000000 0x40000000 0x40000000 >;
> Ethernet_MAC: ethernet@40c00000 {
> compatible = "xlnx,opb-ethernet-1.04.a";
> device_type = "network";
> local-mac-address = [ 02 00 00 00 00 00 ];
> reg = < 0x40c00000 0x10000 >;
> xlnx,cam-bram-0-srl-1 = <0x1>;
> xlnx,cam-exist = <0x0>;
> xlnx,dev-blk-id = <0x1>;
> xlnx,dev-mir-enable = <0x1>;
> xlnx,dma-intr-coalesce = <0x1>;
> xlnx,dma-present = <0x1>;
> xlnx,err-count-exist = <0x1>;
> xlnx,family = "virtex2p";
> xlnx,fcs-insert-exist = <0x1>;
> xlnx,half-duplex-exist = <0x1>;
> xlnx,include-dev-pencoder = <0x1>;
> xlnx,ipif-rdfifo-depth = <0x8000>;
> xlnx,ipif-wrfifo-depth = <0x8000>;
> xlnx,jumbo-exist = <0x0>;
> xlnx,mac-fifo-bram-1-srl-0 = <0x0>;
> xlnx,mac-fifo-depth = <0x40>;
> xlnx,mii-exist = <0x1>;
> xlnx,miim-clkdvd = <0x1f>;
> xlnx,pad-insert-exist = <0x1>;
> xlnx,reset-present = <0x1>;
> xlnx,rx-dre-type = <0x0>;
> xlnx,rx-include-csum = <0x0>;
> xlnx,source-addr-insert-exist = <0x1>;
> xlnx,tx-dre-type = <0x0>;
> xlnx,tx-include-csum = <0x0>;
> } ;
> RS232_Uart_1: serial@40600000 {
> clock-frequency = "";
> compatible = "xlnx,opb-uartlite-1.00.b";
> current-speed = <9600>;
> device_type = "serial";
> interrupt-parent = <&opb_intc_0>;
> interrupts = < 1 0 >;
> port-number = <0>;
> reg = < 0x40600000 0x10000 >;
> xlnx,baudrate = <0x9600>;
> xlnx,clk-freq = <0x5f5e100>;
> xlnx,data-bits = <0x8>;
> xlnx,odd-parity = <0x0>;
> xlnx,use-parity = <0x0>;
> } ;
> SysACE_CompactFlash: sysace@41800000 {
> compatible = "xlnx,opb-sysace-1.00.c";
> interrupt-parent = <&opb_intc_0>;
> interrupts = < 0 2 >;
> reg = < 0x41800000 0x10000 >;
> xlnx,mem-width = <0x10>;
> } ;
> opb_intc_0: interrupt-controller@41200000 {
> #interrupt-cells = <0x2>;
> compatible = "xlnx,opb-intc-1.00.c";
> interrupt-controller ;
> reg = < 0x41200000 0x10000 >;
> xlnx,num-intr-inputs = <0x2>;
> } ;
> } ;
> } ;
> }  ;
> ******************************************************************************************************
> ******************************************************************************************************
>
> Then cp <linux_path>/arch/powerpc/configs/40x/virtex4_defconfig
> <linux_path>/.
>
> Then
> cd <linux_path>
> export ARCH=powerpc
> export CROSS_COMPILE=powerpc-405-linux-gnu-
> export
> PATH=${PATH}:$HOME/xupv2p/opt/crosstool/gcc-3.4.5-glibc-2.3.5/powerpc-405-linux-gnu/bin
> make menuconfig
> I disabled all the options and enabled only:
> -------------------------------------------------------------------------------------------------------------------------------------------------------------------------
> Processor support ->  Processor Type AMCC 40x (!!!  there is not ppc 40x)
> Platform Support ->  Generic Xilinx Virtex board
> Kernel options ->   Kernel support for ELF binaries
>                            Math emulation
>                           Default bootloader kernel arguments
>                             (console=ttyS0,9600)    Initial kernel command
> string
>                                     (simpleImage.virtex405-ml405)
> Additional default image types
> Device Drivers -> Character Devices -> Virtual Terminal
>                                                           Serial 
> Devices ->
> [*] 8250/16550 and compatible serial
>
> [*]   Console on 8250/16550 and compatible serial port
>
> (4) Maximum number of 8250/16550 serial ports
>
> (4) Number of 8250/16550 serial ports to register at runtime
>
> --------------------------------------------------------------------------------------------------------------------------------------------------------------------
>
> Then make clean && make dep && make zImage
> I obtained a binary zImage file (and not zImage.elf) !!!! and I obtained
> simpleImage.virtex405-ml405.elf in <linux_path>/arch/powerpc/boot .
>
> I used xmd to generated a system.ace from the bitstream and the elf.
> The report of xmd is:
> ******************************************************************************
> *****************************************************************************
> XMD% xmd -tcl genace.tcl -opt genace1.opt
> Xilinx Microprocessor Debug (XMD) Engine
> Xilinx EDK 8.2.02 Build EDK_Im_Sp2.4
> Copyright (c) 1995-2005 Xilinx, Inc.  All rights reserved.
> Executing user script : genace.tcl
>
> #######################################################################
> XMD GenACE utility. Generate SystemACE File from bit/elf/data Files
> #######################################################################
> Using GenACE option file : genace1.opt
> GenACE Options:
> Board      : xupv2p
> Jtag Devs  : xc2vp30
> FPGA pos   : 1
> JPROG      : true
> HW File    :
> /home/dhouib/xupv2p/edk_300_100_linux_2-6/implementation/system.bit
> ACE File   : system3.ace
> nCPUs      : 1
>
> Processor ppc_hw_1 Information
> Debug opt : -debugdevice devicenr 1 cpunr 1
> ELF files : simpleImage.virtex405-ml405-3.elf
> Start PC Address : 0x00400000
>
> ############################################################
> Converting Bitstream
> '/home/dhouib/xupv2p/edk_300_100_linux_2-6/implementation/system.bit' to 
> SVF
> file '/home/dhouib/xupv2p/edk_300_100_linux_2-6/implementation/system.svf'
> Executing 'impact -batch bit2svf.scr'
>
> Copying 
> /home/dhouib/xupv2p/edk_300_100_linux_2-6/implementation/system.svf
> File to  system3.svf File
>
>
> ############################################################
> Converting ELF file 'simpleImage.virtex405-ml405-3.elf' to SVF file
> 'simpleImage.virtex405-ml405-3.svf'
> Target reset successfully
> section, .text: 0x00400000-0x00408ed4
> section, .data: 0x00409000-0x0040ac18
> section, __builtin_cmdline: 0x0040ac18-0x0040ae18
> section, .kernel:dtb: 0x0040ae18-0x0040be33
> section, .kernel:vmlinux.strip: 0x0040c000-0x004c3ae1
> section, .bss: 0x004c4000-0x004d0dd8
> Downloaded Program simpleImage.virtex405-ml405-3.elf
> Setting PC with program start addr = 0x00400000
> PC reset to 0x00400000, Clearing MSR Register
>
> Copying simpleImage.virtex405-ml405-3.svf File to  system3.svf File
>
>
> ############################################################
> Writing Processor JTAG "continue" command to SVF file 'sw_suffix.svf'
> PC reset to 0x00400000, Clearing MSR Register
> Processor started. Type "stop" to stop processor
>
> ############################################################
> Converting SVF file 'system3.svf' to SystemACE file 'system3.ace'
> Executing 'impact -batch svf2ace.scr'
>
> SystemACE file 'system3.ace' created successfully
> ********************************************************************************************
> ********************************************************************************************
>
>
> I copied the system3.ace (3 because it was the third kernel that I tested
> :((( ) to the flash disk partition 1 (Type = FAT16, Size = 32Mo ).
> And I booted the kernel.
> I got fllowing message on the Terminal:
>
> *****************************************************************************************
> zImage starting: loaded at 0x00400000 (sp: 0x004c4efc)
> Allocating 0x1acdec bytes for kernel ...
> gunzipping (0x00000000 <- 0x0040c000:0x004c3ae1)...done 0x1951b8 bytes
>
> Linux/PowerPC load: console=ttyS0,9600 root=/dev/xsysace/disc0/part3 ip=on
> Finalizing device tree... flat tree at 0x40ae18
> *******************************************************************************************
>
> My Questions are:
> 1. Why he stops here?
> 2. Why I didn't obtained zImage.elf but simpleImage.virtex405-ml405.elf
> 3. Do I have to copy other files from my <edk_project_path> (xparameters.h 
> ,
> drivers ) to the <linux_path> ? (I copied only the xilinx.dts file)
>
> Thanks
> saadia
>
>
>
>
>
> -- 
> View this message in context: 
> http://www.nabble.com/Linux-2.6-boot-failure-on-xup-virtex-II-ppc405-tp20252128p20252128.html
> Sent from the linuxppc-embedded mailing list archive at Nabble.com.
>
>
>
> ------------------------------
>
> Message: 2
> Date: Thu, 30 Oct 2008 11:11:15 -0700
> From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
> Subject: RE: Linux 2.6 boot failure on xup virtex II ppc405
> To: "saadia" <saadia_dhouib@yahoo.fr>, <linuxppc-embedded@ozlabs.org>
> Message-ID: <20081030181118.5D5E1A38050@mail57-sin.bigfish.com>
> Content-Type: text/plain; charset="us-ascii"
>
>
> Saadia,
>
> I'm guessing that the kernel does not have the right clock information
> in your device tree.  The quick fix is to fix the clock-frequency
> attribute on the uart.  The kernel needs this in order to set the
> register values in the uart correctly.
>
> This information would be populated automatically, if you used a
> somewhat recent version of EDK ( >= 10.1 ) and add a CLOCK_FREQUENCY
> attribute on the external clock pin in the mhs file.
>
> I'm actually somewhat surprised you see any output on the serial port at
> all.
>
> Steve
>
>> -----Original Message-----
>> From: linuxppc-embedded-bounces+stephen=neuendorffer.name@ozlabs.org
> [mailto:linuxppc-embedded-
>> bounces+stephen=neuendorffer.name@ozlabs.org] On Behalf Of saadia
>> Sent: Thursday, October 30, 2008 10:57 AM
>> To: linuxppc-embedded@ozlabs.org
>> Subject: Linux 2.6 boot failure on xup virtex II ppc405
>>
>>
>> Hi,
>> I have downloaded the latest linux kernel linux-2.6-xlnx.git from
>> http://git.xilinx.com/ .
>> Than I have downloaded the device tree generator  device-tree.git from
> the
>> same site.
>> I launched edk 8.2.02, I designed a system with two powerpc cores:
>> ppc_405_0, ppc_405_1, and opb bus , a plb bus, and the following
> devices
>> with their memory map:
>>
>> BASE         HIGH            MODULE
>> 0x00000000 0x0FFFFFFF DDR_256MB_32MX64_rank1_row13_col10_cl2_5
>> 0x40600000 0x4060FFFF RS232_Uart_1
>> 0x40C00000 0x40C0FFFF Ethernet_MAC
>> 0x41200000 0x4120FFFF opb_intc_0
>> 0x41800000 0x4180FFFF SysACE_CompactFlash
>>
>> I generated the bitsteam system.bit.
>> After getting the device tree generator from
>> git://git.xilinx.com/device-tree.git, I have copied the 'bsp'
> directory and
>> contents so that it can be used by edk XPS. Then I selected
> 'device-tree' in
>> the pull down menu labeled 'OS' in the Software Platform Settings
> dialog
>> box.
>> Then selected 'OS and Libraries' on the left, and entered the values
> for
>> 'console device' and  'bootargs' (respectively
>> 'RS232_Uart_1' and 'console=ttyS0,9600 root=/dev/xsysace/disc0/part3
> ip=on'
>> ).
>> Then I generated libraries and  BSP, in the edk_project directory and
> not in
>> the linux src directory.
>> There were those warnings:
>>
> ************************************************************************
> *****************************
>> **************
>> --- device tree generator version: v1.1 ---
>> generating xilinx.dts
>> Clock Port Summary:
>> ppc405_0.CPMC405CLOCK connected to proc_clk_s:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>> ppc405_0.PLBCLK connected to sys_clk_s:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>> reset_block.Slowest_sync_clk connected to sys_clk_s:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>> plb.PLB_Clk connected to sys_clk_s:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>> opb.OPB_Clk connected to sys_clk_s:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>
>> plb2opb.PLB_Clk connected to sys_clk_s:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>> plb2opb.OPB_Clk connected to sys_clk_s:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>> RS232_Uart_1.OPB_Clk connected to sys_clk_s:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>> Ethernet_MAC.OPB_Clk connected to sys_clk_s:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>> SysACE_CompactFlash.OPB_Clk connected to sys_clk_s:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>> DDR_256MB_32MX64_rank1_row13_col10_cl2_5.PLB_Clk connected to
> sys_clk_s:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>> plb_bram_if_cntlr_1.plb_clk connected to sys_clk_s:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>> plb_bram_if_cntlr_1_bram.BRAM_Clk_A connected to
>> plb_bram_if_cntlr_1_port_BRAM_Clk:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>> opb_intc_0.OPB_Clk connected to sys_clk_s:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>> dcm_0.CLKIN connected to dcm_clk_s:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>> dcm_0.CLK0 connected to sys_clk_s:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>     CLK_INPORT = CLKIN
>>     CLK_FACTOR = 1
>> dcm_0.CLK90 connected to clk_90_s:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>     CLK_INPORT = CLKIN
>>     CLK_FACTOR = 1
>> dcm_0.CLKFX connected to proc_clk_s:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>     CLK_INPORT = CLKIN
>>     CLK_FACTOR = C_CLKFX_MULTIPLY / C_CLKFX_DIVIDE
>> dcm_1.CLKIN connected to ddr_feedback_s:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>> dcm_1.CLK0 connected to dcm_1_FB:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>     CLK_INPORT = CLKIN
>>     CLK_FACTOR = 1
>> dcm_1.CLK90 connected to ddr_clk_90_s:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>     CLK_INPORT = CLKIN
>>     CLK_FACTOR = 1
>> Clock Frequency: 300000000
>> IP connected to bus: plb
>> -master DPLB plb ppc405_0
>> -master IPLB plb ppc405_0
>> -slave SPLB plb plb2opb
>> -slave SPLB plb DDR_256MB_32MX64_rank1_row13_col10_cl2_5
>> -slave SPLB plb plb_bram_if_cntlr_1
>> IP connected to bus: opb
>> -master MOPB opb plb2opb
>> -slave SOPB opb RS232_Uart_1
>> -slave SOPB opb Ethernet_MAC
>> -slave SOPB opb SysACE_CompactFlash
>> -slave SOPB opb opb_intc_0
>>
>> WARNING:MDT - Search path /home/dhouib/xupv2p/ directly contains
> pcores
>>    directory. Search path should point to a directory two levels above
>> pcores.
>> WARNING:MDT - Search path /home/dhouib/xupv2p/ directly contains
> pcores
>>    directory. Search path should point to a directory two levels above
>> pcores.
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>> opb.OPB_Clk connected to sys_clk_s:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>> plb2opb.PLB_Clk connected to sys_clk_s:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>
>> plb2opb.OPB_Clk connected to sys_clk_s:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>> RS232_Uart_1.OPB_Clk connected to sys_clk_s:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>
>> Ethernet_MAC.OPB_Clk connected to sys_clk_s:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>> SysACE_CompactFlash.OPB_Clk connected to sys_clk_s:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>> DDR_256MB_32MX64_rank1_row13_col10_cl2_5.PLB_Clk connected to
> sys_clk_s:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>
>> plb_bram_if_cntlr_1.plb_clk connected to sys_clk_s:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>> plb_bram_if_cntlr_1_bram.BRAM_Clk_A connected to
>> plb_bram_if_cntlr_1_port_BRAM_Clk:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>> opb_intc_0.OPB_Clk connected to sys_clk_s:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>> dcm_0.CLKIN connected to dcm_clk_s:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>> dcm_0.CLK0 connected to sys_clk_s:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>     CLK_INPORT = CLKIN
>>     CLK_FACTOR = 1
>> dcm_0.CLK90 connected to clk_90_s:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>     CLK_INPORT = CLKIN
>>     CLK_FACTOR = 1
>>
>> dcm_0.CLKFX connected to proc_clk_s:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>     CLK_INPORT = CLKIN
>>     CLK_FACTOR = C_CLKFX_MULTIPLY / C_CLKFX_DIVIDE
>> dcm_1.CLKIN connected to ddr_feedback_s:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>> dcm_1.CLK0 connected to dcm_1_FB:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>     CLK_INPORT = CLKIN
>>     CLK_FACTOR = 1
>> dcm_1.CLK90 connected to ddr_clk_90_s:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>     CLK_INPORT = CLKIN
>>     CLK_FACTOR = 1
>> Clock Frequency: 300000000
>> IP connected to bus: plb
>>
> ************************************************************************
> *****************************
>> **********
>>
> ************************************************************************
> *****************************
>> **********
>>
>> I copied  <edk_project_path>/ppc_405_0/libsrc/device-tree/xilinx.dts
> to
>> <linux_path>/arch/powerpc/boot/dts/virtex405-ml405.dts .
>>  the device tree file looks like this:
>>
> ************************************************************************
> ****************************
>>
> ************************************************************************
> ****************************
>> /*
>>  * Device Tree Generator version: 1.1
>>  *
>>  * (C) Copyright 2007-2008 Xilinx, Inc.
>>  * (C) Copyright 2007-2008 Michal Simek
>>  *
>>  * Michal SIMEK <monstr@monstr.eu>
>>  *
>>  * This program is free software; you can redistribute it and/or
>>  * modify it under the terms of the GNU General Public License as
>>  * published by the Free Software Foundation; either version 2 of
>>  * the License, or (at your option) any later version.
>>  *
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
>>  * Version: Xilinx EDK 8.2.02 EDK_Im_Sp2.4
>>  *
>>  * XPS project directory: edk_300_100_linux_2-6
>>  */
>>
>> /dts-v1/;
>> / {
>> #address-cells = <1>;
>> #size-cells = <1>;
>> compatible = "xlnx,virtex405", "xlnx,virtex";
>> model = "testing";
>> DDR_256MB_32MX64_rank1_row13_col10_cl2_5: memory@0 {
>> device_type = "memory";
>> reg = < 0x0 0x10000000 >;
>> } ;
>> chosen {
>> bootargs = "console=ttyS0,9600
> root=/dev/xsysace/disc0/part3 ip=on";
>> linux,stdout-path =
> "/plb@0/opb@40000000/serial@40600000";
>> } ;
>> cpus {
>> #address-cells = <1>;
>> #cpus = <0x1>;
>> #size-cells = <0>;
>> ppc405_0: cpu@0 {
>> clock-frequency = <300000000>;
>> compatible = "PowerPC,405", "ibm,ppc405";
>> d-cache-line-size = <0x20>;
>> d-cache-size = <0x4000>;
>> dcr-access-method = "native";
>> dcr-controller ;
>> device_type = "cpu";
>> i-cache-line-size = <0x20>;
>> i-cache-size = <0x4000>;
>> model = "PowerPC,405";
>> reg = <0>;
>> timebase-frequency = <300000000>;
>> xlnx,dcr-resync = <0x0>;
>> xlnx,deterministic-mult = <0x0>;
>> xlnx,disable-operand-forwarding = <0x1>;
>> xlnx,mmu-enable = <0x1>;
>> } ;
>> } ;
>> plb: plb@0 {
>> #address-cells = <1>;
>> #size-cells = <1>;
>> compatible = "xlnx,plb-v34-1.02.a", "simple-bus";
>> ranges ;
>> opb: opb@40000000 {
>> #address-cells = <1>;
>> #size-cells = <1>;
>> compatible = "xlnx,opb-v20-1.10.c",
> "simple-bus";
>> ranges = < 0x40000000 0x40000000 0x40000000 >;
>> Ethernet_MAC: ethernet@40c00000 {
>> compatible = "xlnx,opb-ethernet-1.04.a";
>> device_type = "network";
>> local-mac-address = [ 02 00 00 00 00 00
> ];
>> reg = < 0x40c00000 0x10000 >;
>> xlnx,cam-bram-0-srl-1 = <0x1>;
>> xlnx,cam-exist = <0x0>;
>> xlnx,dev-blk-id = <0x1>;
>> xlnx,dev-mir-enable = <0x1>;
>> xlnx,dma-intr-coalesce = <0x1>;
>> xlnx,dma-present = <0x1>;
>> xlnx,err-count-exist = <0x1>;
>> xlnx,family = "virtex2p";
>> xlnx,fcs-insert-exist = <0x1>;
>> xlnx,half-duplex-exist = <0x1>;
>> xlnx,include-dev-pencoder = <0x1>;
>> xlnx,ipif-rdfifo-depth = <0x8000>;
>> xlnx,ipif-wrfifo-depth = <0x8000>;
>> xlnx,jumbo-exist = <0x0>;
>> xlnx,mac-fifo-bram-1-srl-0 = <0x0>;
>> xlnx,mac-fifo-depth = <0x40>;
>> xlnx,mii-exist = <0x1>;
>> xlnx,miim-clkdvd = <0x1f>;
>> xlnx,pad-insert-exist = <0x1>;
>> xlnx,reset-present = <0x1>;
>> xlnx,rx-dre-type = <0x0>;
>> xlnx,rx-include-csum = <0x0>;
>> xlnx,source-addr-insert-exist = <0x1>;
>> xlnx,tx-dre-type = <0x0>;
>> xlnx,tx-include-csum = <0x0>;
>> } ;
>> RS232_Uart_1: serial@40600000 {
>> clock-frequency = "";
>> compatible = "xlnx,opb-uartlite-1.00.b";
>> current-speed = <9600>;
>> device_type = "serial";
>> interrupt-parent = <&opb_intc_0>;
>> interrupts = < 1 0 >;
>> port-number = <0>;
>> reg = < 0x40600000 0x10000 >;
>> xlnx,baudrate = <0x9600>;
>> xlnx,clk-freq = <0x5f5e100>;
>> xlnx,data-bits = <0x8>;
>> xlnx,odd-parity = <0x0>;
>> xlnx,use-parity = <0x0>;
>> } ;
>> SysACE_CompactFlash: sysace@41800000 {
>> compatible = "xlnx,opb-sysace-1.00.c";
>> interrupt-parent = <&opb_intc_0>;
>> interrupts = < 0 2 >;
>> reg = < 0x41800000 0x10000 >;
>> xlnx,mem-width = <0x10>;
>> } ;
>> opb_intc_0: interrupt-controller@41200000 {
>> #interrupt-cells = <0x2>;
>> compatible = "xlnx,opb-intc-1.00.c";
>> interrupt-controller ;
>> reg = < 0x41200000 0x10000 >;
>> xlnx,num-intr-inputs = <0x2>;
>> } ;
>> } ;
>> } ;
>> }  ;
>>
> ************************************************************************
> *****************************
>> *
>>
> ************************************************************************
> *****************************
>> *
>>
>> Then cp <linux_path>/arch/powerpc/configs/40x/virtex4_defconfig
>> <linux_path>/.
>>
>> Then
>> cd <linux_path>
>> export ARCH=powerpc
>> export CROSS_COMPILE=powerpc-405-linux-gnu-
>> export
>>
> PATH=${PATH}:$HOME/xupv2p/opt/crosstool/gcc-3.4.5-glibc-2.3.5/powerpc-40
> 5-linux-gnu/bin
>> make menuconfig
>> I disabled all the options and enabled only:
>>
> ------------------------------------------------------------------------
> -----------------------------
>> --------------------------------------------------------------------
>> Processor support ->  Processor Type AMCC 40x (!!!  there is not ppc
> 40x)
>> Platform Support ->  Generic Xilinx Virtex board
>> Kernel options ->   Kernel support for ELF binaries
>>                             Math emulation
>>                            Default bootloader kernel arguments
>>                              (console=ttyS0,9600)    Initial kernel
> command
>> string
>>                                      (simpleImage.virtex405-ml405)
>> Additional default image types
>> Device Drivers -> Character Devices -> Virtual Terminal
>>                                                            Serial
> Devices ->
>> [*] 8250/16550 and compatible serial
>>
>> [*]   Console on 8250/16550 and compatible serial port
>>
>> (4) Maximum number of 8250/16550 serial ports
>>
>> (4) Number of 8250/16550 serial ports to register at runtime
>>
>>
> ------------------------------------------------------------------------
> -----------------------------
>> ---------------------------------------------------------------
>>
>> Then make clean && make dep && make zImage
>> I obtained a binary zImage file (and not zImage.elf) !!!! and I
> obtained
>> simpleImage.virtex405-ml405.elf in <linux_path>/arch/powerpc/boot .
>>
>> I used xmd to generated a system.ace from the bitstream and the elf.
>> The report of xmd is:
>>
> ************************************************************************
> ******
>>
> ************************************************************************
> *****
>> XMD% xmd -tcl genace.tcl -opt genace1.opt
>> Xilinx Microprocessor Debug (XMD) Engine
>> Xilinx EDK 8.2.02 Build EDK_Im_Sp2.4
>> Copyright (c) 1995-2005 Xilinx, Inc.  All rights reserved.
>> Executing user script : genace.tcl
>>
>>
> #######################################################################
>> XMD GenACE utility. Generate SystemACE File from bit/elf/data Files
>>
> #######################################################################
>> Using GenACE option file : genace1.opt
>> GenACE Options:
>> Board      : xupv2p
>> Jtag Devs  : xc2vp30
>> FPGA pos   : 1
>> JPROG      : true
>> HW File    :
>> /home/dhouib/xupv2p/edk_300_100_linux_2-6/implementation/system.bit
>> ACE File   : system3.ace
>> nCPUs      : 1
>>
>> Processor ppc_hw_1 Information
>> Debug opt : -debugdevice devicenr 1 cpunr 1
>> ELF files : simpleImage.virtex405-ml405-3.elf
>> Start PC Address : 0x00400000
>>
>> ############################################################
>> Converting Bitstream
>> '/home/dhouib/xupv2p/edk_300_100_linux_2-6/implementation/system.bit'
> to SVF
>> file
> '/home/dhouib/xupv2p/edk_300_100_linux_2-6/implementation/system.svf'
>> Executing 'impact -batch bit2svf.scr'
>>
>> Copying
> /home/dhouib/xupv2p/edk_300_100_linux_2-6/implementation/system.svf
>> File to  system3.svf File
>>
>>
>> ############################################################
>> Converting ELF file 'simpleImage.virtex405-ml405-3.elf' to SVF file
>> 'simpleImage.virtex405-ml405-3.svf'
>> Target reset successfully
>> section, .text: 0x00400000-0x00408ed4
>> section, .data: 0x00409000-0x0040ac18
>> section, __builtin_cmdline: 0x0040ac18-0x0040ae18
>> section, .kernel:dtb: 0x0040ae18-0x0040be33
>> section, .kernel:vmlinux.strip: 0x0040c000-0x004c3ae1
>> section, .bss: 0x004c4000-0x004d0dd8
>> Downloaded Program simpleImage.virtex405-ml405-3.elf
>> Setting PC with program start addr = 0x00400000
>> PC reset to 0x00400000, Clearing MSR Register
>>
>> Copying simpleImage.virtex405-ml405-3.svf File to  system3.svf File
>>
>>
>> ############################################################
>> Writing Processor JTAG "continue" command to SVF file 'sw_suffix.svf'
>> PC reset to 0x00400000, Clearing MSR Register
>> Processor started. Type "stop" to stop processor
>>
>> ############################################################
>> Converting SVF file 'system3.svf' to SystemACE file 'system3.ace'
>> Executing 'impact -batch svf2ace.scr'
>>
>> SystemACE file 'system3.ace' created successfully
>>
> ************************************************************************
> ********************
>>
> ************************************************************************
> ********************
>>
>>
>> I copied the system3.ace (3 because it was the third kernel that I
> tested
>> :((( ) to the flash disk partition 1 (Type = FAT16, Size = 32Mo ).
>> And I booted the kernel.
>> I got fllowing message on the Terminal:
>>
>>
> ************************************************************************
> *****************
>> zImage starting: loaded at 0x00400000 (sp: 0x004c4efc)
>> Allocating 0x1acdec bytes for kernel ...
>> gunzipping (0x00000000 <- 0x0040c000:0x004c3ae1)...done 0x1951b8 bytes
>>
>> Linux/PowerPC load: console=ttyS0,9600 root=/dev/xsysace/disc0/part3
> ip=on
>> Finalizing device tree... flat tree at 0x40ae18
>>
> ************************************************************************
> *******************
>>
>> My Questions are:
>> 1. Why he stops here?
>> 2. Why I didn't obtained zImage.elf but
> simpleImage.virtex405-ml405.elf
>> 3. Do I have to copy other files from my <edk_project_path>
> (xparameters.h ,
>> drivers ) to the <linux_path> ? (I copied only the xilinx.dts file)
>>
>> Thanks
>> saadia
>>
>>
>>
>>
>>
>> --
>> View this message in context:
> http://www.nabble.com/Linux-2.6-boot-failure-on-xup-virtex-II-ppc405-
>> tp20252128p20252128.html
>> Sent from the linuxppc-embedded mailing list archive at Nabble.com.
>>
>> _______________________________________________
>> Linuxppc-embedded mailing list
>> Linuxppc-embedded@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>
> This email and any attachments are intended for the sole use of the named 
> recipient(s) and contain(s) confidential information that may be 
> proprietary, privileged or copyrighted under applicable law. If you are 
> not the intended recipient, do not read, copy, or forward this email 
> message or any attachments. Delete this email message and any attachments 
> immediately.
>
>
>
>
> ------------------------------
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
> End of Linuxppc-embedded Digest, Vol 50, Issue 47
> *************************************************
> 
