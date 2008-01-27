Return-Path: <yeduj@ece.pdx.edu>
Received: from ehlo.cat.pdx.edu (ehlo.cat.pdx.edu [131.252.208.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mailhost.cecs.pdx.edu",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C52C1DDDEC
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 27 Jan 2008 18:11:06 +1100 (EST)
Message-ID: <20080126231047.y3lm7epb0gw4cog8@webmail.cecs.pdx.edu>
Date: Sat, 26 Jan 2008 23:10:47 -0800
From: Yedu Jathavedan <yeduj@ece.pdx.edu>
To: linuxppc-embedded@ozlabs.org
Subject: Load Kernel 2.6 using U-boot on ML403
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=_228oqoahtfuf"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This message is in MIME format.

--=_228oqoahtfuf
Content-Type: multipart/alternative;
	boundary="=_20o0eqe9c0hj"
Content-Transfer-Encoding: 7bit

This message is in MIME format.

--=_20o0eqe9c0hj
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Content-Description: Plaintext Version of Message
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



   Hi,
/I have downloaded the 2.6 kernel from =20
/http://git.secretlab.ca/git/linux-2.6-virtex.git , installed & =20
compiled it. I used "make ARCH=3Dppc CROSS_COMPILE=3Dppc_4xx- =20
ml403_defconfig" to build the .config file. (As explained in =20
http://wiki.secretlab.ca/index.php/Linux_on_Xilinx_Virtex)PROBLEM -

   1)Downloaded(sourceforge.net) & compiled the U-boot 1.1.6 files to =20
get u-boot, u-boot.srec & u-boot.bin (I didn't find ml403 board config =20
for the uboot. So used ml300_config).

   After this, I tried to convert the u-boot (README says that this is =20
an ELF file) into an ace file. But, it gave me the error saying unable =20
to read elf file. Is it because ML403 board is not supported or is it =20
possible that the u-boot image that I created is corrupted?

   $ xmd -tcl genace.tcl -jprog -board ml403 -hw download.bit -elf =20
u-boot -ace uboot.ace
Xilinx EDK 9.1 Build EDK_J.19
Executing xmd script : $HOME/EDK/data/xmd/genace.tcl

#######################################################################
XMD GenACE utility. Generate SystemACE File from bit/elf/data Files
#######################################################################
Target Type not defined for Processor 1, Using default Target Type ppc_hw
GenACE Options:
=A0=A0=A0=A0=A0=A0=A0 Board=A0=A0=A0=A0=A0 : ml403
=A0=A0=A0=A0=A0=A0=A0 Jtag Devs=A0 : xcf32p xc4vfx12 xc95144xl
=A0=A0=A0=A0=A0=A0=A0 FPGA pos=A0=A0 : 2
=A0=A0=A0=A0=A0=A0=A0 JPROG=A0=A0=A0=A0=A0 : true
=A0=A0=A0=A0=A0=A0=A0 HW File=A0=A0=A0 : download.bit
=A0=A0=A0=A0=A0=A0=A0 ACE File=A0=A0 : uboot.ace
=A0=A0=A0=A0=A0=A0=A0 nCPUs=A0=A0=A0=A0=A0 : 1

=A0=A0=A0=A0=A0=A0=A0 Processor ppc_hw_1 Information
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Debug opt : -debugdevice devic=
enr 2 cpunr 1
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ELF files : u-boot
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Start PC Address : 0xfff80000

############################################################
Converting Bitstream 'download.bit' to SVF file 'download.svf'
Executing 'impact -batch bit2svf.scr'
Copying download.svf File to=A0 uboot.svf File
############################################################
Converting ELF file 'u-boot' to SVF file 'u-boot.svf'
Error: E02 Failed to download ELF file

ERROR(1053): UNABLE to Read Elf File. The Elf File Maybe Corrupted
=A0=A0=A0=A0=A0=A0=A0 : u-boot
#$
-------------------------
PROBLEM -
2) Since generating ace files failed, I tried to search the net for an =20
u-boot ace file that could run on ML403 & found it at=A0 =20
http://88.191.24.164/docenligne/projets/samba/2006/linux-embarque-sur-ml-403=
/u-boot-ml403.ace/view

   I copied this ace file (u-boot-ml403.ace) along with the kernel 2.6 =20
