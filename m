Return-Path: <Lixin.Yao@HSTX.com>
Received: from mail2.HSTX.com (mail2.hstx.com [64.95.133.110])
	by ozlabs.org (Postfix) with ESMTP id F2252DE1CD
	for <linuxppc-dev@ozlabs.org>; Sat, 31 Jan 2009 09:37:19 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C98329.567B5148"
Subject: Can not get PATA to work for Compact Flash with 2.6.28 kernel
Date: Fri, 30 Jan 2009 14:23:12 -0800
Message-ID: <03D77CA4AC7F4D48A6AB5DA3F1001B3F10A4B2@exchtxus2.HSTX.global.vpn>
From: "Lixin Yao" <Lixin.Yao@HSTX.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C98329.567B5148
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I use a San Disk compact flash (CF) card on a board with MPC8248
processor. The CF is connected to data and address bus of the processor
and operates in TRUE IDE mode. The registers are memory mapped. I can
read the file system on the CF in u-boot (1.3.4). U-boot can identify
the CF and mount file system correctly.

The hardware is known good hardware.

I use 2.6.28 kernel and configured support for PATA for the CF.

Here is the setup in DTS file:

localbus@f0010100 {
#address-cells =3D <2>;
#size-cells =3D <1>;
compatible =3D "fsl,mpc8248-localbus",
"fsl,pq2-localbus",
"simple-bus";
reg =3D <0xf0010100 0x40>;
ranges =3D <0x3 0x0 0x30000000 0x10000
0x4 0x0 0x40000000 0x10000>;

pata@3,0 {
compatible =3D "fsl,tr5000v2-pata", "ata-generic";
reg =3D <0x3 0x0 0x10 0x4 0x0 0x10>;
reg-shift =3D <1>;
pio-mode =3D <3>;
// interrupts =3D <23 0x8>;
// interrupt-parent =3D <&PIC>;
};
};


Here are some of the related CONFIG items:
#
# UBI - Unsorted block images
#
# CONFIG_MTD_UBI is not set
CONFIG_OF_DEVICE=3Dy
CONFIG_OF_I2C=3Dy
CONFIG_OF_SPI=3Dy
CONFIG_OF_GPIO=3Dy
# CONFIG_PARPORT is not set
CONFIG_BLK_DEV=3Dy
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=3Dy
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_RAM=3Dy
CONFIG_BLK_DEV_RAM_COUNT=3D16
CONFIG_BLK_DEV_RAM_SIZE=3D4096
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_BLK_DEV_HD is not set
# CONFIG_MISC_DEVICES is not set
#CONFIG_HAVE_IDE=3Dy
#CONFIG_IDE=3Dy

#
# SCSI device support
#
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=3Dy
# CONFIG_SCSI_DMA is not set
# CONFIG_SCSI_NETLINK is not set
CONFIG_SCSI_PROC_FS=3Dy
CONFIG_ATA=3Dy
CONFIG_ATA_SFF=3Dy
CONFIG_PATA_PLATFORM=3Dy
CONFIG_PATA_OF_PLATFORM=3Dy

Here is the output at console:

Kernel command line: console=3DttyCPM0,38400 root=3D/dev/nfs rw
nfsroot=3D10.15.34.196
:/home/lyao01/work/target_idu_nccv3
ip=3D172.20.16.150:10.15.34.196:172.20.16.1:25
5.255.255.0:tr5000v2:eth0ff
......
NET: Registered protocol family 16
SCSI subsystem initialized
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 2048 (order: 2, 16384 bytes)
TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
TCP: Hash tables configured (established 2048 bind 2048)
TCP reno registered
NET: Registered protocol family 1
NTFS driver 2.1.29 [Flags: R/O].
msgmni has been set to 119
alg: No test for stdrng (krng)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered (default)
f0011a80.serial: ttyCPM0 at MMIO 0xc500ea80 (irq =3D 16) is a CPM UART
brd: module loaded
loop: module loaded
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
eth0: fs_enet: 00:00:c3:ff:7a:af
CPM2 Bitbanged MII: probed
ata_host_alloc: ENTER
ata_port_alloc: ENTER
__ata_port_freeze: ata4294967295 port frozen
scsi0 : pata_platform
ata1: PATA max PIO3 no IRQ, using PIO polling mmio cmd 0x30000000 ctl
0x40000000
ata_host_register: probe begin
ata_port_schedule_eh: port EH scheduled
ata_scsi_error: ENTER
ata_port_flush_task: ENTER
ata_eh_link_autopsy: ENTER
ata_eh_recover: ENTER
__ata_port_freeze: ata1 port frozen
ata_sff_softreset: ENTER
ata_sff_softreset: about to softreset, devmask=3D0
ata_bus_softreset: ata1: bus reset via SRST
ata_sff_softreset: EXIT, classes[0]=3D9 [1]=3D9
ata_eh_thaw_port: ata1 port thawed
ata_std_postreset: ENTER
ata_std_postreset: EXIT
ata_sff_postreset: EXIT, no device
ata_eh_revalidate_and_attach: ENTER
ata_eh_recover: EXIT, rc=3D0
ata_scsi_error: EXIT
ata_host_register: host probe begin
TCP cubic registered
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
ics1893_config_init() successful
ADDRCONF(NETDEV_UP): eth0: link is not ready
ics1893_config_init() successful
IP-Config: Complete:
device=3Deth0, addr=3D172.20.16.150, mask=3D255.255.255.0, =
gw=3D172.20.16.1,
host=3Dtr5000v2, domain=3D, nis-domain=3D(none),
bootserver=3D10.15.34.196, rootserver=3D10.15.34.196, rootpath=3D
Looking up port of RPC 100003/2 on 10.15.34.196
ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
Looking up port of RPC 100005/1 on 10.15.34.196
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 164k init
### Application running ...
#


