Return-Path: <samlinuxppc@yahoo.com.cn>
Received: from web15602.mail.cnb.yahoo.com (web15602.mail.cnb.yahoo.com
	[202.165.102.56]) by ozlabs.org (Postfix) with SMTP id 650B62BD6A
	for <linuxppc-dev@ozlabs.org>; Sun, 19 Sep 2004 06:11:57 +1000 (EST)
Message-ID: <20040918201154.53000.qmail@web15602.mail.cnb.yahoo.com>
Date: Sun, 19 Sep 2004 04:11:54 +0800 (CST)
From: Song Sam <samlinuxppc@yahoo.com.cn>
To: Pantelis Antoniou <panto@intracom.gr>
In-Reply-To: <414AB4A7.2000807@intracom.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Cc: linuxppc-dev@ozlabs.org
Subject: Re: Linux 2.6.x on 8xx status
List-Id: "Linux on PowerPC \(Including Embedded\) Developers Mail List"
	<linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Pantelis Antoniou <panto@intracom.gr> wrote£∫
> > Well, as I have tested so far, 2.6.x can only work
> > right on 8xx with RAMDISK root file system. As for
> > NFS, still no luck.
> 
> Well it could have fooled me since I have it running
> right here...
> 
> Don't use the old etherner driver.

After following your instruction, I tested fec_8xx
driver on RPXlite DW.
Changes were made as follows:
1. Mask __fw_getenv and 'ethaddr' code in
fec_8xx-netta.c to avoid compiling error 'undefined
reference to __fw_getenv';
2. Replace NETTA as RPXLITE in ..fec_8xx/Makefile &&
Kconfig;

Yeah, the result is so close to work right on RPXlite
DW. So great, a lot improvement. But still a pity...

---------------------------------------------------

U-Boot 1.1.2 (Aug 31 2004 - 09:47:03)

CPU:   PPC823EZTnnB2 at 48 MHz: 16 kB I-Cache 8 kB
D-Cache
Board: RPXlite_DW
DRAM:  64 MB
FLASH: 16 MB
Hit any key to stop autoboot:  0
u-boot>run net_nfs
Using SCC ETHERNET device
TFTP from server 172.16.115.6; our IP address is
172.16.115.7
Filename 'uImage.rpx26nfs919'.
Load address: 0x200000
Loading:
#################################################################
done
Bytes transferred = 726996 (b17d4 hex)
## Booting image at 00200000 ...
   Image Name:   Linux-2.6.9-rc2
   Image Type:   PowerPC Linux Kernel Image (gzip
compressed)
   Data Size:    726932 Bytes = 709.9 kB
   Load Address: 00000000
   Entry Point:  00000000
   Uncompressing Kernel Image ... OK
Linux version 2.6.9-rc2 (root@shu.edu.net) (gcc
version 3.2.2 20030217 (Yellow Dog Linux 3.0
3.2.2-2a_1)) #1 Sun Sep 19 02:33:02 CST 2004
Built 1 zonelists
Kernel command line: root=/dev/nfs rw
nfsroot=172.16.115.6:/workspace/myfilesystem/target/
ip=172.16.115.7:172.16.115.6:172.16.115.254:255.255.255.0::eth0:off
panic=1
PID hash table entries: 512 (order: 9, 8192 bytes)
Decrementer Frequency = 180000000/60
Dentry cache hash table entries: 16384 (order: 4,
65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768
bytes)
Memory: 63104k available (1272k kernel code, 288k
data, 72k init, 0k highmem)
Mount-cache hash table entries: 512 (order: 0, 4096
bytes)
NET: Registered protocol family 16
Serial: CPM driver $Revision: 0.01 $
ttyCPM0 at MMIO 0xfa200a80 (irq = 20) is a CPM UART
ttyCPM1 at MMIO 0xfa200a00 (irq = 46) is a CPM UART
RAMDISK driver initialized: 16 RAM disks of 4096K size
1024 blocksize
loop: loaded (max 8 devices)
fec_8xx.c:v0.1 (May 6, 2004)
FEC Reset timeout!
fec_8xx: eth0 No PHY detected!
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind
8192)
NET: Registered protocol family 1
NET: Registered protocol family 17
FEC Reset timeout!
IP-Config: Complete:
      device=eth0, addr=172.16.115.7,
mask=255.255.255.0, gw=172.16.115.254,
     host=172.16.115.7, domain=, nis-domain=(none),
     bootserver=172.16.115.6, rootserver=172.16.115.6,
rootpath=
Looking up port of RPC 100003/2 on 172.16.115.6
portmap: server 172.16.115.6 not responding, timed out
Root-NFS: Unable to get nfsd port number from server,
using default
Looking up port of RPC 100005/1 on 172.16.115.6
NETDEV WATCHDOG: eth0: transmit timed out
NETDEV WATCHDOG: eth0: transmit timed out
NETDEV WATCHDOG: eth0: transmit timed out
NETDEV WATCHDOG: eth0: transmit timed out
NETDEV WATCHDOG: eth0: transmit timed out
NETDEV WATCHDOG: eth0: transmit timed out
NETDEV WATCHDOG: eth0: transmit timed out
NETDEV WATCHDOG: eth0: transmit timed out
NETDEV WATCHDOG: eth0: transmit timed out
portmap: server 172.16.115.6 not responding, timed out
Root-NFS: Unable to get mountd port number from
server, using default
NETDEV WATCHDOG: eth0: transmit timed out
[snip]
NETDEV WATCHDOG: eth0: transmit timed out
mount: server 172.16.115.6 not responding, timed out
Root-NFS: Server returned error -5 while mounting
/workspace/myfilesystem/target/
VFS: Unable to mount root fs via NFS, trying floppy.
VFS: Cannot open root device "nfs" or
unknown-block(2,0)
Please append a correct "root=" boot option
Kernel panic - not syncing: VFS: Unable to mount root
fs on unknown-block(2,0)
 <0>Rebooting in 1 seconds..<6>NETDEV WATCHDOG: eth0:
transmit timed out
-----------------------------------------------

Idea?

Best regards,

Sam

_________________________________________________________
Do You Yahoo!?
150ÕÚ«˙MP3∑ËøÒÀ—£¨¥¯ƒ˙¥≥»Î“Ù¿÷µÓÃ√
http://music.yisou.com/
√¿≈Æ√˜–«”¶”–æ°”–£¨À—±È√¿Õº°¢—ﬁÕº∫Õø·Õº
http://image.yisou.com
1GæÕ «1000’◊£¨—≈ª¢µÁ” ◊‘÷˙¿©»›£°
http://cn.rd.yahoo.com/mail_cn/tag/1g/*http://cn.mail.yahoo.com/event/mail_1g/
