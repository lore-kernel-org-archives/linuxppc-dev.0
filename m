Message-Id: <m132bGV-001SyaC@bucks>
From: diekema@bucks.si.com (diekema_jon)
Subject: Linux kernel oops during high NFS read activity...
To: linuxppc-embedded@lists.linuxppc.org, dan_malek@mvista.com
Date: Thu, 15 Jun 2000 11:09:07 -0400 (EDT)
Cc: all@cideas.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


	Linux kernel oops during high NFS read activity...

	Hardware:

	- EST SBC8260
	- MPC8260 Rev A.1 CPU/CPM/BUS: 200/133/66 Mhz

	Environment:

	- Linux: 2.4.0-test1-ac10
	- Using the /opt/hardhat/devkit/ppc/8xx/target for the
	  NFS mounted root filesystem

Total memory = 16MB; using 0kB for hash table (at 00000000)
Linux version 2.4.0-test1-ac10 (diekema@dell) (gcc version 2.95.2 19991024 (release)) #43 Tue Jun 13 10:08:58 EDT 2000
Boot arguments: root=/dev/nfs rw nfsroot=126.28.1.117:/target nfsaddrs=126.1.4.5:126.28.1.117
On node 0 totalpages: 4096
zone(0): 4096 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/nfs rw nfsroot=126.28.1.117:/target nfsaddrs=126.1.4.5:126.28.1.117
Calibrating delay loop... 131.89 BogoMIPS
Memory: 14716k available (872k kernel code, 408k data, 48k init) [c0000000,c1000000]
Dentry-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
kmem_create: Poisoning requested, but con given - bdev_cache
Inode-cache hash table entries: 1024 (order: 1, 8192 bytes)
kmem_create: Poisoning requested, but con given - inode_cache
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.3
Based upon Swansea University Computer Society NET3.039
kmem_create: Poisoning requested, but con given - skbuff_head_cache
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 1024 bind 1024)
Starting kswapd v1.6
CPM UART driver version 0.01
ttyS00 at 0x0000 is a SMC
ttyS01 at 0x0040 is a SMC
ttyS02 at 0x8100 is a SCC
ttyS03 at 0x8200 is a SCC
pty: 256 Unix98 ptys configured
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: registered device at major 7
loop: enabling 8 loop devices
eth0: SCC ENET Version 0.1, 00:a0:1e:01:04:05
IP-Config: Guessing netmask 255.0.0.0
kmem_create: Forcing size word alignment - nfs_fh
Looking up port of RPC 100003/2 on 126.28.1.117
Looking up port of RPC 100005/2 on 126.28.1.117
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 48k init
INIT: version 2.77 booti
+ /sbin/ifconfig lo 127.0.0.1
+
+ mount /proc
+ ifconfig -a
eth0      Link encap:Ethernet  HWaddr 00:A0:1E:01:04:05
          inet addr:126.1.4.5  Bcast:126.255.255.255  Mask:255.0.0.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:1073 errors:0 dropped:0 overruns:0 frame:0
          TX packets:447 errors:0 dropped:0 overruns:0 carrier:0
          collisions:2 txqueuelen:100
          Base address:0x8000

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:3904  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0

+ mount -a
+ mount -o rsize=8192,wsize=8192,rw,remount /
INIT: Entering runlevel:

# cat /z-pound.sh
#!/bin/sh

date
tar cf -  [a-c,e-o,q-z]* | wc -c
exec $0

# cd /
# /z-pound.sh &

# ps auxw
USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
root         1  0.1  1.1  1212  164 ?        S    16:00   0:00 init
root         2  0.2  0.0     0    0 ?        SW   16:00   0:00 [kswapd]
root         3  0.0  0.0     0    0 ?        SW   16:00   0:00 [kflushd]
root         4  0.0  0.0     0    0 ?        SW   16:00   0:00 [kupdate]
root         5  1.7  0.0     0    0 ?        SW   16:00   0:03 [rpciod]
root        25  0.0  2.1  1296  324 ttyS0    S    16:00   0:00 /bin/sh
root        27  0.0  1.0  1580  156 ?        S    16:00   0:00 /bin/inetd
root        31  0.0  3.4  1288  516 ttyS0    S    16:00   0:00 /bin/sh /z-pound.sh
root        37  5.0  5.2  1656  772 ttyS0    D    16:02   0:00 tar cf - bin etc lib libexec mnt opt sbin share tmp vrc vrc.N z-pound
root        38  0.5  3.0  1212  452 ttyS0    S    16:02   0:00 wc -c
root        39 33.0  5.8  2764  860 ttyS0    R    16:02   0:00 ps auxw

