Message-Id: <m12tvIQ-001SyZC@bucks>
From: diekema@bucks.si.com (diekema_jon)
Subject: Wait Queue bug triggered on EST SBC8260
To: dan@netx4.com (Dan Malek), linuxppc-embedded@lists.linuxppc.org
Date: Mon, 22 May 2000 12:43:14 -0400 (EDT)
Cc: all@cideas.com
In-Reply-To: <392618FC.F6678E68@embeddededge.com> from "Dan Malek" at May 20, 2000 12:47:56 AM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>From Dan Malek:
May 20, 00 12:47:56 AM -0400
Re: EST SBC8260 Linux memory mapping rules

> diekema_jon wrote:

> > I have loaded the zImage bits at the link address on the SBC8260,
> > and that works just fine.

> Well, you must have some pretty damn magical tools, because that
> certainly will not work based upon the way the code is written.
> What do consider the "link address" and "works"?


The works definition would be able to run /bin/sash.


zvmlinux is being linked at 0x00400000, and its entry point
is also at this same address.

dell 121} powerpc-linux-nm arch/ppc/mbxboot/zvmlinux | grep ' start$'
00400000 T start

dell 108} powerpc-linux-objdump -h arch/ppc/mbxboot/zvmlinux
arch/ppc/mbxboot/zvmlinux:     file format elf32-powerpc

Sections:
Idx Name          Size      VMA       LMA       File off  Algn
  0 .text         000044d4  00400000  00400000  00010000  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
  1 .rodata       00000470  004044e0  004044e0  000144e0  2**4
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  2 .data         0000030c  00405000  00405000  00015000  2**2
                  CONTENTS, ALLOC, LOAD, DATA
  3 .data.init    00000000  00406000  00406000  0008ce71  2**0
                  CONTENTS
  4 .bss          00005270  00406000  00406000  00016000  2**2
                  ALLOC
  5 .gzimage      00071c01  0040b270  0040b270  0001b270  2**0
                  CONTENTS, ALLOC, LOAD, READONLY, DATA

We are using the vxWorks boot rom on the EST SBC8260 board, and it
understandsa ELF files.  This boot rom is loading zvmlinux at the
address is was linked at.  Here is an example:


                            VxWorks System Boot

Copyright 1984-1998  Wind River Systems, Inc.

CPU: EST Corp. est8260 -- MPC8260 PowerQUICC II SBC
Version: 5.4
BSP version: 1.2/3
Creation date: Apr 19 2000, 10:24:59

Press any key to stop auto-boot...

Attached TCP/IP interface to motfcc0.
Subnet Mask: 0xff000000
Attaching network interface lo0... done.
Loading... 45680 + 465921
Starting at 0x400000...

loaded at:     00400000 0040B270
board data at: 00FFFFC0 00FFFFE4
relocated to:  00200100 00200124
zimage at:     0040B270 0047CE71
avail ram:     0047D000 01000000

Linux/PPC load: root=/dev/nfs rw nfsroot=126.28.1.117:/target nfsaddrs=126.1.4.5:126.28.1.117::255.0.0.0
Uncompressing Linux...done.
Now booting the kernel
Total memory = 16MB; using 0kB for hash table (at 00000000)
Linux version 2.3.99-pre9 (diekema@dell) (gcc version 2.95.2 19991024 (release)) #45 Sat May 20 21:08:00 EDT 2000
Boot arguments:  root=/dev/nfs rw nfsroot=126.28.1.117:/target nfsaddrs=126.1.4.5:126.28.1.117::255.0.0.0
On node 0 totalpages: 4096
zone(0): 4096 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Calibrating delay loop... 164.66 BogoMIPS
Memory: 14736k available (860k kernel code, 416k data, 48k init) [c0000000,c1000000]
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
kmem_create: Forcing size word alignment - nfs_fh
Looking up port of RPC 100003/2 on 126.28.1.117
Looking up port of RPC 100005/2 on 126.28.1.117
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 48k init
bad magic 0 (should be c01fb2e0, creator 0), wq bug, forcing oops.
kernel BUG at sched.c:656!
NIP: C000FB5C XER: 00000000 LR: C000FB5C REGS: c01adc00 TRAP: 0700
MSR: 00081032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c01ac000[1] 'init' Last syscall: 6
last math 00000000 last altivec 00000000
GPR00: C000FB5C C01ADCB0 C01AC000 0000001B 00001032 C010EF80 C01FB260 C0128502
GPR08: 0000001B C0110000 F00000B8 C01ADBF0 24444028 1001EEB4 00000000 00000000
GPR16: 00000000 00000000 00000000 00000000 00009032 C01DA060 00000000 00000000
GPR24: 00000021 00000001 C01DA060 C010A3E0 C0125000 C0110000 C01FB2D4 C01ADCB0
Call backtrace:
C000FB5C C008CB8C C007F560 C007FE8C C0033CE4 C0033D80 C0032818
C00328CC C00328FC C00048F0 10005548 10005A20 0FF09E78 00000000
Kernel panic: Exception in kernel pc c000fb5c signal 4
Rebooting in 180 seconds..