image (uImage) onto my CF card & booted the board. After loading the =20
kernel, it fails to read the correct root device. I tried changing the =20
"bootargs" env variable root =3D /dev/xsysace/disc0/part2 rw to root =3D =20
/dev/xsysace2 rw & root =3D /dev/xsda2 rw.

   But, it failed in both cases. (There was a previous post on =20
Problem2 a year ago & he solved it by giving root =3D/dev/xsysace2)

   Environment size: 246/1020 bytes
#u-boot> setenv bootargs console=3DttyS0,9600 root=3D/dev/xsysace2 rw=A0=A0=
=A0=A0
#u-boot> fatload ace 0 0x400000 uImage
reading uImage

952237 bytes read
#u-boot>=A0 bootm 0x400000
## Booting image at 00400000 ...
=A0=A0 Image Name:=A0=A0 Linux-2.6.24-rc3
=A0=A0 Image Type:=A0=A0 PowerPC Linux Kernel Image (gzip compressed)
=A0=A0 Data Size:=A0=A0=A0 952173 Bytes =3D 929.9 kB
=A0=A0 Load Address: 00000000
=A0=A0 Entry Point:=A0 00000000
=A0=A0 Verifying Checksum ... OK
=A0=A0 Uncompressing Kernel Image ... OK
[=A0=A0=A0 0.000000] Linux version 2.6.24-rc3 (icdt@icdt05) (gcc version =20
4.0.0 (DENX ELDK 4.0 4.0.0)) #1 Fri Jan 25 21:23:54 PST 2008
[=A0=A0=A0 0.000000] Xilinx ML403 Reference System (Virtex-4 FX)
[=A0=A0=A0 0.000000] Zone PFN ranges:
[=A0=A0=A0 0.000000]=A0=A0 DMA=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 ->=A0=
=A0=A0 16384
[=A0=A0=A0 0.000000]=A0=A0 Normal=A0=A0=A0=A0=A0 16384 ->=A0=A0=A0 16384
[=A0=A0=A0 0.000000] Movable zone start PFN for each node
[=A0=A0=A0 0.000000] early_node_map[1] active PFN ranges
[=A0=A0=A0 0.000000]=A0=A0=A0=A0 0:=A0=A0=A0=A0=A0=A0=A0 0 ->=A0=A0=A0 16384
[=A0=A0=A0 0.000000] Built 1 zonelists in Zone order, mobility grouping on.=
=A0 =20
Total pages: 16256
[=A0=A0=A0 0.000000] Kernel command line: console=3DttyS0,9600 ip=3Doff =20
root=3D/dev/xsysace=A0 root=3D/dev/xsysace2 rw
[=A0=A0=A0 0.000000] Xilinx INTC #0 at 0xD1000FC0 mapped to 0xFDFFEFC0
[=A0=A0=A0 0.000000] PID hash table entries: 256 (order: 8, 1024 bytes)
[=A0=A0=A0 0.000179] Console: colour dummy device 80x25
[=A0=A0=A0 0.000669] Dentry cache hash table entries: 8192 (order: 3, 32768 =
bytes)
[=A0=A0=A0 0.001431] Inode-cache hash table entries: 4096 (order: 2, 16384 b=
ytes)
[=A0=A0=A0 0.015197] Memory: 62860k available (1452k kernel code, 496k data,=
 =20
96k init, 0k highmem)
[=A0=A0=A0 0.204614] Mount-cache hash table entries: 512
[=A0=A0=A0 0.209345] net_namespace: 64 bytes
[=A0=A0=A0 0.213840] NET: Registered protocol family 16
[=A0=A0=A0 0.252576] NET: Registered protocol family 2
[=A0=A0=A0 0.288713] IP route cache hash table entries: 1024 (order: 0, 4096=
 bytes)
