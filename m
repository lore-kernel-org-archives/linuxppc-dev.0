Message-ID: <39FF3F15.F699D3F7@mvista.com>
Date: Tue, 31 Oct 2000 13:52:21 -0800
From: Matthew Locke <mlocke@mvista.com>
MIME-Version: 1.0
To: clark@esteem.com
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PCMCIA Problems
References: <5.0.0.25.1.20001031130633.00a49d60@pop.esteem.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I set _IO_BASE to 0x80000000 and it worked fine in 2.2.14.  My patches
are on our ftp site.

ftp://ftp.mvista.com/Area51/ppc_8xx

clark@esteem.com wrote:
>
>         Hello,
>
>         I seem to be having trouble with getting pcmcia-cs working. I am using a
> custom board with a MPC850 running PPCBoot and HardHat Linux. Everything
> seems to work fine up until Cardmgr loads. I know I need to define _IO_BASE
> and its size but I'm not sure how to figure out what to set it to. I have
> tried to set it to various values 0x80000000, 0xEC000000, 0xC0000000, and
> 0xD0000000 all with no luck. Do I need to do more than declare it?
>
> here is typical output.
>
> Hit any key to stop autoboot:  0
> ## Booting Linux kernel at 40030000 ...
>     Image Name:   2.2.13 for EST192E
>     Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>     Data Size:    412481 Bytes = 402 kB = 0 MB
>     Load Address: 00000000
>     Entry Point:  0000000c
>     Verifying Checksum ... OK
>     Uncompressing Kernel Image ... OK
> Linux version 2.2.13 (brent@strecker.esteem.com) (gcc version 2.95.2 19991024
> (release)) #20 Fri Oct 27 09:53:01 PDT 2000
> Boot arguments: root=/dev/nfs rw ip=100.100.100.21:100.100.100.11:100.100.100.
> 1:255.0.0.0:esteem192e.com:eth0 nfsroot=100.100.100.11:/home/brent/dk80211b/ro
> otfs.nfs
> time_init: decrementer frequency = 183750000/60
> Calibrating delay loop... 48.84 BogoMIPS
> Memory: 15132k available (748k kernel code, 464k data, 40k init) [c0000000,c10
> 00000]
> DENTRY hash table entries: 262144 (order: 9, 2097152 bytes)
> Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
> Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
> POSIX conformance testing by UNIFIX
> Linux NET4.0 for Linux 2.2
> Based upon Swansea University Computer Society NET3.039
> NET4: Unix domain sockets 1.0 for Linux NET4.0.
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP Protocols: ICMP, UDP, TCP, IGMP
> TCP: Hash tables configured (ehash 16384 bhash 16384)
> Starting kswapd v 1.1.1.1
> CPM UART driver version 0.03
> ttyS00 at 0x0280 is a SMC
> ttyS01 at 0x0380 is a SMC
> pty: 256 Unix98 ptys configured
> RAM disk driver initialized:  16 RAM disks of 4096K size
> loop: registered device at major 7
> NET4: Ethernet Bridge 008 for NET4.0
> eth0: CPM ENET Version 0.2, 00:00:00:00:00:00
> PPP: version 2.3.7 (demand dialling)
> TCP compression code copyright 1989 Regents of the University of California
> PPP line discipline registered.
> Looking up port of RPC 100003/2 on 100.100.100.11
> Looking up port of RPC 100005/1 on 100.100.100.11
> VFS: Mounted root (NFS filesystem).
> Freeing unused kernel memory: 40k init
> INIT: version 2.77 booti
> Linux PCMCIA Card Services 3.1.10
>    kernel build: 2.2.13 #20 Fri Oct 27 09:53:01 PDT 2000
>    options:  none
> m8xx_pcmcia: Version 0.03, 14-Feb-2000, Magnus Damm
> m8xx_pcmcia: ESTEEM192E using SLOT_B with IRQ 13.
> p80211.o: 0.1.7 Loaded
> cardmgr[17]: starting, version is 3.1.10
> cardmgr[17]: watching 1 sockets
> cardmgr[17]: initializing socket 0
> Machine check in kernel mode.
> Caused by (from msr): regs c0c75850 Unknown values in msr
> NIP: C4003C94 XER: C000FF7F LR: C4003C70 REGS: c0c75850 TRAP: 0200
> MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
> TASK = c0c74000[17] 'cardmgr' mm->pgd c0c7f000 Last syscall: 54
> last math 00000000
> GPR00: C4016000 C0C75900 C0C74000 C4015000 C0C09054 000001F7 C00D3000 00000015
>
> GPR08: 00000C40 C4015000 C0C123AC 00001000 35F33F34 10021500 1009FFD0 00000000
>
> GPR16: 100A6310 00000000 00FBFE38 00000000 00009032 00C75E80 00000000 C0002544
>
> GPR24: C0002284 00000002 C00E886C C0C7596A 00000002 00000000 C00E8800 C4015000
>
> Call backtrace:
> C4003C70 C4004418 C4004978 C4004700 C400608C C40038C8 C400F4C8
> C0032FC4 C00022D8 00000000 100018A0 10002A50 10003FF0 0FF09E78
> 00000000
> Kernel panic: machine check
> Rebooting in 180 seconds..
>
>         With a silly scope I can see the pcmcia device assert the RDY/BSY_B line
> after it is reset, and /CE1_B & /CE2_B get asserted once just before it
> explodes in my face.
>
> Any help apprieciated, Many thanks in advance.
>
>         Conn
> *****************************************************************
>    If you live at home long enough, your parrents will move out.
> *****************************************************************
>
> Conn Clark
> Engineering Stooge                              clark@esteem.com
> Electronic Systems Technology Inc.              www.esteem.com
>
> Stock Ticker Symbol                             ELST
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