The root partition gets mounted via NFS, but we die with a scheduling
related problem.

dell 138} ./backtrace < z
0xc000fb5c -- 0xc000fad4 + 0x0088   __wake_up
0xc008cb8c -- 0xc008c8bc + 0x02d0   rs_8xx_close
0xc007f560 -- 0xc007f30c + 0x0254   release_dev
0xc007fe8c -- 0xc007fe78 + 0x0014   tty_release
0xc0033ce4 -- 0xc0033c9c + 0x0048   __fput
0xc0033d80 -- 0xc0033d60 + 0x0020   _fput
0xc0032818 -- 0xc0032784 + 0x0094   filp_close
0xc00328cc -- 0xc0032830 + 0x009c   do_close
0xc00328fc -- 0xc00328e8 + 0x0014   sys_close
0xc00048f0 -- 0xc00048f0 + 0x0000   ret_from_syscall_1
0x10005548 -- 0xc0125d84 + 0x4fedf7c4   packet_proto_init
0x10005a20 -- 0xc0125d84 + 0x4fedfc9c   packet_proto_init
0x0ff09e78 -- 0xc0125d84 + 0x4fde40f4   packet_proto_init
0x00000000 -- 0xc0125d84 + 0x3feda27c   packet_proto_init


dell 106} search '*.[hcsS]' | xargs  grep 'wq bug'
./include/linux/wait.h: printk("wq bug, forcing oops.\n"); \

"wq bug" is used in the WQ_BUG macro

#define WQ_BUG() do { \
        printk("wq bug, forcing oops.\n"); \
        BUG(); \
} while (0)

The WQ_BUG is used int the CHECK_MAGIC_WQHEAD macro.

#define CHECK_MAGIC_WQHEAD(x) do { \
        if (x->__magic != (long)&(x->__magic)) { \
                printk("bad magic %lx (should be %lx, creator %lx), ", \
                        x->__magic, (long)&(x->__magic), x->__creator); \
                WQ_BUG(); \
        } \
} while (0)



>From kernel/sched.c:

static inline void __wake_up_common(wait_queue_head_t *q, unsigned int mode, con
st int sync)
{
        struct list_head *tmp, *head;
        struct task_struct *p;
        unsigned long flags;

        if (!q)
                goto out;

        wq_write_lock_irqsave(&q->lock, flags);

#if WAITQUEUE_DEBUG
        CHECK_MAGIC_WQHEAD(q);  <<<<<<<<<<<<<<<-- Magic numbers are wrong!!!
#endif

        head = &q->task_list;
#if WAITQUEUE_DEBUG
        if (!head->next || !head->prev)
                WQ_BUG();
#endif
        list_for_each(tmp, head) {
                unsigned int state;
                wait_queue_t *curr = list_entry(tmp, wait_queue_t, task_list);

#if WAITQUEUE_DEBUG
                CHECK_MAGIC(curr->__magic);
#endif
                p = curr->task;
                state = p->state;
                if (state & (mode & ~TASK_EXCLUSIVE)) {
#if WAITQUEUE_DEBUG
                        curr->__waker = (long)__builtin_return_address(0);
#endif
                        if (sync)
                                wake_up_process_synchronous(p);
                        else
                                wake_up_process(p);
                        if (state & mode & TASK_EXCLUSIVE)
                                break;
                }
        }
        wq_write_unlock_irqrestore(&q->lock, flags);
out:
        return;
}


