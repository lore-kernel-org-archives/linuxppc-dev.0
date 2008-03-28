Return-Path: <wzc0066@yahoo.com.cn>
Received: from web15205.mail.cnb.yahoo.com (web15205.mail.cnb.yahoo.com
	[202.165.105.135]) by ozlabs.org (Postfix) with SMTP id 9F36ADDE03
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2008 18:20:09 +1100 (EST)
Date: Fri, 28 Mar 2008 15:13:27 +0800 (CST)
From: zechao wang <wzc0066@yahoo.com.cn>
Subject: Booting the board using NFS on AMCC PPC 405EP
To: linuxppc devel <linuxppc-dev@ozlabs.org>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1516960893-1206688407=:21903"
Message-ID: <413023.21903.qm@web15205.mail.cnb.yahoo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--0-1516960893-1206688407=:21903
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 8bit

Hello Everyone :

I'm failed when booting the board using NFS on AMCC PPC 405EP.
I think i have read the getting started guide carefully!
The tftp server and nfs server can works well. 
And the firewall was disabled, too.

My env was set as below:
---------------------------------------------------------
=> printenv
baudrate=115200
loads_echo=1
preboot=echo;echo You are welcom!;echo;
netdev=eth0
hostname=IOStation
addip=setenv bootargs $(bootargs) ip=$(ipaddr):$(serverip):$(gatewayip):$(netmask):$(hostname):$(netdev):off panic=1
addtty=setenv bootargs $(bootargs) console=ttyS0,$(baudrate)
flash_nfs=run nfsargs addip addtty;bootm $(kernel_addr)
nfs_boot=tftp $(kernel_addr) $(bootfile);run flash_nfs
bootfile=uImage
kernel_addr=200000
ethaddr=00:01:02:03:04:87
bootargs=console=ttyS0,115200
cleanenv=protect off fffa0000 fffbffff;erase fffa0000 fffbffff
upuboot=tftp 100000 u-boot.bin;protect off fffc0000 ffffffff;era fffc0000 ffffffff;cp.b 100000 fffc0000 40000
burnKernel=tftp 200000 uImage;nand erase 0 200000;nand write.jffs2 ${fileaddr} 0 ${filesize}
burnInitrd=tftp 200000 uInitrd;nand erase 200000 80000;nand write.jffs2 ${fileaddr} 200000 ${filesize}
burnCramfs=tftp 200000 cramfs.img;nand erase 280000 1580000;nand write.jffs2 ${fileaddr} 280000 ${filesize}
burnJffs2=tftp 200000 jffs2.img;nand erase 1800000 500000;nand write.jffs2 ${fileaddr} 1800000 ${filesize}
burnFirmware=run burnKernel;run burnInitrd;run burnCramfs;run burnJffs2
flashboot=setenv bootargs console=ttyS0,115200;nand read.jffs2 200000 0 200000;nand read.jffs2 400000 200000 80000;bootm 200000 400000
ethact=VT6122
bootcmd=run nfs_boot
bootdelay=10
filesize=10930b
fileaddr=100000
gatewayip=192.168.1.1
ipaddr=192.168.1.120
serverip=192.168.1.142
rootpath=/opt/eldk/ppc_4xx
nfsargs=setenv bootargs root=/dev/nfs rw nfsroot=$(serverip):$(rootpath)
stdin=serial
stdout=serial
stderr=serial
ver=U-Boot 1.2.0 (Jan 26 2008 - 18:50:29)

Environment size: 1600/65532 bytes
---------------------------------------------------------

And the whole log is:
---------------------------------------------------------
U-Boot 1.2.0 (Jan 26 2008 - 18:50:29)

CPU:   AMCC PowerPC 405EP Rev. B at 266.666 MHz (PLB=133, OPB=66, EBC=66 MHz)
       I2C boot EEPROM disabled
       Internal PCI arbiter enabled
       16 kB I-Cache 16 kB D-Cache
Board: Bubinga - AMCC PPC405EP Evaluation Board
I2C:   ready
DRAM:  64 MB
FLASH: 512 kB
NAND:  64 MiB
In:    serial
Out:   serial
Err:   serial
Net:   VT6122

You are welcom!

Hit any key to stop autoboot:  0
Link autonegation speed 100M bps full duplex
Using VT6122 device
TFTP from server 192.168.1.142; our IP address is 192.168.1.120
Filename 'uImage'.
Load address: 0x200000
Loading: #################################################################
         #################################################################
         #################################################################
         ##################
