Return-Path: <andre.schwarz@matrix-vision.de>
Received: from p15137414.pureserver.info (matrixvision.de [217.160.213.229])
	by ozlabs.org (Postfix) with ESMTP id 57A3CDE000
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Apr 2008 22:54:15 +1000 (EST)
Message-ID: <47FCBC73.40703@matrix-vision.de>
Date: Wed, 09 Apr 2008 14:54:11 +0200
From: Andre Schwarz <andre.schwarz@matrix-vision.de>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: MPC8343 - "unable to handle paging request @ 0"
References: <47F73625.9040903@matrix-vision.de>
	<20080407161036.GA2688@loki.buserror.net>
	<47FB7822.6090401@matrix-vision.de>
	<20080408164853.GH2552@loki.buserror.net>
In-Reply-To: <20080408164853.GH2552@loki.buserror.net>
Content-Type: multipart/alternative;
	boundary="------------090303060807090704090807"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------090303060807090704090807
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Scott Wood schrieb:
> On Tue, Apr 08, 2008 at 03:50:26PM +0200, Andre Schwarz wrote:
>   
>> after building a debug kernel and attaching the bdi2000 it looks like  
>> the crash occurs during "console_init()" ...
>>     
>
> Does your device tree have a /chosen node after u-boot is done with it? 
> find_legacy_serial_ports() can crash otherwise (we really should fix that).
>
>   
>> Since we're using a dtb I omit the "console=..." argument for the  
>> kernel. Is this correct ?
>>     
>
> It's OK if you have /chosen/linux,stdout-path.
>
>   
>> If "console=/dev/ttyS0,115200N8" argument is given the serial console  
>> stops working after console_init....
>>
>>
>> On other PowerPC system I could see something like this during boot :
>>
>> -> find_legacy_serial_port()
>> stdout is /soc8568@e0000000/serial@4600
>> legacy_serial_console = 1
>> default console speed = 115340
>> <- find_legacy_serial_port()
>>
>>
>> Should I see this message also ?
>>     
>
> Only if you enable debug messages in legacy_serial.c.
>
>   
>> Have I misconfigured anything ?
>>     
>
> One thing that sticks out from the above is that you ask for ttyS0, but the
> stdout you list from the other system corresponds to ttyS1.  Is this just a
> difference between the two systems?
>
> -Scott
>   

Scott,

I've added kallsyms and the #debug in legacy_serial.
Obviously there's missing something
-> see error "can't find stdout package /soc8343@e0000000/serial@4500 !" 
below.


Can you help here ?

Thanks,
Andre


## Booting kernel from Legacy Image at ff810000 ...
   Image Name:   2.6.25 mvBL-M7 MPC8343 #12
   Image Type:   PowerPC Linux Kernel Image (uncompressed)
   Data Size:    2494236 Bytes =  2.4 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK
## Flattened Device Tree blob at 00000000
   Booting using the fdt blob at 0x600000
## Loading init Ramdisk from Legacy Image at 01000000 ...
   Image Name:   mvBC-1G uInitrd #1.1.03
   Image Type:   PowerPC Linux RAMDisk Image (uncompressed)
   Data Size:    2654208 Bytes =  2.5 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Loading Ramdisk to 1fcb7000, end 1ff3f000 ... OK
 -> early_init_devtree(c0600000)
search "chosen", depth: 0, uname:
search "chosen", depth: 1, uname: chosen
Looking for initrd properties... <3>initrd_start=0xdfcb7000  
initrd_end=0xdff3f000
Command line is: root=/dev/ram ro rootfstype=squashfs
dt_root_size_cells = 1
dt_root_addr_cells = 1
memory scan node memory, reg size 8, data: 0 20000000 2 1,
 - 0 ,  20000000
reserving: 1fcb7000 -> 288001
Phys. mem: 20000000
-> move_device_tree
<- move_device_tree
Scanning CPUs ...
boot cpu: logical 0 physical 0
 <- early_init_devtree()
Using mvBlueLYNX-M7 machine description
Linux version 2.6.25-rc8-01197-g1de15bb-dirty (root@nova) (gcc version 
4.0.0 (DENX ELDK 4.1 4.0.0)) #12 PREEMPT Wed Apr 9 14:40:48 CEST 2008
 -> unflatten_device_tree()
  size is 192c, allocating...
  unflattening dfffe6d0...