[=A0=A0=A0 0.291229] TCP established hash table entries: 2048 (order: 2, =20
16384 bytes)
[=A0=A0=A0 0.291535] TCP bind hash table entries: 2048 (order: 1, 8192 bytes=
)
[=A0=A0=A0 0.291709] TCP: Hash tables configured (established 2048 bind 2048=
)
[=A0=A0=A0 0.291737] TCP reno registered
[=A0=A0=A0 0.301433] sysctl table check failed: /kernel/l2cr .1.31 Missing s=
trategy
[=A0=A0=A0 0.301509] Call Trace:
[=A0=A0=A0 0.301528] [c3c17e80] [c00084f4] show_stack+0x4c/0x174 (unreliable=
)
[=A0=A0=A0 0.301611] [c3c17eb0] [c00305e0] set_fail+0x50/0x68
[=A0=A0=A0 0.301678] [c3c17ed0] [c0030c68] sysctl_check_table+0x670/0x6bc
[=A0=A0=A0 0.301726] [c3c17f10] [c0030c7c] sysctl_check_table+0x684/0x6bc
[=A0=A0=A0 0.301771] [c3c17f50] [c001df28] register_sysctl_table+0x5c/0xac
[=A0=A0=A0 0.301832] [c3c17f70] [c01dca84] register_ppc_htab_sysctl+0x18/0x2=
c
[=A0=A0=A0 0.301897] [c3c17f80] [c01d6848] kernel_init+0xc8/0x284
[=A0=A0=A0 0.301938] [c3c17ff0] [c0004af8] kernel_thread+0x44/0x60
[=A0=A0=A0 0.307739] io scheduler noop registered
[=A0=A0=A0 0.307792] io scheduler anticipatory registered (default)
[=A0=A0=A0 0.307817] io scheduler deadline registered
[=A0=A0=A0 0.307967] io scheduler cfq registered
[=A0=A0=A0 0.364669] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, =
=20
IRQ sharing disabled
[=A0=A0=A0 0.370815] serial8250.0: ttyS0 at MMIO 0xa0001003 (irq =3D 9) is a=
 16450
[=A0=A0=A0 0.370893] console [ttyS0] enabled
[=A0=A0=A0 3.286815] RAMDISK driver initialized: 16 RAM disks of 65536K size=
 =20
1024 blocksize
[=A0=A0=A0 3.376997] tun: Universal TUN/TAP device driver, 1.6
[=A0=A0=A0 3.437161] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[=A0=A0=A0 3.512736] mice: PS/2 mouse device common for all mice
[=A0=A0=A0 3.574814] TCP cubic registered
[=A0=A0=A0 3.613145] NET: Registered protocol family 1
[=A0=A0=A0 3.665227] NET: Registered protocol family 17
[=A0=A0=A0 3.720647] VFS: Cannot open root device "xsysace2" or unknown-bloc=
k(0,0)
[=A0=A0=A0 3.801333] Please append a correct "root=3D" boot option; here are=
 =20
the available partitions:
[=A0=A0=A0 3.901354] Kernel panic - not syncing: VFS: Unable to mount root =
=20
fs on unknown-block(0,0)
[=A0=A0=A0 4.000286] Rebooting in 180 seconds..
-------------------------
Can anyone help me with either one (or both) of the above problems?=A0 I =20
have pretty much run out of ideas. :(

   Thanks & Regards,
Yedu



--=_20o0eqe9c0hj
Content-Type: text/html;
	charset=ISO-8859-1
Content-Description: HTML Version of Message
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


<p>
<font size=3D"2">Hi,</font><br /><font size=3D"2"><i>I
have downloaded the 2.6 kernel from </i><a class=3D"fixed"
href=3D"http://git.secretlab.ca/git/linux-2.6-virtex.git"
target=3D"_blank">http://git.secretlab.ca/git/linux-2.6-virtex.git</a> , ins=
talled
&amp; compiled it. I used &quot;make
ARCH=3Dppc CROSS_COMPILE=3Dppc_4xx- ml403_defconfig&quot; to build the .conf=
ig file.
(As explained in <a class=3D"fixed"
href=3D"http://wiki.secretlab.ca/index.php/Linux_on_Xilinx_Virtex"
target=3D"_blank">http://wiki.secretlab.ca/index.php/Linux_on_Xilinx_Virtex<=
/a>)</font></p><b>Problem
-</b><br /><p><font size=3D"2">1)Downloaded(sourceforge.net) &amp; compiled =
the
U-boot 1.1.6 files to get u-boot, u-boot.srec &amp; u-boot.bin (I didn't fin=
d
ml403 board config for the uboot. So used ml300_config). </font></p><p><font
size=3D"2">After this, I tried to convert the u-boot (README says that this =
is an
ELF file) into an ace file. But, it gave me the error saying unable to read =
elf
file. Is it because ML403 board is not supported or is it possible that the
u-boot image that I created is corrupted?</font></p><p><font size=3D"2"><i>$=
 xmd