done
Bytes transferred = 1086219 (10930b hex)
Checking ...
Check1. Check2. ## Booting image at 00200000 ...
   Image Name:   Linux-2.6.19.2
   Created:      2008-03-25  11:15:51 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1086155 Bytes =  1 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Linux version 2.6.19.2 (zwang@wzc) (gcc version 4.0.0 (DENX ELDK 4.1 4.0.0)) #6 Tue Mar 25 19:15:48 CST 2008
IBM Bubinga port (MontaVista Software, Inc. <source@mvista.com>)
Zone PFN ranges:
  DMA             0 ->    16384
  Normal      16384 ->    16384
early_node_map[1] active PFN ranges
    0:        0 ->    16384
Built 1 zonelists.  Total pages: 16256
Kernel command line: root=/dev/nfs rw nfsroot=192.168.1.142:/opt/eldk/ppc_4xx ip=192.168.1.120:192.168.1.142:192.168.1.1::IOStation:eth0:off p0PID hash table entries: 256 (order: 8, 1024 bytes)
Warning: real time clock seems stuck!
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 62592k available (1764k kernel code, 428k data, 132k init, 0k highmem)
Mount-cache hash table entries: 512
NET: Registered protocol family 16
PCI: Probing PCI hardware
NET: Registered protocol family 2
IP route cache hash table entries: 512 (order: -1, 2048 bytes)
TCP established hash table entries: 2048 (order: 1, 8192 bytes)
TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
TCP: Hash tables configured (established 2048 bind 1024)
TCP reno registered
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Generic RTC Driver v1.07
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at MMIO 0x0 (irq = 0) is a 16550A
serial8250: ttyS1 at MMIO 0x0 (irq = 1) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
VIA Networking Velocity Family Gigabit Ethernet Adapter Driver Ver. 1.14
Copyright (c) 2002, 2003 VIA Networking Technologies, Inc.
Copyright (c) 2004 Red Hat Inc.
eth0: VIA Networking Velocity Family Gigabit Ethernet Adapter
eth0: Ethernet Address: 00:01:02:03:04:87
Found: AMD AM29LV040B
PPC40x-flash: Found 1 x8 devices at 0x0 in 8-bit bank
number of JEDEC chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
Creating 3 MTD partitions on "PPC40x-flash":
0x00000000-0x00020000 : "reserved"
0x00020000-0x00040000 : "env"
0x00040000-0x00080000 : "u-boot"
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
Velocity is AUTO mode
IP-Config: Guessing netmask 255.255.255.0
IP-Config: Complete:
      device=eth0, addr=192.168.1.120, mask=255.255.255.0, gw=192.168.1.1,
     host=IOStation, domain=, nis-domain=(none),
     bootserver=192.168.1.142, rootserver=192.168.1.142, rootpath=
Looking up port of RPC 100003/2 on 192.168.1.142
eth0: Link autonegation speed 100M bps full duplex
TD structure errror TDindex=0
portmap: server 192.168.1.142 not responding, timed out
Root-NFS: Unable to get nfsd port number from server, using default
Looking up port of RPC 100005/1 on 192.168.1.142
portmap: server 192.168.1.142 not responding, timed out
Root-NFS: Unable to get mountd port number from server, using default
mount: server 192.168.1.142 not responding, timed out
Root-NFS: Server returned error -5 while mounting /opt/eldk/ppc_4xx
VFS: Unable to mount root fs via NFS, trying floppy.
VFS: Cannot open root device "nfs" or unknown-block(2,0)
Please append a correct "root=" boot option
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(2,0)
 <0>Rebooting in 1 seconds..<NULL>
System Halted
---------------------------------------------------------

Could anyone give me some advice ? Thank you very much.



       
---------------------------------
 —≈ª¢” œ‰£¨ƒ˙µƒ÷’…˙” œ‰£°
--0-1516960893-1206688407=:21903
Content-Type: text/html; charset=gb2312
Content-Transfer-Encoding: 8bit

