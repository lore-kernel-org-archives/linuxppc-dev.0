Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <20040809145454.46774.qmail@web15609.mail.cnb.yahoo.com>
Date: Mon, 9 Aug 2004 22:54:54 +0800 (CST)
From: Song Sam <samlinuxppc@yahoo.com.cn>
Subject: Boot time with several filesystems on RPXlite DW
To: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20040807062126.8EF1BC109F@atlas.denx.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I used several filesystems based on MTD vs ramdisk to
test boot time on RPXlite DW and got the following
result:

Common condition:
1) 2.4.18[uncompressed] + 48MHZ[CORE] + 48MHZ[BUS] +
converted SELF
2) console=ttyS0,9600

Filesytem     I       II       III[Total]
ramdisk     01"14    11"97     16"79

JFFS2       01"14    10"07     15"39
Cramfs      01"14    07"60     12"54
Ext2        01"14              13"68

u-boot>run flash_self
            <----------------  START TIME : 00"00
## Booting image at ff080000 ...
   Image Name:   RPXlite DW uncompressed kernel
   Image Type:   PowerPC Linux Kernel Image
(uncompressed)
   Data Size:    1256048 Bytes =  1.2 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
OK
             <--------------------- Pharse I
Linux version 2.4.18_ ...
......
Kernel command line: console=ttyS0,9600
root=/dev/mtdblock3 rw
ip=172.16.115.7:172.16.115.6:172.16.115.254:255.255.255.0::eth0:off
panic=1
......
Memory: 62780k available (1008k kernel code, 332k
data, 64k init, 0k highmem)
Dentry-cache hash table entries: 8192 (order: 4, 65536
bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768
bytes)
Mount-cache hash table entries: 1024 (order: 1, 8192
bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384
bytes)
Page-cache hash table entries: 16384 (order: 4, 65536
bytes)
.....
Creating 3 MTD partitions on "RPX":
0x00000000-0x00080000 : "RPXLITE flash U-BOOT
partition"
0x00080000-0x00200000 : "RPXLITE flash KERNEL
partition"
0x00200000-0x01000000 : "RPXLITE flash APPLICATION
partition"..
......
IP-Config: Complete:
      device=eth0, addr=172.16.115.7,
mask=255.255.255.0, gw=172.16.115.254,
     host=172.16.115.7, domain=, nis-domain=(none),
     bootserver=172.16.115.6, rootserver=172.16.115.6,
rootpath=
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (jffs2 filesystem).
Freeing unused kernel memory: 64k init
             < ----------------------- Phrase II
My application is running ... Sam Song
         Feb.7,2004

BusyBox v0.60.1 (2002.10.24-04:52+0000) Built-in shell
(msh)
Enter 'help' for a list of built-in commands.

# Hello Shanghai Univ.
Hi Everybody!
             < ----------------------- Phrase III

------------------------------------------------

It seemed that Cramfs filesystem could get the most
fast boot time.Also No matter how I tried,the boot
time still exceeded 12 seconds at least.But this
result is not the same as Wolfgang said,5~6 seconds
boot time on 8xx board with 50MHZ core and bus
frequency.Where did I go wrong?

I would be satisfied with less than 8 seconds in my
case.Any ideas?

Thanks in advance!

Best regards,

Sam

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