-tcl genace.tcl -jprog -board ml403 -hw download.bit -elf u-boot -ace
uboot.ace<br />Xilinx EDK 9.1 Build EDK_J.19<br />Executing xmd script :
$HOME/EDK/data/xmd/genace.tcl<br /><br
/>#######################################################################<br
/>XMD GenACE utility. Generate SystemACE File from bit/elf/data Files<br
/>#######################################################################<br
/>Target Type not defined for Processor 1, Using default Target Type ppc_hw<=
br
/>GenACE Options:<br />=A0=A0=A0=A0=A0=A0=A0 Board=A0=A0=A0=A0=A0 : ml403<br=
 />=A0=A0=A0=A0=A0=A0=A0 Jtag Devs=A0 :
xcf32p xc4vfx12 xc95144xl<br />=A0=A0=A0=A0=A0=A0=A0 FPGA pos=A0=A0 : 2<br /=
>=A0=A0=A0=A0=A0=A0=A0 JPROG=A0=A0=A0=A0=A0 :
true<br />=A0=A0=A0=A0=A0=A0=A0 HW File=A0=A0=A0 : download.bit<br />=A0=A0=
=A0=A0=A0=A0=A0 ACE File=A0=A0 :
uboot.ace<br />=A0=A0=A0=A0=A0=A0=A0 nCPUs=A0=A0=A0=A0=A0 : 1<br /><br />=A0=
=A0=A0=A0=A0=A0=A0 Processor ppc_hw_1
Information<br />=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Debug opt : -=
debugdevice devicenr 2 cpunr 1<br
/>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ELF files : u-boot<br />=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Start PC Address :
0xfff80000<br /><br
/>############################################################<br />Converti=
ng
Bitstream 'download.bit' to SVF file 'download.svf'<br />Executing 'impact
-batch bit2svf.scr'<br />Copying download.svf File to=A0 uboot.svf File<br
/>############################################################<br />Converti=
ng
ELF file 'u-boot' to SVF file 'u-boot.svf'<br />Error: E02 Failed to downloa=
d
ELF file<br /><br />ERROR(1053): UNABLE to Read Elf File. The Elf File Maybe
Corrupted<br />=A0=A0=A0=A0=A0=A0=A0 : u-boot<br />#$</i></font></p><hr widt=
h=3D"100%" size=3D"2"
/><font size=3D"2"><b>Problem -</b><br />2) Since generating ace files faile=
d, I
tried to search the net for an u-boot ace file that could run on ML403 &amp;
found it at=A0
http://88.191.24.164/docenligne/projets/samba/2006/linux-embarque-sur-ml-403=
/u-boot-ml403.ace/view</font><p><font
size=3D"2">I copied this ace file (u-boot-ml403.ace) along with the kernel 2=
.6
image (uImage) onto my CF card &amp; booted the board. After loading the ker=
nel,
it fails to read the correct root device. I tried changing the
&quot;bootargs&quot; env variable root =3D /dev/xsysace/disc0/part2 rw to ro=
ot =3D
/dev/xsysace2 rw &amp; root =3D /dev/xsda2 rw.</font></p><p><font size=3D"2"=
>But, it
failed in both cases. (There was a previous post on Problem2 a year ago &amp=
; he
solved it by giving root =3D/dev/xsysace2)</font></p><p><font
size=3D"2"><i>Environment size: 246/1020 bytes<br />#u-boot&gt; setenv boota=
rgs
console=3DttyS0,9600 root=3D/dev/xsysace2 rw=A0=A0=A0=A0 <br />#u-boot&gt; f=
atload ace 0
0x400000 uImage<br />reading uImage<br /><br />952237 bytes read<br
/>#u-boot&gt;=A0 bootm 0x400000<br />## Booting image at 00400000 ...<br />=
=A0=A0
Image Name:=A0=A0 Linux-2.6.24-rc3<br />=A0=A0 Image Type:=A0=A0 PowerPC Lin=
ux Kernel Image
(gzip compressed)<br />=A0=A0 Data Size:=A0=A0=A0 952173 Bytes =3D 929.9 kB<=
br />=A0=A0 Load
Address: 00000000<br />=A0=A0 Entry Point:=A0 00000000<br />=A0=A0 Verifying=
 Checksum ...
