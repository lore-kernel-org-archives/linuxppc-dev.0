Return-Path: <jonb@marel.is>
Received: from marel.marel.is (GW-NAT01-ISLNET.marel.is [213.213.131.1])
	by ozlabs.org (Postfix) with ESMTP id 802812BDC5
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Sep 2004 04:22:35 +1000 (EST)
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
MIME-Version: 1.0
Message-ID: <OF4E11986A.DD692D61-ON00256F18.005010DC-00256F18.00637C77@marel.is>
From: "=?iso-8859-1?Q?J=F3n_Benediktsson?=" <jonb@marel.is>
Date: Thu, 23 Sep 2004 18:06:39 +0000
Content-Type: multipart/alternative;
	boundary="=_alternative 00637C7400256F18_="
Subject: MPC5200 with PCF8563 RTC
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.
--=_alternative 00637C7400256F18_=
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi

I am working on porting linux to a custom board based on MPC5200, which=20
has a PCF8563 real time clock connected via i2c2=5Fio and i2c2=5Fclk pins.
It looks like this same combination is used on the PM520 board.

I am using u-boot and it was a breeze getting this combination to work in=20
u-boot.  I just added the right CONFIG=5Fs and the u-boot date command=20
worked
without any problems.

I am however having a more difficult time getting the linux kernel=20
(linuxppc=5F2=5F4=5Fdevel from Denx) to work with PCF8563.  I get errors fr=
om=20
rtc=5Frd( ), but I
can't understand why.  I have compared the i2c clock signals between=20
u-boot and linux and noticed that the clock signal is different with=20
linux.   The third clock
pulse is much narrower than the others, whereas with u-boot the clock=20
pulses are all even.  But I can't figure out why the i2c clock behaves=20
differently with linux.
Attached is the console output.

Any thoughts ?


Thanks,
J=F3n Benediktsson
Marel hf.


Memory BAT mapping: BAT2=3D32Mb, BAT3=3D0Mb, residual: 0Mb
Linux version 2.4.25 (jonb@tux.marel.is) (gcc version 3.2.2 20030217=20
(Yellow Dog
 Linux 3.0 3.2.2-2a=5F1)) #46 Fim Sep 23 17:43:42 UTC 2004