NIP: C00CF230 XER: 00000000 LR: C0020ABC REGS: c010dd60 TRAP: 0300
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c010c000[0] 'swapper' Last syscall: 120
last math c0384000 last altivec 00000000
GPR00: 5A5A5A5A C010DE10 C010C000 C0BAB393 FFFFFF92 00000000 00000001 00000000
GPR08: 0000007D 5A5A5A5A C012E6D8 C0BAB410 24444022 1004206C 00000000 00000000
GPR16: 00000000 00000000 00000000 00000000 00001032 C00DFFB8 C012E2F0 C0110000
GPR24: C0130000 C0130000 C0110000 C0141980 C011B780 C0130000 C00CF200 C0BAB393
Call backtrace:
C00206EC C0020ABC C001BD10 C001BBE0 C001B968 C0004BF4 C0005D8C
C0005DD0 C011C7DC 000036C0
Kernel panic: kernel access of bad area pc c00cf230 lr c0020abc address 5A5A5A5E tsk swapper/0
In interrupt handler - not syncing
Rebooting in 180 seconds..floating point used in kernel (task=c010c000, pc=ff000100)

dell 119} sh/backtrace
C00206EC C0020ABC C001BD10 C001BBE0 C001B968 C0004BF4 C0005D8C
C0005DD0 C011C7DC 000036C0
0xc00206ec -- 0xc0020648 + 0x00a4   update_process_times
0xc0020abc -- 0xc0020748 + 0x0374   timer_bh
0xc001bd10 -- 0xc001bcd0 + 0x0040   bh_action
0xc001bbe0 -- 0xc001bb4c + 0x0094   tasklet_hi_action
0xc001b968 -- 0xc001b8b0 + 0x00b8   do_softirq
0xc0004bf4 -- 0xc0004bf4 + 0x0000   do_bottom_half_ret
0xc0005d8c -- 0xc0005d4c + 0x0040   idled
0xc0005dd0 -- 0xc0005dc0 + 0x0010   cpu_idle
0xc011c7dc -- 0xc011c64c + 0x0190   start_kernel
0x000036c0 -- 0xc0126fa4 + 0x3fedc71c   packet_proto_init


I tried the test again, and received another kernel oops.


kmem_free: Bad obj addr (objp=c0b4f4c0, name=nfs_read_data)
kernel BUG at slab.c:1664!
NIP: C002D8E8 XER: 00000000 LR: C002D8E8 REGS: c01d9d20 TRAP: 0700
MSR: 00089032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c01d8000[5] 'rpciod' Last syscall: -1
last math c0fa0000 last altivec 00000000
GPR00: C002D8E8 C01D9DD0 C01D8000 0000001B 00001032 C010FF80 C01F6260 00000000
GPR08: 0000001B C0110000 F00000C8 C01D9D10 24444028 1004206C 00000000 00000000
GPR16: C011A210 C0120000 C011AC64 00000000 C0120000 C0110000 C0130000 C010B3E0
GPR24: C0100000 C011AC64 C0120000 C010B3E0 C0B4F63C C0B4FF21 C0B4F4C0 C01F4340
Call backtrace:
C002D8E8 C005B234 C00D1D50 C00D1584 C00D176C C00D222C C0008FAC
Kernel panic: Exception in kernel pc c002d8e8 signal 4
Rebooting in 180 seconds..floating point used in kernel (task=c01d8000, pc=ff000100)

dell 120} sh/backtrace
C002D8E8 C005B234 C00D1D50 C00D1584 C00D176C C00D222C C0008FAC
0xc002d8e8 -- 0xc002d558 + 0x0390   kmem_cache_free
0xc005b234 -- 0xc005b218 + 0x001c   nfs_readdata_release
0xc00d1d50 -- 0xc00d1b5c + 0x01f4   rpc_release_task
0xc00d1584 -- 0xc00d10ec + 0x0498   __rpc_execute
0xc00d176c -- 0xc00d1634 + 0x0138   __rpc_schedule
0xc00d222c -- 0xc00d20d4 + 0x0158   rpciod
0xc0008fac -- 0xc0008f80 + 0x002c   kernel_thread

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