The San Disk Compact Flash is not discovered.

I appreciate any insights or suggestions.

Lixin Yao
Harris Stratex Networks Inc
RTP, North Carolina, USA


------_=_NextPart_001_01C98329.567B5148
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7651.59">
<TITLE> Can not get PATA to work for Compact Flash with 2.6.28 =
kernel</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Arial">I use a San Disk compact flash (CF) =
card on a board with MPC8248 processor. The CF is connected to data and =
address bus of the processor and operates in TRUE IDE mode. The =
registers are memory mapped. I can read the file system on the CF in =
u-boot (1.3.4). U-boot can identify the CF and mount file system =
correctly.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">The hardware is known good =
hardware.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I use 2.6.28 kernel and configured =
support for PATA for the CF.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Here is the setup in DTS file:</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">localbus@f0010100 {</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">#address-cells =3D &lt;2&gt;;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">#size-cells =3D &lt;1&gt;;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">compatible =3D =
&quot;fsl,mpc8248-localbus&quot;,</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&quot;fsl,pq2-localbus&quot;,</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&quot;simple-bus&quot;;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">reg =3D &lt;0xf0010100 =
0x40&gt;;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">ranges =3D &lt;0x3 0x0 0x30000000 =
0x10000</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">0x4 0x0 0x40000000 0x10000&gt;;</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">pata@3,0 {</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">compatible =3D =
&quot;fsl,tr5000v2-pata&quot;, &quot;ata-generic&quot;;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">reg =3D &lt;0x3 0x0 0x10 0x4 0x0 =
0x10&gt;;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">reg-shift =3D &lt;1&gt;;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">pio-mode =3D &lt;3&gt;;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">// interrupts =3D &lt;23 =
0x8&gt;;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">// interrupt-parent =3D =
&lt;&amp;PIC&gt;;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">};</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">};</FONT>
</P>
<BR>

