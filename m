Message-Id: <5.1.0.14.0.20020802171621.03b8ac48@synergy>
Date: Fri, 02 Aug 2002 17:53:28 -0700
To: linuxppc-dev@lists.linuxppc.org
From: Rob Baxter <robb@synergymicro.com>
Subject: 1GB of Memory on UP Kernel (2.4.19) Fails
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm not able to boot an UP kernel on an SMP platform when the amount
of local memory is greater than 512MB, in this case 1GB.  The kernel
boots just fine when configured for SMP and/or when the size of local
memory is less than or equal to 512MB.


Starting:
loaded at:     00010000 0011E2C0
relocated to:  00800000 0090E2C0
zimage at:     00806000 008C6C70
sysmap at:     008C6C74 00909CF8
avail ram:     00400000 00800000

Command line:
Uncompressing Linux...done.
Memory BAT mapping: BAT2=256Mb, BAT3=256Mb, residual: 768Mb
Total memory = 1024MB; using 2048kB for hash table (at c0200000)
Linux version 2.4.19A (robb@mothra.ioinc.tucson.az.us) (gcc version 2.95.3
20010
111 (prerelease/franzo/20010111)) #1 Fri Aug 2 17:22:53 MST 2002
PCI: Galileo Discovery host bridge, 2 PCI controllers
On node 0 totalpages: 262144
zone(0): 196608 pages.
zone(1): 0 pages.
zone(2): 65536 pages.
Kernel command line:
Synergy RPIC interrupt controller at 0xffec0000
RPIC timer frequency: 4166666Hz
Calibrating delay loop... 999.42 BogoMIPS
Memory: 1031156k available (1388k kernel code, 484k data, 116k init,
262144k hig
hmem)
System.map loaded at 0xc08c6c74 for debugger, size: 274564 bytes
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)

.
.
.

VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 116k init
kernel BUG at /sandbox/robb/linux-2.4.19A/include/asm/highmem.h:105!
Oops: Exception in kernel mode, sig: 4
NIP: C0028110 XER: 00000000 LR: C0028110 SP: C150D9C0 REGS: c150d910 TRAP: 0700
    Not tainted
MSR: 00089032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c150c000[1] 'init' Last syscall: 11
last math 00000000 last altivec 00000000
GPR00: C0028110 C150D9C0 C150C000 00000045 00001032 00000001 00000020 C01C0000
GPR08: 000011E4 C0193DA0 00000000 C150D8E0 0000FFFF 00000000 10000000 1001754C
GPR16: C150DCCC 00000060 00000001 EFE9E6A0 00009032 0150DAF0 00000000 C0006358
GPR24: C01C1080 30027660 C1509D20 C01AF240 C01AD09C C1509D50 30027660 C01C0000
Call backtrace:
C0028110 C0028454 C00106C0 C0006358 FFFFFFEA C0058D4C C00596A8
C004569C C0045A08 C0009318 C000611C C0003E2C C0008AF8
Kernel panic: Attempted to kill init!
  <0>Rebooting in 180 seconds..

The "BUG" statement is from ./asm-ppc/highmem.h, the inline function
kmap_atomic():

#if HIGHMEM_DEBUG
         if (!pte_none(*(kmap_pte+idx)))
                 BUG();
#endif

Observation when hunting down the problem; I think the line
in ./arch/ppc/mm/pgtable.c:

         printk(KERN_INFO "Memory BAT mapping: BAT2=%ldMb, BAT3=%ldMb,"
                         " residual: %ldMb\n", __bat2 >> 20, __bat3 >> 20,
                         (total_lowmem - (__bat2 - __bat3)) >> 20);

should be:

         printk(KERN_INFO "Memory BAT mapping: BAT2=%ldMb, BAT3=%ldMb,"
                         " residual: %ldMb\n", __bat2 >> 20, __bat3 >> 20,
                         (total_memory - (__bat2 + __bat3)) >> 20);

Thanks in advance and sorry for long post.

Rob Baxter
Synergy Microsystems


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