Hello Everyone :<br><br>I'm failed when booting the board using NFS on AMCC PPC 405EP.<br>I think i have read the getting started guide carefully!<br>The tftp server and nfs server can works well. <br>And the firewall was disabled, too.<br><br>My env was set as below:<br>---------------------------------------------------------<br>=&gt; printenv<br>baudrate=115200<br>loads_echo=1<br>preboot=echo;echo You are welcom!;echo;<br>netdev=eth0<br>hostname=IOStation<br>addip=setenv bootargs $(bootargs) ip=$(ipaddr):$(serverip):$(gatewayip):$(netmask):$(hostname):$(netdev):off panic=1<br>addtty=setenv bootargs $(bootargs) console=ttyS0,$(baudrate)<br>flash_nfs=run nfsargs addip addtty;bootm $(kernel_addr)<br>nfs_boot=tftp $(kernel_addr) $(bootfile);run flash_nfs<br>bootfile=uImage<br>kernel_addr=200000<br>ethaddr=00:01:02:03:04:87<br>bootargs=console=ttyS0,115200<br>cleanenv=protect off fffa0000 fffbffff;erase fffa0000 fffbffff<br>upuboot=tftp 100000 u-boot.bin;protect off fffc0000
 ffffffff;era fffc0000 ffffffff;cp.b 100000 fffc0000 40000<br>burnKernel=tftp 200000 uImage;nand erase 0 200000;nand write.jffs2 ${fileaddr} 0 ${filesize}<br>burnInitrd=tftp 200000 uInitrd;nand erase 200000 80000;nand write.jffs2 ${fileaddr} 200000 ${filesize}<br>burnCramfs=tftp 200000 cramfs.img;nand erase 280000 1580000;nand write.jffs2 ${fileaddr} 280000 ${filesize}<br>burnJffs2=tftp 200000 jffs2.img;nand erase 1800000 500000;nand write.jffs2 ${fileaddr} 1800000 ${filesize}<br>burnFirmware=run burnKernel;run burnInitrd;run burnCramfs;run burnJffs2<br>flashboot=setenv bootargs console=ttyS0,115200;nand read.jffs2 200000 0 200000;nand read.jffs2 400000 200000 80000;bootm 200000 400000<br>ethact=VT6122<br>bootcmd=run nfs_boot<br>bootdelay=10<br>filesize=10930b<br>fileaddr=100000<br>gatewayip=192.168.1.1<br>ipaddr=192.168.1.120<br>serverip=192.168.1.142<br>rootpath=/opt/eldk/ppc_4xx<br>nfsargs=setenv bootargs root=/dev/nfs rw
 nfsroot=$(serverip):$(rootpath)<br>stdin=serial<br>stdout=serial<br>stderr=serial<br>ver=U-Boot 1.2.0 (Jan 26 2008 - 18:50:29)<br><br>Environment size: 1600/65532 bytes<br>---------------------------------------------------------<br><br>And the whole log is:<br>---------------------------------------------------------<br>U-Boot 1.2.0 (Jan 26 2008 - 18:50:29)<br><br>CPU:&nbsp;&nbsp; AMCC PowerPC 405EP Rev. B at 266.666 MHz (PLB=133, OPB=66, EBC=66 MHz)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I2C boot EEPROM disabled<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Internal PCI arbiter enabled<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 16 kB I-Cache 16 kB D-Cache<br>Board: Bubinga - AMCC PPC405EP Evaluation Board<br>I2C:&nbsp;&nbsp; ready<br>DRAM:&nbsp; 64 MB<br>FLASH: 512 kB<br>NAND:&nbsp; 64 MiB<br>In:&nbsp;&nbsp;&nbsp; serial<br>Out:&nbsp;&nbsp; serial<br>Err:&nbsp;&nbsp; serial<br>Net:&nbsp;&nbsp; VT6122<br><br>You are welcom!<br><br>Hit any key to stop autoboot:&nbsp; 0<br>Link
 autonegation speed 100M bps full duplex<br>Using VT6122 device<br>TFTP from server 192.168.1.142; our IP address is 192.168.1.120<br>Filename 'uImage'.<br>Load address: 0x200000<br>Loading: #################################################################<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #################################################################<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #################################################################<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ##################<br>done<br>Bytes transferred = 1086219 (10930b hex)<br>Checking ...<br>Check1. Check2. ## Booting image at 00200000 ...<br>&nbsp;&nbsp; Image Name:&nbsp;&nbsp; Linux-2.6.19.2<br>&nbsp;&nbsp; Created:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2008-03-25&nbsp; 11:15:51 UTC<br>&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux Kernel Image (gzip compressed)<br>&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 1086155 Bytes =&nbsp; 1
 MB<br>&nbsp;&nbsp; Load Address: 00000000<br>&nbsp;&nbsp; Entry Point:&nbsp; 00000000<br>&nbsp;&nbsp; Verifying Checksum ... OK<br>&nbsp;&nbsp; Uncompressing Kernel Image ... OK<br>Linux version 2.6.19.2 (zwang@wzc) (gcc version 4.0.0 (DENX ELDK 4.1 4.0.0)) #6 Tue Mar 25 19:15:48 CST 2008<br>IBM Bubinga port (MontaVista Software, Inc. &lt;source@mvista.com&gt;)<br>Zone PFN ranges:<br>&nbsp; DMA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 -&gt;&nbsp;&nbsp;&nbsp; 16384<br>&nbsp; Normal&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 16384 -&gt;&nbsp;&nbsp;&nbsp; 16384<br>early_node_map[1] active PFN ranges<br>&nbsp;&nbsp;&nbsp; 0:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 -&gt;&nbsp;&nbsp;&nbsp; 16384<br>Built 1 zonelists.&nbsp; Total pages: 16256<br>Kernel command line: root=/dev/nfs rw nfsroot=192.168.1.142:/opt/eldk/ppc_4xx ip=192.168.1.120:192.168.1.142:192.168.1.1::IOStation:eth0:off p0PID hash table entries: 256 (order: 8, 1024 bytes)<br>Warning: real
 time clock seems stuck!<br>Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)<br>Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)<br>Memory: 62592k available (1764k kernel code, 428k data, 132k init, 0k highmem)<br>Mount-cache hash table entries: 512<br>NET: Registered protocol family 16<br>PCI: Probing PCI hardware<br>NET: Registered protocol family 2<br>IP route cache hash table entries: 512 (order: -1, 2048 bytes)<br>TCP established hash table entries: 2048 (order: 1, 8192 bytes)<br>TCP bind hash table entries: 1024 (order: 0, 4096 bytes)<br>TCP: Hash tables configured (established 2048 bind 1024)<br>TCP reno registered<br>io scheduler noop registered<br>io scheduler anticipatory registered (default)<br>io scheduler deadline registered<br>io scheduler cfq registered<br>Generic RTC Driver v1.07<br>Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled<br>serial8250: ttyS0 at MMIO 0x0 (irq = 0) is a 16550A<br>serial8250: ttyS1 at
 MMIO 0x0 (irq = 1) is a 16550A<br>RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize<br>loop: loaded (max 8 devices)<br>VIA Networking Velocity Family Gigabit Ethernet Adapter Driver Ver. 1.14<br>Copyright (c) 2002, 2003 VIA Networking Technologies, Inc.<br>Copyright (c) 2004 Red Hat Inc.<br>eth0: VIA Networking Velocity Family Gigabit Ethernet Adapter<br>eth0: Ethernet Address: 00:01:02:03:04:87<br>Found: AMD AM29LV040B<br>PPC40x-flash: Found 1 x8 devices at 0x0 in 8-bit bank<br>number of JEDEC chips: 1<br>cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.<br>Creating 3 MTD partitions on "PPC40x-flash":<br>0x00000000-0x00020000 : "reserved"<br>0x00020000-0x00040000 : "env"<br>0x00040000-0x00080000 : "u-boot"<br>TCP cubic registered<br>NET: Registered protocol family 1<br>NET: Registered protocol family 17<br>NET: Registered protocol family 15<br>Velocity is AUTO mode<br>IP-Config: Guessing netmask 255.255.255.0<br>IP-Config:
 Complete:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device=eth0, addr=192.168.1.120, mask=255.255.255.0, gw=192.168.1.1,<br>&nbsp;&nbsp;&nbsp;&nbsp; host=IOStation, domain=, nis-domain=(none),<br>&nbsp;&nbsp;&nbsp;&nbsp; bootserver=192.168.1.142, rootserver=192.168.1.142, rootpath=<br>Looking up port of RPC 100003/2 on 192.168.1.142<br>eth0: Link autonegation speed 100M bps full duplex<br>TD structure errror TDindex=0<br>portmap: server 192.168.1.142 not responding, timed out<br>Root-NFS: Unable to get nfsd port number from server, using default<br>Looking up port of RPC 100005/1 on 192.168.1.142<br>portmap: server 192.168.1.142 not responding, timed out<br>Root-NFS: Unable to get mountd port number from server, using default<br>mount: server 192.168.1.142 not responding, timed out<br>Root-NFS: Server returned error -5 while mounting /opt/eldk/ppc_4xx<br>VFS: Unable to mount root fs via NFS, trying floppy.<br>VFS: Cannot open root device "nfs" or unknown-block(2,0)<br>Please
 append a correct "root=" boot option<br>Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(2,0)<br>&nbsp;&lt;0&gt;Rebooting in 1 seconds..&lt;NULL&gt;<br>System Halted<br>---------------------------------------------------------<br><br>Could anyone give me some advice ? Thank you very much.<br><BR><BR><p>&#32;


      <hr size=1><a href="http://cn.mail.yahoo.com/"> —≈ª¢” œ‰£¨ƒ˙µƒ÷’…˙” œ‰£°</a>
--0-1516960893-1206688407=:21903--