On node 0 totalpages: 8192
zone(0): 8192 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=3D/dev/nfs rw=20
nfsroot=3D10.100.1.30:/opt/eldk/ppc=5F82xx ip=3D
10.100.50.68:10.100.1.30:10.100.254.254:255.255.0.0:ns4:eth0:off panic=3D1
Calibrating delay loop (skipped)... 0.05 BogoMIPS
Memory: 29992k available (1348k kernel code, 452k data, 76k init, 0k=20
highmem)
Dentry cache hash table entries: 4096 (order: 3, 32768 bytes)
Inode cache hash table entries: 2048 (order: 2, 16384 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
JFFS2 version 2.2. (C) 2001-2003 Red Hat, Inc.
i2c-core.o: i2c core module version 2.6.1 (20010830)
i2c-dev.o: i2c /dev entries driver module version 2.6.1 (20010830)
i2c-proc.o version 2.6.1 (20010830)
pty: 256 Unix98 ptys configured
ttyS0 on PSC1
ttyS1 on PSC2
ttyS2 on PSC3
PCF8563 Real-Time Clock Driver $Revision: 1.3 $ wd@denx.de
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with=20
idebus=3Dxx
Port Config is: 0x91050404
ipb=3D66MHz, set clock period to 15
GPIO config: 91050404
ATA invalid: 00800000
ATA hostcnf: 03000000
ATA pio1   : 100a0a00
ATA pio2   : 02040600
XLB Arb cnf: 80002006
mpc5xxx=5Fide: Setting up IDE interface ide0...
Probing IDE interface ide0...
hda: SAMSUNG CF/ATA, CFA DISK drive
ide0 at 0xf0003a60-0xf0003a67,0xf0003a5c on irq 45
hda: attached ide-disk driver.
hda: 507904 sectors (260 MB) w/1KiB Cache, CHS=3D992/16/32
Partition check:
 hda: hda1 hda2 hda3 hda4
Icecube Bank 0: Found 1 x16 devices at 0x0 in 8-bit mode
 Amd/Fujitsu Extended Query Table at 0x0040
Icecube Bank 0: CFI does not contain boot bank location. Assuming top.
number of CFI chips: 1
cfi=5Fcmdset=5F0002: Disabling erase-suspend-program due to code brokenness.
Icecube flash bank 0: Using static image partition definition
Creating 5 MTD partitions on "Icecube Bank 0":
0x00000000-0x00800000 : "Spare"
0x00800000-0x00900000 : "kernel"
0x00900000-0x00c00000 : "initrd"
0x00c00000-0x00f00000 : "jffs"
0x00f00000-0x01000000 : "Firmware"
i2c-core.o: client [PCF8563] registered to adapter [PM520 I2C module #2=20
interfac
e](pos. 0).
RTC switching kernel pointers
rtc=5Frd(): i2c transfer error
rtc=5Frd(): i2c transfer error
rtc=5Frd(): i2c transfer error
rtc=5Frd(): i2c transfer error
rtc=5Frd(): i2c transfer error
rtc=5Frd(): i2c transfer error
rtc=5Frd(): i2c transfer error
Get RTC year: ff mon/cent: ff mday: ff wday: ff hr: ff min: ff sec: ff
rtc=5Frd(): i2c transfer error
rtc=5Frd(): i2c transfer error
rtc=5Frd(): i2c transfer error
rtc=5Frd(): i2c transfer error
Alarms: wday: ff day: ff hour: ff min: ff
PCF8563 RTC Low Voltage - date/time not reliable
get rtc [dec] year=3D2165 mon=3D25 day=3D45 hour=3D45 min=3D85 sec=3D85
Set System Time from RTC Time: 1925913489
RTC installed, minor 135
rtc=5Frd(): i2c transfer error
PCF8563 RTC Low Voltage - date/time not reliable
rtc=5Fwr(): i2c transfer error
rtc=5Fwr(): i2c transfer error
rtc=5Fwr(): i2c transfer error
rtc=5Frd(): i2c transfer error
rtc=5Fwr(): i2c transfer error
rtc=5Fwr(): i2c transfer error
rtc=5Fwr(): i2c transfer error
rtc=5Fwr(): i2c transfer error
rtc=5Fwr(): i2c transfer error
i2c-algo-5xxx.o: scanning bus PM520 I2C module #2 interface...
(0x00)(0x01)(0x02)(0x03)(0x04)(0x05)(0x06)(0x07)(0x08)(0x09)(0x0a)(0x0b)(0x=
0c)(0
x0d)(0x0e)(0x0f)(0x10)(0x11)(0x12)(0x13)(0x14)(0x15)(0x16)(0x17)(0x18)(0x19=
)(0x1
a)(0x1b)(0x1c)(0x1d)(0x1e)(0x1f)(0x20)(0x21)(0x22)(0x23)(0x24)(0x25)(0x26)(=
0x27)
(0x28)(0x29)(0x2a)(0x2b)(0x2c)(0x2d)(0x2e)(0x2f)(0x30)(0x31)(0x32)(0x33)(0x=
34)(0
x35)(0x36)(0x37)(0x38)(0x39)(0x3a)(0x3b)(0x3c)(0x3d)(0x3e)(0x3f)(0x40)(0x41=
)(0x4
2)(0x43)(0x44)(0x45)(0x46)(0x47)(0x48)(0x49)(0x4a)(0x4b)(0x4c)(0x4d)(0x4e)(=
0x4f)
(0x50)(0x51)(0x52)(0x53)(0x54)(0x55)(0x56)(0x57)(0x58)(0x59)(0x5a)(0x5b)(0x=
5c)(0
x5d)(0x5e)(0x5f)(0x60)(0x61)(0x62)(0x63)(0x64)(0x65)(0x66)(0x67)(0x68)(0x69=
)(0x6
a)(0x6b)(0x6c)(0x6d)(0x6e)(0x6f)(0x70)(0x71)(0x72)(0x73)(0x74)(0x75)(0x76)(=
0x77)
(0x78)(0x79)(0x7a)(0x7b)(0x7c)(0x7d)(0x7e)(0x7f)
i2c-pm520.o: I2C module #2 installed
NET4: Linux TCP/IP 1.0 for NET4.0
eth0: Phy @ 0x0, type DP83847 (0x20005c30)
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 4096)
eth0: config: auto-negotiation on, 100FDX, 100HDX, 10FDX, 10HDX.
eth0: Waiting for the link to be up...
eth0: status: link up, 100 Mbps Half Duplex.
IP-Config: Complete:
      device=3Deth0, addr=3D10.100.50.68, mask=3D255.255.0.0, gw=3D10.100.2=
