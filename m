Date: Tue, 1 Jul 2003 17:51:17 -0400
From: Kent Borg <kentborg@borg.org>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Large initrd and arch/ppc/boot/simple Question
Message-ID: <20030701175117.G20876@borg.org>
References: <20030701162944.E20876@borg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030701162944.E20876@borg.org>; from kentborg@borg.org on Tue, Jul 01, 2003 at 04:29:44PM -0400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Looking more, it seems that we are (at minimum) killing the kernel by
asking for too much memory.  We are seeing whether we can reproduce
that with a simpler program.

-kb


In the meantime, here is some output of and about our crash:

  $ size bigapp.strip
     text	   data	    bss	    dec	    hex	filename
  7465252	  97296	 401844	7964392	 7986e8	bigapp.strip
  $ size /tftpboot/zImage.initrd.elf
     text	   data	    bss	    dec	    hex	filename
    24896	6856704	  12732	6894332	 6932fc	/tftpboot/zImage.initrd.elf




  loaded at:     02000000 026941BC
  zimage at:     02007D34 02097813
  initrd at:     02098000 02690529
  avail ram:     00400000 01000000

  Linux/PPC load: console=ttyS0,115200 ip=off mem=48m
  Uncompressing Linux...done.
  Now booting the kernel
  Warning hardcoded alaska_find_end_of_memory() alaska.c:172
  Memory BAT mapping: BAT2=32Mb, BAT3=16Mb, residual: 32Mb
  Linux version 2.4.21-rc1 (pbarada@hyper) (gcc version 3.2.2) #136 Tue Jul 1 16:36:46 EDT 2003
  On node 0 totalpages: 12288
  zone(0): 12288 pages.
  zone(1): 0 pages.
  zone(2): 0 pages.
  Kernel command line: console=ttyS0,115200 ip=off mem=48m
  Calibrating delay loop... X BogoMIPS
  Memory: 41056k available (1028k kernel code, 308k data, 64k init, 0k highmem)
  Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
  Inode cache hash table entries: 4096 (order: 3, 32768 bytes)
  Mount cache hash table entries: 512 (order: 0, 4096 bytes)
  Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
  Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
  POSIX conformance testing by UNIFIX
  PCI: Probing PCI hardware
  Linux NET4.0 for Linux 2.4
  Based upon Swansea University Computer Society NET3.039
  Initializing RT netlink socket
  Starting kswapd
  pty: 256 Unix98 ptys configured
  Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
  ttyS00 at 0xf1001008 (irq = 73) is a ST16650
  ttyS01 at 0xf1001010 (irq = 74) is a ST16650
  RAMDISK driver initialized: 16 RAM disks of 14336K size 1024 blocksize
  loop: loaded (max 8 devices)
  PPP generic driver version 2.4.2
  PPP Deflate Compression module registered
  NET4: Linux TCP/IP 1.0 for NET4.0
  IP Protocols: ICMP, UDP, TCP, IGMP
  IP: routing cache hash table of 512 buckets, 4Kbytes
  TCP: Hash tables configured (established 4096 bind 8192)
  NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
  RAMDISK: Compressed image found at block 0
  Freeing initrd memory: 6113k freed
  VFS: Mounted root (romfs filesystem) readonly.
  Freeing unused kernel memory: 64k init
  INIT: version 2.78 booting
  INIT: Entering runlevel: 1
  /etc/rc: line 11:    18 Terminated              /sbin/syslogd
  [01/Jan/1970:00:00:07 +0000] boa: server version Boa/0.94.8.3
  [01/Jan/1970:00:00:07 +0000] boa: server built Jun 20 2003 at 10:43:07.
  [01/Jan/1970:00:00:07 +0000] boa: starting server pid=25, port 80
  "Space, a great big place of unknown stuff."  -Dexter, for our MotD.
  sh-2.05b#
  sh-2.05b# ps
    PID  Uid     Stat Command
      1 root     S    init
      2 root     S    [keventd]
      3 root     S    [ksoftirqd_CPU0]
      4 root     S    [kswapd]
      5 root     S    [bdflush]
      6 root     S    [kupdated]
     19 root     S    /sbin/syslogd
     21 root     S    /sbin/xinetd
     23 bin      S    [portmap]
     25 root     S    /bin/boa
     29 root     S    /bin/sh
     30 root     R    ps
  sh-2.05b#
  sh-2.05b# cat /proc/meminfo
          total:    used:    free:  shared: buffers:  cached:
  Mem:  48369664 18210816 30158848        0  2772992 13422592
  Swap:        0        0        0
  MemTotal:        47236 kB
  MemFree:         29452 kB
  MemShared:           0 kB
  Buffers:          2708 kB
  Cached:          13108 kB
  SwapCached:          0 kB
  Active:           4008 kB
  Inactive:        12616 kB
  HighTotal:           0 kB
  HighFree:            0 kB
  LowTotal:        47236 kB
  LowFree:         29452 kB
  SwapTotal:           0 kB
  SwapFree:            0 kB
  sh-2.05b#
  sh-2.05b# df
  Filesystem           1k-blocks      Used Available Use% Mounted on
  rootfs                   12161     12161         0 100% /
  /dev/ram0                12161     12161         0 100% /
  /dev/ram1                 1003        26       977   3% /var
  sh-2.05b#
  sh-2.05b# cd /tmp
  sh-2.05b# /usr/local/bin/bigapp.strip -m8m
  Assert failed: "sjret == 0xABCD" ../ts/tsmdsun.c:580
  Fatal at line 580 in ../ts/tsmdsun.c
  Terminating execution via an "illegal instruction" signal
  Illegal instruction
  sh-2.05b# /usr/local/bin/bigapp.strip -m16m
  Oops: kernel access of bad area, sig: 11
  NIP: C002F3A8 XER: 00000000 LR: C002F2D0 SP: C24C3D60 REGS: c24c3cb0 TRAP:   0300    Not tainted
  MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
  DAR: 00000000, DSISR: 22000000
  TASK = c24c2000[34] 'bigapp.strip' Last syscall: 90
  last math c24c2000 last altivec 00000000
  GPR00: 00000000 C24C3D60 C24C2000 00000001 00009032 C011BDCC 02000000 C0143  790
  GPR08: 00000000 BA2E0000 00000000 00000000 44000024 1074DAB8 00000000 00000  000
  GPR16: 00000000 00000000 00000000 10770000 00009032 024C3F40 C0143790 C0143  790
  GPR24: 00000001 00000000 C011BB9C C011BB9C 000001D2 00000003 C011BBD4 C019B  4C0
  Call backtrace:
  00000000 C002FA04 C002F65C C0023090 C00231D0 C00233F8 C000EC88
  C0005DB0 102AC5CC 10000570 1033A2DC 00000000
  Oops: kernel access of bad area, sig: 11
  NIP: C00254B8 XER: 20000000 LR: C0021A78 SP: C24C3A90 REGS: c24c39e0 TRAP:   0300    Not tainted
  MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
  DAR: DEADBEEF, DSISR: 22000000
  TASK = c24c2000[34] 'bigapp.strip' Last syscall: 90
  last math c24c2000 last altivec 00000000
  GPR00: 00000000 C24C3A90 C24C2000 C01D03C0 00000004 1072E000 00019000 DEADB  EF7
  GPR08: DEADBEEF 00000010 DEADBEEF DEADBEEF C0140000 1074DAB8 00000000 00000  000
  GPR16: 00000000 00000000 00000000 10770000 00001032 024C3CA0 1072E000 C0140  000
  GPR24: 00000001 FFFFFFFD 00000000 FFFFFFFD 00019000 00000000 00000001 C01D0  3C0
  Call backtrace:
  C0017D8C C0021A78 C0023898 C0021D54 C00250B8 C0012F60 C0016364
  C0005F3C C000EEB8 C000EBE4 C0005DB0 00000000 C002FA04 C002F65C
  C0023090 C00231D0 C00233F8 C000EC88 C0005DB0 102AC5CC 10000570
  1033A2DC 00000000
  Oops: kernel access of bad area, sig: 11
  NIP: C002D784 XER: 20000000 LR: C002CFA4 SP: C24C3860 REGS: c24c37b0 TRAP:   0300    Not tainted
  MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
  DAR: DEADBF07, DSISR: 20000000
  TASK = c24c2000[34] 'bigapp.strip' Last syscall: 90
  last math c24c2000 last altivec 00000000
  GPR00: C016B000 C24C3860 C24C2000 DEADBEEF C2F5E000 00000100 00000E45 00000  000
  GPR08: C0140000 00082428 C016B000 C0140000 C0140000 1074DAB8 00000000 00000  000
  GPR16: 00000000 00000000 00000000 10770000 00009032 024C39D0 00000000 C0005  DB0
  GPR24: 00030001 02000000 C24C39E0 00000008 00000000 C263E1E0 00000100 C2F5E  000
  Call backtrace:
  00000000 C004FFD0 C0015B58 C0016380 C0005F3C C000EEB8 C000EBE4
  C0005DB0 C0017D8C C0021A78 C0023898 C0021D54 C00250B8 C0012F60
  C0016364 C0005F3C C000EEB8 C000EBE4 C0005DB0 00000000 C002FA04
  C002F65C C0023090 C00231D0 C00233F8 C000EC88 C0005DB0 102AC5CC
  10000570 1033A2DC 00000000
  Oops: kernel access of bad area, sig: 11
  NIP: C002D794 XER: 20000000 LR: C002CF40 SP: C24C3670 REGS: c24c35c0 TRAP:   0300    Not tainted
  MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
  DAR: DEADBEFB, DSISR: 20000000
  TASK = c24c2000[34] 'bigapp.strip' Last syscall: 90
  last math c24c2000 last altivec 00000000
  GPR00: C016B000 C24C3670 C24C2000 C016AC90 C263B200 00000001 00001215 C016A  CA0
  GPR08: DEADBEEF C01D4224 00000020 C0140000 C0140000 1074DAB8 00000000 00000  000
  GPR16: 00000000 00000000 00000000 10770000 00001032 024C37A0 00000000 C0005  DB0
  GPR24: 00030001 00000000 C24C37B0 20000000 C263B200 C016AC90 C24C2000 C263B  200
  Call backtrace:
  C24C37B0 C0016460 C0005F3C C000EEB8 C000EBE4 C0005DB0 00000000
  C004FFD0 C0015B58 C0016380 C0005F3C C000EEB8 C000EBE4 C0005DB0
  C0017D8C C0021A78 C0023898 C0021D54 C00250B8 C0012F60 C0016364
  C0005F3C C000EEB8 C000EBE4 C0005DB0 00000000 C002FA04 C002F65C
  C0023090 C00231D0 C00233F8 C000EC88 C0005DB0
  Oops: kernel access of bad area, sig: 11
  NIP: C002D794 XER: 20000000 LR: C002CF40 SP: C24C3460 REGS: c24c33b0 TRAP:   0300    Not tainted
  MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
  DAR: DEADBEFB, DSISR: 20000000
  TASK = c24c2000[34] 'bigapp.strip' Last syscall: 90
  last math c24c2000 last altivec 00000000
  GPR00: C016B000 C24C3460 C24C2000 C016ABB8 C219F060 00000001 000015F7 C016A  BC8
  GPR08: DEADBEEF C01C7754 00000520 C0140000 C0140000 1074DAB8 00000000 00000  000
  GPR16: 00000000 00000000 00000000 10770000 00001032 024C35B0 00000000 C0005  DB0
  GPR24: 00030001 00000000 C24C35C0 20000000 C219F060 C016ABB8 C24C2000 C219F  060
  Call backtrace:
  024C35B0 C001CCF4 C00164F0 C0005F3C C000EEB8 C000EBE4 C0005DB0
  C24C37B0 C0016460 C0005F3C C000EEB8 C000EBE4 C0005DB0 00000000
  C004FFD0 C0015B58 C0016380 C0005F3C C000EEB8 C000EBE4 C0005DB0
  C0017D8C C0021A78 C0023898 C0021D54 C00250B8 C0012F60 C0016364
  C0005F3C C000EEB8 C000EBE4 C0005DB0 00000000
  kernel BUG at page_alloc.c:217!




  $ ppc-linux-addr2line -e vmlinux 0xc002f3a8
  include/linux/list.h:83
  $ ppc-linux-addr2line -e vmlinux 0xc002f2d0
  mm/page_alloc.c:208
  $ ppc-linux-addr2line -e vmlinux 0xc011bdcc
  arch/ppc/kernel/entry.S:0
  $ ppc-linux-addr2line -e vmlinux 0xc0143790
  arch/ppc/kernel/entry.S:0
  $ ppc-linux-addr2line -e vmlinux 0xc002fa04
  mm/page_alloc.c:347
  $ ppc-linux-addr2line -e vmlinux 0xc002f65c
  mm/page_alloc.c:247
  $ ppc-linux-addr2line -e vmlinux 0xc0023090
  mm/memory.c:1205
  $ ppc-linux-addr2line -e vmlinux 0xc00233f8
  mm/memory.c:1387
  $ ppc-linux-addr2line -e vmlinux 0xc000ec88
  arch/ppc/mm/fault.c:252
  $ ppc-linux-addr2line -e vmlinux 0xc0005db0
  arch/ppc/kernel/entry.S:0
  $ ppc-linux-addr2line -e vmlinux 0xc0021a78
  mm/memory.c:84
  $ ppc-linux-addr2line -e vmlinux 0xc00254b8
  include/linux/list.h:83
  $ ppc-linux-addr2line -e vmlinux 0xc0017d8c
  kernel/softirq.c:90
  $ ppc-linux-addr2line -e vmlinux 0xc0021a78
  mm/memory.c:84
  $ ppc-linux-addr2line -e vmlinux 0xc0023898
  mm/memory.c:312
  $ ppc-linux-addr2line -e vmlinux 0xc0021d54
  mm/memory.c:352
  $ ppc-linux-addr2line -e vmlinux 0xc00250b8
  mm/mmap.c:1153
  $ ppc-linux-addr2line -e vmlinux 0xc0012f60
  include/asm/atomic.h:150
  $ ppc-linux-addr2line -e vmlinux 0xc0016364
  kernel/exit.c:445
  $ ppc-linux-addr2line -e vmlinux 0xc0005f3c
  arch/ppc/kernel/traps.c:114
  $ ppc-linux-addr2line -e vmlinux 0xc000eeb8
  arch/ppc/mm/fault.c:341
  $ ppc-linux-addr2line -e vmlinux 0xc000ebe4
  arch/ppc/mm/fault.c:288
  $ ppc-linux-addr2line -e vmlinux 0xc0005db0
  arch/ppc/kernel/entry.S:0

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
