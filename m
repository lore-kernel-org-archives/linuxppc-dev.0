Return-Path: <daveg@sonartech.com.au>
Received: from sonartech.com.au (newgate.sonartech.com.au [203.28.130.2])
	by ozlabs.org (Postfix) with ESMTP id BBDF22BDA6
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Sep 2004 14:31:29 +1000 (EST)
Received: from sonartech.com.au (daveg@dgees.sonartech.com.au [203.28.130.98])
	by sonartech.com.au (8.12.11/8.12.11) with ESMTP id i8O4XFFa016504
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Sep 2004 14:33:15 +1000
Message-ID: <4153A362.8010604@sonartech.com.au>
Date: Fri, 24 Sep 2004 14:32:34 +1000
From: David Gardiner <daveg@sonartech.com.au>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Content-Type: multipart/mixed; boundary="------------020604090105060901060509"
Subject: powerpc with gigabit card hanging
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------020604090105060901060509
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Not sure that this really belongs here but since I've got an i386 - 
2.6.7 running with a e1000 fine I would assume, it's got something to do 
with the platform and I'm hoping someone has seen something similar. 
Anyway whenever I configure a gigabit ethernet card (bcm5700 or intel 
pro 1000) the system hangs and 100 base (e100) is fine.

What I've tried
bcm5700 - with bcm5700 versions 7.1.22 & 7.3.5 and the kernel module tg3
Intel pro 1000 - with the kernel modules

What I can do, insert the modules remove them, bring them down (ifconfig 
ethx down) although they aren't up.
What I can't do, bring them up (ifconfig ethx ....... up)

I've attached straces for bringing up an e100 and e1000, noting that 
after that is freezes/hangs while trying to configure the e1000, and the 
strace's for the bcm5700 looks exactly the same.

help,
dg

oh, kernel version 2.6.9-rc2 with these patches
http://www.ussg.iu.edu/hypermail/linux/kernel/0409.1/1192.html
http://ozlabs.org/pipermail/linuxppc-dev/2004-September/000068.html




--------------020604090105060901060509
Content-Type: text/plain;
 name="strace.e100"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="strace.e100"

# strace ifconfig eth0 192.168.20.108 netmask 255.255.255.0 up

execve("/sbin/ifconfig", ["ifconfig", "eth0", "192.168.20.108", "netmask", "255.255.255.0", "up"], [/* 23 vars */]) = 0
uname({sys="Linux", node="arrgh", ...}) = 0
brk(0)                                  = 0x1001e000
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x30018000
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=13130, ...}) = 0
mmap(NULL, 13130, PROT_READ, MAP_PRIVATE, 3, 0) = 0x30019000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\1\312"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=1256436, ...}) = 0
mmap(0xfeb5000, 1288532, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0xfeb5000
mprotect(0, 117076, PROT_NONE)          = -1 ENOMEM (Cannot allocate memory)
mmap(0xffd5000, 102400, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED, 3, 0x110000) = 0xffd5000
mmap(0xffee000, 6484, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xffee000
close(3)                                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x3001d000
munmap(0x30019000, 13130)               = 0
uname({sys="Linux", node="arrgh", ...}) = 0
access("/proc/net", R_OK)               = 0
access("/proc/net/unix", R_OK)          = 0
socket(PF_UNIX, SOCK_DGRAM, 0)          = 3
socket(PF_INET, SOCK_DGRAM, IPPROTO_IP) = 4
access("/proc/net/if_inet6", R_OK)      = 0
socket(PF_INET6, SOCK_DGRAM, IPPROTO_IP) = 5
access("/proc/net/ax25", R_OK)          = -1 ENOENT (No such file or directory)
access("/proc/net/nr", R_OK)            = -1 ENOENT (No such file or directory)
access("/proc/net/ipx", R_OK)           = -1 ENOENT (No such file or directory)
access("/proc/net/appletalk", R_OK)     = -1 ENOENT (No such file or directory)
access("/proc/net/x25", R_OK)           = -1 ENOENT (No such file or directory)
ioctl(4, 0x8916, 0x7ffff5d0)            = 0
ioctl(4, 0x8913, 0x7ffff4f0)            = 0
ioctl(4, 0x8914, 0x7ffff4f0)            = 0
ioctl(4, 0x891c, 0x7ffff5d0)            = 0
ioctl(4, 0x8913, 0x7ffff4f0)            = 0
ioctl(4, 0x8914, 0x7ffff4f0)            = 0
exit_group(0)                           = ?

--------------020604090105060901060509
Content-Type: text/plain;
 name="strace.e1000"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="strace.e1000"

# strace ifconfig eth2 192.168.22.108 netmask 255.255.255.0 up
execve("/sbin/ifconfig", ["ifconfig", "eth2", "192.168.22.108", "netmask", "255.255.255.0", "up"], [/* 23 vars */]) = 0
uname({sys="Linux", node="arrgh", ...}) = 0
brk(0)                                  = 0x1001e000
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x30018000
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=13130, ...}) = 0
mmap(NULL, 13130, PROT_READ, MAP_PRIVATE, 3, 0) = 0x30019000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\1\312"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=1256436, ...}) = 0
mmap(0xfeb5000, 1288532, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0xfeb5000
mprotect(0, 117076, PROT_NONE)          = -1 ENOMEM (Cannot allocate memory)
mmap(0xffd5000, 102400, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED, 3, 0x110000) = 0xffd5000
mmap(0xffee000, 6484, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xffee000
close(3)                                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x3001d000
munmap(0x30019000, 13130)               = 0
uname({sys="Linux", node="arrgh", ...}) = 0
access("/proc/net", R_OK)               = 0
access("/proc/net/unix", R_OK)          = 0
socket(PF_UNIX, SOCK_DGRAM, 0)          = 3
socket(PF_INET, SOCK_DGRAM, IPPROTO_IP) = 4
access("/proc/net/if_inet6", R_OK)      = 0
socket(PF_INET6, SOCK_DGRAM, IPPROTO_IP) = 5
access("/proc/net/ax25", R_OK)          = -1 ENOENT (No such file or directory)
access("/proc/net/nr", R_OK)            = -1 ENOENT (No such file or directory)
access("/proc/net/ipx", R_OK)           = -1 ENOENT (No such file or directory)
access("/proc/net/appletalk", R_OK)     = -1 ENOENT (No such file or directory)
access("/proc/net/x25", R_OK)           = -1 ENOENT (No such file or directory)
ioctl(4, 0x8916, 0x7ffff5d0)            = 0
ioctl(4, 0x8913, 0x7ffff4f0)            = 0
ioctl(4, 0x8914

--------------020604090105060901060509--
