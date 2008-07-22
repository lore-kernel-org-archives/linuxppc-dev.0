Return-Path: <joachim.bader@diehl-aerospace.de>
Received: from mail02.diehl.de (mail02.diehl.de [193.201.236.151])
	by ozlabs.org (Postfix) with ESMTP id D2293DDF61
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Jul 2008 23:34:04 +1000 (EST)
Received: from alg1.diehl.com (localhost [127.0.0.1])
	by alg1.diehl.com (8.13.8/8.13.8) with ESMTP id m6MDY13q019164
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Jul 2008 15:34:01 +0200 (CEST)
To: linuxppc-embedded@ozlabs.org
Subject: Help: Kernel BUG with U-boot 1.1.4 and kernel 2.6.23 scanning PCIe on
	a MPC8641D board
MIME-Version: 1.0
From: joachim.bader@diehl-aerospace.de
Message-ID: <OFB15FD6AA.EA941C67-ONC125748E.00488CEE-C125748E.004A8A08@diehl-gruppe.de>
Date: Tue, 22 Jul 2008 15:33:50 +0200
Content-Type: multipart/alternative;
	boundary="=_alternative 004A8A00C125748E_="
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dies ist eine mehrteilige Nachricht im MIME-Format.
--=_alternative 004A8A00C125748E_=
Content-Type: text/plain; charset="utf-8"
content-transfer-encoding: quoted-printable

Hello folks,

we run a proprietary board with Freescale MPC8641D using U-boot 1.1.4 and=20
Linux kernel 2.6.23

First of all, we are no experts in PCIe-Bus handling and management.
We started with the problem that U-Boot was able to scan the devices=20
connected to PCIe-Bus where the kernel fails.
Using the information provided by Vince Asbridge regarding the different=20
numbering of devices on PCIe bus by U-Boot and kernel we were able to get=20
the kernel up recognizing the devices correctly.
Thanks for this info.

But now we are blocked by an exception in kernel mode during=20
initialisation of the PCIe-Buses and devices. We instrumented the kernel=20
additional to the standard print outs to get more information and to=20
understand the behavior of the scan and allocation process. But now we get=
=20
lost. I assume that the problem is caused by the transparent bridges.

I appent here after the trace log. Perhaps someone knows this problem=20
already or can give me a hint .

I read in the logs some messages that 2.6.23 does contain some bugs=20
related to PCIe and it would be a good choice to upgrade to 2.6.25. Is=20
this one of that cases?
Currently we would like to prevent switching the kernel version.

Any help is appreciated.

Thanks in advance.

Joachim
--=20
Dipl.-Ing. Joachim Bader
Research & Technology
Cockpit and Display Systems

Diehl Aerospace GmbH
An der Sandelmuehle 13
D-60439 Frankfurt
Phone +49-69-5805-1270
Fax       +49-69-5805-1400
e-mail:  joachim.bader@diehl-aerospace.de
http://www.diehl-aerospace.de
------ TRACE LOG --------

Load address: 0x1000000
Loading: #################################################################
         #################################################################
         #################################################################
         #################################################################
         ############
done
Bytes transferred =3D 1389893 (153545 hex)
## Booting image at 01000000 ...
   Image Name:   Linux-2.6.23
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1389829 Bytes =3D  1.3 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Current stack ends at 0x0FF9B968 =3D> set upper limit to 0x00800000
## cmdline at 0x007FFF00 ... 0x007FFF9B
bd address  =3D 0x0FF9BFB0
memstart    =3D 0x00000000
memsize     =3D 0x20000000
flashstart  =3D 0xF0000000
flashsize   =3D 0x10000000
flashoffset =3D 0x00000000
sramstart   =3D 0x00000000
sramsize    =3D 0x00000000
bootflags   =3D 0x00000001
intfreq     =3D    990 MHz
busfreq     =3D    396 MHz
ethaddr     =3D 00:E0:0C:00:00:10
eth1addr    =3D 00:E0:0C:00:01:10
eth2addr    =3D 00:E0:0C:00:02:10
eth3addr    =3D 00:E0:0C:00:03:10
IP addr     =3D 172.30.222.10
baudrate    =3D 115200 bps
No initrd
## Transferring control to Linux (at address 00000000) ...
Linux Kernel Parameters:
   of_flat_tree: 007fde60 =3D d00dfeed
   kernel: 00000000 =3D 60000000
Using MPC86xx HPCN machine description
Total memory =3D 512MB; using 1024kB for hash table (at cff00000)
Linux version 2.6.23 (vowinkel@ariadne) (gcc version 3.3.2) #94 Tue Jul 22=
=20
14:43:39 CEST 2008
console [udbg0] enabled
setup_arch: bootmem
mpc86xx_hpcn_setup_arch()
Found FSL PCI host bridge at 0x00000000d4008000.Firmware bus number:=20
0->254
Dump of resource ranges:
 len=3D12
0x02000000
0x00000000
0x40000000
0x40000000
0x00000000
0x10000000
0x01000000
0x00000000
0x00000000
0x5e000000
0x00000000
0x01000000

PCI: MEM[0] 0x40000000 -> 0x4fffffff
PCI: IO Phys =3D 0x5e000000
PCI: IO Virt =3D 0x5e000000
PCI: IO 0x0 -> 0xffffff
Found FSL PCI host bridge at 0x00000000d4009000.Firmware bus number:=20
0->254
Dump of resource ranges:
 len=3D12
0x02000000
0x00000000
0x80000000
0x80000000
0x00000000
0x10000000
0x01000000
0x00000000
0x00000000
0x9e000000
0x00000000
0x 1000000

PCI: MEM[0] 0x80000000 -> 0x8fffffff
PCI: IO Phys =3D 0x9e000000
PCI: IO Virt =3D 0x9e000000
PCI: IO 0x0 -> 0xffffff

