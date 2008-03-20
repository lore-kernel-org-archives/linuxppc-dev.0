Return-Path: <jblack547@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.248])
	by ozlabs.org (Postfix) with ESMTP id D6E69DDED5
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 21 Mar 2008 05:02:51 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so238954anc.78
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Mar 2008 11:02:46 -0700 (PDT)
Message-ID: <b77025b40803201102w200dde6fuc4235d9a3cb8b0dd@mail.gmail.com>
Date: Thu, 20 Mar 2008 12:02:46 -0600
From: "James Black" <jblack547@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: muram in device tree for mpc8250 in arch/powerpc
In-Reply-To: <b77025b40803191107x2f9a7884n9b7f062fcf45370@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
References: <b77025b40803191006m60dc3145la368ac227df43b17@mail.gmail.com>
	<20080319174001.GF7962@ld0162-tx32.am.freescale.net>
	<b77025b40803191107x2f9a7884n9b7f062fcf45370@mail.gmail.com>
Cc: Scott Wood <scottwood@freescale.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Scott,

>  > That's strange... how in particular was it killing it?  Which allocato=
r?
>  >
>  > Do you know which particular line of code is crashing?
>  >

I made the changes you suggested to the device tree and recompiled and
still get the same problem. The line that code execution stops is in


arch/powerpc/mm/mem.c: paging_init(),line 256, calls
                                    : free_area_init_nodes(), line 284, cal=
ls
                                    : free_area_init_node(), line 3902, cal=
ls
                                    : alloc_node_mem_map(), line 3460
<-- never returns

This is the device tree command line. If I don't pad the device tree
to 0x1000, then
I get this complaint from u-boot.

   Loading Device Tree to 007ff000, end 007ff909 ... OK
fdt_chosen: FDT_ERR_NOSPACE
ERROR: /chosen node create failed - must RESET the bo

I've also compiled without the -b option.
dtc -I dts -O dtb -S 0x1000 -b 0
../../linux-2.6.24/arch/powerpc/boot/dts/cta5000s.dts -o cta5000s.dtb


The following is the early kernel debugging output with debug turned
on in prom.c.


U-Boot 1.3.2 (Mar 14 2008 - 10:36:25)

MPC8250 Reset Status: External Soft, External Hard

MPC8250 Clock Configuration
 - Bus-to-Core Mult 2x, VCO Div 2, 60x Bus Freq  50-150, Core Freq 100-300
 - dfbrg 1, corecnf 0x04, busdf 3, cpmdf 1, plldf 0, pllmf 1, pcidf 3
 - vco_out  264000000, scc_clk   66000000, brg_clk   16500000
 - cpu_clk  132000000, cpm_clk  132000000, bus_clk   66000000

CPU:   MPC8250 (HiP4 Rev 14, Mask C.0 5K25A) at 132 MHz
Manuf: Aztek Networks, Inc.
Board: CTA5000S
       Watchdog enabled
DRAM:  64 MB
FLASH:  2 MB
In:    serial
Out:   serial
Err:   serial
Net:   FCC1 ETHERNET
IDE:   Bus 0: not available
Hit any key to stop autoboot:  0
Using FCC1 ETHERNET device
TFTP from server 192.168.1.20; our IP address is 192.168.1.10
Filename 'uImage'.
Load address: 0x2000000
Loading: #################################################################
         ######
done
Bytes transferred =3D 1035332 (fcc44 hex)
Using FCC1 ETHERNET device
TFTP from server 192.168.1.20; our IP address is 192.168.1.10
Filename 'uRamdisk'.
Load address: 0x2200000
Loading: #################################################################
         #####################################################
done
Bytes transferred =3D 1731966 (1a6d7e hex)
Using FCC1 ETHERNET device
TFTP from server 192.168.1.20; our IP address is 192.168.1.10
Filename 'cta5000s.dtb'.
Load address: 0x2400000
Loading: #
done
Bytes transferred =3D 4096 (1000 hex)
## Booting image at 02000000 ...
   Image Name:   Linux-2.6.24.2
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1035268 Bytes =3D 1011 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Loading RAMDisk Image at 02200000 ...
   Image Name:   Simple Embedded Linux Framework
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    1731902 Bytes =3D  1.7 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Booting using the fdt at 0x2400000
   Loading Ramdisk to 039d9000, end 03b7fd3e ... OK
   Loading Device Tree to 007fe000, end 007fefff ... OK
Xid mach(): done
MMU:enter
MMU:hw init
MMU:mapin
MMU:setio
MMU:exit
 -> early_init_devtree(c07fe000)
