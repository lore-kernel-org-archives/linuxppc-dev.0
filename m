Return-Path: <andre.schwarz@matrix-vision.de>
Received: from p15137414.pureserver.info (matrixvision.de [217.160.213.229])
	by ozlabs.org (Postfix) with ESMTP id 5115DDDDEF
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Apr 2008 18:51:23 +1000 (EST)
Message-ID: <47FB3206.7080406@matrix-vision.de>
Date: Tue, 08 Apr 2008 10:51:18 +0200
From: Andre Schwarz <andre.schwarz@matrix-vision.de>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: MPC8343 - "unable to handle paging request @ 0"
References: <47F73625.9040903@matrix-vision.de>
	<20080407161036.GA2688@loki.buserror.net>
In-Reply-To: <20080407161036.GA2688@loki.buserror.net>
Content-Type: multipart/alternative;
	boundary="------------020302030509020500090003"
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
--------------020302030509020500090003
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Scott Wood schrieb:
> On Sat, Apr 05, 2008 at 10:19:49AM +0200, Andr=E9 Schwarz wrote:
>  =20
>> Kernel starts and crashes with "unable to handle kernel paging request=
 @ =20
>> 00000000".
>>
>> After turning debug on in some files I can see that the initrd memory =
=20
>> gets reserved and the dtb is parsed correctly.
>> PCI memory/io spaces are set up fine.
>>
>> At first I thought this is a problem with the device tree since the ca=
ll =20
>> trace always points to "of_"-functions and "strcmp".
>>    =20
>
> Could you provide this call trace?
>
> -Scott
>  =20

Scott,

thanks for your reply.

please find below the output after the bootm command in u-boot.

My System.map :

...
c00126b8 T strcpy
c00126d4 T strncpy
c0012714 T strcat
c0012740 T strcmp
c0012764 T strlen
c001277c T memcmp
...
c0140bc4 T of_find_property
c0140c74 T of_get_property
c0140ca8 T of_device_is_compatible
c0140d48 T of_match_node
c0140e68 T of_find_matching_node
c0140f20 T of_n_size_cells
c0140f9c T of_n_addr_cells



Log:


# Booting kernel from Legacy Image at ff810000 ...
   Image Name:   2.6.25 mvBL-M7 MPC8343 #1
   Image Type:   PowerPC Linux Kernel Image (uncompressed)
   Data Size:    2084636 Bytes =3D  2 MB
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
   Data Size:    2654208 Bytes =3D  2.5 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Loading Ramdisk to 1fcb7000, end 1ff3f000 ... OK
 -> early_init_devtree(c0600000)
search "chosen", depth: 0, uname:
search "chosen", depth: 1, uname: chosen
Looking for initrd properties... <3>initrd_start=3D0xdfcb7000 =20
initrd_end=3D0xdff3f000
Command line is: root=3D/dev/ram ro rootfstype=3Dsquashfs
dt_root_size_cells =3D 1
dt_root_addr_cells =3D 1
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
Linux version 2.6.25-rc8-01197-g1de15bb-dirty (root@nova) (gcc version=20
4.0.0 (DENX ELDK 4.1 4.0.0)) #1 PREEMPT Tue Apr 8 10:40:51 CEST 2008
 -> unflatten_device_tree()
  size is 1840, allocating...
  unflattening dfffe7bc...
fixed up name for  ->
fixed up name for chosen -> chosen
fixed up name for aliases -> aliases
fixed up name for cpus -> cpus
fixed up name for PowerPC,8343@0 -> PowerPC,8343
fixed up name for memory -> memory
fixed up name for soc8343@e0000000 -> soc8343
fixed up name for wdt@200 -> wdt
fixed up name for i2c@3000 -> i2c
fixed up name for rtc@68 -> rtc
fixed up name for i2c@3100 -> i2c
fixed up name for spi@7000 -> spi
fixed up name for usb@22000 -> usb
fixed up name for mdio@24520 -> mdio
fixed up name for ethernet-phy@0 -> ethernet-phy
fixed up name for ethernet-phy@1 -> ethernet-phy
fixed up name for ethernet@24000 -> ethernet
fixed up name for ethernet@25000 -> ethernet
fixed up name for serial@4500 -> serial
fixed up name for serial@4600 -> serial
fixed up name for pic@700 -> pic
fixed up name for localbus@e0005000 -> localbus
fixed up name for flash@0,0 -> flash
 <- unflatten_device_tree()