The last message before we die is "Freeing unused kernel memory: 48k init".
This is generated from the free_initmem() routine in arch/ppc/mm/init.c.
free_initmem() gets call from init() in init/main.c.

static int init(void * unused)
{
        lock_kernel();
        do_basic_setup();

        /*
         * Ok, we have completed the initial bootup, and
         * we're essentially up and running. Get rid of the
         * initmem segments and start the user-mode stuff..
         */
        free_initmem();  <<<<<<<<<<<<<<<-- We go this far w/o probems
        unlock_kernel();

        if (open("/dev/console", O_RDWR, 0) < 0)
                printk("Warning: unable to open an initial console.\n");

        (void) dup(0);
        (void) dup(0);

        /*
         * We try each of these until one succeeds.
         *
         * The Bourne shell can be used instead of init if we are
         * trying to recover a really broken machine.
         */

        if (execute_command)
                execve(execute_command,argv_init,envp_init);
        execve("/sbin/init",argv_init,envp_init);
        execve("/etc/init",argv_init,envp_init);
        execve("/bin/init",argv_init,envp_init);
        execve("/bin/sh",argv_init,envp_init);
        panic("No init found.  Try passing init= option to kernel.");
}


Does anybody have any hints on how I might try to debug this problem?
Options that I have thought about:

- Boot sash instead of init

Ok, I have modifified the boot params to include init=/bin/sash.
I am able to run /bin/sash, but init is giving me grief.

Note: The root file system is from the MontaVista Hard Hat Linux
      version 1.1.

./ppc_8xx/RPMS/hhl-ppc_8xx-sysvinit-2.77-6.noarch.rpm

Attached TCP/IP interface to motfcc0.
Subnet Mask: 0xff000000
Attaching network interface lo0... done.
Loading... 45680 + 465921
Starting at 0x400000...

loaded at:     00400000 0040B270
board data at: 00FFFFC0 00FFFFE4
relocated to:  00200100 00200124
zimage at:     0040B270 0047CE71
avail ram:     0047D000 01000000

Linux/PPC load: root=/dev/nfs rw nfsroot=126.28.1.117:/target nfsaddrs=126.1.4.5:126.28.1.117::255.0.0.0 init=/bin/sash
Uncompressing Linux...done.
Now booting the kernel
Total memory = 16MB; using 0kB for hash table (at 00000000)
Linux version 2.3.99-pre9 (diekema@dell) (gcc version 2.95.2 19991024 (release)) #45 Sat May 20 21:08:00 EDT 2000
Boot arguments: root=/dev/nfs rw nfsroot=126.28.1.117:/target nfsaddrs=126.1.4.5:126.28.1.117::255.0.0.0 init=/bin/sash
On node 0 totalpages: 4096
zone(0): 4096 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Calibrating delay loop... 164.66 BogoMIPS
Memory: 14736k available (860k kernel code, 416k data, 48k init) [c0000000,c1000000]
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
kmem_create: Forcing size word alignment - nfs_fh
Looking up port of RPC 100003/2 on 126.28.1.117
Looking up port of RPC 100005/2 on 126.28.1.117
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 48k init
Stand-alone shell (version 3.4)
> /etc/rc*
+ /sbin/ifconfig lo 127.0.0.1
+
+ mount /proc
+ ifconfig -a
eth0      Link encap:Ethernet  HWaddr 00:A0:1E:01:04:05
          inet addr:126.1.4.5  Bcast:126.255.255.255  Mask:255.0.0.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:1227 errors:0 dropped:0 overruns:0 frame:0
          TX packets:490 errors:0 dropped:0 overruns:0 carrier:0
          collisions:4 txqueuelen:100
          Base address:0x8000

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:3904  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0

+ mount -a
+ mount -o rsize=8192,wsize=8192,rw,remount /

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
