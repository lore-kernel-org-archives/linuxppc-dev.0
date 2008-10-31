Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id A9BDCDDD0C
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  1 Nov 2008 03:21:53 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1Kvwkw-0003rB-2X
	for linuxppc-embedded@ozlabs.org; Fri, 31 Oct 2008 09:21:50 -0700
Message-ID: <20269333.post@talk.nabble.com>
Date: Fri, 31 Oct 2008 09:21:50 -0700 (PDT)
From: saadia dhouib <saadia_dhouib@yahoo.fr>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Linux 2.6 boot failure on xup virtex II ppc405
In-Reply-To: <20252128.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
References: <20252128.post@talk.nabble.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi all,

After booting successfully the kernel without a root file system.

I  installed a file system on the flash disk. I used: BusyBox 1.12.1, and
the script mkrootfs.sh (written by=20

Wofgang Klingauf) to generate the rfs.

=20

I changed the boot arg in the kernel configuration as follows:

 [*] Default bootloader kernel arguments                                   =
                                =20
=E2=94=82 =E2=94=82=20
  =E2=94=82 =E2=94=82                                      (console=3DttyUL=
0,9600
root=3D/dev/xsysace/disc0/xsa3 rw) Initial kernel command string=20

=20

=20

Then I rebooted the kernel, and there were those errors :( :

=20

Linux/PowerPC load: console=3DttyUL0,9600 root=3D/dev/xsysace/disc0/part3 i=
p=3Don
Finalizing device tree... flat tree at 0x40ae18
Using Xilinx Virtex machine description
Linux version 2.6.27-rc9 (dhouib@lo-lester-030) (gcc version 3.4.5) #19
PREEMPT Fri Oct 31 15:41:03 CET 2008
Zone PFN ranges:
  DMA      0x00000000 -> 0x00010000
  Normal   0x00010000 -> 0x00010000
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0: 0x00000000 -> 0x00010000
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024
Kernel command line: console=3DttyUL0,9600 root=3D/dev/xsysace/disc0/part3 =
ip=3Don
Xilinx intc at 0x41200000 mapped to 0xfdfff000
PID hash table entries: 1024 (order: 10, 4096 bytes)
clocksource: timebase mult[d55555] shift[22] registered
Console: colour dummy device 80x25
console [ttyUL0] enabled
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 257792k/262144k available (1564k kernel code, 4044k reserved, 84k
data, 89k bss, 76k init)
Calibrating delay loop... 598.01 BogoMIPS (lpj=3D1196032)
Mount-cache hash table entries: 512
msgmni has been set to 504
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
40600000.serial: ttyUL0 at MMIO 0x40600003 (irq =3D 16) is a uartlite
xsysace 41800000.sysace: Xilinx SystemACE revision 1.0.12
xsysace 41800000.sysace: capacity: 3940272 sectors
 xsa: xsa1 xsa2 xsa3
Xilinx SystemACE device driver, major=3D254
mice: PS/2 mouse device common for all mice
VFS: Cannot open root device "xsysace/disc0/part3" or unknown-block(0,0)
Please append a correct "root=3D" boot option; here are the available
partitions:
fe00    1970136 xsa (driver?)
  fe01      32098 xsa1
  fe02     265072 xsa2
  fe03    1020127 xsa3
Kernel panic - not syncing: VFS: Unable to mount root fs on
unknown-block(0,0)
Rebooting in 180 seconds..<2>init has generated signal 8 but has no handler
for it
note: swapper[1] exited with preempt_count 2
Kernel panic - not syncing: Attempted to kill init!
Rebooting in 180 seconds..Oops: Exception in kernel mode, sig: 8 [#1]
PREEMPT Xilinx Virtex
NIP: cf80ab60 LR: cf81fba0 CTR: 00000000
REGS: cf81faf0 TRAP: cf81fba0   Not tainted  (2.6.27-rc9)
MSR: 00000020 <IR>  CR: 44004022  XER: cf80ab68
TASK =3D cf814c00[1] 'swapper' THREAD: cf81e000
GPR00: 44000084 cf81fb50 00000006 c0190000 00029030 c0190000 00000030
cf81e000
GPR08: cf81fb20 004ca564 c01a0000 c01a0000 c01621a0 cf81fc58 cf814c00
cf81fd20
GPR16: c01a0000 c01648c0 cf814c00 c01a0000 cf81fbc0 c0026428 00000039
000000b4
GPR24: c01a4d70 ffffffff 00000000 000009b8 00000004 00000000 00000000
c01a0000
NIP [cf80ab60] 0xcf80ab60
LR [cf81fba0] 0xcf81fba0
Call Trace:
[cf81fb50] [ffffffff] 0xffffffff (unreliable)
Instruction dump:
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
---[ end trace 17f4c6d1c47d3b7d ]---
Fixing recursive fault but reboot is needed!
BUG: scheduling while atomic: swapper/1/0x00000003
Call Trace:
[cf81f8a0] [c0007704] show_stack+0x40/0x16c (unreliable)
[cf81f8d0] [c0020150] __schedule_bug+0x64/0x78
[cf81f8f0] [c013d108] __sched_text_start+0x390/0x3fc
[cf81f930] [c0027f10] do_exit+0x440/0x7b0
[cf81f970] [c000b594] _exception+0x0/0x1ac
[cf81f990] [c000b6a8] _exception+0x114/0x1ac
[cf81fae0] [c000e0fc] ret_from_except_full+0x0/0x4c
[cf81fb20] [cf81fc58] 0xcf81fc58

=20
Could someone help me please?

Thanks=20

Saadia=20



saadia dhouib wrote:
>=20
> Hi,
> I have downloaded the latest linux kernel linux-2.6-xlnx.git from
> http://git.xilinx.com/ .=20
> Than I have downloaded the device tree generator  device-tree.git from th=
e
> same site.
> I launched edk 8.2.02, I designed a system with two powerpc cores:
> ppc_405_0, ppc_405_1, and opb bus , a plb bus, and the following devices
> with their memory map:
>=20
> BASE =09        HIGH =09           MODULE
> 0x00000000 =090x0FFFFFFF =09DDR_256MB_32MX64_rank1_row13_col10_cl2_5
> 0x40600000 =090x4060FFFF =09RS232_Uart_1
> 0x40C00000 =090x40C0FFFF =09Ethernet_MAC
> 0x41200000 =090x4120FFFF =09opb_intc_0
> 0x41800000 =090x4180FFFF =09SysACE_CompactFlash
>=20
> I generated the bitsteam system.bit.
> After getting the device tree generator from
> git://git.xilinx.com/device-tree.git, I have copied the 'bsp' directory
> and contents so that it can be used by edk XPS. Then I selected
> 'device-tree' in the pull down menu labeled 'OS' in the Software Platform
> Settings dialog box.=20
> Then selected 'OS and Libraries' on the left, and entered the values for
> 'console device' and  'bootargs' (respectively=20
> 'RS232_Uart_1' and 'console=3DttyS0,9600 root=3D/dev/xsysace/disc0/part3
> ip=3Don' ).
> Then I generated libraries and  BSP, in the edk_project directory and not
> in the linux src directory.
> There were those warnings:
> *************************************************************************=
******************************************
> --- device tree generator version: v1.1 ---
> generating xilinx.dts
> Clock Port Summary:
> ppc405_0.CPMC405CLOCK connected to proc_clk_s:
>     CLK_FREQ_HZ =3D WARNING: no frequency found!
> ppc405_0.PLBCLK connected to sys_clk_s:
>     CLK_FREQ_HZ =3D WARNING: no frequency found!
> reset_block.Slowest_sync_clk connected to sys_clk_s:
>     CLK_FREQ_HZ =3D WARNING: no frequency found!
> plb.PLB_Clk connected to sys_clk_s:
>     CLK_FREQ_HZ =3D WARNING: no frequency found!
> opb.OPB_Clk connected to sys_clk_s:
>     CLK_FREQ_HZ =3D WARNING: no frequency found!
>=20
> plb2opb.PLB_Clk connected to sys_clk_s:
>     CLK_FREQ_HZ =3D WARNING: no frequency found!
> plb2opb.OPB_Clk connected to sys_clk_s:
>     CLK_FREQ_HZ =3D WARNING: no frequency found!
> RS232_Uart_1.OPB_Clk connected to sys_clk_s:
>     CLK_FREQ_HZ =3D WARNING: no frequency found!
> Ethernet_MAC.OPB_Clk connected to sys_clk_s:
>     CLK_FREQ_HZ =3D WARNING: no frequency found!
> SysACE_CompactFlash.OPB_Clk connected to sys_clk_s:
>     CLK_FREQ_HZ =3D WARNING: no frequency found!
> DDR_256MB_32MX64_rank1_row13_col10_cl2_5.PLB_Clk connected to sys_clk_s:
>     CLK_FREQ_HZ =3D WARNING: no frequency found!
> plb_bram_if_cntlr_1.plb_clk connected to sys_clk_s:
>     CLK_FREQ_HZ =3D WARNING: no frequency found!
> plb_bram_if_cntlr_1_bram.BRAM_Clk_A connected to
> plb_bram_if_cntlr_1_port_BRAM_Clk:
>     CLK_FREQ_HZ =3D WARNING: no frequency found!
> opb_intc_0.OPB_Clk connected to sys_clk_s:
>     CLK_FREQ_HZ =3D WARNING: no frequency found!
> dcm_0.CLKIN connected to dcm_clk_s:
>     CLK_FREQ_HZ =3D WARNING: no frequency found!
> dcm_0.CLK0 connected to sys_clk_s:
>     CLK_FREQ_HZ =3D WARNING: no frequency found!
>     CLK_INPORT =3D CLKIN
>     CLK_FACTOR =3D 1
> dcm_0.CLK90 connected to clk_90_s:
>     CLK_FREQ_HZ =3D WARNING: no frequency found!
>     CLK_INPORT =3D CLKIN
>     CLK_FACTOR =3D 1
> dcm_0.CLKFX connected to proc_clk_s:
>     CLK_FREQ_HZ =3D WARNING: no frequency found!
>     CLK_INPORT =3D CLKIN
>     CLK_FACTOR =3D C_CLKFX_MULTIPLY / C_CLKFX_DIVIDE
> dcm_1.CLKIN connected to ddr_feedback_s:
>     CLK_FREQ_HZ =3D WARNING: no frequency found!
> dcm_1.CLK0 connected to dcm_1_FB:
>     CLK_FREQ_HZ =3D WARNING: no frequency found!
>     CLK_INPORT =3D CLKIN
>     CLK_FACTOR =3D 1
> dcm_1.CLK90 connected to ddr_clk_90_s:
>     CLK_FREQ_HZ =3D WARNING: no frequency found!
>     CLK_INPORT =3D CLKIN
>     CLK_FACTOR =3D 1
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
>=20
> WARNING:MDT - Search path /home/dhouib/xupv2p/ directly contains pcores
>    directory. Search path should point to a directory two levels above
> pcores.
> WARNING:MDT - Search path /home/dhouib/xupv2p/ directly contains pcores
>    directory. Search path should point to a directory two levels above
> pcores.
>     CLK_FREQ_HZ =3D WARNING: no frequency found!
>=20
>     CLK_FREQ_HZ =3D WARNING: no frequency found!
>=20
>     CLK_FREQ_HZ =3D WARNING: no frequency found!
>=20
>     CLK_FREQ_HZ =3D WARNING: no frequency found!
> opb.OPB_Clk connected to sys_clk_s:
>     CLK_FREQ_HZ =3D WARNING: no frequency found!
> plb2opb.PLB_Clk connected to sys_clk_s:
>     CLK_FREQ_HZ =3D WARNING: no frequency found!
>=20
> plb2opb.OPB_Clk connected to sys_clk_s:
>     CLK_FREQ_HZ =3D WARNING: no frequency found!
> RS232_Uart_1.OPB_Clk connected to sys_clk_s:
>     CLK_FREQ_HZ =3D WARNING: no frequency found!
>=20
> Ethernet_MAC.OPB_Clk connected to sys_clk_s:
>     CLK_FREQ_HZ =3D WARNING: no frequency found!
> SysACE_CompactFlash.OPB_Clk connected to sys_clk_s:
>     CLK_FREQ_HZ =3D WARNING: no frequency found!
> DDR_256MB_32MX64_rank1_row13_col10_cl2_5.PLB_Clk connected to sys_clk_s:
>     CLK_FREQ_HZ =3D WARNING: no frequency found!
>=20
> plb_bram_if_cntlr_1.plb_clk connected to sys_clk_s:
>     CLK_FREQ_HZ =3D WARNING: no frequency found!
> plb_bram_if_cntlr_1_bram.BRAM_Clk_A connected to
> plb_bram_if_cntlr_1_port_BRAM_Clk:
>     CLK_FREQ_HZ =3D WARNING: no frequency found!
> opb_intc_0.OPB_Clk connected to sys_clk_s:
>     CLK_FREQ_HZ =3D WARNING: no frequency found!
> dcm_0.CLKIN connected to dcm_clk_s:
>     CLK_FREQ_HZ =3D WARNING: no frequency found!
> dcm_0.CLK0 connected to sys_clk_s:
>     CLK_FREQ_HZ =3D WARNING: no frequency found!
>     CLK_INPORT =3D CLKIN
>     CLK_FACTOR =3D 1
> dcm_0.CLK90 connected to clk_90_s:
>     CLK_FREQ_HZ =3D WARNING: no frequency found!
>     CLK_INPORT =3D CLKIN
>     CLK_FACTOR =3D 1
>=20
> dcm_0.CLKFX connected to proc_clk_s:
>     CLK_FREQ_HZ =3D WARNING: no frequency found!
>     CLK_INPORT =3D CLKIN
>     CLK_FACTOR =3D C_CLKFX_MULTIPLY / C_CLKFX_DIVIDE
> dcm_1.CLKIN connected to ddr_feedback_s:
>     CLK_FREQ_HZ =3D WARNING: no frequency found!
> dcm_1.CLK0 connected to dcm_1_FB:
>     CLK_FREQ_HZ =3D WARNING: no frequency found!
>     CLK_INPORT =3D CLKIN
>     CLK_FACTOR =3D 1
> dcm_1.CLK90 connected to ddr_clk_90_s:
>     CLK_FREQ_HZ =3D WARNING: no frequency found!
>     CLK_INPORT =3D CLKIN
>     CLK_FACTOR =3D 1
> Clock Frequency: 300000000
> IP connected to bus: plb
> *************************************************************************=
**************************************
> *************************************************************************=
**************************************
>=20
> I copied  <edk_project_path>/ppc_405_0/libsrc/device-tree/xilinx.dts to
> <linux_path>/arch/powerpc/boot/dts/virtex405-ml405.dts .
>  the device tree file looks like this:
> *************************************************************************=
***************************
> *************************************************************************=
***************************
> /*
>  * Device Tree Generator version: 1.1
>  *
>  * (C) Copyright 2007-2008 Xilinx, Inc.
>  * (C) Copyright 2007-2008 Michal Simek
>  *
>  * Michal SIMEK <monstr@monstr.eu>
>  *
>  * This program is free software; you can redistribute it and/or
>  * modify it under the terms of the GNU General Public License as
>  * published by the Free Software Foundation; either version 2 of
>  * the License, or (at your option) any later version.
>  *
>  * This program is distributed in the hope that it will be useful,
>  * but WITHOUT ANY WARRANTY; without even the implied warranty of
>  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>  * GNU General Public License for more details.
>  *
>  * You should have received a copy of the GNU General Public License
>  * along with this program; if not, write to the Free Software
>  * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
>  * MA 02111-1307 USA
>  *
>  * CAUTION: This file is automatically generated by libgen.
>  * Version: Xilinx EDK 8.2.02 EDK_Im_Sp2.4
>  *
>  * XPS project directory: edk_300_100_linux_2-6
>  */
>=20
> /dts-v1/;
> / {
> =09#address-cells =3D <1>;
> =09#size-cells =3D <1>;
> =09compatible =3D "xlnx,virtex405", "xlnx,virtex";
> =09model =3D "testing";
> =09DDR_256MB_32MX64_rank1_row13_col10_cl2_5: memory@0 {
> =09=09device_type =3D "memory";
> =09=09reg =3D < 0x0 0x10000000 >;
> =09} ;
> =09chosen {
> =09=09bootargs =3D "console=3DttyS0,9600 root=3D/dev/xsysace/disc0/part3 =
ip=3Don";
> =09=09linux,stdout-path =3D "/plb@0/opb@40000000/serial@40600000";
> =09} ;
> =09cpus {
> =09=09#address-cells =3D <1>;
> =09=09#cpus =3D <0x1>;
> =09=09#size-cells =3D <0>;
> =09=09ppc405_0: cpu@0 {
> =09=09=09clock-frequency =3D <300000000>;
> =09=09=09compatible =3D "PowerPC,405", "ibm,ppc405";
> =09=09=09d-cache-line-size =3D <0x20>;
> =09=09=09d-cache-size =3D <0x4000>;
> =09=09=09dcr-access-method =3D "native";
> =09=09=09dcr-controller ;
> =09=09=09device_type =3D "cpu";
> =09=09=09i-cache-line-size =3D <0x20>;
> =09=09=09i-cache-size =3D <0x4000>;
> =09=09=09model =3D "PowerPC,405";
> =09=09=09reg =3D <0>;
> =09=09=09timebase-frequency =3D <300000000>;
> =09=09=09xlnx,dcr-resync =3D <0x0>;
> =09=09=09xlnx,deterministic-mult =3D <0x0>;
> =09=09=09xlnx,disable-operand-forwarding =3D <0x1>;
> =09=09=09xlnx,mmu-enable =3D <0x1>;
> =09=09} ;
> =09} ;
> =09plb: plb@0 {
> =09=09#address-cells =3D <1>;
> =09=09#size-cells =3D <1>;
> =09=09compatible =3D "xlnx,plb-v34-1.02.a", "simple-bus";
> =09=09ranges ;
> =09=09opb: opb@40000000 {
> =09=09=09#address-cells =3D <1>;
> =09=09=09#size-cells =3D <1>;
> =09=09=09compatible =3D "xlnx,opb-v20-1.10.c", "simple-bus";
> =09=09=09ranges =3D < 0x40000000 0x40000000 0x40000000 >;
> =09=09=09Ethernet_MAC: ethernet@40c00000 {
> =09=09=09=09compatible =3D "xlnx,opb-ethernet-1.04.a";
> =09=09=09=09device_type =3D "network";
> =09=09=09=09local-mac-address =3D [ 02 00 00 00 00 00 ];
> =09=09=09=09reg =3D < 0x40c00000 0x10000 >;
> =09=09=09=09xlnx,cam-bram-0-srl-1 =3D <0x1>;
> =09=09=09=09xlnx,cam-exist =3D <0x0>;
> =09=09=09=09xlnx,dev-blk-id =3D <0x1>;
> =09=09=09=09xlnx,dev-mir-enable =3D <0x1>;
> =09=09=09=09xlnx,dma-intr-coalesce =3D <0x1>;
> =09=09=09=09xlnx,dma-present =3D <0x1>;
> =09=09=09=09xlnx,err-count-exist =3D <0x1>;
> =09=09=09=09xlnx,family =3D "virtex2p";
> =09=09=09=09xlnx,fcs-insert-exist =3D <0x1>;
> =09=09=09=09xlnx,half-duplex-exist =3D <0x1>;
> =09=09=09=09xlnx,include-dev-pencoder =3D <0x1>;
> =09=09=09=09xlnx,ipif-rdfifo-depth =3D <0x8000>;
> =09=09=09=09xlnx,ipif-wrfifo-depth =3D <0x8000>;
> =09=09=09=09xlnx,jumbo-exist =3D <0x0>;
> =09=09=09=09xlnx,mac-fifo-bram-1-srl-0 =3D <0x0>;
> =09=09=09=09xlnx,mac-fifo-depth =3D <0x40>;
> =09=09=09=09xlnx,mii-exist =3D <0x1>;
> =09=09=09=09xlnx,miim-clkdvd =3D <0x1f>;
> =09=09=09=09xlnx,pad-insert-exist =3D <0x1>;
> =09=09=09=09xlnx,reset-present =3D <0x1>;
> =09=09=09=09xlnx,rx-dre-type =3D <0x0>;
> =09=09=09=09xlnx,rx-include-csum =3D <0x0>;
> =09=09=09=09xlnx,source-addr-insert-exist =3D <0x1>;
> =09=09=09=09xlnx,tx-dre-type =3D <0x0>;
> =09=09=09=09xlnx,tx-include-csum =3D <0x0>;
> =09=09=09} ;
> =09=09=09RS232_Uart_1: serial@40600000 {
> =09=09=09=09clock-frequency =3D "";
> =09=09=09=09compatible =3D "xlnx,opb-uartlite-1.00.b";
> =09=09=09=09current-speed =3D <9600>;
> =09=09=09=09device_type =3D "serial";
> =09=09=09=09interrupt-parent =3D <&opb_intc_0>;
> =09=09=09=09interrupts =3D < 1 0 >;
> =09=09=09=09port-number =3D <0>;
> =09=09=09=09reg =3D < 0x40600000 0x10000 >;
> =09=09=09=09xlnx,baudrate =3D <0x9600>;
> =09=09=09=09xlnx,clk-freq =3D <0x5f5e100>;
> =09=09=09=09xlnx,data-bits =3D <0x8>;
> =09=09=09=09xlnx,odd-parity =3D <0x0>;
> =09=09=09=09xlnx,use-parity =3D <0x0>;
> =09=09=09} ;
> =09=09=09SysACE_CompactFlash: sysace@41800000 {
> =09=09=09=09compatible =3D "xlnx,opb-sysace-1.00.c";
> =09=09=09=09interrupt-parent =3D <&opb_intc_0>;
> =09=09=09=09interrupts =3D < 0 2 >;
> =09=09=09=09reg =3D < 0x41800000 0x10000 >;
> =09=09=09=09xlnx,mem-width =3D <0x10>;
> =09=09=09} ;
> =09=09=09opb_intc_0: interrupt-controller@41200000 {
> =09=09=09=09#interrupt-cells =3D <0x2>;
> =09=09=09=09compatible =3D "xlnx,opb-intc-1.00.c";
> =09=09=09=09interrupt-controller ;
> =09=09=09=09reg =3D < 0x41200000 0x10000 >;
> =09=09=09=09xlnx,num-intr-inputs =3D <0x2>;
> =09=09=09} ;
> =09=09} ;
> =09} ;
> }  ;
> *************************************************************************=
*****************************
> *************************************************************************=
*****************************
>=20
> Then cp <linux_path>/arch/powerpc/configs/40x/virtex4_defconfig
> <linux_path>/.
>=20
> Then=20
> cd <linux_path>
> export ARCH=3Dpowerpc
> export CROSS_COMPILE=3Dpowerpc-405-linux-gnu-
> export
> PATH=3D${PATH}:$HOME/xupv2p/opt/crosstool/gcc-3.4.5-glibc-2.3.5/powerpc-4=
05-linux-gnu/bin
> make menuconfig
> I disabled all the options and enabled only:
> -------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------
> Processor support ->  Processor Type AMCC 40x (!!!  there is not ppc 40x)=
 =20
> Platform Support ->  Generic Xilinx Virtex board
> Kernel options ->   Kernel support for ELF binaries  =20
>                             Math emulation=20
>                            Default bootloader kernel arguments=20
>                              (console=3DttyS0,9600)    Initial kernel
> command  string=20
>                                      (simpleImage.virtex405-ml405)
> Additional default image types
> Device Drivers -> Character Devices -> Virtual Terminal
>                                                            Serial Devices
> ->   [*] 8250/16550 and compatible serial=20
>                                                                          =
            =20
> [*]   Console on 8250/16550 and compatible serial port
>                                                                          =
            =20
> (4) Maximum number of 8250/16550 serial ports
>                                                                          =
             =20
> (4) Number of 8250/16550 serial ports to register at runtime       =20
>=20
> -------------------------------------------------------------------------=
---------------------------------------------------------------------------=
----------------
>=20
> Then make clean && make dep && make zImage
> I obtained a binary zImage file (and not zImage.elf) !!!! and I obtained
> simpleImage.virtex405-ml405.elf in <linux_path>/arch/powerpc/boot .=20
>=20
> I used xmd to generated a system.ace from the bitstream and the elf.
> The report of xmd is:
> *************************************************************************=
*****
> *************************************************************************=
****
> XMD% xmd -tcl genace.tcl -opt genace1.opt
> Xilinx Microprocessor Debug (XMD) Engine
> Xilinx EDK 8.2.02 Build EDK_Im_Sp2.4
> Copyright (c) 1995-2005 Xilinx, Inc.  All rights reserved.
> Executing user script : genace.tcl
>=20
> #######################################################################
> XMD GenACE utility. Generate SystemACE File from bit/elf/data Files
> #######################################################################
> Using GenACE option file : genace1.opt
> GenACE Options:
> =09Board      : xupv2p
> =09Jtag Devs  : xc2vp30
> =09FPGA pos   : 1
> =09JPROG      : true
> =09HW File    :
> /home/dhouib/xupv2p/edk_300_100_linux_2-6/implementation/system.bit
> =09ACE File   : system3.ace
> =09nCPUs      : 1
>=20
> =09Processor ppc_hw_1 Information
> =09=09Debug opt : -debugdevice devicenr 1 cpunr 1
> =09=09ELF files : simpleImage.virtex405-ml405-3.elf
> =09=09Start PC Address : 0x00400000
>=20
> ############################################################
> Converting Bitstream
> '/home/dhouib/xupv2p/edk_300_100_linux_2-6/implementation/system.bit' to
> SVF file
> '/home/dhouib/xupv2p/edk_300_100_linux_2-6/implementation/system.svf'
> Executing 'impact -batch bit2svf.scr'
>=20
> Copying
> /home/dhouib/xupv2p/edk_300_100_linux_2-6/implementation/system.svf File
> to  system3.svf File
>=20
>=20
> ############################################################
> Converting ELF file 'simpleImage.virtex405-ml405-3.elf' to SVF file
> 'simpleImage.virtex405-ml405-3.svf'
> Target reset successfully
> =09section, .text: 0x00400000-0x00408ed4
> =09section, .data: 0x00409000-0x0040ac18
> =09section, __builtin_cmdline: 0x0040ac18-0x0040ae18
> =09section, .kernel:dtb: 0x0040ae18-0x0040be33
> =09section, .kernel:vmlinux.strip: 0x0040c000-0x004c3ae1
> =09section, .bss: 0x004c4000-0x004d0dd8
> Downloaded Program simpleImage.virtex405-ml405-3.elf
> Setting PC with program start addr =3D 0x00400000
> PC reset to 0x00400000, Clearing MSR Register
>=20
> Copying simpleImage.virtex405-ml405-3.svf File to  system3.svf File
>=20
>=20
> ############################################################
> Writing Processor JTAG "continue" command to SVF file 'sw_suffix.svf'
> PC reset to 0x00400000, Clearing MSR Register
> Processor started. Type "stop" to stop processor
>=20
> ############################################################
> Converting SVF file 'system3.svf' to SystemACE file 'system3.ace'
> Executing 'impact -batch svf2ace.scr'
>=20
> SystemACE file 'system3.ace' created successfully
> *************************************************************************=
*******************
> *************************************************************************=
*******************
>=20
>=20
> I copied the system3.ace (3 because it was the third kernel that I tested
> :((( ) to the flash disk partition 1 (Type =3D FAT16, Size =3D 32Mo ).
> And I booted the kernel.
> I got fllowing message on the Terminal:=20
>=20
> *************************************************************************=
****************
> zImage starting: loaded at 0x00400000 (sp: 0x004c4efc)                   =
      =20
> Allocating 0x1acdec bytes for kernel ...                                 =
      =20
> gunzipping (0x00000000 <- 0x0040c000:0x004c3ae1)...done 0x1951b8 bytes   =
      =20
>                                                                          =
      =20
> Linux/PowerPC load: console=3DttyS0,9600 root=3D/dev/xsysace/disc0/part3 =
ip=3Don     =20
> Finalizing device tree... flat tree at 0x40ae18                 =20
> *************************************************************************=
******************
>=20
> My Questions are:
> 1. Why he stops here?
> 2. Why I didn't obtained zImage.elf but simpleImage.virtex405-ml405.elf
> 3. Do I have to copy other files from my <edk_project_path> (xparameters.=
h
> , drivers ) to the <linux_path> ? (I copied only the xilinx.dts file)
>=20
> Thanks
> saadia
>=20
>=20
> =20
>=20
>=20
>=20

--=20
View this message in context: http://www.nabble.com/Linux-2.6-boot-failure-=
on-xup-virtex-II-ppc405-tp20252128p20269333.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
