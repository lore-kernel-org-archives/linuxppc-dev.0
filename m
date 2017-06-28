Return-Path: <eguan@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyGJ92DTCzDr0g
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 18:32:41 +1000 (AEST)
Date: Wed, 28 Jun 2017 16:32:37 +0800
From: Eryu Guan <eguan@redhat.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Balbir Singh <bsingharora@gmail.com>, liwan@redhat.com
Subject: [v4.12-rc1 regression] mount ext4 fs results in kernel crash on
 PPC64le host
Message-ID: <20170628083237.GF23360@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

Li Wang and I are constantly seeing ppc64le hosts crashing due to bad
page access. But it's not reproducing on every ppc64le host we've
tested, but it usually happened in filesystem testings.

[  207.403459] Unable to handle kernel paging request for unaligned access at address 0xc0000001c52c5e7f
[  207.403470] Faulting instruction address: 0xc0000000004d470c
[  207.403475] Oops: Kernel access of bad area, sig: 7 [#1]
[  207.403477] SMP NR_CPUS=2048
[  207.403478] NUMA
[  207.403480] pSeries
[  207.403483] Modules linked in: ext4 jbd2 mbcache sg pseries_rng ghash_generic gf128mul xts vmx_crypto nfsd auth_rpcgss nfs_acl lockd grace sunrpc ip_tables xfs libcrc32c sd_mod ibmveth ibmvscsi scsi_transport_srp
[  207.403503] CPU: 0 PID: 2263 Comm: mount Not tainted 4.12.0-rc7 #26
[  207.403506] task: c0000003ef2fde00 task.stack: c0000003de394000
[  207.403509] NIP: c0000000004d470c LR: c00000000011cd24 CTR: c000000000130de0
[  207.403512] REGS: c0000003de397450 TRAP: 0600   Not tainted  (4.12.0-rc7)
[  207.403515] MSR: 800000010280b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE,TM[E]>
[  207.403521]   CR: 28028844  XER: 00000001
[  207.403525] CFAR: c00000000011cd20 DAR: c0000001c52c5e7f DSISR: 00000000 SOFTE: 0
[  207.403525] GPR00: c00000000011cce8 c0000003de3976d0 c000000001049500 c0000003f2c6ec20
[  207.403525] GPR04: c0000003f2c6ec20 c0000001c52c5e7f 0000000000000000 0000000000000001
[  207.403525] GPR08: 000c5543cab19830 0000000198e19900 0000000000000008 0000000000000000
[  207.403525] GPR12: c000000000130de0 c00000000fac0000 0000000000000000 c0000003f1328000
[  207.403525] GPR16: 0000000000000000 c0000003de700400 0000000000000000 c0000003de700594
[  207.403525] GPR20: 0000000000000002 0000000000000000 0000000000004000 c000000000cc5780
[  207.403525] GPR24: 00000001c45ffc5f 0000000000000000 00000001c45ffc5f c00000000107dd00
[  207.403525] GPR28: c0000003f2c6f434 0000000000000004 0000000000000800 c0000003f2c6ec00
[  207.403567] NIP [c0000000004d470c] llist_add_batch+0xc/0x40
[  207.403571] LR [c00000000011cd24] try_to_wake_up+0x4a4/0x5b0
[  207.403573] Call Trace:
[  207.403576] [c0000003de3976d0] [c00000000011cce8] try_to_wake_up+0x468/0x5b0 (unreliable)
[  207.403581] [c0000003de397750] [c000000000102cc8] create_worker+0x148/0x250
[  207.403585] [c0000003de3977f0] [c000000000105e7c] alloc_unbound_pwq+0x3bc/0x4c0
[  207.403589] [c0000003de397850] [c0000000001064bc] apply_wqattrs_prepare+0x2ac/0x320
[  207.403593] [c0000003de3978c0] [c00000000010656c] apply_workqueue_attrs_locked+0x3c/0xa0
[  207.403597] [c0000003de3978f0] [c000000000106acc] apply_workqueue_attrs+0x4c/0x80
[  207.403601] [c0000003de397930] [c00000000010866c] __alloc_workqueue_key+0x16c/0x4e0
[  207.403615] [c0000003de3979f0] [d000000013de5ce0] ext4_fill_super+0x1c70/0x3390 [ext4]
[  207.403620] [c0000003de397b30] [c00000000031739c] mount_bdev+0x21c/0x250
[  207.403633] [c0000003de397bd0] [d000000013dddb80] ext4_mount+0x20/0x40 [ext4]
[  207.403637] [c0000003de397bf0] [c000000000318944] mount_fs+0x74/0x210
[  207.403641] [c0000003de397ca0] [c000000000340638] vfs_kern_mount+0x68/0x1d0
[  207.403644] [c0000003de397d10] [c000000000345348] do_mount+0x278/0xef0
[  207.403648] [c0000003de397de0] [c0000000003463e4] SyS_mount+0x94/0x100
[  207.403652] [c0000003de397e30] [c00000000000af84] system_call+0x38/0xe0
[  207.403655] Instruction dump:
[  207.403658] 60420000 38600000 4e800020 60000000 60420000 7c832378 4e800020 60000000
[  207.403663] 60000000 e9250000 f9240000 7c0004ac <7d4028a8> 7c2a4800 40c20010 7c6029ad
[  207.403669] ---[ end trace 4fa94bf890f28f69 ]---

Today I've finally found a host that could reliably trigger the crash by
mounting an ext4 filesystem and I've done a git bisect. The first bad
pointed to this commit:

commit 9c355917fcf006af47ffaa5ae43a1a804764a6f6
Author: Balbir Singh <bsingharora@gmail.com>
Date:   Wed Apr 12 16:35:19 2017 +1000

    powerpc/tracing: Allow tracing of mmap syscalls
    
    Currently sys_mmap() and sys_mmap2() (32-bit only), are not visible to the
    syscall tracing machinery. This means users are not able to see the execution of
    mmap() syscalls using the syscall tracer.
    
    Fix that by using SYSCALL_DEFINE6 for sys_mmap() and sys_mmap2() so that the
    meta-data associated with these syscalls is visible to the syscall tracer.
    
    A side-effect of this change is that the return type has changed from unsigned
    long to long. However this should have no effect, the only code in the kernel
    which uses the result of these syscalls is in the syscall return path, which is
    written in asm and treats the result as unsigned regardless.
    
    Example output:
      cat-3399  [001] ....   196.542410: sys_mmap(addr: 7fff922a0000, len: 20000, prot: 3, flags: 812, fd: 3, offset: 1b0000)
      cat-3399  [001] ....   196.542443: sys_mmap -> 0x7fff922a0000
      cat-3399  [001] ....   196.542668: sys_munmap(addr: 7fff922c0000, len: 6d2c)
      cat-3399  [001] ....   196.542677: sys_munmap -> 0x0
    
    Signed-off-by: Balbir Singh <bsingharora@gmail.com>
    [mpe: Massage change log, add detail on return type change]
    Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

And I've confirmed that reverting above commit 'resolves' the crash. I
appended memory and cpu information of the host to the end of this
email, if you need more detailed information please let me know.

Thanks,
Eryu

[root@ibm-p8-03-lp6 ~]# free
              total        used        free      shared  buff/cache   available
Mem:       18756864      399552    17880704       12672      476608    17470592
Swap:       7864256           0     7864256
[root@ibm-p8-03-lp6 ~]# lscpu
Architecture:          ppc64le
Byte Order:            Little Endian
CPU(s):                16
On-line CPU(s) list:   0-15
Thread(s) per core:    8
Core(s) per socket:    1
Socket(s):             2
NUMA node(s):          3
Model:                 2.1 (pvr 004b 0201)
Model name:            POWER8 (architected), altivec supported
Hypervisor vendor:     (null)
Virtualization type:   full
L1d cache:             64K
L1i cache:             32K
NUMA node0 CPU(s):     0-7
NUMA node2 CPU(s):     8-15
NUMA node3 CPU(s):