fixed up name for  ->
fixed up name for chosen -> chosen
fixed up name for wdt@200 -> wdt
fixed up name for ethernet-phy@0 -> ethernet-phy
fixed up name for ethernet-phy@1 -> ethernet-phy
fixed up name for ethernet@24000 -> ethernet
fixed up name for ethernet@25000 -> ethernet
fixed up name for serial@4500 -> serial
fixed up name for serial@4600 -> serial
fixed up name for pic@700 -> pic
fixed up name for ppcboot_env@0 -> ppcboot_env
fixed up name for ppcboot_env_red@0x2000 -> ppcboot_env_red
fixed up name for u-boot_autoscript@0x4000 -> u-boot_autoscript
fixed up name for u-boot_autoscript_red@0x4000 -> u-boot_autoscript_red
fixed up name for dtb@0x8000 -> dtb
fixed up name for dtb_red@0xa000 -> dtb_red
fixed up name for kernel@0x10000 -> kernel
fixed up name for rfs@0x400000 -> rfs
fixed up name for u-boot@0x700000 -> u-boot
fixed up name for fpga@0x780000 -> fpga
 <- unflatten_device_tree()
Found initrd at 0xdfcb7000:0xdff3f000
 -> find_legacy_serial_port()
stdout is /soc8343@e0000000/serial@4500
legacy_serial_console = 0
default console speed = 115740
 <- find_legacy_serial_port()
