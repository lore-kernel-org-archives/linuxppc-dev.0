Message-Id: <m13309t-001SyaC@bucks>
From: diekema@bucks.si.com (diekema_jon)
Subject: Linux kernel oops during high NFS read activity with 2.4.0-test1-ac18
To: linuxppc-embedded@lists.linuxppc.org, dan_malek@mvista.com
Date: Fri, 16 Jun 2000 13:43:57 -0400 (EDT)
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

	- Linux: 2.4.0-test1-ac18

	- Using the /opt/hardhat/devkit/ppc/8xx/target for the
	  NFS mounted root filesystem

	Test:

	- Run the following script from bash on the console

bash-2.03# /z-pound.sh &
bash-2.03# cat /z-pound.sh
#!/bin/sh

date
cd /
tar cf -  [a-c,e-o,q-z]* | wc -c
exec $0

	Results from 2 different runs:

kmem_free: Bad obj addr (objp=c0bb7560, name=inode_cache)
kernel BUG at slab.c:1664!
NIP: C002DC0C XER: 00000000 LR: C002DC0C REGS: c01ebd90 TRAP: 0700
MSR: 00089032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c01ea000[2] 'kswapd' Last syscall: -1
last math c011e000 last altivec 00000000
GPR00: C002DC0C C01EBE40 C01EA000 0000001B 00001032 C0111FA8 C01F3260 00000000
GPR08: 0000001B C0110000 F00000B8 C01EBD80 24448028 1001EEB4 00000000 00000000
GPR16: 00000000 00000000 00000000 00000000 003FF000 00000000 00000000 00000000
GPR24: 00000000 C0130000 00000001 C010D3E0 C0BB76FC C0BB7F1C C0BB7560 C0153BE0
Call backtrace:
C002DC0C C004ECE8 C0060FEC C004C4B4 C004C8B8 C002F44C C002F5B0
C0008FD0
Kernel panic: Exception in kernel pc c002dc0c signal 4
Rebooting in 180 seconds..

dell 730} ./sh/backtrace
C002DC0C C004ECE8 C0060FEC C004C4B4 C004C8B8 C002F44C C002F5B0
C0008FD0
0xc002dc0c -- 0xc002d87c + 0x0390   kmem_cache_free
0xc004ece8 -- 0xc004ea24 + 0x02c4   iput
0xc0060fec -- 0xc0060f5c + 0x0090   nfs_dentry_iput
0xc004c4b4 -- 0xc004c3d8 + 0x00dc   prune_dcache
0xc004c8b8 -- 0xc004c88c + 0x002c   shrink_dcache_memory
0xc002f44c -- 0xc002f3e0 + 0x006c   do_try_to_free_pages
0xc002f5b0 -- 0xc002f4fc + 0x00b4   kswapdiput: inode 00:05/177709 still has locks!
0xc0008fd0 -- 0xc0008fa4 + 0x002c   kernel_thread


iput: inode 00:05/177709 still has locks!
iput: device 00:05 inode 177709 still has aliases!
NIP: C004C420 XER: 20000000 LR: C004C518 REGS: c01ebe00 TRAP: 0300
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c01ea000[2] 'kswapd' Last syscall: -1
last math c0c7e000 last altivec 00000000
GPR00: C004C518 C01EBEB0 C01EA000 C0B7F400 00000013 00000000 C0B7F66C 00000000
GPR08: C0B7F61E 5A5A5A5A F00000C0 5A5A5A5A 24444024 1004206C 00000000 00000000
GPR16: 00000000 00000000 00000000 00000000 003FF000 00000000 00000000 00000000
GPR24: 00000000 C0130000 00000001 C0120000 C01158F4 00000008 C0B7F400 C0B7F600
Call backtrace:
C004C518 C004C8B8 C002F44C C002F5B0 C0008FD0
Kernel panic: kernel access of bad area pc c004c420 lr c004c518 address 5A5A5A5E
tsk kswapd/2
Rebooting in 180 seconds..floating point used in kernel (task=c01ea000, pc=ff0001
00)

dell 735} ./sh/backtrace
C004C518 C004C8B8 C002F44C C002F5B0 C0008FD0
0xc004c518 -- 0xc004c3d8 + 0x0140   prune_dcache
0xc004c8b8 -- 0xc004c88c + 0x002c   shrink_dcache_memory
0xc002f44c -- 0xc002f3e0 + 0x006c   do_try_to_free_pages
0xc002f5b0 -- 0xc002f4fc + 0x00b4   kswapd
0xc0008fd0 -- 0xc0008fa4 + 0x002c   kernel_thread

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
