Message-ID: <3C2C84A2.51B8D952@c-s.fr>
Date: Fri, 28 Dec 2001 15:41:38 +0100
From: "LEROY Christophe" <christophe.leroy@c-s.fr>
MIME-Version: 1.0
To: linuxppc <linuxppc-embedded@lists.linuxppc.org>
Subject: Kernel Oops when receiving a lot of UDP packets while booting
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


If the board is receiving a lot of 172 bytes UDP packets (800 packets by
second) while booting, it oopses like that:

Linux version 2.4.16 (root@localhost.localdomain) (gcc version 2.95.3
20010315 (
release)) #215 jeu déc 27 15:37:42 CET 2001
On node 0 totalpages: 2048
zone(0): 2048 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: nfsroot=/mcrlinux ip=192.168.2.50:192.168.2.51:::::
root=/d
ev/nfs init=/bin/init
Decrementer Frequency = 150000000/60
Calibrating delay loop... 39.73 BogoMIPS
Memory: 6852k available (848k kernel code, 296k data, 44k init, 0k
highmem)
Dentry-cache hash table entries: 1024 (order: 1, 8192 bytes)
Inode-cache hash table entries: 512 (order: 0, 4096 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 2048 (order: 1, 8192 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd
CPM UART driver version 0.03
ttyS00 at 0x0280 is a SMC
ttyS01 at 0x0380 is a SMC
block: 64 slots per queue, batch=16
eth0: CPM ENET Version 0.2 on SCC1, 08:00:3e:01:00:17
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
Oops: kernel access of bad area, sig: 11
NIP: C0106838 XER: 00000000 LR: C01067C8 SP: C017FF70 REGS: c017fec0
TRAP: 0300
   Not tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: C0162004, DSISR: 82000000
TASK = c017e000[1] 'swapper' Last syscall: 120
last math 00000000 last altivec 00000000
GPR00: 00000000 C017FF70 C017E000 00000035 00001032 00000001 00000001
C016A060
GPR08: 000004EF 000001FF 00000001 C0162000 0000000D 0009CA80 00000000
00000000
GPR16: 00000000 00000000 00000000 00000000 00000000 00000000 00410000
00002963
GPR24: 00000000 00001089 C0110000 C00F0000 C0110000 C0110000 C0110000
00001000
Call backtrace:
C01067C8 C0106A2C C0107228 C00FF790 C00FF7D8 C00022C4 C0004B68
CPM ENET: BSY can't happen.
CPM ENET: BSY can't happen.
CPM ENET: BSY can't happen.
CPM ENET: BSY can't happen.
CPM ENET: BSY can't happen.
............. This message until I stop the emission of the packets.
CPM ENET: BSY can't happen.
CPM ENET: BSY can't happen.
CPM ENET: BSY can't happen.
CPM ENET: BSY can't happen.
CPM ENET: BSY can't happen.
Oops: kernel access of bad area, sig: 11
NIP: C00956B4 XER: 00000000 LR: C009784C SP: C017FC50 REGS: c017fba0
TRAP: 0300
   Not tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 45000144, DSISR: 0000000A
TASK = c017e000[1] 'swapper' Last syscall: 120
last math 00000000 last altivec 00000000
GPR00: 55555555 C017FC50 C017E000 C0164120 C0A80232 C0A80233 00000000
00000002
GPR08: C0120000 C0110000 450000C8 C0110000 C0110000 0009CA80 00000000
00000000
GPR16: 00000000 00000000 00000000 00000000 00001032 00000274 0000012B
C00FE4D0
GPR24: 0000012C C0169000 C01690DC C0169000 C0A80233 00000000 C0164120
C0A80232
Call backtrace:
0009CA80 C009784C C008CD14 C0012354 C000382C C00026EC C0002874
C0009CA4 C0009B28 C00026F4 C01067C8 C0106A2C C0107228 C00FF790
C00FF7D8 C00022C4 C0004B68
Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