search "chosen", depth: 0, uname:
search "chosen", depth: 1, uname: cpus
search "chosen", depth: 2, uname: PowerPC,8250@0
search "chosen", depth: 1, uname: memory
search "chosen", depth: 1, uname: localbus@f0010100
search "chosen", depth: 2, uname: flash@fe000000,0
search "chosen", depth: 1, uname: soc@f0000000
search "chosen", depth: 2, uname: cpm@119c0
search "chosen", depth: 3, uname: muram@0
search "chosen", depth: 4, uname: data@0
search "chosen", depth: 3, uname: brg@119f0
search "chosen", depth: 3, uname: serial@11a00
search "chosen", depth: 3, uname: serial@11a40
search "chosen", depth: 3, uname: ethernet@11300
search "chosen", depth: 2, uname: interrupt-controller@10c00
search "chosen", depth: 1, uname: chosen
Looking for initrd properties... <3>initrd_start=3D0xc39d9000  initrd_end=
=3D0xc3b7fe
Command line is:
dt_root_size_cells =3D 1
dt_root_addr_cells =3D 1
memory scan node memory, reg size 8, data: 0 4000000 2 1,
 - 0 ,  4000000
reserving: 39d9000 -> 1a6d3f
Phys. mem: 4000000
-> move_device_tree
<- move_device_tree
Scanning CPUs ...
boot cpu: logical 0 physical 0
 <- early_init_devtree()
Using Aztek Networks cta5000s machine description
Linux version 2.6.24.2 (jblack@jblack.azteknetworks.net) (gcc version 4.2.2=
) #38
 -> unflatten_device_tree()
  size is bd4, allocating...
  unflattening c3fff428...
fixed up name for  ->
fixed up name for cpus -> cpus
fixed up name for PowerPC,8250@0 -> PowerPC,8250
fixed up name for memory -> memory
fixed up name for localbus@f0010100 -> localbus
fixed up name for flash@fe000000,0 -> flash
fixed up name for soc@f0000000 -> soc
fixed up name for cpm@119c0 -> cpm
fixed up name for muram@0 -> muram
fixed up name for data@0 -> data
fixed up name for brg@119f0 -> brg
fixed up name for serial@11a00 -> serial
fixed up name for serial@11a40 -> serial
fixed up name for ethernet@11300 -> ethernet
fixed up name for interrupt-controller@10c00 -> interrupt-controller
fixed up name for chosen -> chosen
 <- unflatten_device_tree()
Found initrd at 0xc39d9000:0xc3b7fd3e
console [udbg0] enabled
setup_arch: bootmem
cta5000s_setup_arch(): entry
cpm_muran_init(): entry
cpm_muran_init(): exit
init_ioports(): empty
cta5000s_setup_arch(): exit
setup_arch: exit
Zone PFN ranges:
  DMA             0 ->    16384
  Normal      16384 ->    16384
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0:        0 ->    16384
Unable to handle kernel paging request for data at address 0xe001a000
Faulting instruction address: 0xc00e1a6c
Oops: Kernel access of bad area, sig: 11 [#1]
Unable to handle kernel paging request for data at address 0x401c1ae0
Faulting instruction address: 0xc00e6254
Oops: Kernel access of bad area, sig: 11 [#2]
Unable to handle kernel paging request for data at address 0x401c1ae0
Faulting instruction address: 0xc00e6254
Recursive die() failure, output suppressed
---[ end trace 8640abe69a316dee ]---
Kernel panic - not syncing: Attempted to kill the idle task!

>  > > I tried to fully describe the segments in muram node and it seems to
>  > > mess things up even worse.
>  >
>  > What do you mean?  What changes did you make, and what was the result?

I changed the muram node description to describe all the segments in
the dual port ram of the immr for the 8250. The thinking was that I
needed to describe the non-contiguous portions in the immr. The user
manual (page 3-1) shows the immr to be defined as:

0x00000=960x03FFF Dual-port RAM (DPRAM1) R/W 16 Kbytes
0x04000=960x05FFF Dual-port RAM (microcode only) (DPRAM)1 R/W 8 Kbytes
0x06000=960x07FFF Reserved =97 8 Kbytes
0x08000=960x08FFF Dual-port RAM (DPRAM2) R/W 4 Kbytes
0x09000=960x0AFFF Reserved =97 8 Kbytes
0x0B000=960x0BFFF Dual-port RAM (DPRAM3) R/W 4 Kbytes
0x0C000=960x0FFFF Reserved =97 16 Kbytes

muram@0 {
   #address-cells =3D <1>;
   #size-cells =3D <1>;
   ranges =3D <0 0 10000>;

   data@0 {
      compatible =3D "fsl,cpm-muram-data";
      reg =3D <0 4000 8000 1000 B000 1000>;
   };
};

Sometimes I get a stack trace, sometimes I don't.

Unable to handle kernel paging request for data at address 0xde7ebbe7
Faulting instruction address: 0xc00114fc
Oops: Kernel access of bad area, sig: 11 [#1]

[c023ff20] [c001a498] printk+0x50/0x60 (unreliable)
[c023ff40] [c01110a0] of_get_property+0x10/0x34
[c023ff50] [c01110e8] of_device_is_compatible+0x24/0xa0
[c023ff80] [c01111dc] of_find_compatible_node+0x78/0xc4
[c023ffa0] [c0211020] cta5000s_pic_init+0x24/0x6c
[c023ffb0] [c020c880] init_IRQ+0x24/0x34
[c023ffc0] [c0206948] start_kernel+0x17c/0x2b8
[c023fff0] [00003438] 0x3438