OK<br />=A0=A0 Uncompressing Kernel Image ... OK<br />[=A0=A0=A0 0.000000] L=
inux version
2.6.24-rc3 (icdt@icdt05) (gcc version 4.0.0 (DENX ELDK 4.0 4.0.0)) #1 Fri Ja=
n 25
21:23:54 PST 2008<br />[=A0=A0=A0 0.000000] Xilinx ML403 Reference System (V=
irtex-4
FX)<br />[=A0=A0=A0 0.000000] Zone PFN ranges:<br />[=A0=A0=A0 0.000000]=A0=
=A0 DMA=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0
-&gt;=A0=A0=A0 16384<br />[=A0=A0=A0 0.000000]=A0=A0 Normal=A0=A0=A0=A0=A0 1=
6384 -&gt;=A0=A0=A0 16384<br />[=A0=A0=A0
0.000000] Movable zone start PFN for each node<br />[=A0=A0=A0 0.000000]
early_node_map[1] active PFN ranges<br />[=A0=A0=A0 0.000000]=A0=A0=A0=A0 0:=
=A0=A0=A0=A0=A0=A0=A0 0 -&gt;=A0=A0=A0
16384<br />[=A0=A0=A0 0.000000] Built 1 zonelists in Zone order, mobility gr=
ouping
on.=A0 Total pages: 16256<br />[=A0=A0=A0 0.000000] Kernel command line:
console=3DttyS0,9600 ip=3Doff root=3D/dev/xsysace=A0 root=3D/dev/xsysace2 rw=
<br />[=A0=A0=A0
0.000000] Xilinx INTC #0 at 0xD1000FC0 mapped to 0xFDFFEFC0<br />[=A0=A0=A0 =
0.000000]
PID hash table entries: 256 (order: 8, 1024 bytes)<br />[=A0=A0=A0 0.000179]=
 Console:
colour dummy device 80x25<br />[=A0=A0=A0 0.000669] Dentry cache hash table =
entries:
8192 (order: 3, 32768 bytes)<br />[=A0=A0=A0 0.001431] Inode-cache hash tabl=
e entries:
4096 (order: 2, 16384 bytes)<br />[=A0=A0=A0 0.015197] Memory: 62860k availa=
ble (1452k
kernel code, 496k data, 96k init, 0k highmem)<br />[=A0=A0=A0 0.204614] Moun=
t-cache
hash table entries: 512<br />[=A0=A0=A0 0.209345] net_namespace: 64 bytes<br=
 />[=A0=A0=A0
0.213840] NET: Registered protocol family 16<br />[=A0=A0=A0 0.252576] NET: =
Registered
protocol family 2<br />[=A0=A0=A0 0.288713] IP route cache hash table entrie=
s: 1024
(order: 0, 4096 bytes)<br />[=A0=A0=A0 0.291229] TCP established hash table =
entries:
2048 (order: 2, 16384 bytes)<br />[=A0=A0=A0 0.291535] TCP bind hash table e=
ntries:
2048 (order: 1, 8192 bytes)<br />[=A0=A0=A0 0.291709] TCP: Hash tables confi=
gured
(established 2048 bind 2048)<br />[=A0=A0=A0 0.291737] TCP reno registered<b=
r />[=A0=A0=A0
0.301433] sysctl table check failed: /kernel/l2cr .1.31 Missing strategy<br
/>[=A0=A0=A0 0.301509] Call Trace:<br />[=A0=A0=A0 0.301528] [c3c17e80] [c00=
084f4]
show_stack+0x4c/0x174 (unreliable)<br />[=A0=A0=A0 0.301611] [c3c17eb0] [c00=
305e0]
set_fail+0x50/0x68<br />[=A0=A0=A0 0.301678] [c3c17ed0] [c0030c68]
sysctl_check_table+0x670/0x6bc<br />[=A0=A0=A0 0.301726] [c3c17f10] [c0030c7=
c]
sysctl_check_table+0x684/0x6bc<br />[=A0=A0=A0 0.301771] [c3c17f50] [c001df2=
8]
register_sysctl_table+0x5c/0xac<br />[=A0=A0=A0 0.301832] [c3c17f70] [c01dca=
84]
register_ppc_htab_sysctl+0x18/0x2c<br />[=A0=A0=A0 0.301897] [c3c17f80] [c01=
d6848]
kernel_init+0xc8/0x284<br />[=A0=A0=A0 0.301938] [c3c17ff0] [c0004af8]
kernel_thread+0x44/0x60<br />[=A0=A0=A0 0.307739] io scheduler noop register=
ed<br
/>[=A0=A0=A0 0.307792] io scheduler anticipatory registered (default)<br />[=
=A0=A0=A0
0.307817] io scheduler deadline registered<br />[=A0=A0=A0 0.307967] io sche=
duler cfq
registered<br />[=A0=A0=A0 0.364669] Serial: 8250/16550 driver $Revision: 1.=
90 $ 4
ports, IRQ sharing disabled<br />[=A0=A0=A0 0.370815] serial8250.0: ttyS0 at=
 MMIO
