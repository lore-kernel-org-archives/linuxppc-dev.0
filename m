Message-ID: <2F67A63DFFB1D31185D90090278CBB2D017D2A39@apmail6.chn.agilent.com>
From: "ZHANG,HAI-TAO (Non-A-China,ex1)" <hai-tao_zhang@non.agilent.com>
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Cc: "ZHANG,HAI-TAO (Non-A-China,ex1)" <hai-tao_zhang@non.agilent.com>
Subject: RE: root filesystem over nfs
Date: Fri, 20 Oct 2000 20:25:32 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I tried to change one line in eepro100.c and now the 2.4.0-test9 boot is ok.

$ diff eepro100.c eepro100.c.orig
1098c1098
<       outl(TX_RING_ELEM_DMA(sp, sp->dirty_tx % TX_RING_SIZE),
---
>       outl(cpu_to_le32(TX_RING_ELEM_DMA(sp, sp->dirty_tx % TX_RING_SIZE)),

It seems like the endianess is changed twice so the kernel hangs up. Maybe
we should define some macros like outl for CONFIG_SANDPOINT.

Thanks,
Haitao Zhang


> -----Original Message-----
> From: ZHANG,HAI-TAO (Non-A-China,ex1)
> [mailto:hai-tao_zhang@non.agilent.com]
> Sent: Friday, September 29, 2000 10:15 PM
> To: Rainer Kloud; linuxppc-embedded
> Subject: RE: root filesystem over nfs
>
>
>
> Hi,
>
> I met the same problem with 2.4.0-test2 or test9 kernel on
> the sandpoint
> 603e/MPC107. The problem happened on executing /sbin/init
> both on nfsroot or
> root fs on IDE. The backtrace and printk messages show that
> exeception(or
> hang-up) is in pad_zero() from load_elf_binary (fs/binfmt_elf.c).
>
> Thanks,
> Haitao Zhang
>
>
>
> > -----Original Message-----
> > From: Rainer Kloud [mailto:rainer.kloud@siemens.at]
> > Sent: Friday, September 29, 2000 6:58 PM
> > To: linuxppc-embedded
> > Subject: root filesystem over nfs
> >
> >
> >
> > Dear All,
> >
> > I'm porting the 2.4.0-test4 kernel to my Scout Board
> > (MPC750/MPC8260) and I have finished everything until
> > executeing the init process (shell) on the remote
> > filesystem (mounted over nfs).
> >
> > When the kernel executes the init process (in my case
> > a programm which calls only a printf and then sleeps
> > forever) I get a Machine check exception (the backtrace
> > tells me in set_brk called from load_elf_binary).
> >
> > Does anybody know whats going wrong? Whow has my remote
> > root filesystem look like (I have compiled my own glibc,
> > modprobe, sh and ls)? Is there any information on the web
> > available?
> >
> > My remote filesystem looks like the following:
> >
> > PCC141:/tftpboot/LinuxPQ2 # ls -lR
> > total 5
> > drwxr-xr-x   5 root     root         1024 Sep 29 09:56 .
> > drwxrwxrwx   5 root     root         1024 Sep 25 10:08 ..
> > drwxr-xr-x   2 root     root         1024 Sep 29 13:06 bin
> > drwxr-xr-x   2 root     root         1024 Sep  8  1998 dev
> > drwxr-xr-x   2 root     root         1024 Sep 29 13:03 lib
> > lrwxrwxrwx   1 root     root            3 Sep 29 09:56 sbin -> bin
> >
> > bin:
> > total 849
> > drwxr-xr-x   2 root     root         1024 Sep 29 13:06 .
> > drwxr-xr-x   5 root     root         1024 Sep 29 09:56 ..
> > -rwxr-xr-x   1 root     root        67907 Sep 29 10:56 depmod
> > -rwxr-xr-x   1 root     root       106133 Sep 29 10:56 insmod
> > -rwxr-xr-x   1 root     root          359 Sep 29 10:56
> > insmod_ksymoops_clean
> > -rwxr-xr-x   1 root     root       106133 Sep 29 10:56 kallsyms
> > -rwxr-xr-x   1 root     root          451 Sep 29 10:56 kernelversion
> > -rwxr-xr-x   1 root     root       106133 Sep 29 10:56 ksyms
> > -rwxr-xr-x   1 root     root        54584 Sep  8  1998 ls
> > -rwxr-xr-x   1 root     root       106133 Sep 29 10:56 lsmod
> > -rwxr-xr-x   1 root     root        57876 Sep 29 10:56 modinfo
> > -rwxr-xr-x   1 root     root       106133 Sep 29 11:31 modprobe
> > -rwxr-xr-x   1 root     root       106133 Sep 29 10:56 rmmod
> > -rwxr-xr-x   1 root     root        33073 Sep 29 10:56 sh
> >
> > dev:
> > total 2
> > drwxr-xr-x   2 root     root         1024 Sep  8  1998 .
> > drwxr-xr-x   5 root     root         1024 Sep 29 09:56 ..
> > lrwxrwxrwx   1 root     root            5 Sep 29 09:51
> > console -> ttyS0
> > crw-r--r--   1 root     root       5,   0 Sep  8  1998 tty
> > crw-r--r--   1 root     root       4,  64 Sep  8  1998 ttyS0
> >
> > lib:
> > total 4456
> > drwxr-xr-x   2 root     root         1024 Sep 29 13:03 .
> > drwxr-xr-x   5 root     root         1024 Sep 29 09:56 ..
> > -rwxr-xr-x   1 root     root       379736 Sep 29 11:07 ld-2.1.3.so
> > lrwxrwxrwx   1 root     root           11 Sep 29 11:08 ld.so.1 ->
> > ld-2.1.3.so
> > -rwxr-xr-x   1 root     root      4160040 Sep 29 11:08 libc-2.1.3.so
> > lrwxrwxrwx   1 root     root           13 Sep 29 11:09 libc.so.6 ->
> > libc-2.1.3.so
> >
> > Does anybody know whats going wrong, and what should
> > I try to get the init programm running?
> >
> > Thank you,
> > Rainer
> >
> >
> >
> > scout> go 600000
> > Disable Cash !!!
> > Jump to Addr: 0x600000 ...
> > loaded at:     00600000 0060B274
> > relocated to:  00400000 0040B274
> > board data at: 0000002E 0000005A
> > relocated to:  00200100 0020012C
> > zimage at:     00606000 00680A51
> > avail ram:     00681000 02000000
> >
> > Linux/PPC load:
> > Uncompressing Linux...done.
> > Now booting the kernel
> > Total memory = 32MB; using 128kB for hash table (at c0160000)
> > Linux version 2.4.0-test4 (kloud@PCC141) (gcc version
> 2.95.2 19991024
> > (release)) #74 Fri Sep 29 12:40:20 CEST 2000
> > Boot arguments: root=/dev/nfs rw
> > On node 0 totalpages: 8192
> > zone(0): 8192 pages.
> > zone(1): 0 pages.
> > zone(2): 0 pages.
> > Kernel command line: root=/dev/nfs rw
> > Calibrating delay loop... 3434.09 BogoMIPS
> > Memory: 30720k available (912k kernel code, 388k data, 52k init)
> > [c0000000,c2000000]
> > Dentry-cache hash table entries: 4096 (order: 3, 32768 bytes)
> > Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
> > Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
> > Inode-cache hash table entries: 2048 (order: 2, 16384 bytes)
> > POSIX conformance testing by UNIFIX
> > Linux NET4.0 for Linux 2.3
> > Based upon Swansea University Computer Society NET3.039
> > NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> > NET4: Linux TCP/IP 1.0 for NET4.0
> > IP Protocols: ICMP, UDP, TCP, IGMP
> > IP: routing cache hash table of 512 buckets, 4Kbytes
> > TCP: Hash tables configured (established 2048 bind 2048)
> > Starting kswapd v1.6
> > CPM UART driver version 0.01
> > ttyS00 at 0x8000 is a SCC
> > pty: 256 Unix98 ptys configured
> > RAMDISK driver initialized: 16 RAM disks of 4096K size 1024
> blocksize
> > loop: registered device at major 7
> > loop: enabling 8 loop devices
> > fcc_startup: gfmr: 0x2000003c, fccm: 0x1a0000, mask: 0x1a,
> fcce: 0x0,
> > fpsmr: 0x80, fdsr: 0xd555
> > eth0: FCC ENET Version 0.2, 08:00:06:08:e6:16
> > Serial driver version 5.01 (2000-05-29) with no serial
> options enabled
> > PPP generic driver version 2.4.1
> > IP-Config: Entered.
> > IP-Config: Opened eth0 (able=1)
> > BOOTP: XID=72eef6f4
> > Sending BOOTP requests....ic_bootp_recv
> > BOOTP: Got extension 01 ff ff ff 00
> > BOOTP: Got extension 11 2f 74 66 74 70 62 6f 6f 74 2f 4c 69
> > 6e 75 78 50
> > 51 32
> > ic_bootp_recv
> >  OK
> > IP-Config: Got BOOTP answer from 195.9.17.222, my address is
> > 195.9.17.216
> > IP-Config: device=eth0, local=c30911d8, server=c30911de,
> > boot=c30911de,
> > gw=ffffffff, mask=ffffff00
> > IP-Config: host=195.9.17.216, domain=(none),
> path=`/tftpboot/LinuxPQ2'
> > kmem_create: Forcing size word alignment - nfs_fh
> > Looking up port of RPC 100003/2 on 195.9.17.222
> > Looking up port of RPC 100005/2 on 195.9.17.222
> > VFS: Mounted root (nfs filesystem).
> > Freeing unused kernel memory: 52k init
> > init: execute /bin/sh
> > Machine check in kernel mode.
> > Caused by (from SRR1=49030): Transfer error ack signal
> > NIP: C000D5E4 XER: 20000000 LR: C004B830 REGS: c0129a30 TRAP: 0200
> > MSR: 00049030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
> > TASK = c0128000[6] 'modprobe' Last syscall: 11
> > last math 00000000 last altivec 00000000
> > GPR00: 000001E1 C0129AE0 C0128000 00000000 00000784
> 00000000 10023890
> > 00000000
> > GPR08: 30000000 00000000 C01271E0 C02491E0 0000000C
> D4B1D575 1002387C
> > 100234C8
> > GPR16: 10000000 1002387C 1002387C 00000002 100242F6
> 30010654 C0215620
> > 00000006
> > GPR24: C01271E0 100234C8 00001812 00000000 1002387C
> 1002387C C0129C78
> > C0232720
> > Call backtrace:
> > C004B7E0 C004C850 C003D44C C003D808 C0006B70 C00048AC C00201CC
> > C00202A8 C00095B0
> > Kernel panic: machine check
> > Rebooting in 180 seconds..
> >
> >
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