console [udbg0] enabled
setup_arch: bootmem
mvblm7_setup_arch()
arch: exit
Zone PFN ranges:
  DMA             0 ->   131072
  Normal     131072 ->   131072
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0:        0 ->   131072
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 130048
Kernel command line: root=/dev/ram ro rootfstype=squashfs
PID hash table entries: 2048 (order: 11, 8192 bytes)
clocksource: timebase mult[3c00001] shift[22] registered

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
 -> check_legacy_serial_console()
 can't find stdout package /soc8343@e0000000/serial@4500 !
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 514048k/524288k available (2328k kernel code, 9676k reserved, 
88k data, 126k bss, 140k init)
SLUB: Genslabs=12, HWalign=32, Order=0-1, MinObjects=4, CPUs=1, Nodes=1
Mount-cache hash table entries: 512
------------[ cut here ]------------
Badness at lib/kref.c:43
NIP: c00f5494 LR: c000d6b0 CTR: 00000000
REGS: c025de60 TRAP: 0700   Not tainted  (2.6.25-rc8-01197-g1de15bb-dirty)
MSR: 00029032 <EE,ME,IR,DR>  CR: 84000048  XER: 00000000
TASK = c0248510[0] 'swapper' THREAD: c025c000
GPR00: 00000001 c025df10 c0248510 dffff170 dffff050 00000009 df80fc6a 
00000000
GPR08: 0007ffff 00000000 df80b990 c06011cf 24000042 5fffffff 1fffd000 
00000000
GPR16: 1fffffff 9fffffff 00000000 00000000 1fff8910 1ff426f8 00000004 
00288000
GPR24: 00000000 00000000 c02630a0 c0260000 dfffefa0 c025c000 dffff050 
dffff13c
NIP [c00f5494] kref_get+0xc/0x24
LR [c000d6b0] of_node_get+0x20/0x38
Call Trace:
[c025df10] [c06011cf] 0xc06011cf (unreliable)
[c025df20] [c01571a4] of_get_next_child+0x40/0x9c
[c025df40] [c00bab5c] proc_device_tree_add_node+0x4c/0x144
[c025df60] [c00bab50] proc_device_tree_add_node+0x40/0x144
[c025df80] [c00bab50] proc_device_tree_add_node+0x40/0x144
[c025dfa0] [c00bacc8] proc_device_tree_init+0x74/0xa0
[c025dfb0] [c0235c70] proc_root_init+0xd4/0x10c
[c025dfc0] [c022374c] start_kernel+0x244/0x2cc
[c025dff0] [00003438] 0x3438
Instruction dump:
4bf289e1 7fa3eb78 3ba00000 4bfff3ad 4bffffd8 90830000 4e800020 38800001
4bfffff4 80030000 21200000 7c090114 <0f000000> 7d201828 31290001 7d20192d
WARNING: Bad of_node_put() on
Call Trace:
[c025ded0] [c00088fc] show_stack+0x50/0x190 (unreliable)
[c025df00] [c000de70] of_node_release+0xb0/0xcc
[c025df20] [c00f5500] kref_put+0x54/0x6c
[c025df30] [c000d6ec] of_node_put+0x24/0x34
[c025df40] [c00babc8] proc_device_tree_add_node+0xb8/0x144
[c025df60] [c00bab50] proc_device_tree_add_node+0x40/0x144
[c025df80] [c00bab50] proc_device_tree_add_node+0x40/0x144
[c025dfa0] [c00bacc8] proc_device_tree_init+0x74/0xa0
[c025dfb0] [c0235c70] proc_root_init+0xd4/0x10c
[c025dfc0] [c022374c] start_kernel+0x244/0x2cc
[c025dff0] [00003438] 0x3438
Unable to handle kernel paging request for data at address 0x00000000
Faulting instruction address: 0xc0014454
Oops: Kernel access of bad area, sig: 11 [#1]
PREEMPT mvBlueLYNX-M7
Modules linked in:
NIP: c0014454 LR: c00ba9e0 CTR: 00000000
REGS: c025de70 TRAP: 0300   Not tainted  (2.6.25-rc8-01197-g1de15bb-dirty)
MSR: 00009032 <EE,ME,IR,DR>  CR: 44000048  XER: 00000000
DAR: 00000000, DSISR: 20000000
TASK = c0248510[0] 'swapper' THREAD: c025c000
GPR00: c00bac0c c025df20 c0248510 00000023 ffffffff df80fd60 df80fd6e 
00000000
GPR08: 001fffff 00000002 df80b990 c06010f5 24000022 5fffffff 1fffd000 
00000000
GPR16: 1fffffff 9fffffff 00000000 00000000 1fff8910 1ff426f8 00000004 
00288000
GPR24: 00000000 00000000 c02630a0 c0260000 dfffefa0 00000000 c025c000 
df80fd00
NIP [c0014454] strcmp+0x10/0x24
LR [c00ba9e0] duplicate_name+0x3c/0x94
Call Trace:
[c025df20] [c00ba870] __proc_device_tree_add_prop+0x54/0xd4 (unreliable)
[c025df40] [c00bac0c] proc_device_tree_add_node+0xfc/0x144
[c025df60] [c00bab50] proc_device_tree_add_node+0x40/0x144
[c025df80] [c00bab50] proc_device_tree_add_node+0x40/0x144
[c025dfa0] [c00bacc8] proc_device_tree_init+0x74/0xa0
[c025dfb0] [c0235c70] proc_root_init+0xd4/0x10c
[c025dfc0] [c022374c] start_kernel+0x244/0x2cc
[c025dff0] [00003438] 0x3438
Instruction dump:
2c000000 4082fff8 38a5ffff 8c040001 2c000000 9c050001 4082fff4 4e800020
38a3ffff 3884ffff 8c650001 2c830000 <8c040001> 7c601851 4d860020 4182ffec
---[ end trace 8640abe69a316dee ]---
Kernel panic - not syncing: Attempted to kill the idle task!
Rebooting in 180 
seconds..                                                                                      



MATRIX VISION GmbH, Talstraße 16, DE-71570 Oppenweiler  - Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschäftsführer: Gerhard Thullner, Werner Armingeon, Uwe Furtner

--------------090303060807090704090807
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Scott Wood schrieb:
<blockquote cite="mid:20080408164853.GH2552@loki.buserror.net"
 type="cite">
  <pre wrap="">On Tue, Apr 08, 2008 at 03:50:26PM +0200, Andre Schwarz wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">after building a debug kernel and attaching the bdi2000 it looks like  
the crash occurs during "console_init()" ...
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Does your device tree have a /chosen node after u-boot is done with it? 
find_legacy_serial_ports() can crash otherwise (we really should fix that).

  </pre>
  <blockquote type="cite">
    <pre wrap="">Since we're using a dtb I omit the "console=..." argument for the  
kernel. Is this correct ?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
It's OK if you have /chosen/linux,stdout-path.

  </pre>
  <blockquote type="cite">
    <pre wrap="">If "console=/dev/ttyS0,115200N8" argument is given the serial console  
stops working after console_init....


On other PowerPC system I could see something like this during boot :

-&gt; find_legacy_serial_port()
stdout is /soc8568@e0000000/serial@4600
legacy_serial_console = 1
default console speed = 115340
&lt;- find_legacy_serial_port()


Should I see this message also ?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Only if you enable debug messages in legacy_serial.c.

  </pre>
  <blockquote type="cite">
    <pre wrap="">Have I misconfigured anything ?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
One thing that sticks out from the above is that you ask for ttyS0, but the
stdout you list from the other system corresponds to ttyS1.  Is this just a
difference between the two systems?

-Scott
  </pre>
</blockquote>
<br>
Scott,<br>
<br>
I've added kallsyms and the #debug in legacy_serial.<br>
Obviously there's missing something <br>
-&gt; see error "can't find stdout package
/soc8343@e0000000/serial@4500 !" below.<br>
<br>
<br>
Can you help here ?<br>
<br>
Thanks,<br>
Andre<br>
<br>
<br>
## Booting kernel from Legacy Image at ff810000 ...<br>
&nbsp;&nbsp; Image Name:&nbsp;&nbsp; 2.6.25 mvBL-M7 MPC8343 #12<br>
&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux Kernel Image (uncompressed)<br>
&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 2494236 Bytes =&nbsp; 2.4 MB<br>
&nbsp;&nbsp; Load Address: 00000000<br>
&nbsp;&nbsp; Entry Point:&nbsp; 00000000<br>
&nbsp;&nbsp; Verifying Checksum ... OK<br>
&nbsp;&nbsp; Loading Kernel Image ... OK<br>
OK<br>
## Flattened Device Tree blob at 00000000<br>
&nbsp;&nbsp; Booting using the fdt blob at 0x600000<br>
## Loading init Ramdisk from Legacy Image at 01000000 ...<br>
&nbsp;&nbsp; Image Name:&nbsp;&nbsp; mvBC-1G uInitrd #1.1.03<br>
&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux RAMDisk Image (uncompressed)<br>
&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 2654208 Bytes =&nbsp; 2.5 MB<br>
&nbsp;&nbsp; Load Address: 00000000<br>
&nbsp;&nbsp; Entry Point:&nbsp; 00000000<br>
&nbsp;&nbsp; Verifying Checksum ... OK<br>
&nbsp;&nbsp; Loading Ramdisk to 1fcb7000, end 1ff3f000 ... OK<br>
&nbsp;-&gt; early_init_devtree(c0600000)<br>
search "chosen", depth: 0, uname:<br>
search "chosen", depth: 1, uname: chosen<br>
Looking for initrd properties... &lt;3&gt;initrd_start=0xdfcb7000&nbsp;
initrd_end=0xdff3f000<br>
Command line is: root=/dev/ram ro rootfstype=squashfs<br>
dt_root_size_cells = 1<br>
dt_root_addr_cells = 1<br>
memory scan node memory, reg size 8, data: 0 20000000 2 1,<br>
&nbsp;- 0 ,&nbsp; 20000000<br>
reserving: 1fcb7000 -&gt; 288001<br>
Phys. mem: 20000000<br>
-&gt; move_device_tree<br>
&lt;- move_device_tree<br>
Scanning CPUs ...<br>
boot cpu: logical 0 physical 0<br>
&nbsp;&lt;- early_init_devtree()<br>
Using mvBlueLYNX-M7 machine description<br>
Linux version 2.6.25-rc8-01197-g1de15bb-dirty (root@nova) (gcc version
4.0.0 (DENX ELDK 4.1 4.0.0)) #12 PREEMPT Wed Apr 9 14:40:48 CEST 2008<br>
&nbsp;-&gt; unflatten_device_tree()<br>
&nbsp; size is 192c, allocating...<br>
&nbsp; unflattening dfffe6d0...<br>
fixed up name for&nbsp; -&gt;<br>
fixed up name for chosen -&gt; chosen<br>
fixed up name for wdt@200 -&gt; wdt<br>
fixed up name for ethernet-phy@0 -&gt; ethernet-phy<br>
fixed up name for ethernet-phy@1 -&gt; ethernet-phy<br>
fixed up name for ethernet@24000 -&gt; ethernet<br>
fixed up name for ethernet@25000 -&gt; ethernet<br>
fixed up name for serial@4500 -&gt; serial<br>
fixed up name for serial@4600 -&gt; serial<br>
fixed up name for pic@700 -&gt; pic<br>
fixed up name for ppcboot_env@0 -&gt; ppcboot_env<br>
fixed up name for ppcboot_env_red@0x2000 -&gt; ppcboot_env_red<br>
fixed up name for u-boot_autoscript@0x4000 -&gt; u-boot_autoscript<br>
fixed up name for u-boot_autoscript_red@0x4000 -&gt;
u-boot_autoscript_red<br>
fixed up name for dtb@0x8000 -&gt; dtb<br>
fixed up name for dtb_red@0xa000 -&gt; dtb_red<br>
fixed up name for kernel@0x10000 -&gt; kernel<br>
fixed up name for rfs@0x400000 -&gt; rfs<br>
fixed up name for u-boot@0x700000 -&gt; u-boot<br>
fixed up name for fpga@0x780000 -&gt; fpga<br>
&nbsp;&lt;- unflatten_device_tree()<br>
Found initrd at 0xdfcb7000:0xdff3f000<br>
&nbsp;-&gt; find_legacy_serial_port()<br>
stdout is /soc8343@e0000000/serial@4500<br>
legacy_serial_console = 0<br>
default console speed = 115740<br>
&nbsp;&lt;- find_legacy_serial_port()<br>
console [udbg0] enabled<br>
setup_arch: bootmem<br>
mvblm7_setup_arch()<br>
arch: exit<br>
Zone PFN ranges:<br>
&nbsp; DMA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 -&gt;&nbsp;&nbsp; 131072<br>
&nbsp; Normal&nbsp;&nbsp;&nbsp;&nbsp; 131072 -&gt;&nbsp;&nbsp; 131072<br>
Movable zone start PFN for each node<br>
early_node_map[1] active PFN ranges<br>
&nbsp;&nbsp;&nbsp; 0:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 -&gt;&nbsp;&nbsp; 131072<br>
Built 1 zonelists in Zone order, mobility grouping on.&nbsp; Total pages:
130048<br>
Kernel command line: root=/dev/ram ro rootfstype=squashfs<br>
PID hash table entries: 2048 (order: 11, 8192 bytes)<br>
clocksource: timebase mult[3c00001] shift[22] registered<br>
<br>
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!<br>
&nbsp;-&gt; check_legacy_serial_console()<br>
&nbsp;can't find stdout package /soc8343@e0000000/serial@4500 !<br>
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!<br>
<br>
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)<br>
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)<br>
Memory: 514048k/524288k available (2328k kernel code, 9676k reserved,
88k data, 126k bss, 140k init)<br>
SLUB: Genslabs=12, HWalign=32, Order=0-1, MinObjects=4, CPUs=1, Nodes=1<br>
Mount-cache hash table entries: 512<br>
------------[ cut here ]------------<br>
Badness at lib/kref.c:43<br>
NIP: c00f5494 LR: c000d6b0 CTR: 00000000<br>
REGS: c025de60 TRAP: 0700&nbsp;&nbsp; Not tainted&nbsp;
(2.6.25-rc8-01197-g1de15bb-dirty)<br>
MSR: 00029032 &lt;EE,ME,IR,DR&gt;&nbsp; CR: 84000048&nbsp; XER: 00000000<br>
TASK = c0248510[0] 'swapper' THREAD: c025c000<br>
GPR00: 00000001 c025df10 c0248510 dffff170 dffff050 00000009 df80fc6a
00000000<br>
GPR08: 0007ffff 00000000 df80b990 c06011cf 24000042 5fffffff 1fffd000
00000000<br>
GPR16: 1fffffff 9fffffff 00000000 00000000 1fff8910 1ff426f8 00000004
00288000<br>
GPR24: 00000000 00000000 c02630a0 c0260000 dfffefa0 c025c000 dffff050
dffff13c<br>
NIP [c00f5494] kref_get+0xc/0x24<br>
LR [c000d6b0] of_node_get+0x20/0x38<br>
Call Trace:<br>
[c025df10] [c06011cf] 0xc06011cf (unreliable)<br>
[c025df20] [c01571a4] of_get_next_child+0x40/0x9c<br>
[c025df40] [c00bab5c] proc_device_tree_add_node+0x4c/0x144<br>
[c025df60] [c00bab50] proc_device_tree_add_node+0x40/0x144<br>
[c025df80] [c00bab50] proc_device_tree_add_node+0x40/0x144<br>
[c025dfa0] [c00bacc8] proc_device_tree_init+0x74/0xa0<br>
[c025dfb0] [c0235c70] proc_root_init+0xd4/0x10c<br>
[c025dfc0] [c022374c] start_kernel+0x244/0x2cc<br>
[c025dff0] [00003438] 0x3438<br>
Instruction dump:<br>
4bf289e1 7fa3eb78 3ba00000 4bfff3ad 4bffffd8 90830000 4e800020 38800001<br>
4bfffff4 80030000 21200000 7c090114 &lt;0f000000&gt; 7d201828 31290001
7d20192d<br>
WARNING: Bad of_node_put() on<br>
Call Trace:<br>
[c025ded0] [c00088fc] show_stack+0x50/0x190 (unreliable)<br>
[c025df00] [c000de70] of_node_release+0xb0/0xcc<br>
[c025df20] [c00f5500] kref_put+0x54/0x6c<br>
[c025df30] [c000d6ec] of_node_put+0x24/0x34<br>
[c025df40] [c00babc8] proc_device_tree_add_node+0xb8/0x144<br>
[c025df60] [c00bab50] proc_device_tree_add_node+0x40/0x144<br>
[c025df80] [c00bab50] proc_device_tree_add_node+0x40/0x144<br>
[c025dfa0] [c00bacc8] proc_device_tree_init+0x74/0xa0<br>
[c025dfb0] [c0235c70] proc_root_init+0xd4/0x10c<br>
[c025dfc0] [c022374c] start_kernel+0x244/0x2cc<br>
[c025dff0] [00003438] 0x3438<br>
Unable to handle kernel paging request for data at address 0x00000000<br>
Faulting instruction address: 0xc0014454<br>
Oops: Kernel access of bad area, sig: 11 [#1]<br>
PREEMPT mvBlueLYNX-M7<br>
Modules linked in:<br>
NIP: c0014454 LR: c00ba9e0 CTR: 00000000<br>
REGS: c025de70 TRAP: 0300&nbsp;&nbsp; Not tainted&nbsp;
(2.6.25-rc8-01197-g1de15bb-dirty)<br>
MSR: 00009032 &lt;EE,ME,IR,DR&gt;&nbsp; CR: 44000048&nbsp; XER: 00000000<br>
DAR: 00000000, DSISR: 20000000<br>
TASK = c0248510[0] 'swapper' THREAD: c025c000<br>
GPR00: c00bac0c c025df20 c0248510 00000023 ffffffff df80fd60 df80fd6e
00000000<br>
GPR08: 001fffff 00000002 df80b990 c06010f5 24000022 5fffffff 1fffd000
00000000<br>
GPR16: 1fffffff 9fffffff 00000000 00000000 1fff8910 1ff426f8 00000004
00288000<br>
GPR24: 00000000 00000000 c02630a0 c0260000 dfffefa0 00000000 c025c000
df80fd00<br>
NIP [c0014454] strcmp+0x10/0x24<br>
LR [c00ba9e0] duplicate_name+0x3c/0x94<br>
Call Trace:<br>
[c025df20] [c00ba870] __proc_device_tree_add_prop+0x54/0xd4 (unreliable)<br>
[c025df40] [c00bac0c] proc_device_tree_add_node+0xfc/0x144<br>
[c025df60] [c00bab50] proc_device_tree_add_node+0x40/0x144<br>
[c025df80] [c00bab50] proc_device_tree_add_node+0x40/0x144<br>
[c025dfa0] [c00bacc8] proc_device_tree_init+0x74/0xa0<br>
[c025dfb0] [c0235c70] proc_root_init+0xd4/0x10c<br>
[c025dfc0] [c022374c] start_kernel+0x244/0x2cc<br>
[c025dff0] [00003438] 0x3438<br>
Instruction dump:<br>
2c000000 4082fff8 38a5ffff 8c040001 2c000000 9c050001 4082fff4 4e800020<br>
38a3ffff 3884ffff 8c650001 2c830000 &lt;8c040001&gt; 7c601851 4d860020
4182ffec<br>
---[ end trace 8640abe69a316dee ]---<br>
Kernel panic - not syncing: Attempted to kill the idle task!<br>
Rebooting in 180
seconds..&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<br>
<BR>

MATRIX VISION GmbH, Talstraße 16, DE-71570 Oppenweiler  - Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschäftsführer: Gerhard Thullner, Werner Armingeon, Uwe Furtner
<BR>
</body>
</html>

--------------090303060807090704090807--