Found initrd at 0xdfcb7000:0xdff3f000
console [udbg0] enabled
setup_arch: bootmem
mvblm7_setup_arch()
Unable to handle kernel paging request for data at address 0x00000000
Faulting instruction address: 0xc0012748
Oops: Kernel access of bad area, sig: 11 [#1]
PREEMPT mvBlueLYNX-M7
Modules linked in:
NIP: c0012748 LR: c0140c10 CTR: 00000000
REGS: c01f9e40 TRAP: 0300   Not tainted  (2.6.25-rc8-01197-g1de15bb-dirty=
)
MSR: 00001032 <ME,IR,DR>  CR: 22008048  XER: 20000000
DAR: 00000000, DSISR: 20000000
TASK =3D c01e4510[0] 'swapper' THREAD: c01f8000
GPR00: c0140c84 c01f9ef0 c01e4510 00000000 c0197a7f ffffffff c01f9edc=20
00000000
GPR08: c01f15e4 00000003 c0600b84 0000004d 22002048 ffffffdf 1fffd000=20
00000000
GPR16: ffffffdf ffff7fdf 00000000 00000000 1fff8974 1ff426f8 00000004=20
00288000
GPR24: 00000002 00000000 5f0fffff c01993e4 c01f9f28 c0197a80 c01f8000=20
dffff9e4
Call Trace:
[c01f9ef0] [c001c190]  (unreliable)
[c01f9f10] [c0140c84]
[c01f9f20] [c0140ccc]
[c01f9f40] [c014145c]
[c01f9f60] [c0014014]
[c01f9fa0] [c01d1a40]
[c01f9fb0] [c01ce64c]
[c01f9fc0] [c01c55ac]
[c01f9ff0] [00003438]
Instruction dump:
3884ffff 8c050001 2c000000 4082fff8 38a5ffff 8c040001 2c000000 9c050001
4082fff4 4e800020 38a3ffff 3884ffff <8c650001> 2c830000 8c040001 7c601851
---[ end trace 8640abe69a316dee ]---
Kernel panic - not syncing: Attempted to kill the idle task!
Rebooting in 180 seconds.. =20






Please let me know if you need more information.


regards,
Andre


MATRIX VISION GmbH, Talstra=DFe 16, DE-71570 Oppenweiler  - Registergeric=
ht: Amtsgericht Stuttgart, HRB 271090
Gesch=E4ftsf=FChrer: Gerhard Thullner, Werner Armingeon, Uwe Furtner

--------------020302030509020500090003
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Scott Wood schrieb:
<blockquote cite="mid:20080407161036.GA2688@loki.buserror.net"
 type="cite">
  <pre wrap="">On Sat, Apr 05, 2008 at 10:19:49AM +0200, Andr&eacute; Schwarz wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Kernel starts and crashes with "unable to handle kernel paging request @  
00000000".

After turning debug on in some files I can see that the initrd memory  
gets reserved and the dtb is parsed correctly.
PCI memory/io spaces are set up fine.

At first I thought this is a problem with the device tree since the call  
trace always points to "of_"-functions and "strcmp".
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Could you provide this call trace?

-Scott
  </pre>
</blockquote>
<br>
Scott,<br>
<br>
thanks for your reply.<br>
<br>
please find below the output after the bootm command in u-boot.<br>
<br>
My System.map :<br>
<br>
...<br>
c00126b8 T strcpy<br>
c00126d4 T strncpy<br>
c0012714 T strcat<br>
c0012740 T strcmp<br>
c0012764 T strlen<br>
c001277c T memcmp<br>
...<br>
c0140bc4 T of_find_property<br>
c0140c74 T of_get_property<br>
c0140ca8 T of_device_is_compatible<br>
c0140d48 T of_match_node<br>
c0140e68 T of_find_matching_node<br>
c0140f20 T of_n_size_cells<br>
c0140f9c T of_n_addr_cells<br>
<br>
<br>
<br>
Log:<br>
<br>
<br>
# Booting kernel from Legacy Image at ff810000 ...<br>
&nbsp;&nbsp; Image Name:&nbsp;&nbsp; 2.6.25 mvBL-M7 MPC8343 #1<br>
&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux Kernel Image (uncompressed)<br>
&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 2084636 Bytes =&nbsp; 2 MB<br>
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
4.0.0 (DENX ELDK 4.1 4.0.0)) #1 PREEMPT Tue Apr 8 10:40:51 CEST 2008<br>
&nbsp;-&gt; unflatten_device_tree()<br>
&nbsp; size is 1840, allocating...<br>
&nbsp; unflattening dfffe7bc...<br>
fixed up name for&nbsp; -&gt;<br>
fixed up name for chosen -&gt; chosen<br>
fixed up name for aliases -&gt; aliases<br>
fixed up name for cpus -&gt; cpus<br>
fixed up name for PowerPC,8343@0 -&gt; PowerPC,8343<br>
fixed up name for memory -&gt; memory<br>
fixed up name for soc8343@e0000000 -&gt; soc8343<br>
fixed up name for wdt@200 -&gt; wdt<br>
fixed up name for i2c@3000 -&gt; i2c<br>
fixed up name for rtc@68 -&gt; rtc<br>
fixed up name for i2c@3100 -&gt; i2c<br>
fixed up name for spi@7000 -&gt; spi<br>
fixed up name for usb@22000 -&gt; usb<br>
fixed up name for mdio@24520 -&gt; mdio<br>
fixed up name for ethernet-phy@0 -&gt; ethernet-phy<br>
fixed up name for ethernet-phy@1 -&gt; ethernet-phy<br>
fixed up name for ethernet@24000 -&gt; ethernet<br>
fixed up name for ethernet@25000 -&gt; ethernet<br>
fixed up name for serial@4500 -&gt; serial<br>
fixed up name for serial@4600 -&gt; serial<br>
fixed up name for pic@700 -&gt; pic<br>
fixed up name for localbus@e0005000 -&gt; localbus<br>
fixed up name for flash@0,0 -&gt; flash<br>
&nbsp;&lt;- unflatten_device_tree()<br>
Found initrd at 0xdfcb7000:0xdff3f000<br>
console [udbg0] enabled<br>
setup_arch: bootmem<br>
mvblm7_setup_arch()<br>
Unable to handle kernel paging request for data at address 0x00000000<br>
Faulting instruction address: 0xc0012748<br>
Oops: Kernel access of bad area, sig: 11 [#1]<br>
PREEMPT mvBlueLYNX-M7<br>
Modules linked in:<br>
NIP: c0012748 LR: c0140c10 CTR: 00000000<br>
REGS: c01f9e40 TRAP: 0300&nbsp;&nbsp; Not tainted&nbsp;
(2.6.25-rc8-01197-g1de15bb-dirty)<br>
MSR: 00001032 &lt;ME,IR,DR&gt;&nbsp; CR: 22008048&nbsp; XER: 20000000<br>
DAR: 00000000, DSISR: 20000000<br>
TASK = c01e4510[0] 'swapper' THREAD: c01f8000<br>
GPR00: c0140c84 c01f9ef0 c01e4510 00000000 c0197a7f ffffffff c01f9edc
00000000<br>
GPR08: c01f15e4 00000003 c0600b84 0000004d 22002048 ffffffdf 1fffd000
00000000<br>
GPR16: ffffffdf ffff7fdf 00000000 00000000 1fff8974 1ff426f8 00000004
00288000<br>
GPR24: 00000002 00000000 5f0fffff c01993e4 c01f9f28 c0197a80 c01f8000
dffff9e4<br>
Call Trace:<br>
[c01f9ef0] [c001c190]&nbsp; (unreliable)<br>
[c01f9f10] [c0140c84]<br>
[c01f9f20] [c0140ccc]<br>
[c01f9f40] [c014145c]<br>
[c01f9f60] [c0014014]<br>
[c01f9fa0] [c01d1a40]<br>
[c01f9fb0] [c01ce64c]<br>
[c01f9fc0] [c01c55ac]<br>
[c01f9ff0] [00003438]<br>
Instruction dump:<br>
3884ffff 8c050001 2c000000 4082fff8 38a5ffff 8c040001 2c000000 9c050001<br>
4082fff4 4e800020 38a3ffff 3884ffff &lt;8c650001&gt; 2c830000 8c040001
7c601851<br>
---[ end trace 8640abe69a316dee ]---<br>
Kernel panic - not syncing: Attempted to kill the idle task!<br>
Rebooting in 180 seconds..&nbsp;&nbsp; <br>
<br>
<br>
<br>
<br>
<br>
<br>
Please let me know if you need more information.<br>
<br>
<br>
regards,<br>
Andre<br>
<BR>

MATRIX VISION GmbH, Talstraße 16, DE-71570 Oppenweiler  - Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschäftsführer: Gerhard Thullner, Werner Armingeon, Uwe Furtner
<BR>
</body>
</html>

--------------020302030509020500090003--