54.254,
     host=3Dns4, domain=3D, nis-domain=3D(none),
     bootserver=3D10.100.1.30, rootserver=3D10.100.1.30, rootpath=3D
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 10.100.1.30
Looking up port of RPC 100005/1 on 10.100.1.30
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 76k init
INIT: version 2.84 booting

--=_alternative 00637C7400256F18_=
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable


<br><font size=3D2 face=3D"sans-serif">Hi</font>
<br>
<br><font size=3D2 face=3D"sans-serif">I am working on porting linux to a c=
ustom
board based on MPC5200, which has a PCF8563 real time clock connected via
i2c2=5Fio and i2c2=5Fclk pins.</font>
<br><font size=3D2 face=3D"sans-serif">It looks like this same combination
is used on the PM520 board.</font>
<br>
<br><font size=3D2 face=3D"sans-serif">I am using u-boot and it was a breeze
getting this combination to work in u-boot. &nbsp;I just added the right
CONFIG=5Fs and the u-boot date command worked</font>
<br><font size=3D2 face=3D"sans-serif">without any problems.</font>
<br>
<br><font size=3D2 face=3D"sans-serif">I am however having a more difficult
time getting the linux kernel (linuxppc=5F2=5F4=5Fdevel from Denx) to work =
with
PCF8563. &nbsp;I get errors from rtc=5Frd( ), but I</font>
<br><font size=3D2 face=3D"sans-serif">can't understand why. &nbsp;I have c=
ompared
the i2c clock signals between u-boot and linux and noticed that the clock
signal is different with linux. &nbsp; The third clock</font>
<br><font size=3D2 face=3D"sans-serif">pulse is much narrower than the othe=
rs,
whereas with u-boot the clock pulses are all even. &nbsp;But I can't figure
out why the i2c clock behaves differently with linux.</font>
<br><font size=3D2 face=3D"sans-serif">Attached is the console output.</fon=
t>
<br>
<br><font size=3D2 face=3D"sans-serif">Any thoughts ?</font>
<br>
<br>
<br><font size=3D2 face=3D"sans-serif">Thanks,</font>
<br><font size=3D2 face=3D"sans-serif">J=F3n Benediktsson</font>
<br><font size=3D2 face=3D"sans-serif">Marel hf.</font>
<br>
<br>
<br><font size=3D2 face=3D"sans-serif">Memory BAT mapping: BAT2=3D32Mb, BAT=
3=3D0Mb,
residual: 0Mb</font>
<br><font size=3D2 face=3D"sans-serif">Linux version 2.4.25 (jonb@tux.marel=
.is)
(gcc version 3.2.2 20030217 (Yellow Dog</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Linux 3.0 3.2.2-2a=5F1)) #46 F=
im
Sep 23 17:43:42 UTC 2004</font>
<br><font size=3D2 face=3D"sans-serif">On node 0 totalpages: 8192</font>
<br><font size=3D2 face=3D"sans-serif">zone(0): 8192 pages.</font>
<br><font size=3D2 face=3D"sans-serif">zone(1): 0 pages.</font>
<br><font size=3D2 face=3D"sans-serif">zone(2): 0 pages.</font>
<br><font size=3D2 face=3D"sans-serif">Kernel command line: root=3D/dev/nfs=
 rw
