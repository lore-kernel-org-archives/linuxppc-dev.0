Return-Path: <bounces@nabble.com>
Received: from talk.nabble.com (www.nabble.com [72.21.53.35])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 054F6DDE01
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Mar 2007 19:52:38 +1100 (EST)
Received: from [72.21.53.38] (helo=jubjub.nabble.com)
	by talk.nabble.com with esmtp (Exim 4.50) id 1HRlhG-0002t3-Ff
	for linuxppc-embedded@ozlabs.org; Thu, 15 Mar 2007 01:52:30 -0700
Message-ID: <9490528.post@talk.nabble.com>
Date: Thu, 15 Mar 2007 01:52:30 -0700 (PDT)
From: Nethra <nethra_gmit@yahoo.co.in>
To: linuxppc-embedded@ozlabs.org
Subject: kernel hangs after jffs mounting
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


hi,

   I m using Montavista linux kernel 2.6.10, boot-loader is u-boot-1.1.2 and 
flash is MBM29LV160T(Fujitsu MBM29LV160T).
 
After nfs mounting, jffs2 mounting is done with empty partition.
But after jffs2 mounting kernel hangs...

root@cashel:~# mount -t jffs2 /dev/mtdblock0 /mnt
root@cashel:~# Oops: kernel access of bad area, sig: 11 [#1]
PREEMPT
NIP: 00000000 LR: C00E65CC SP: C02DDE60 REGS: c02dddb0 TRAP: 0400    Not
tainted
MSR: 20009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c02d7af0[39] 'pdflush' THREAD: c02dc000
Last syscall: -1
GPR00: FFFFFFFF C02DDE60 C02D7AF0 C035B600 C05821A0 00000000 C05821CC
00000001
GPR08: C0281910 00000000 00000024 C05821D0 0000A000 7BEBCFC3 00FFE000
00000000
GPR16: 00000001 00000001 FFFFFFFF 007FFF00 00FF8E00 00000000 00000000
C0C1B4C0
GPR24: C0C1B4F4 00000000 C002CCA4 C0C1B4B8 C0D8ADA0 C05821A0 00000000
C0C1B400
Call trace: [c00e7508]  [c00614e4]  [c0039c74]  [c003aca8]  [c002cc68] 
[c00066a
4]
root@cashel:~#df
Filesystem           1K-blocks      Used Available Use% Mounted on
rootfs                74393444  59841276  10712236  85% /
/dev/root             74393444  59841276  10712236  85% /
tmpfs                     6960         0      6960   0% /tmp
/dev/root             74393444  59841276  10712236  85% /dev/.static/dev
none                     10240      2148      8092  21% /dev
tmpfs                     6960         0      6960   0% /dev/shm
/dev/mtdblock0            4096       512      3584  13% /mnt

root@cashel:~# cd /mnt
root@cashel:/mnt# ls
root@cashel:/mnt# touch nethra
kernel hangs.........

after this kernel hangs....
what is the problem?


here is boot message...
-----------------------------------------------------------------------------------------------------------------
## Booting image at 00200000 ...
   Image Name:   Linux-2.6.10_mvl401-8272ads
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1008901 Bytes = 985.3 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Motorola PQ2 ADS PowerPC port
Built 1 zonelists
Kernel command line: root=/dev/nfs
nfsroot=192.168.178.110:/home/nethra/opt/targ
et
ip=192.168.178.89:192.168.178.110:192.168.174.47:255.255.255.0:cashel:eth2:of
f
PID hash table entries: 128 (order: 7, 2048 bytes)
hr_time_init: arch_to_nsec = 83886080, nsec_to_arch = 107374182
Warning: real time clock seems stuck!
Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
Memory: 13824k available (1796k kernel code, 500k data, 92k init, 0k
highmem)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
spawn_desched_task(00000000)
desched cpu_callback 3/00000000
ksoftirqd started up.
desched cpu_callback 2/00000000
desched thread 0 started up.
NET: Registered protocol family 16
mpc8272ads: Init2
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
JFFS2 version 2.2. (C) 2001-2003 Red Hat, Inc.
Initializing Cryptographic API
Serial: CPM driver $Revision: 0.01 $
ttyCPM0 at MMIO 0xf0011a00 (irq = 40) is a CPM UART
ttyCPM1 at MMIO 0xf0011a60 (irq = 43) is a CPM UART
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
loop: loaded (max 8 devices)
fs_enet.c:v1.0 (Aug 8, 2005)
fs_enet: eth0 Phy @ 0x0, type GENERIC (0x00000000)
fs_enet: eth1 Phy @ 0x3, type GENERIC (0x00000000)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 50MHz system bus speed for PIO modes; override with idebus=xx
elevator: using anticipatory as default io scheduler
physmap flash device: 400000 at ffc00000
cmdlinepart partition parsing not available
RedBoot partition parsing not available
The immap->im_cpmux.cmx_fcr value is 352c0000
eth2: FCC ENET Version for Cashel Board, 00:99:23:c4:ad:de
The immap->im_cpmux.cmx_fcr value is 352c0000
eth3: FCC ENET Version for Cashel Board, 00:99:23:44:ad:de
The immap->im_cpmux.cmx_fcr value is 352c0000
eth4: FCC ENET Version for Cashel Board, 00:99:23:64:ad:de
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 1024 bind 2048)
NET: Registered protocol family 1
NET: Registered protocol family 17
IP-Config: Gateway not on directly connected network.
Looking up port of RPC 100003/2 on 192.168.178.110
Looking up port of RPC 100005/1 on 192.168.178.110
VFS: Mounted root (nfs filesystem) readonly.
Freeing unused kernel memory: 92k initINIT: version 2.85 booting
Mounting a tmpfs over /dev...done.
Creating initial device nodes...done.
Activating swap...done.
Remounting root filesystem...done.
Calculating module dependencies
Loading modules:
Checking all file systems: fsck
fsck 1.35 (28-Feb-2004)
Mounting local filesystems: mount nothing was mounted
Setting up IP spoofing protection: rp_filter.
Disable TCP/IP Explicit Congestion Notification: done.
Starting network interfaces: /sbin/ifup: interface lo already configured
done.
Starting hotplug subsystem:
   pci
   pci      [success]
   usb
   usb      [success]
   isapnp
   isapnp   [success]
   ide
   ide      [success]
   input
   input    [failed]
   scsi
   scsi     [success]
done.
Starting portmap daemon: portmap.
Cleaning: /tmp /var/lock /var/run done.
Setting pseudo-terminal access permissions...done.
Updating /etc/motd...done.
INIT: Entering runlevel: 3
Starting system log daemon: syslogd klogd.
Starting NFS common utilities: statd lockd.
Starting internet superserver: inetd.
Starting MontaVista target tools daemon: mvltdmvltd version 2.1 MontaVista
Softw
are,Inc.
mvltd[833]: can't send broadcast message: Network is unreachable
. Starting NTP server: ntpd
MontaVista(R) Linux(R) Professional Edition 4.0.1 (0502020)

cashel login: root
Password:
Last login: Thu Jan  1 00:04:33 1970 on console
Linux cashel 2.6.10_mvl401-8272ads #93 Thu Mar 15 11:15:46 IST 2007 ppc
GNU/Linu
x

Welcome to MontaVista(R) Linux(R) Professional Edition 4.0.1 (0502020).

.
root@cashel:~#
-----------------------------------------------------------------------------------------------------------------

thanks in advance,

Nethra









-- 
View this message in context: http://www.nabble.com/kernel-hangs-after-jffs-mounting-tf3407038.html#a9490528
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