<P><FONT SIZE=3D2 FACE=3D"Arial">Here are some of the related CONFIG =
items:</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">#</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial"># UBI - Unsorted block images</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">#</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial"># CONFIG_MTD_UBI is not set</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">CONFIG_OF_DEVICE=3Dy</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">CONFIG_OF_I2C=3Dy</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">CONFIG_OF_SPI=3Dy</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">CONFIG_OF_GPIO=3Dy</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial"># CONFIG_PARPORT is not set</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">CONFIG_BLK_DEV=3Dy</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial"># CONFIG_BLK_DEV_FD is not set</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial"># CONFIG_BLK_CPQ_DA is not set</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial"># CONFIG_BLK_CPQ_CISS_DA is not =
set</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial"># CONFIG_BLK_DEV_DAC960 is not =
set</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial"># CONFIG_BLK_DEV_COW_COMMON is not =
set</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">CONFIG_BLK_DEV_LOOP=3Dy</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial"># CONFIG_BLK_DEV_CRYPTOLOOP is not =
set</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial"># CONFIG_BLK_DEV_NBD is not set</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial"># CONFIG_BLK_DEV_SX8 is not set</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">CONFIG_BLK_DEV_RAM=3Dy</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">CONFIG_BLK_DEV_RAM_COUNT=3D16</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">CONFIG_BLK_DEV_RAM_SIZE=3D4096</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial"># CONFIG_CDROM_PKTCDVD is not =
set</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial"># CONFIG_ATA_OVER_ETH is not =
set</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial"># CONFIG_BLK_DEV_HD is not set</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial"># CONFIG_MISC_DEVICES is not =
set</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">#CONFIG_HAVE_IDE=3Dy</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">#CONFIG_IDE=3Dy</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">#</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial"># SCSI device support</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">#</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial"># CONFIG_RAID_ATTRS is not set</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">CONFIG_SCSI=3Dy</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial"># CONFIG_SCSI_DMA is not set</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial"># CONFIG_SCSI_NETLINK is not =
set</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">CONFIG_SCSI_PROC_FS=3Dy</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">CONFIG_ATA=3Dy</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">CONFIG_ATA_SFF=3Dy</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">CONFIG_PATA_PLATFORM=3Dy</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">CONFIG_PATA_OF_PLATFORM=3Dy</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Here is the output at console:</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Kernel command line: =
console=3DttyCPM0,38400 root=3D/dev/nfs rw nfsroot=3D10.15.34.196</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">:/home/lyao01/work/target_idu_nccv3 =
ip=3D172.20.16.150:10.15.34.196:172.20.16.1:25</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">5.255.255.0:tr5000v2:eth0ff</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">......</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">NET: Registered protocol family =
16</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">SCSI subsystem initialized</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">NET: Registered protocol family =
2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">IP route cache hash table entries: =
1024 (order: 0, 4096 bytes)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">TCP established hash table entries: =
2048 (order: 2, 16384 bytes)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">TCP bind hash table entries: 2048 =
(order: 1, 8192 bytes)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">TCP: Hash tables configured =
(established 2048 bind 2048)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">TCP reno registered</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">NET: Registered protocol family =
1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">NTFS driver 2.1.29 [Flags: =
R/O].</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">msgmni has been set to 119</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">alg: No test for stdrng (krng)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">io scheduler noop registered</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">io scheduler anticipatory =
registered</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">io scheduler deadline registered =
(default)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">f0011a80.serial: ttyCPM0 at MMIO =
0xc500ea80 (irq =3D 16) is a CPM UART</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">brd: module loaded</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">loop: module loaded</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">PPP generic driver version =
2.4.2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">PPP Deflate Compression module =
registered</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">eth0: fs_enet: =
00:00:c3:ff:7a:af</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">CPM2 Bitbanged MII: probed</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">ata_host_alloc: ENTER</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">ata_port_alloc: ENTER</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">__ata_port_freeze: ata4294967295 port =
frozen</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">scsi0 : pata_platform</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">ata1: PATA max PIO3 no IRQ, using PIO =
polling mmio cmd 0x30000000 ctl 0x40000000</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">ata_host_register: probe begin</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">ata_port_schedule_eh: port EH =
scheduled</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">ata_scsi_error: ENTER</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">ata_port_flush_task: ENTER</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">ata_eh_link_autopsy: ENTER</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">ata_eh_recover: ENTER</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">__ata_port_freeze: ata1 port =
frozen</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">ata_sff_softreset: ENTER</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">ata_sff_softreset: about to softreset, =
devmask=3D0</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">ata_bus_softreset: ata1: bus reset via =
SRST</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">ata_sff_softreset: EXIT, =
classes[0]=3D9 [1]=3D9</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">ata_eh_thaw_port: ata1 port =
thawed</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">ata_std_postreset: ENTER</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">ata_std_postreset: EXIT</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">ata_sff_postreset: EXIT, no =
device</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">ata_eh_revalidate_and_attach: =
ENTER</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">ata_eh_recover: EXIT, rc=3D0</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">ata_scsi_error: EXIT</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">ata_host_register: host probe =
begin</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">TCP cubic registered</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">NET: Registered protocol family =
10</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">IPv6 over IPv4 tunneling driver</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">NET: Registered protocol family =
17</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RPC: Registered udp transport =
module.</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RPC: Registered tcp transport =
module.</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">ics1893_config_init() =
successful</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">ADDRCONF(NETDEV_UP): eth0: link is not =
ready</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">ics1893_config_init() =
successful</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">IP-Config: Complete:</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">device=3Deth0, addr=3D172.20.16.150, =
mask=3D255.255.255.0, gw=3D172.20.16.1,</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">host=3Dtr5000v2, domain=3D, =
nis-domain=3D(none),</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">bootserver=3D10.15.34.196, =
rootserver=3D10.15.34.196, rootpath=3D</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Looking up port of RPC 100003/2 on =
10.15.34.196</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">ADDRCONF(NETDEV_CHANGE): eth0: link =
becomes ready</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Looking up port of RPC 100005/1 on =
10.15.34.196</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">VFS: Mounted root (nfs =
filesystem).</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Freeing unused kernel memory: 164k =
init</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">### Application running ...</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">#</FONT>
</P>
<BR>

<P><FONT SIZE=3D2 FACE=3D"Arial">The San Disk Compact Flash is not =
discovered.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I appreciate any insights or =
suggestions.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Lixin Yao</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Harris Stratex Networks Inc</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTP, North Carolina, USA</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C98329.567B5148--