nfsroot=3D10.100.1.30:/opt/eldk/ppc=5F82xx ip=3D</font>
<br><font size=3D2 face=3D"sans-serif">10.100.50.68:10.100.1.30:10.100.254.=
254:255.255.0.0:ns4:eth0:off
panic=3D1</font>
<br><font size=3D2 face=3D"sans-serif">Calibrating delay loop (skipped)...
0.05 BogoMIPS</font>
<br><font size=3D2 face=3D"sans-serif">Memory: 29992k available (1348k kern=
el
code, 452k data, 76k init, 0k highmem)</font>
<br><font size=3D2 face=3D"sans-serif">Dentry cache hash table entries: 4096
(order: 3, 32768 bytes)</font>
<br><font size=3D2 face=3D"sans-serif">Inode cache hash table entries: 2048
(order: 2, 16384 bytes)</font>
<br><font size=3D2 face=3D"sans-serif">Mount cache hash table entries: 512
(order: 0, 4096 bytes)</font>
<br><font size=3D2 face=3D"sans-serif">Buffer cache hash table entries: 1024
(order: 0, 4096 bytes)</font>
<br><font size=3D2 face=3D"sans-serif">Page-cache hash table entries: 8192
(order: 3, 32768 bytes)</font>
<br><font size=3D2 face=3D"sans-serif">POSIX conformance testing by UNIFIX<=
/font>
<br><font size=3D2 face=3D"sans-serif">PCI: Probing PCI hardware</font>
<br><font size=3D2 face=3D"sans-serif">Linux NET4.0 for Linux 2.4</font>
<br><font size=3D2 face=3D"sans-serif">Based upon Swansea University Comput=
er
Society NET3.039</font>
<br><font size=3D2 face=3D"sans-serif">Initializing RT netlink socket</font>
<br><font size=3D2 face=3D"sans-serif">Starting kswapd</font>
<br><font size=3D2 face=3D"sans-serif">Journalled Block Device driver loade=
d</font>
<br><font size=3D2 face=3D"sans-serif">JFFS2 version 2.2. (C) 2001-2003 Red
Hat, Inc.</font>
<br><font size=3D2 face=3D"sans-serif">i2c-core.o: i2c core module version
2.6.1 (20010830)</font>
<br><font size=3D2 face=3D"sans-serif">i2c-dev.o: i2c /dev entries driver m=
odule
version 2.6.1 (20010830)</font>
<br><font size=3D2 face=3D"sans-serif">i2c-proc.o version 2.6.1 (20010830)<=
/font>
<br><font size=3D2 face=3D"sans-serif">pty: 256 Unix98 ptys configured</fon=
t>
<br><font size=3D2 face=3D"sans-serif">ttyS0 on PSC1</font>
<br><font size=3D2 face=3D"sans-serif">ttyS1 on PSC2</font>
<br><font size=3D2 face=3D"sans-serif">ttyS2 on PSC3</font>
<br><font size=3D2 face=3D"sans-serif">PCF8563 Real-Time Clock Driver $Revi=
sion:
1.3 $ wd@denx.de</font>
<br><font size=3D2 face=3D"sans-serif">RAMDISK driver initialized: 16 RAM d=
isks
of 4096K size 1024 blocksize</font>
<br><font size=3D2 face=3D"sans-serif">loop: loaded (max 8 devices)</font>
<br><font size=3D2 face=3D"sans-serif">Uniform Multi-Platform E-IDE driver
Revision: 7.00beta4-2.4</font>
<br><font size=3D2 face=3D"sans-serif">ide: Assuming 33MHz system bus speed
for PIO modes; override with idebus=3Dxx</font>
<br><font size=3D2 face=3D"sans-serif">Port Config is: 0x91050404</font>
<br><font size=3D2 face=3D"sans-serif">ipb=3D66MHz, set clock period to 15<=
/font>
<br><font size=3D2 face=3D"sans-serif">GPIO config: 91050404</font>
<br><font size=3D2 face=3D"sans-serif">ATA invalid: 00800000</font>
<br><font size=3D2 face=3D"sans-serif">ATA hostcnf: 03000000</font>
<br><font size=3D2 face=3D"sans-serif">ATA pio1 &nbsp; : 100a0a00</font>
<br><font size=3D2 face=3D"sans-serif">ATA pio2 &nbsp; : 02040600</font>
<br><font size=3D2 face=3D"sans-serif">XLB Arb cnf: 80002006</font>
<br><font size=3D2 face=3D"sans-serif">mpc5xxx=5Fide: Setting up IDE interf=
ace
ide0...</font>
<br><font size=3D2 face=3D"sans-serif">Probing IDE interface ide0...</font>
<br><font size=3D2 face=3D"sans-serif">hda: SAMSUNG CF/ATA, CFA DISK drive<=
/font>
<br><font size=3D2 face=3D"sans-serif">ide0 at 0xf0003a60-0xf0003a67,0xf000=
3a5c
on irq 45</font>
<br><font size=3D2 face=3D"sans-serif">hda: attached ide-disk driver.</font>
<br><font size=3D2 face=3D"sans-serif">hda: 507904 sectors (260 MB) w/1KiB
Cache, CHS=3D992/16/32</font>
<br><font size=3D2 face=3D"sans-serif">Partition check:</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp;hda: hda1 hda2 hda3 hda4</font>
<br><font size=3D2 face=3D"sans-serif">Icecube Bank 0: Found 1 x16 devices
at 0x0 in 8-bit mode</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Amd/Fujitsu Extended Query Tab=
le
at 0x0040</font>
<br><font size=3D2 face=3D"sans-serif">Icecube Bank 0: CFI does not contain
boot bank location. Assuming top.</font>
<br><font size=3D2 face=3D"sans-serif">number of CFI chips: 1</font>
<br><font size=3D2 face=3D"sans-serif">cfi=5Fcmdset=5F0002: Disabling erase=
-suspend-program
due to code brokenness.</font>
<br><font size=3D2 face=3D"sans-serif">Icecube flash bank 0: Using static i=
mage
partition definition</font>
<br><font size=3D2 face=3D"sans-serif">Creating 5 MTD partitions on &quot;I=
cecube
Bank 0&quot;:</font>
<br><font size=3D2 face=3D"sans-serif">0x00000000-0x00800000 : &quot;Spare&=
quot;</font>
<br><font size=3D2 face=3D"sans-serif">0x00800000-0x00900000 : &quot;kernel=
&quot;</font>
<br><font size=3D2 face=3D"sans-serif">0x00900000-0x00c00000 : &quot;initrd=
&quot;</font>
<br><font size=3D2 face=3D"sans-serif">0x00c00000-0x00f00000 : &quot;jffs&q=
uot;</font>
<br><font size=3D2 face=3D"sans-serif">0x00f00000-0x01000000 : &quot;Firmwa=
re&quot;</font>
<br><font size=3D2 face=3D"sans-serif">i2c-core.o: client [PCF8563] registe=
red
to adapter [PM520 I2C module #2 interfac</font>
<br><font size=3D2 face=3D"sans-serif">e](pos. 0).</font>
<br><font size=3D2 face=3D"sans-serif">RTC switching kernel pointers</font>
<br><font size=3D2 face=3D"sans-serif">rtc=5Frd(): i2c transfer error</font>
<br><font size=3D2 face=3D"sans-serif">rtc=5Frd(): i2c transfer error</font>
<br><font size=3D2 face=3D"sans-serif">rtc=5Frd(): i2c transfer error</font>
<br><font size=3D2 face=3D"sans-serif">rtc=5Frd(): i2c transfer error</font>
<br><font size=3D2 face=3D"sans-serif">rtc=5Frd(): i2c transfer error</font>
<br><font size=3D2 face=3D"sans-serif">rtc=5Frd(): i2c transfer error</font>
<br><font size=3D2 face=3D"sans-serif">rtc=5Frd(): i2c transfer error</font>
<br><font size=3D2 face=3D"sans-serif">Get RTC year: ff mon/cent: ff mday:
ff wday: ff hr: ff min: ff sec: ff</font>
<br><font size=3D2 face=3D"sans-serif">rtc=5Frd(): i2c transfer error</font>
<br><font size=3D2 face=3D"sans-serif">rtc=5Frd(): i2c transfer error</font>
<br><font size=3D2 face=3D"sans-serif">rtc=5Frd(): i2c transfer error</font>
<br><font size=3D2 face=3D"sans-serif">rtc=5Frd(): i2c transfer error</font>
<br><font size=3D2 face=3D"sans-serif">Alarms: wday: ff day: ff hour: ff mi=
n:
ff</font>
<br><font size=3D2 face=3D"sans-serif">PCF8563 RTC Low Voltage - date/time
not reliable</font>
<br><font size=3D2 face=3D"sans-serif">get rtc [dec] year=3D2165 mon=3D25 d=
ay=3D45
hour=3D45 min=3D85 sec=3D85</font>
<br><font size=3D2 face=3D"sans-serif">Set System Time from RTC Time: 19259=
13489</font>
<br><font size=3D2 face=3D"sans-serif">RTC installed, minor 135</font>
<br><font size=3D2 face=3D"sans-serif">rtc=5Frd(): i2c transfer error</font>
<br><font size=3D2 face=3D"sans-serif">PCF8563 RTC Low Voltage - date/time
not reliable</font>
<br><font size=3D2 face=3D"sans-serif">rtc=5Fwr(): i2c transfer error</font>
<br><font size=3D2 face=3D"sans-serif">rtc=5Fwr(): i2c transfer error</font>
<br><font size=3D2 face=3D"sans-serif">rtc=5Fwr(): i2c transfer error</font>
<br><font size=3D2 face=3D"sans-serif">rtc=5Frd(): i2c transfer error</font>
<br><font size=3D2 face=3D"sans-serif">rtc=5Fwr(): i2c transfer error</font>
<br><font size=3D2 face=3D"sans-serif">rtc=5Fwr(): i2c transfer error</font>
<br><font size=3D2 face=3D"sans-serif">rtc=5Fwr(): i2c transfer error</font>
<br><font size=3D2 face=3D"sans-serif">rtc=5Fwr(): i2c transfer error</font>
<br><font size=3D2 face=3D"sans-serif">rtc=5Fwr(): i2c transfer error</font>
<br><font size=3D2 face=3D"sans-serif">i2c-algo-5xxx.o: scanning bus PM520
I2C module #2 interface...</font>
<br><font size=3D2 face=3D"sans-serif">(0x00)(0x01)(0x02)(0x03)(0x04)(0x05)=
(0x06)(0x07)(0x08)(0x09)(0x0a)(0x0b)(0x0c)(0</font>
<br><font size=3D2 face=3D"sans-serif">x0d)(0x0e)(0x0f)(0x10)(0x11)(0x12)(0=
x13)(0x14)(0x15)(0x16)(0x17)(0x18)(0x19)(0x1</font>
<br><font size=3D2 face=3D"sans-serif">a)(0x1b)(0x1c)(0x1d)(0x1e)(0x1f)(0x2=
0)(0x21)(0x22)(0x23)(0x24)(0x25)(0x26)(0x27)</font>
<br><font size=3D2 face=3D"sans-serif">(0x28)(0x29)(0x2a)(0x2b)(0x2c)(0x2d)=
(0x2e)(0x2f)(0x30)(0x31)(0x32)(0x33)(0x34)(0</font>
<br><font size=3D2 face=3D"sans-serif">x35)(0x36)(0x37)(0x38)(0x39)(0x3a)(0=
x3b)(0x3c)(0x3d)(0x3e)(0x3f)(0x40)(0x41)(0x4</font>
<br><font size=3D2 face=3D"sans-serif">2)(0x43)(0x44)(0x45)(0x46)(0x47)(0x4=
8)(0x49)(0x4a)(0x4b)(0x4c)(0x4d)(0x4e)(0x4f)</font>
<br><font size=3D2 face=3D"sans-serif">(0x50)(0x51)(0x52)(0x53)(0x54)(0x55)=
(0x56)(0x57)(0x58)(0x59)(0x5a)(0x5b)(0x5c)(0</font>
<br><font size=3D2 face=3D"sans-serif">x5d)(0x5e)(0x5f)(0x60)(0x61)(0x62)(0=
x63)(0x64)(0x65)(0x66)(0x67)(0x68)(0x69)(0x6</font>
<br><font size=3D2 face=3D"sans-serif">a)(0x6b)(0x6c)(0x6d)(0x6e)(0x6f)(0x7=
0)(0x71)(0x72)(0x73)(0x74)(0x75)(0x76)(0x77)</font>
<br><font size=3D2 face=3D"sans-serif">(0x78)(0x79)(0x7a)(0x7b)(0x7c)(0x7d)=
(0x7e)(0x7f)</font>
<br><font size=3D2 face=3D"sans-serif">i2c-pm520.o: I2C module #2 installed=
</font>
<br><font size=3D2 face=3D"sans-serif">NET4: Linux TCP/IP 1.0 for NET4.0</f=
ont>
<br><font size=3D2 face=3D"sans-serif">eth0: Phy @ 0x0, type DP83847 (0x200=
05c30)</font>
<br><font size=3D2 face=3D"sans-serif">IP Protocols: ICMP, UDP, TCP, IGMP</=
font>
<br><font size=3D2 face=3D"sans-serif">IP: routing cache hash table of 512
buckets, 4Kbytes</font>
<br><font size=3D2 face=3D"sans-serif">TCP: Hash tables configured (establi=
shed
2048 bind 4096)</font>
<br><font size=3D2 face=3D"sans-serif">eth0: config: auto-negotiation on, 1=
00FDX,
100HDX, 10FDX, 10HDX.</font>
<br><font size=3D2 face=3D"sans-serif">eth0: Waiting for the link to be up.=
..</font>
<br><font size=3D2 face=3D"sans-serif">eth0: status: link up, 100 Mbps Half
Duplex.</font>
<br><font size=3D2 face=3D"sans-serif">IP-Config: Complete:</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; device=3Deth0, =
addr=3D10.100.50.68,
mask=3D255.255.0.0, gw=3D10.100.254.254,</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; &nbsp;host=3Dns4, doma=
in=3D,
nis-domain=3D(none),</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; &nbsp;bootserver=3D10.=
100.1.30,
rootserver=3D10.100.1.30, rootpath=3D</font>
<br><font size=3D2 face=3D"sans-serif">NET4: Unix domain sockets 1.0/SMP for
Linux NET4.0.</font>
<br><font size=3D2 face=3D"sans-serif">Looking up port of RPC 100003/2 on 1=
0.100.1.30</font>
<br><font size=3D2 face=3D"sans-serif">Looking up port of RPC 100005/1 on 1=
0.100.1.30</font>
<br><font size=3D2 face=3D"sans-serif">VFS: Mounted root (nfs filesystem).<=
/font>
<br><font size=3D2 face=3D"sans-serif">Freeing unused kernel memory: 76k in=
it</font>
<br><font size=3D2 face=3D"sans-serif">INIT: version 2.84 booting</font>
<br>
--=_alternative 00637C7400256F18_=--
