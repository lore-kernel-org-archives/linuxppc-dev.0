Date: Fri, 6 Apr 2001 18:13:57 -0300
From: Marcio Koch <koch@inf.pucrs.br>
To: machael <dony.he@huawei.com.cn>
Cc: LinuxPPC-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: kernel 2.4.2 build fails when I enable modules support
Message-ID: <20010406181357.A3687@sirrah.inf.pucrs.br>
References: <20010405154926.A3644@sirrah.inf.pucrs.br> <006e01c0be65$4b9368a0$8021690a@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
In-Reply-To: <006e01c0be65$4b9368a0$8021690a@huawei.com>; from dony.he@huawei.com.cn on Sex, Abr 06, 2001 at 03:46:22 -0300
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Em 2001.04.06 03:46:22 -0300 machael escreveu:
>
> Hi, Marcio, You should make such modifications in
> arch/ppc/kernel/ppc_ksyms.c
>
> +#ifdef CONFIG_VT
>     EXPORT_SYMBOL(kd_mksound);
> +#endif
>
> +#ifdef CONFIG_ALL_PPC
>     EXPORT_SYMBOL(sys_ctrler);
> +#endif
>
> Cheers,
>
> machael
>
>

Thank you Machael this will help when I switch back to that kernel version,
because now I'm using the kernel 2.4.3-pre4 that I caught from
ftp://ftp.denx.de/pub/LinuxPPC/usr/src/. And it compiles ok with modules
support.

My problem now, is when I try to load the modules.

When I run:

sh-2.03# modprobe mtdchar

It fails with this error:

can't locate module mtdchar

And the modules are all there instaled in
$TARGET/lib/modules/2.4.3-pre4/...

sh-2.03# ls -lR /lib/modules/2.4.3-pre4/
/lib/modules/2.4.3-pre4/:
total 20
lrwxrwxrwx   1 root     root           42 Apr  6  2001 build ->
/usr/local/src/linux-2.4.3-pre4-2001-03-19
drwxrwxr-x   4 root     root         4096 Apr  6  2001 kernel
-rw-rw-r--   1 root     root            0 Apr  6  2001 modules.dep
-rw-rw-r--   1 root     root           81 Apr  6  2001 modules.isapnpmap
-rw-rw-r--   1 root     root           99 Apr  6  2001 modules.pcimap
-rw-rw-r--   1 root     root          177 Apr  6  2001 modules.usbmap
drwxrwxr-x   2 root     root         4096 Apr  6  2001 pcmcia

/lib/modules/2.4.3-pre4/kernel:
total 8
drwxrwxr-x   3 root     root         4096 Apr  6  2001 drivers
drwxrwxr-x   3 root     root         4096 Apr  6  2001 fs

/lib/modules/2.4.3-pre4/kernel/drivers:
total 4
drwxrwxr-x   2 root     root         4096 Apr  6  2001 mtd

/lib/modules/2.4.3-pre4/kernel/drivers/mtd:
total 72
-rw-rw-r--   1 root     root        11576 Apr  6  2001 cfi_probe.o
-rw-rw-r--   1 root     root        19060 Apr  6  2001 ftl.o
-rw-rw-r--   1 root     root         2360 Apr  6  2001 map_rom.o
-rw-rw-r--   1 root     root        11744 Apr  6  2001 mtdblock.o
-rw-rw-r--   1 root     root         8416 Apr  6  2001 mtdchar.o
-rw-rw-r--   1 root     root         6264 Apr  6  2001 mtdcore.o
-rw-rw-r--   1 root     root         3216 Apr  6  2001 rpxlite.o

/lib/modules/2.4.3-pre4/kernel/fs:
total 4
drwxrwxr-x   2 root     root         4096 Apr  6  2001 jffs

/lib/modules/2.4.3-pre4/kernel/fs/jffs:
total 84
-rw-rw-r--   1 root     root        79236 Apr  6  2001 jffs.o

/lib/modules/2.4.3-pre4/pcmcia:
total 0


The modules.dep file is empty, is that right ?


Here is the boot message:

Uncompressing Linux...done.
Now booting the kernel
Linux version 2.4.3-pre4 (root@sirrah.elinux.pucrs.br) (gcc version 2.95.2
19991030 (2.95.3 prerelease/franzo)) #1 Sex Abr 6 15:43:08 BRT 2001
On node 0 totalpages: 4096
zone(0): 4096 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/nfs rw
Decrementer Frequency: 3000000
Calibrating delay loop... 47.61 BogoMIPS
Memory: 14764k available (892k kernel code, 376k data, 44k init, 0k
highmem)
Dentry-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 1024 (order: 1, 8192 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
CPM UART driver version 0.03
ttyS0 on SMC1 at 0x0280, BRG1
pty: 256 Unix98 ptys configured
block: queued sectors max/low 9706kB/3235kB, 64 slots per queue
eth0: CPM ENET Version 0.2 on SCC2, 00:50:15:00:03:85
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 1024 bind 1024)
Sending BOOTP requests.... OK
IP-Config: Got BOOTP answer from 172.16.0.1, my address is 172.16.0.77
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
devfs: v0.102 (20000622) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x2
Looking up port of RPC 100003/2 on 172.16.0.1
Looking up port of RPC 100005/2 on 172.16.0.1
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 44k init
modprobe: can't locate module char-major-4
INIT: version 2.77 booting
INIT: Entering runlevel: 3

Take a look at the line just before INIT, what is this module char-major-4
about ? Is that the problem ?

Any help would be very appreciated.


Best regards,

Marcio Koch
koch@inf.pucrs.br
PUCRS/ELinux

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
