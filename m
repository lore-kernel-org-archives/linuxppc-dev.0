Message-ID: <0B0A39652BB0D411BCCF00508B9512EC08AEB45B@tx14exm05.ftw.mot.com>
From: Yu Bo-BOYU1 <Bo.Yu@motorola.com>
To: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Does linux (for target 82xx) clear DPRAM after boot
Date: Wed, 9 Oct 2002 12:25:49 -0500 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Does Linux for powerpc 82xx clear DPRAM (immr to immr+64k) ? The reason I
ask is to verify if I can comment out all the port pin configuration in
uart.c and
fcc_enet.c or not as the boot code (vxWorks based) already configure pins
correctly.

Currently I am able to see printouts in serial port smc1 but I
could not see any frames even bad frames using ethereal sniffer. But
apparently
the kernel is trying to send out DHCP requests. But I did see periodical
blink
of the link LED on the hub. The only thing I could think that could be wrong
is
mii pin configuration. The board is using intel Lxt 971 phy and i think the
default
setting will work after hard reset without explicit configuration thru MDIO.

Another question is how to remove

ttyS1 on SMC2 at 0x0040, BRG2
ttyS2 on SCC1 at 0x8000, BRG3
ttyS3 on SCC2 at 0x8100, BRG4

I don't think the custom board used SMC2, SCCx yet.

Thanks a lot.

Bo


Here is the log I had.



Attached TCP/IP interface to dbg0.
Attaching network interface lo0... done.
Loading... 606864
Starting at 0x400000...


loaded at:     00400000 00494290
board data at: 004911B0 00491200
relocated to:  004052CC 0040531C
zimage at:     00405850 0049015E
avail ram:     00495000 01000000

Linux/PPC load: root=/dev/nfs rw ip=auto
Uncompressing Linux...done.
Now booting the kernel
Memory BAT mapping: BAT2=16Mb, BAT3=0Mb, residual: 0Mb
Linux version 2.4.17_mvl21 (root@localhost.localdomain) (gcc version 2.95.3
2001
0315 (release/MontaVista)) #5 Wed Oct 9 11:07:53 CDT 2002
On node 0 totalpages: 4096
zone(0): 4096 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/nfs rw ip=auto
Warning: real time clock seems stuck!
Calibrating delay loop... 54.88 BogoMIPS
Memory: 14600k available (1020k kernel code, 416k data, 64k init, 0k
highmem)
Dentry-cache hash table entries: 2048 (order: 2, 16384 bytes)
Inode-cache hash table entries: 1024 (order: 1, 8192 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Disabling the Out Of Memory Killer
i2c-core.o: i2c core module version 2.6.2 (20011118)
i2c-dev.o: i2c /dev entries driver module version 2.6.2 (20011118)
i2c-proc.o version 2.6.2 (20011118)
CPM UART driver version 0.01
ttyS0 on SMC1 at 0x0000, BRG1
ttyS1 on SMC2 at 0x0040, BRG2
ttyS2 on SCC1 at 0x8000, BRG3
ttyS3 on SCC2 at 0x8100, BRG4
pty: 256 Unix98 ptys configured
block: 64 slots per queue, batch=16
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
eth0: FCC ENET Version 0.3, 08:00:3e:26:15:59
loop: loaded (max 8 devices)
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 1024 bind 1024)
Sending DHCP requests ...... timed out!
IP-Config: Retrying forever (NFS root)...
Sending DHCP requests ...... timed out!
IP-Config: Retrying forever (NFS root)...
Sending DHCP requests ...... timed out!


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