0xa0001003 (irq =3D 9) is a 16450<br />[=A0=A0=A0 0.370893] console [ttyS0] =
enabled<br
/>[=A0=A0=A0 3.286815] RAMDISK driver initialized: 16 RAM disks of 65536K si=
ze 1024
blocksize<br />[=A0=A0=A0 3.376997] tun: Universal TUN/TAP device driver, 1.=
6<br
/>[=A0=A0=A0 3.437161] tun: (C) 1999-2004 Max Krasnyansky &lt;maxk@qualcomm.=
com&gt;<br
/>[=A0=A0=A0 3.512736] mice: PS/2 mouse device common for all mice<br />[=A0=
=A0=A0 3.574814]
TCP cubic registered<br />[=A0=A0=A0 3.613145] NET: Registered protocol fami=
ly 1<br
/>[=A0=A0=A0 3.665227] NET: Registered protocol family 17<br />[=A0=A0=A0 3.=
720647] VFS:
Cannot open root device &quot;xsysace2&quot; or unknown-block(0,0)<br />[=A0=
=A0=A0
3.801333] Please append a correct &quot;root=3D&quot; boot option; here are =
the
available partitions:<br />[=A0=A0=A0 3.901354] Kernel panic - not syncing: =
VFS:
Unable to mount root fs on unknown-block(0,0)<br />[=A0=A0=A0 4.000286] Rebo=
oting in
180 seconds..</i></font></p><hr width=3D"100%" size=3D"2" /><font size=3D"2"=
>Can
anyone help me with either one (or both) of the above problems?=A0 I have pr=
etty
much run out of ideas. :(</font><p><font size=3D"2">Thanks &amp; Regards,<br
/>Yedu</font></p><p />
--=_20o0eqe9c0hj--

--=_228oqoahtfuf
Content-Type: multipart/alternative;
	boundary="=_4k7x00bp7c1h";
	name=""
Content-Transfer-Encoding: 7bit

Date: Sat, 26 Jan 2008 21:59:17 -0800
From: Yedu Jathavedan <yeduj@ece.pdx.edu>
To: linuxppc-embedded@ozlabs.org
Subject: Load Kernel 2.6 using U-boot on ML403
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="=_4k7x00bp7c1h"
Content-Transfer-Encoding: 7bit


--=_4k7x00bp7c1h
Content-Type: text/plain;
	charset=ISO-8859-1;
	delsp="Yes";
	format="flowed"
Content-Description: Plaintext Version of Message
Content-Disposition: inline
Content-Transfer-Encoding: 7bit



Hi,

/ GOAL - To use the USB Host on ML403 in a PowerPC processor reference  
system to store some data on a Thumb Drive./

   /BACKGROUND - I downloaded the 2.6 kernel from  
/http://git.secretlab.ca/git/linux-2.6-virtex.git , installed &  
compiled it to get uImage & zImage.elf files. I used "make  
ml403_defconfig" to build the .config file. (As explained in  
http://wiki.secretlab.ca/index.php/Linux_on_Xilinx_Virtex)



--=_4k7x00bp7c1h
Content-Type: text/html;
	charset=ISO-8859-1
Content-Description: HTML Version of Message
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

<p>
<br />
Hi,<br />
<br /><i><b>
Goal -</b> To use the USB Host on ML403 in a PowerPC processor reference system
to store some data on a Thumb Drive.</i></p><p><i><b>Background - </b>I
downloaded the 2.6 kernel from </i><a target="_blank"
href="http://git.secretlab.ca/git/linux-2.6-virtex.git"
class="fixed">http://git.secretlab.ca/git/linux-2.6-virtex.git</a> , installed
&amp; compiled it to get uImage &amp; zImage.elf files. I used &quot;make
ml403_defconfig&quot; to build the .config file. (As explained in <a
target="_blank" href="http://wiki.secretlab.ca/index.php/Linux_on_Xilinx_Virtex"
class="fixed">http://wiki.secretlab.ca/index.php/Linux_on_Xilinx_Virtex</a>)</p><p></p><p></p>
--=_4k7x00bp7c1h--

--=_228oqoahtfuf--