MPC86xx HPCN board from Freescale Semiconductor
arch: exit
Zone PFN ranges:
  DMA             0 ->   131072
  Normal     131072 ->   131072
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0:        0 ->   131072
Built 1 zonelists in Zone order.  Total pages: 130048
Kernel command line: root=3D/dev/nfs rw=20
nfsroot=3D172.30.222.1:/data/home/pub/taurus10=20
ip=3D172.30.222.10:172.30.222.1:172.30.222.1:255.255.255.0:taurus:eth2:off=
=20
console=3DttyS0,115200
mpic: Setting up MPIC " MPIC     " version 1.2 at d4040000, max 2 CPUs
mpic: ISU size: 88, shift: 7, mask: 7f
mpic: Initializing for 88 sources
PID hash table entries: 2048 (order: 11, 8192 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 515328k/524288k available (2712k kernel code, 8620k reserved, 144k=
=20
data, 140k bss, 136k init)
Mount-cache hash table entries: 512
=3D=3D=3D=3D=3D=3D bus.c -> registering device: ID =3D 'platform'
NET: Registered protocol family 16
=3D=3D=3D=3D=3D=3D bus.c -> registering device: ID =3D 'vtcon0'

=3D=3D=3D=3D=3D=3D bus.c -> registering device: ID =3D 'fsl-gianfar_mdio.35'
=3D=3D=3D=3D=3D=3D bus.c -> registering device: ID =3D 'fsl-gianfar.1'
=3D=3D=3D=3D=3D=3D bus.c -> registering device: ID =3D 'fsl-gianfar.2'
=3D=3D=3D=3D=3D=3D bus.c -> registering device: ID =3D 'fsl-gianfar.3'
=3D=3D=3D=3D=3D=3D bus.c -> registering device: ID =3D 'fsl-gianfar.4'
=3D=3D=3D=3D=3D=3D bus.c -> registering device: ID =3D 'fsl-i2c.1'
=3D=3D=3D=3D=3D=3D bus.c -> registering device: ID =3D 'fsl-i2c.2'
=3D=3D=3D=3D=3D=3D bus.c -> registering device: ID =3D 'fsl-hydra.1'
PCI: Probing PCI hardware
=3D=3D=3D=3D=3D=3D bus.c -> registering device: ID =3D 'pci0000:00'
PCI: 0000:00:00.0: class b20 doesn't match header type 01. Ignoring class.
PCI: Transparent bridge - 0000:00:00.0
=3D=3D=3D=3D=3D=3D bus.c -> registering device: ID =3D '0000:00:00.0'
=3D=3D=3D=3D=3D=3D bus.c -> registering device: ID =3D '0000:01:00.0'
=3D=3D=3D=3D=3D=3D bus.c -> registering device: ID =3D '0000:02:01.0'
=3D=3D=3D=3D=3D=3D bus.c -> registering device: ID =3D '0000:02:02.0'
=3D=3D=3D=3D=3D=3D bus.c -> registering device: ID =3D 'pci0001:05'
PCI: 0001:05:00.0: class b20 doesn't match header type 01. Ignoring class.
PCI: Transparent bridge - 0001:05:00.0
=3D=3D=3D=3D=3D=3D bus.c -> registering device: ID =3D '0001:05:00.0'
=3D=3D=3D=3D=3D=3D bus.c -> registering device: ID =3D '0001:06:00.0'
=3D=3D=3D=3D=3D=3D bus.c -> registering device: ID =3D '0001:07:01.0'
=3D=3D=3D=3D=3D=3D bus.c -> registering device: ID =3D '0001:07:02.0'
=3D=3D=3D=3D=3D=3D bus.c -> registering device: ID =3D '0001:07:03.0'
=3D=3D=3D=3D=3D=3D bus.c -> registering device: ID =3D '0001:09:00.0'
=3D=3D=3D=3D=3D=3D bus.c -> registering device: ID =3D '0001:0a:04.0'
=3D=3D=3D=3D=3D=3D bus.c -> registering device: ID =3D '0001:0a:04.1'
=3D=3D=3D=3D=3D=3D bus.c -> registering device: ID =3D '0001:0a:04.2'

 Res: 0xC02F5040
 Start: 0x0

 End: 0xFFFFFF

 Name: /soc8641@d4000000/pcie@8000

 Flags: 0x100

 Par: 0xC02AB2A4
 Start: 0x0

 End: 0xFFFFFFFF

 Name: PCI IO

 Flags: 0x100
PCI: bridge rsrc 0..ffffff (100), parent c02ab2a4

 Res: 0xC02F505C
 Start: 0x40000000

 End: 0x4FFFFFFF

 Name: /soc8641@d4000000/pcie@8000

 Flags: 0x200

 Par: 0xC02AB2C0
 Start: 0x0

 End: 0xFFFFFFFF

 Name: PCI mem

 Flags: 0x200
PCI: bridge rsrc 40000000..4fffffff (200), parent c02ab2c0

 Res: 0xDFFE32C8
 Start: 0x0

 End: 0xFFFFFF

 Name: PCI Bus #01

 Flags: 0x100

 Par: 0xC02F5040
 Start: 0x0

 End: 0xFFFFFF

 Name: /soc8641@d4000000/pcie@8000

 Flags: 0x100
PCI: bridge rsrc 0..ffffff (100), parent c02f5040

 Res: 0xDFFE32E4
 Start: 0x40000000

 End: 0x4FFFFFFF

 Name: PCI Bus #01

 Flags: 0x200

 Par: 0xC02F505C
 Start: 0x40000000

 End: 0x4FFFFFFF

 Name: /soc8641@d4000000/pcie@8000

 Flags: 0x200
PCI: bridge rsrc 40000000..4fffffff (200), parent c02f505c

 Res: 0xC02FA040
 Start: 0xFF000000

 End: 0xFFFFFFFF

 Name: /soc8641@d4000000/pcie@9000

 Flags: 0x100

 Par: 0xC02AB2A4
 Start: 0x0

 End: 0xFFFFFFFF

 Name: PCI IO

 Flags: 0x100
PCI: bridge rsrc ff000000..ffffffff (100), parent c02ab2a4

 Res: 0xC02FA05C
 Start: 0x80000000

 End: 0x8FFFFFFF

 Name: /soc8641@d4000000/pcie@9000

 Flags: 0x200

 Par: 0xC02AB2C0
 Start: 0x0

 End: 0xFFFFFFFF

 Name: PCI mem

 Flags: 0x200
PCI: bridge rsrc 80000000..8fffffff (200), parent c02ab2c0

 Res: 0xDFFE1360
 Start: 0xFF000000

 End: 0xFFFFFFFF

 Name: PCI Bus #06

 Flags: 0x100

 Par: 0xC02FA040
 Start: 0xFF000000

 End: 0xFFFFFFFF

 Name: /soc8641@d4000000/pcie@9000

 Flags: 0x100
PCI: bridge rsrc ff000000..ffffffff (100), parent c02fa040

 Res: 0xDFFE137C
 Start: 0x80000000

 End: 0x8FFFFFFF

 Name: PCI Bus #06

 Flags: 0x200

 Par: 0xC02FA05C
 Start: 0x80000000

 End: 0x8FFFFFFF

 Name: /soc8641@d4000000/pcie@9000

 Flags: 0x200
PCI: bridge rsrc 80000000..8fffffff (200), parent c02fa05c

 Res: 0xDFFE0AD8
 Start: 0xFF000000

 End: 0xFF000FFF

 Name: PCI Bus #0a

 Flags: 0x101

 Par: 0x0
 PCI: bridge rsrc ff000000..ff000fff (101), parent 00000000
PCI: Cannot allocate resource region 0 of PCI bridge 10

 Res: 0xDFFE0AF4
 Start: 0x0

 End: 0xFFFFF

 Name: PCI Bus #0a

 Flags: 0x200

 Par: 0x0PCI: bridge rsrc 0..fffff (200), parent 00000000
PCI: Cannot allocate resource region 1 of PCI bridge 10

 Res: 0xDFFE0B10
 Start: 0x0

 End: 0xFFFFF

 Name: PCI Bus #0a

 Flags: 0x1201

 Par: 0x0PCI: bridge rsrc 0..fffff (1201), parent 00000000
PCI: Cannot allocate resource region 2 of PCI bridge 10
PCI: Cannot allocate resource region 0 of device 0000:01:00.0
PCI: Cannot allocate resource region 0 of device 0001:06:00.0
PCI: Cannot allocate resource region 0 of device 0001:09:00.0
PCI: Cannot allocate resource region 0 of device 0001:0a:04.0
PCI: Cannot allocate resource region 0 of device 0001:0a:04.1
PCI: Cannot allocate resource region 0 of device 0001:0a:04.2
PCI: Failed to allocate mem resource #0:2000@0 for 0001:09:00.0
------------[ cut here ]------------
Kernel BUG at c028c504 [verbose debug info unavailable]
Oops: Exception in kernel mode, sig: 5 [#1]
MPC86xx HPCN
NIP: c028c504 LR: c028c504 CTR: c00115b4
REGS: dffc1e40 TRAP: 0700   Not tainted  (2.6.23)
MSR: 00029032 <EE,ME,IR,DR>  CR: 22008022  XER: 00000000
TASK =3D dfff0830[1] 'swapper' THREAD: dffc0000
GPR00: c028c504 dffc1ef0 dfff0830 fffffff4 00000001 00000001 00000000=20
c02d0000
GPR08: 00003379 c02ab200 00000000 c02b0000 22008022 f7fbfffc 0fffa100=20
00000001
GPR16: 00000001 ffffffff 007fff00 c02a0000 c02a0000 c02a0000 00000002=20
0ff9ea08
GPR24: c02d0000 c02d0000 000000ff c02d0000 c02d2e88 dffe0814 00000000=20
dffe0a14
NIP [c028c504] pcibios_assign_resources+0xb8/0xe4
LR [c028c504] pcibios_assign_resources+0xb8/0xe4
Call Trace:
[dffc1ef0] [c028c504] pcibios_assign_resources+0xb8/0xe4 (unreliable)
[dffc1f10] [c028cb24] pcibios_init+0x120/0x164
[dffc1f40] [c0284884] do_initcalls+0x58/0x20c
[dffc1fd0] [c0284afc] kernel_init+0x4c/0xa4
[dffc1ff0] [c0011580] kernel_thread+0x44/0x60
Instruction dump:
2c000000 41820018 7c0803a6 4e800021 2c030000 40820020 813f000c 552000c2
7fa3eb78 7fc4f378 901f000c 4be925c5 <0f030000> 3bde0001 3bff001c 2c1e0005
Kernel panic - not syncing: Attempted to kill init!
Rebooting in 180 seconds.



___________________________________________________________________________=
____________________________________________
Der Inhalt dieser E-Mail ist f=C3=BCr den Absender rechtlich nicht verbindl=
ich.=20
Informieren Sie uns bitte, wenn Sie diese E-Mail f=C3=A4lschlicherweise erh=
alten haben (Fax: +49-69-5805-1399). Bitte l=C3=B6schen Sie in diesem Fall =
die Nachricht. Jede Form der weiteren Benutzung ist untersagt.

The content of this e-mail is not legally binding upon the sender.
If this e-mail was transmitted to you by error, then please inform us accor=
dingly (Fax: +49-69-5805-1399). In such case you are requested to erase the=
 message. Any use of such e-mail message is strictly prohibited.

--=_alternative 004A8A00C125748E_=
Content-Type: text/html; charset="utf-8"
content-transfer-encoding: quoted-printable


<br><font size=3D2 face=3D"sans-serif">Hello folks,</font>
<br>
<br><font size=3D2 face=3D"sans-serif">we run a proprietary board with Free=
scale
MPC8641D using U-boot 1.1.4 and Linux kernel 2.6.23</font>
<br>
<br><font size=3D2 face=3D"sans-serif">First of all, we are no experts in P=
CIe-Bus
handling and management.</font>
<br><font size=3D2 face=3D"sans-serif">We started with the problem that U-B=
oot
was able to scan the devices connected to PCIe-Bus where the kernel fails.<=
/font>
<br><font size=3D2 face=3D"sans-serif">Using the information provided by <b=
>Vince
Asbridge</b> regarding the different numbering of devices on PCIe bus by
U-Boot and kernel we were able to get the kernel up recognizing the devices
correctly.</font>
<br><font size=3D2 face=3D"sans-serif">Thanks for this info.</font>
<br>
<br><font size=3D2 face=3D"sans-serif">But now we are blocked by an excepti=
on
in kernel mode during initialisation of the PCIe-Buses and devices. We
instrumented the kernel additional to the standard print outs to get more
information and to understand the behavior of the scan and allocation proce=
ss.
But now we get lost. I assume that the problem is caused by the transparent
bridges.</font>
<br>
<br><font size=3D2 face=3D"sans-serif">I appent here after the trace log. P=
erhaps
someone knows this problem already or can give me a hint .</font>
<br>
<br><font size=3D2 face=3D"sans-serif">I read in the logs some messages that
2.6.23 does contain some bugs related to PCIe and it would be a good choice
to upgrade to 2.6.25. Is this one of that cases?</font>
<br><font size=3D2 face=3D"sans-serif">Currently we would like to prevent s=
witching
the kernel version.</font>
<br>
<br><font size=3D2 face=3D"sans-serif">Any help is appreciated.</font>
<br>
<br><font size=3D2 face=3D"sans-serif">Thanks in advance.</font>
<br>
<br><font size=3D2 face=3D"sans-serif">Joachim</font>
<br><font size=3D2 face=3D"sans-serif">-- <br>
Dipl.-Ing. Joachim Bader<br>
Research &amp; Technology<br>
Cockpit and Display Systems<br>
<br>
Diehl Aerospace GmbH<br>
An der Sandelmuehle 13<br>
D-60439 Frankfurt<br>
Phone +49-69-5805-1270<br>
Fax &nbsp; &nbsp; &nbsp; +49-69-5805-1400<br>
e-mail: &nbsp;joachim.bader@diehl-aerospace.de<br>
http://www.diehl-aerospace.de</font>
<br><font size=3D2 face=3D"sans-serif">------ TRACE LOG --------</font>
<br>
<br><font size=3D2 face=3D"sans-serif">Load address: 0x1000000</font>
<br><font size=3D2 face=3D"sans-serif">Loading: ###########################=
######################################</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;##=
###############################################################</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;##=
###############################################################</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;##=
###############################################################</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;##=
##########</font>
<br><font size=3D2 face=3D"sans-serif">done</font>
<br><font size=3D2 face=3D"sans-serif">Bytes transferred =3D 1389893 (153545
hex)</font>
<br><font size=3D2 face=3D"sans-serif">## Booting image at 01000000 ...</fo=
nt>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp;Image Name: &nbsp; Linu=
x-2.6.23</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp;Image Type: &nbsp; Powe=
rPC
Linux Kernel Image (gzip compressed)</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp;Data Size: &nbsp; &nbsp=
;1389829
Bytes =3D &nbsp;1.3 MB</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp;Load Address: 00000000<=
/font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp;Entry Point: &nbsp;0000=
0000</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp;Verifying Checksum ...
OK</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp;Uncompressing Kernel Im=
age
... OK</font>
<br><font size=3D2 face=3D"sans-serif">## Current stack ends at 0x0FF9B968
=3D&gt; set upper limit to 0x00800000</font>
<br><font size=3D2 face=3D"sans-serif">## cmdline at 0x007FFF00 ... 0x007FF=
F9B</font>
<br><font size=3D2 face=3D"sans-serif">bd address &nbsp;=3D 0x0FF9BFB0</fon=
t>
<br><font size=3D2 face=3D"sans-serif">memstart &nbsp; &nbsp;=3D 0x00000000=
</font>
<br><font size=3D2 face=3D"sans-serif">memsize &nbsp; &nbsp; =3D 0x20000000=
</font>
<br><font size=3D2 face=3D"sans-serif">flashstart &nbsp;=3D 0xF0000000</fon=
t>
<br><font size=3D2 face=3D"sans-serif">flashsize &nbsp; =3D 0x10000000</fon=
t>
<br><font size=3D2 face=3D"sans-serif">flashoffset =3D 0x00000000</font>
<br><font size=3D2 face=3D"sans-serif">sramstart &nbsp; =3D 0x00000000</fon=
t>
<br><font size=3D2 face=3D"sans-serif">sramsize &nbsp; &nbsp;=3D 0x00000000=
</font>
<br><font size=3D2 face=3D"sans-serif">bootflags &nbsp; =3D 0x00000001</fon=
t>
<br><font size=3D2 face=3D"sans-serif">intfreq &nbsp; &nbsp; =3D &nbsp; &nb=
sp;990
MHz</font>
<br><font size=3D2 face=3D"sans-serif">busfreq &nbsp; &nbsp; =3D &nbsp; &nb=
sp;396
MHz</font>
<br><font size=3D2 face=3D"sans-serif">ethaddr &nbsp; &nbsp; =3D 00:E0:0C:0=
0:00:10</font>
<br><font size=3D2 face=3D"sans-serif">eth1addr &nbsp; &nbsp;=3D 00:E0:0C:0=
0:01:10</font>
<br><font size=3D2 face=3D"sans-serif">eth2addr &nbsp; &nbsp;=3D 00:E0:0C:0=
0:02:10</font>
<br><font size=3D2 face=3D"sans-serif">eth3addr &nbsp; &nbsp;=3D 00:E0:0C:0=
0:03:10</font>
<br><font size=3D2 face=3D"sans-serif">IP addr &nbsp; &nbsp; =3D 172.30.222=
.10</font>
<br><font size=3D2 face=3D"sans-serif">baudrate &nbsp; &nbsp;=3D 115200 bps=
</font>
<br><font size=3D2 face=3D"sans-serif">No initrd</font>
<br><font size=3D2 face=3D"sans-serif">## Transferring control to Linux (at
address 00000000) ...</font>
<br><font size=3D2 face=3D"sans-serif">Linux Kernel Parameters:</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp;of_flat_tree: 007fde60
=3D d00dfeed</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp;kernel: 00000000 =3D 60=
000000</font>
<br><font size=3D2 face=3D"sans-serif">Using MPC86xx HPCN machine descripti=
on</font>
<br><font size=3D2 face=3D"sans-serif">Total memory =3D 512MB; using 1024kB=
 for
hash table (at cff00000)</font>
<br><font size=3D2 face=3D"sans-serif">Linux version 2.6.23 (vowinkel@ariad=
ne)
(gcc version 3.3.2) #94 Tue Jul 22 14:43:39 CEST 2008</font>
<br><font size=3D2 face=3D"sans-serif">console [udbg0] enabled</font>
<br><font size=3D2 face=3D"sans-serif">setup_arch: bootmem</font>
<br><font size=3D2 face=3D"sans-serif">mpc86xx_hpcn_setup_arch()</font>
<br><font size=3D2 face=3D"sans-serif">Found FSL PCI host bridge at 0x00000=
000d4008000.Firmware
bus number: 0-&gt;254</font>
<br><font size=3D2 face=3D"sans-serif">Dump of resource ranges:</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp;len=3D12</font>
<br><font size=3D2 face=3D"sans-serif">0x02000000</font>
<br><font size=3D2 face=3D"sans-serif">0x00000000</font>
<br><font size=3D2 face=3D"sans-serif">0x40000000</font>
<br><font size=3D2 face=3D"sans-serif">0x40000000</font>
<br><font size=3D2 face=3D"sans-serif">0x00000000</font>
<br><font size=3D2 face=3D"sans-serif">0x10000000</font>
<br><font size=3D2 face=3D"sans-serif">0x01000000</font>
<br><font size=3D2 face=3D"sans-serif">0x00000000</font>
<br><font size=3D2 face=3D"sans-serif">0x00000000</font>
<br><font size=3D2 face=3D"sans-serif">0x5e000000</font>
<br><font size=3D2 face=3D"sans-serif">0x00000000</font>
<br><font size=3D2 face=3D"sans-serif">0x01000000</font>
<br>
<br><font size=3D2 face=3D"sans-serif">PCI: MEM[0] 0x40000000 -&gt; 0x4ffff=
fff</font>
<br><font size=3D2 face=3D"sans-serif">PCI: IO Phys =3D 0x5e000000</font>
<br><font size=3D2 face=3D"sans-serif">PCI: IO Virt =3D 0x5e000000</font>
<br><font size=3D2 face=3D"sans-serif">PCI: IO 0x0 -&gt; 0xffffff</font>
<br><font size=3D2 face=3D"sans-serif">Found FSL PCI host bridge at 0x00000=
000d4009000.Firmware
bus number: 0-&gt;254</font>
<br><font size=3D2 face=3D"sans-serif">Dump of resource ranges:</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp;len=3D12</font>
<br><font size=3D2 face=3D"sans-serif">0x02000000</font>
<br><font size=3D2 face=3D"sans-serif">0x00000000</font>
<br><font size=3D2 face=3D"sans-serif">0x80000000</font>
<br><font size=3D2 face=3D"sans-serif">0x80000000</font>
<br><font size=3D2 face=3D"sans-serif">0x00000000</font>
<br><font size=3D2 face=3D"sans-serif">0x10000000</font>
<br><font size=3D2 face=3D"sans-serif">0x01000000</font>
<br><font size=3D2 face=3D"sans-serif">0x00000000</font>
<br><font size=3D2 face=3D"sans-serif">0x00000000</font>
<br><font size=3D2 face=3D"sans-serif">0x9e000000</font>
<br><font size=3D2 face=3D"sans-serif">0x00000000</font>
<br><font size=3D2 face=3D"sans-serif">0x 1000000</font>
<br>
<br><font size=3D2 face=3D"sans-serif">PCI: MEM[0] 0x80000000 -&gt; 0x8ffff=
fff</font>
<br><font size=3D2 face=3D"sans-serif">PCI: IO Phys =3D 0x9e000000</font>
<br><font size=3D2 face=3D"sans-serif">PCI: IO Virt =3D 0x9e000000</font>
<br><font size=3D2 face=3D"sans-serif">PCI: IO 0x0 -&gt; 0xffffff</font>
<br>
<br><font size=3D2 face=3D"sans-serif">MPC86xx HPCN board from Freescale Se=
miconductor</font>
<br><font size=3D2 face=3D"sans-serif">arch: exit</font>
<br><font size=3D2 face=3D"sans-serif">Zone PFN ranges:</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; DMA &nbsp; &nbsp; &nbsp; &nbs=
p;
&nbsp; &nbsp; 0 -&gt; &nbsp; 131072</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; Normal &nbsp; &nbsp; 131072 -=
&gt;
&nbsp; 131072</font>
<br><font size=3D2 face=3D"sans-serif">Movable zone start PFN for each node=
</font>
<br><font size=3D2 face=3D"sans-serif">early_node_map[1] active PFN ranges<=
/font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; 0: &nbsp; &nbsp; &nbsp;
&nbsp;0 -&gt; &nbsp; 131072</font>
<br><font size=3D2 face=3D"sans-serif">Built 1 zonelists in Zone order. &nb=
sp;Total
pages: 130048</font>
<br><font size=3D2 face=3D"sans-serif">Kernel command line: root=3D/dev/nfs=
 rw
nfsroot=3D172.30.222.1:/data/home/pub/taurus10 ip=3D172.30.222.10:172.30.22=
2.1:172.30.222.1:255.255.255.0:taurus:eth2:off
console=3DttyS0,115200</font>
<br><font size=3D2 face=3D"sans-serif">mpic: Setting up MPIC &quot; MPIC &n=
bsp;
&nbsp; &quot; version 1.2 at d4040000, max 2 CPUs</font>
<br><font size=3D2 face=3D"sans-serif">mpic: ISU size: 88, shift: 7, mask:
7f</font>
<br><font size=3D2 face=3D"sans-serif">mpic: Initializing for 88 sources</f=
ont>
<br><font size=3D2 face=3D"sans-serif">PID hash table entries: 2048 (order:
11, 8192 bytes)</font>
<br><font size=3D2 face=3D"sans-serif">Console: colour dummy device 80x25</=
font>
<br><font size=3D2 face=3D"sans-serif">Dentry cache hash table entries: 655=
36
(order: 6, 262144 bytes)</font>
<br><font size=3D2 face=3D"sans-serif">Inode-cache hash table entries: 32768
(order: 5, 131072 bytes)</font>
<br><font size=3D2 face=3D"sans-serif">Memory: 515328k/524288k available (2=
712k
kernel code, 8620k reserved, 144k data, 140k bss, 136k init)</font>
<br><font size=3D2 face=3D"sans-serif">Mount-cache hash table entries: 512<=
/font>
<br><font size=3D2 face=3D"sans-serif">=3D=3D=3D=3D=3D=3D bus.c -&gt; regis=
tering device:
ID =3D 'platform'</font>
<br><font size=3D2 face=3D"sans-serif">NET: Registered protocol family 16</=
font>
<br><font size=3D2 face=3D"sans-serif">=3D=3D=3D=3D=3D=3D bus.c -&gt; regis=
tering device:
ID =3D 'vtcon0'</font>
<br>
<br><font size=3D2 face=3D"sans-serif">=3D=3D=3D=3D=3D=3D bus.c -&gt; regis=
tering device:
ID =3D 'fsl-gianfar_mdio.35'</font>
<br><font size=3D2 face=3D"sans-serif">=3D=3D=3D=3D=3D=3D bus.c -&gt; regis=
tering device:
ID =3D 'fsl-gianfar.1'</font>
<br><font size=3D2 face=3D"sans-serif">=3D=3D=3D=3D=3D=3D bus.c -&gt; regis=
tering device:
ID =3D 'fsl-gianfar.2'</font>
<br><font size=3D2 face=3D"sans-serif">=3D=3D=3D=3D=3D=3D bus.c -&gt; regis=
tering device:
ID =3D 'fsl-gianfar.3'</font>
<br><font size=3D2 face=3D"sans-serif">=3D=3D=3D=3D=3D=3D bus.c -&gt; regis=
tering device:
ID =3D 'fsl-gianfar.4'</font>
<br><font size=3D2 face=3D"sans-serif">=3D=3D=3D=3D=3D=3D bus.c -&gt; regis=
tering device:
ID =3D 'fsl-i2c.1'</font>
<br><font size=3D2 face=3D"sans-serif">=3D=3D=3D=3D=3D=3D bus.c -&gt; regis=
tering device:
ID =3D 'fsl-i2c.2'</font>
<br><font size=3D2 face=3D"sans-serif">=3D=3D=3D=3D=3D=3D bus.c -&gt; regis=
tering device:
ID =3D 'fsl-hydra.1'</font>
<br><font size=3D2 face=3D"sans-serif">PCI: Probing PCI hardware</font>
<br><font size=3D2 face=3D"sans-serif">=3D=3D=3D=3D=3D=3D bus.c -&gt; regis=
tering device:
ID =3D 'pci0000:00'</font>
<br><font size=3D2 face=3D"sans-serif">PCI: 0000:00:00.0: class b20 doesn't
match header type 01. Ignoring class.</font>
<br><font size=3D2 face=3D"sans-serif">PCI: Transparent bridge - 0000:00:00=
.0</font>
<br><font size=3D2 face=3D"sans-serif">=3D=3D=3D=3D=3D=3D bus.c -&gt; regis=
tering device:
ID =3D '0000:00:00.0'</font>
<br><font size=3D2 face=3D"sans-serif">=3D=3D=3D=3D=3D=3D bus.c -&gt; regis=
tering device:
ID =3D '0000:01:00.0'</font>
<br><font size=3D2 face=3D"sans-serif">=3D=3D=3D=3D=3D=3D bus.c -&gt; regis=
tering device:
ID =3D '0000:02:01.0'</font>
<br><font size=3D2 face=3D"sans-serif">=3D=3D=3D=3D=3D=3D bus.c -&gt; regis=
tering device:
ID =3D '0000:02:02.0'</font>
<br><font size=3D2 face=3D"sans-serif">=3D=3D=3D=3D=3D=3D bus.c -&gt; regis=
tering device:
ID =3D 'pci0001:05'</font>
<br><font size=3D2 face=3D"sans-serif">PCI: 0001:05:00.0: class b20 doesn't
match header type 01. Ignoring class.</font>
<br><font size=3D2 face=3D"sans-serif">PCI: Transparent bridge - 0001:05:00=
.0</font>
<br><font size=3D2 face=3D"sans-serif">=3D=3D=3D=3D=3D=3D bus.c -&gt; regis=
tering device:
ID =3D '0001:05:00.0'</font>
<br><font size=3D2 face=3D"sans-serif">=3D=3D=3D=3D=3D=3D bus.c -&gt; regis=
tering device:
ID =3D '0001:06:00.0'</font>
<br><font size=3D2 face=3D"sans-serif">=3D=3D=3D=3D=3D=3D bus.c -&gt; regis=
tering device:
ID =3D '0001:07:01.0'</font>
<br><font size=3D2 face=3D"sans-serif">=3D=3D=3D=3D=3D=3D bus.c -&gt; regis=
tering device:
ID =3D '0001:07:02.0'</font>
<br><font size=3D2 face=3D"sans-serif">=3D=3D=3D=3D=3D=3D bus.c -&gt; regis=
tering device:
ID =3D '0001:07:03.0'</font>
<br><font size=3D2 face=3D"sans-serif">=3D=3D=3D=3D=3D=3D bus.c -&gt; regis=
tering device:
ID =3D '0001:09:00.0'</font>
<br><font size=3D2 face=3D"sans-serif">=3D=3D=3D=3D=3D=3D bus.c -&gt; regis=
tering device:
ID =3D '0001:0a:04.0'</font>
<br><font size=3D2 face=3D"sans-serif">=3D=3D=3D=3D=3D=3D bus.c -&gt; regis=
tering device:
ID =3D '0001:0a:04.1'</font>
<br><font size=3D2 face=3D"sans-serif">=3D=3D=3D=3D=3D=3D bus.c -&gt; regis=
tering device:
ID =3D '0001:0a:04.2'</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Res: 0xC02F5040</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Start: 0x0</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;End: 0xFFFFFF</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Name: /soc8641@d4000000/pcie@8=
000</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Flags: 0x100</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Par: 0xC02AB2A4</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Start: 0x0</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;End: 0xFFFFFFFF</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Name: PCI IO</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Flags: 0x100</font>
<br><font size=3D2 face=3D"sans-serif">PCI: bridge rsrc 0..ffffff (100), pa=
rent
c02ab2a4</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Res: 0xC02F505C</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Start: 0x40000000</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;End: 0x4FFFFFFF</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Name: /soc8641@d4000000/pcie@8=
000</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Flags: 0x200</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Par: 0xC02AB2C0</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Start: 0x0</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;End: 0xFFFFFFFF</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Name: PCI mem</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Flags: 0x200</font>
<br><font size=3D2 face=3D"sans-serif">PCI: bridge rsrc 40000000..4fffffff
(200), parent c02ab2c0</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Res: 0xDFFE32C8</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Start: 0x0</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;End: 0xFFFFFF</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Name: PCI Bus #01</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Flags: 0x100</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Par: 0xC02F5040</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Start: 0x0</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;End: 0xFFFFFF</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Name: /soc8641@d4000000/pcie@8=
000</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Flags: 0x100</font>
<br><font size=3D2 face=3D"sans-serif">PCI: bridge rsrc 0..ffffff (100), pa=
rent
c02f5040</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Res: 0xDFFE32E4</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Start: 0x40000000</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;End: 0x4FFFFFFF</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Name: PCI Bus #01</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Flags: 0x200</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Par: 0xC02F505C</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Start: 0x40000000</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;End: 0x4FFFFFFF</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Name: /soc8641@d4000000/pcie@8=
000</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Flags: 0x200</font>
<br><font size=3D2 face=3D"sans-serif">PCI: bridge rsrc 40000000..4fffffff
(200), parent c02f505c</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Res: 0xC02FA040</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Start: 0xFF000000</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;End: 0xFFFFFFFF</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Name: /soc8641@d4000000/pcie@9=
000</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Flags: 0x100</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Par: 0xC02AB2A4</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Start: 0x0</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;End: 0xFFFFFFFF</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Name: PCI IO</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Flags: 0x100</font>
<br><font size=3D2 face=3D"sans-serif">PCI: bridge rsrc ff000000..ffffffff
(100), parent c02ab2a4</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Res: 0xC02FA05C</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Start: 0x80000000</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;End: 0x8FFFFFFF</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Name: /soc8641@d4000000/pcie@9=
000</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Flags: 0x200</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Par: 0xC02AB2C0</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Start: 0x0</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;End: 0xFFFFFFFF</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Name: PCI mem</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Flags: 0x200</font>
<br><font size=3D2 face=3D"sans-serif">PCI: bridge rsrc 80000000..8fffffff
(200), parent c02ab2c0</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Res: 0xDFFE1360</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Start: 0xFF000000</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;End: 0xFFFFFFFF</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Name: PCI Bus #06</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Flags: 0x100</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Par: 0xC02FA040</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Start: 0xFF000000</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;End: 0xFFFFFFFF</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Name: /soc8641@d4000000/pcie@9=
000</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Flags: 0x100</font>
<br><font size=3D2 face=3D"sans-serif">PCI: bridge rsrc ff000000..ffffffff
(100), parent c02fa040</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Res: 0xDFFE137C</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Start: 0x80000000</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;End: 0x8FFFFFFF</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Name: PCI Bus #06</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Flags: 0x200</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Par: 0xC02FA05C</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Start: 0x80000000</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;End: 0x8FFFFFFF</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Name: /soc8641@d4000000/pcie@9=
000</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Flags: 0x200</font>
<br><font size=3D2 face=3D"sans-serif">PCI: bridge rsrc 80000000..8fffffff
(200), parent c02fa05c</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Res: 0xDFFE0AD8</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Start: 0xFF000000</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;End: 0xFF000FFF</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Name: PCI Bus #0a</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Flags: 0x101</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Par: 0x0</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp;PCI: bridge rsrc ff000000..ff0=
00fff
(101), parent 00000000</font>
<br><font size=3D2 face=3D"sans-serif">PCI: Cannot allocate resource region
0 of PCI bridge 10</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Res: 0xDFFE0AF4</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Start: 0x0</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;End: 0xFFFFF</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Name: PCI Bus #0a</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Flags: 0x200</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Par: 0x0PCI: bridge rsrc 0..ff=
fff
(200), parent 00000000</font>
<br><font size=3D2 face=3D"sans-serif">PCI: Cannot allocate resource region
1 of PCI bridge 10</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Res: 0xDFFE0B10</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Start: 0x0</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;End: 0xFFFFF</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Name: PCI Bus #0a</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Flags: 0x1201</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Par: 0x0PCI: bridge rsrc 0..ff=
fff
(1201), parent 00000000</font>
<br><font size=3D2 face=3D"sans-serif">PCI: Cannot allocate resource region
2 of PCI bridge 10</font>
<br><font size=3D2 face=3D"sans-serif">PCI: Cannot allocate resource region
0 of device 0000:01:00.0</font>
<br><font size=3D2 face=3D"sans-serif">PCI: Cannot allocate resource region
0 of device 0001:06:00.0</font>
<br><font size=3D2 face=3D"sans-serif">PCI: Cannot allocate resource region
0 of device 0001:09:00.0</font>
<br><font size=3D2 face=3D"sans-serif">PCI: Cannot allocate resource region
0 of device 0001:0a:04.0</font>
<br><font size=3D2 face=3D"sans-serif">PCI: Cannot allocate resource region
0 of device 0001:0a:04.1</font>
<br><font size=3D2 face=3D"sans-serif">PCI: Cannot allocate resource region
0 of device 0001:0a:04.2</font>
<br><font size=3D2 face=3D"sans-serif">PCI: Failed to allocate mem resource
#0:2000@0 for 0001:09:00.0</font>
<br><font size=3D2 face=3D"sans-serif">------------[ cut here ]------------=
</font>
<br><font size=3D2 face=3D"sans-serif">Kernel BUG at c028c504 [verbose debug
info unavailable]</font>
<br><font size=3D2 face=3D"sans-serif">Oops: Exception in kernel mode, sig:
5 [#1]</font>
<br><font size=3D2 face=3D"sans-serif">MPC86xx HPCN</font>
<br><font size=3D2 face=3D"sans-serif">NIP: c028c504 LR: c028c504 CTR: c001=
15b4</font>
<br><font size=3D2 face=3D"sans-serif">REGS: dffc1e40 TRAP: 0700 &nbsp; Not
tainted &nbsp;(2.6.23)</font>
<br><font size=3D2 face=3D"sans-serif">MSR: 00029032 &lt;EE,ME,IR,DR&gt; &n=
bsp;CR:
22008022 &nbsp;XER: 00000000</font>
<br><font size=3D2 face=3D"sans-serif">TASK =3D dfff0830[1] 'swapper' THREA=
D:
dffc0000</font>
<br><font size=3D2 face=3D"sans-serif">GPR00: c028c504 dffc1ef0 dfff0830 ff=
fffff4
00000001 00000001 00000000 c02d0000</font>
<br><font size=3D2 face=3D"sans-serif">GPR08: 00003379 c02ab200 00000000 c0=
2b0000
22008022 f7fbfffc 0fffa100 00000001</font>
<br><font size=3D2 face=3D"sans-serif">GPR16: 00000001 ffffffff 007fff00 c0=
2a0000
c02a0000 c02a0000 00000002 0ff9ea08</font>
<br><font size=3D2 face=3D"sans-serif">GPR24: c02d0000 c02d0000 000000ff c0=
2d0000
c02d2e88 dffe0814 00000000 dffe0a14</font>
<br><font size=3D2 face=3D"sans-serif">NIP [c028c504] pcibios_assign_resour=
ces+0xb8/0xe4</font>
<br><font size=3D2 face=3D"sans-serif">LR [c028c504] pcibios_assign_resourc=
es+0xb8/0xe4</font>
<br><font size=3D2 face=3D"sans-serif">Call Trace:</font>
<br><font size=3D2 face=3D"sans-serif">[dffc1ef0] [c028c504] pcibios_assign=
_resources+0xb8/0xe4
(unreliable)</font>
<br><font size=3D2 face=3D"sans-serif">[dffc1f10] [c028cb24] pcibios_init+0=
x120/0x164</font>
<br><font size=3D2 face=3D"sans-serif">[dffc1f40] [c0284884] do_initcalls+0=
x58/0x20c</font>
<br><font size=3D2 face=3D"sans-serif">[dffc1fd0] [c0284afc] kernel_init+0x=
4c/0xa4</font>
<br><font size=3D2 face=3D"sans-serif">[dffc1ff0] [c0011580] kernel_thread+=
0x44/0x60</font>
<br><font size=3D2 face=3D"sans-serif">Instruction dump:</font>
<br><font size=3D2 face=3D"sans-serif">2c000000 41820018 7c0803a6 4e800021
2c030000 40820020 813f000c 552000c2</font>
<br><font size=3D2 face=3D"sans-serif">7fa3eb78 7fc4f378 901f000c 4be925c5
&lt;0f030000&gt; 3bde0001 3bff001c 2c1e0005</font>
<br><font size=3D2 face=3D"sans-serif">Kernel panic - not syncing: Attempted
to kill init!</font>
<br><font size=3D2 face=3D"sans-serif">Rebooting in 180 seconds.</font>
<br>
<br>
<br>
<span style=3D"font-family:sans-serif,helvetica; font-size:10pt; color:#000=
000">______________________________________________________________________=
_________________________________________________</span><br>
<span style=3D"font-family:sans-serif,helvetica; font-size:10pt; color:#000=
000">Der Inhalt dieser E-Mail ist f=C3=BCr den Absender rechtlich nicht ver=
bindlich. </span><br>
<span style=3D"font-family:sans-serif,helvetica; font-size:10pt; color:#000=
000">Informieren Sie uns bitte, wenn Sie diese E-Mail f=C3=A4lschlicherweis=
e erhalten haben (Fax: +49-69-5805-1399). Bitte l=C3=B6schen Sie in diesem =
Fall die Nachricht. Jede Form der weiteren Benutzung ist untersagt.</span><=
br>
<br>
<span style=3D"font-family:sans-serif,helvetica; font-size:10pt; color:#000=
000">The content of this e-mail is not legally binding upon the sender.</sp=
an><br>
<span style=3D"font-family:sans-serif,helvetica; font-size:10pt; color:#000=
000">If this e-mail was transmitted to you by error, then please inform us =
accordingly (Fax: +49-69-5805-1399). In such case you are requested to eras=
e the message. Any use of such e-mail message is strictly prohibited.</span=
><br>
<br>
--=_alternative 004A8A00C125748E_=--
