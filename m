Return-Path: <sachinp@in.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [59.145.155.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp02.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 53035DDFAE
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Apr 2009 17:57:23 +1000 (EST)
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by e28smtp02.in.ibm.com (8.13.1/8.13.1) with ESMTP id n387vHgm013237
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Apr 2009 13:27:17 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n387vRcc3494070
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Apr 2009 13:27:27 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
	by d28av05.in.ibm.com (8.13.1/8.13.3) with ESMTP id n387vGsi001880
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Apr 2009 17:57:16 +1000
Message-ID: <49DC58DD.8090006@in.ibm.com>
Date: Wed, 08 Apr 2009 13:27:17 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [2.6.30-rc1] Crash in .hpte_need_flush with hugetlbfs test[shm-fork]
Content-Type: multipart/mixed; boundary="------------080302040802060100050902"
Cc: libhugetlbfs-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------080302040802060100050902
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I was executing libhugetlbfs tests on a power6 box [9117-MMA]. One of the
sub test (shm-fork) caused the machine to crash. Here is the information :

llm62 login: cpu 0x1: Vector: 300 (Data Access) at [c0000000f9827490]
    pc: c000000000038028: .hpte_need_flush+0x1b8/0x2d8
    lr: c000000000037edc: .hpte_need_flush+0x6c/0x2d8
    sp: c0000000f9827710
   msr: 8000000000009032
   dar: c0000000d0157260
 dsisr: 40000000
  current = 0xc0000000f970bc20
  paca    = 0xc000000000a82500
    pid   = 11314, comm = shm-fork
enter ? for help
[c0000000f9827710] c000000000038050 .hpte_need_flush+0x1e0/0x2d8 (unreliable)
[c0000000f98277d0] c000000000039d78 .huge_ptep_get_and_clear+0x40/0x5c
[c0000000f9827850] c00000000010fe88 .__unmap_hugepage_range+0x178/0x2b8
[c0000000f9827940] c00000000011001c .unmap_hugepage_range+0x54/0x88
[c0000000f98279e0] c0000000000f9dc4 .unmap_vmas+0x178/0x8f4
[c0000000f9827b30] c0000000000ff4f4 .unmap_region+0xfc/0x1d8
[c0000000f9827c00] c000000000100c68 .do_munmap+0x2f4/0x38c
[c0000000f9827cc0] c000000000289a74 .SyS_shmdt+0xc0/0x188
[c0000000f9827d70] c00000000000c30c .sys_ipc+0x26c/0x2f4
[c0000000f9827e30] c0000000000084ac syscall_exit+0x0/0x40
--- Exception: c01 (System Call) at 000004000020d2dc
SP (fffd23a3c50) is in userspace
1:mon> di %pc
c000000000038028  eb898000      ld      r28,-32768(r9)
c00000000003802c  2f800000      cmpwi   cr7,r0,0
c000000000038030  409e0028      bne     cr7,c000000000038058    #
.hpte_need_flush+0x1e8/0x2d8
c000000000038034  7fe3fb78      mr      r3,r31
c000000000038038  7f24cb78      mr      r4,r25
c00000000003803c  7f85e378      mr      r5,r28
c000000000038040  7f6607b4      extsw   r6,r27
c000000000038044  7fa7eb78      mr      r7,r29
c000000000038048  39000000      li      r8,0
c00000000003804c  4bffc2cd      bl      c000000000034318        #
.flush_hash_page+0x0/0x1c0
c000000000038050  60000000      nop
c000000000038054  480000bc      b       c000000000038110        #
.hpte_need_flush+0x2a0/0x2d8
c000000000038058  7f0b07b5      extsw.  r11,r24
c00000000003805c  41820030      beq     c00000000003808c        #
.hpte_need_flush+0x21c/0x2d8
c000000000038060  e81e0010      ld      r0,16(r30)
c000000000038064  7fba0000      cmpd    cr7,r26,r0
1:mon>  r
R00 = 0000000000000000   R16 = 000000004f42e5b0
R01 = c0000000f9827710   R17 = 0000000000000000
R02 = c00000000098cf58   R18 = ffffffffffff9010
R03 = 0000000000000004   R19 = 0000000000000000
R04 = 000003ffec000000   R20 = 0000000000000000
R05 = c0000000d014f260   R21 = 0000040000000000
R06 = 0000220008000393   R22 = c0000000d014f260
R07 = 0000000000000001   R23 = 0000000000760000
R08 = 0000000000000004   R24 = 0000000000000000
R09 = c0000000d015f260   R25 = 0000220008000393
R10 = 000000000003ffec   R26 = c0000000f947ca80
R11 = 0000000000000330   R27 = 0000000000000004
R12 = 0000000024022422   R28 = c000000000790430
R13 = c000000000a82500   R29 = 0000000000000001
R14 = 0000000000000010   R30 = c000000000ef0430
R15 = ffffffffffffffff   R31 = 0fa89fffec000000
pc  = c000000000038028 .hpte_need_flush+0x1b8/0x2d8
lr  = c000000000037edc .hpte_need_flush+0x6c/0x2d8
msr = 8000000000009032   cr  = 44022424
ctr = c0000000000fedc0   xer = 0000000000000001   trap =  300
dar = c0000000d0157260   dsisr = 40000000
1:mon> di %lr
c000000000037edc  60000000      nop
c000000000037ee0  7c7b1b78      mr      r27,r3
c000000000037ee4  e8028cd8      ld      r0,-29480(r2)
c000000000037ee8  7fbf0040      cmpld   cr7,r31,r0
c000000000037eec  419d00a8      bgt     cr7,c000000000037f94    #
.hpte_need_flush+0x124/0x2d8
c000000000037ef0  3800ffff      li      r0,-1
c000000000037ef4  3ba00000      li      r29,0
c000000000037ef8  78000600      clrldi  r0,r0,24
c000000000037efc  7fbf0040      cmpld   cr7,r31,r0
c000000000037f00  409d000c      ble     cr7,c000000000037f0c    #
.hpte_need_flush+0x9c/0x2d8
c000000000037f04  e9228ce0      ld      r9,-29472(r2)
c000000000037f08  eba90002      lwa     r29,0(r9)
c000000000037f0c  2fbd0000      cmpdi   cr7,r29,0
c000000000037f10  e97a0390      ld      r11,912(r26)
c000000000037f14  409e003c      bne     cr7,c000000000037f50    #
.hpte_need_flush+0xe0/0x2d8
c000000000037f18  796b83e4      rldicr  r11,r11,16,47
1:mon>

CONFIG_PPC_64K_PAGES=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y

Have attached the dmesg log extracted via xmon. The libhugetlbfs
tests [v2.0] are part of autotest framework [autotest.kernel.org].
The sub test that caused this was shm-fork. I have attached the
libhugetlbfs execution log.

Thanks
-Sachin

-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------


--------------080302040802060100050902
Content-Type: text/plain;
 name="dmesg_log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg_log"

72 bind 65536).
<6>TCP reno registered.
<6>NET: Registered protocol family 1.
<6>Unpacking initramfs... done.
<7>irq: irq 655360 on host null mapped to virtual irq 17.
<7>irq: irq 655362 on host null mapped to virtual irq 18.
<6>IOMMU table initialized, virtual merging enabled.
<7>irq: irq 589825 on host null mapped to virtual irq 19.
<7>RTAS daemon started.
<4>====[ backtrace testing ]===========.
<4>Testing a backtrace from process context..
<4>The following trace is a kernel self test and not a bug!.
<4>Call Trace:.
<4>[c0000000fe843c70] [c0000000000115ac] .show_stack+0x6c/0x16c (unreliable).
<4>[c0000000fe843d20] [c00000000009f91c] .backtrace_regression_test+0x44/0x134.
<4>[c0000000fe843e10] [c000000000009238] .do_one_initcall+0x80/0x19c.
<4>[c0000000fe843f00] [c000000000730370] .kernel_init+0x1a8/0x224.
<4>[c0000000fe843f90] [c00000000002b62c] .kernel_thread+0x54/0x70.
<4>Testing a backtrace from irq context..
<4>The following trace is a kernel self test and not a bug!.
<4>Call Trace:.
<4>[c000000001f9fcf0] [c0000000000115ac] .show_stack+0x6c/0x16c (unreliable).
<4>[c000000001f9fda0] [c00000000009f8b4] .backtrace_test_irq_callback+0x18/0x3c.
<4>[c000000001f9fe20] [c00000000006d1b4] .tasklet_action+0xec/0x1ac.
<4>[c000000001f9fec0] [c00000000006dc84] .__do_softirq+0x124/0x258.
<4>[c000000001f9ff90] [c00000000002b468] .call_do_softirq+0x14/0x24.
<4>[c0000000fe85bdb0] [c00000000000d4f0] .do_softirq+0x88/0xf0.
<4>[c0000000fe85be50] [c00000000006d628] .ksoftirqd+0xb8/0x184.
<4>[c0000000fe85bf00] [c0000000000827ac] .kthread+0x78/0xc4.
<4>[c0000000fe85bf90] [c00000000002b62c] .kernel_thread+0x54/0x70.
<4>Testing a saved backtrace..
<4>The following trace is a kernel self test and not a bug!.
<4> [000000009f9d0>] .backtrace_regression_test+0xf8/0x134.
<4> [000000009238>] .do_one_initcall+0x80/0x19c.
<4> [
<c000000000730370>] .kernel_init+0x1a8/0x224.
<4> [
<c00000000002b62c>] .kernel_thread+0x54/0x70.
<4>====[ end of backtrace testing ]====.
<6>audit: initializing netlink socket (disabled).
<5>type=2000 audit(1239168602.587:1): initialized.
<6>Kprobe smoke test started.
<6>Kprobe smoke test passed successfully.
<1>rcu-torture:--- Start of test: nreaders=8 nfakewriters=4 stat_interval=0 verbose=0 test_no_idle_hz=0 shuffle_interval=3 stutter=5 irqreader=1.
<6>HugeTLB registered 16 MB page size, pre-allocated 0 pages.
<6>HugeTLB registered 16 GB page size, pre-allocated 0 pages.
<5>VFS: Disk quotas dquot_6.5.2.
<4>Dquot-cache hash table entries: 8192 (order 0, 65536 bytes).
<6>JFS: nTxBlock = 1896, nTxLock = 15168.
<6>msgmni has been set to 7584.
<6>alg: No test for stdrng (krng).
<6>Block layer SCSI generic (bsg) driver version 0.4 loaded (major 254).
<6>io scheduler noop registered.
<6>io scheduler anticipatory registered.
<6>io scheduler deadline registered.
<6>io scheduler cfq registered (default).
<6>pci_hotplug: PCI Hot Plug PCI Core version: 0.5.
<6>rpaphp: RPA HOT Plug PCI Controller Driver version: 0.1.
<7>vio_register_driver: driver hvc_console registering.
<7>HVSI: registered 0 devices.
<6>Generic RTC Driver v1.07.
<6>Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled.
<6>input: Macintosh mouse button emulation as /class/input/input0.
<6>Uniform Multi-Platform E-IDE driver.
<6>ide-gd driver 1.18.
<7>vio_register_driver: driver ibmvscsi registering.
<6>ibmvscsi 30000002: SRP_VERSION: 16.a.
<6>scsi0 : IBM POWER Virtual SCSI Adapter 1.5.8.
<6>ibmvscsi 30000002: partner initialization complete.
<6>ibmvscsi 30000002: sent SRP login.
<6>ibmvscsi 30000002: SRP_LOGIN succeeded.
<6>ibmvscsi 30000002: host srp version: 16.a, host partition VIO (1), OS 3, max io 1048576.
<5>scsi 0:0:1:0: Direct-Access     AIX      VDASD            0001 PQ: 0 ANSI: 3.
<4>Driver 'sd' needs updating - please use bus_type methods.
<5>sd 0:0:1:0: Attached scsi generic sg0 type 0.
<6>ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver.
<6>ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver.
<5>sd 0:0:1:0: [sda] 167772160 512-byte hardware sectors: (85.8 GB/80.0 GiB).
<5>sd 0:0:1:0: [sda] Write Protect is off.
<7>sd 0:0:1:0: [sda] Mode Sense: 17 00 00 08.
<5>sd 0:0:1:0: [sda] Cache data unavailable.
<3>sd 0:0:1:0: [sda] Assuming drive cache: write through.
<5>sd 0:0:1:0: [sda] Cache data unavailable.
<3>sd 0:0:1:0: [sda] Assuming drive cache: write through.
<6> sda: sda1 sda2 
< sda5 > sda3 sda4.
<5>sd 0:0:1:0: [sda] Attached SCSI disk.
<6>mice: PS/2 mouse device common for all mice.
<6>EDAC MC: Ver: 2.1.0 Apr  8 2009.
<6>usbcore: registered new interface driver hiddev.
<6>usbcore: registered new interface driver usbhid.
<6>usbhid: v2.6:USB HID core driver.
<6>TCP cubic registered.
<6>NET: Registered protocol family 15.
<7>Running code patching self-tests ....
<7>Running feature fixup self-tests ....
<7>Running MSI bitmap self-tests ....
<4>registered taskstats version 1.
<4>Freeing unused kernel memory: 448k freed.
<6>SysRq : Changing Loglevel.
<4>Loglevel set to 1.
<6>udevd version 128 started.
<6>kjournald starting.  Commit interval 5 seconds.
<6>EXT3 FS on sda5, internal journal.
<6>EXT3-fs: mounted filesystem with writeback data mode..
<6>udevd version 128 started.
<6>IBM eHEA ethernet device driver (Release EHEA_0100).
<7>irq: irq 590080 on host null mapped to virtual irq 256.
<6>ehea: eth0: Jumbo frames are disabled.
<6>ehea: eth0 -> logical port id #2.
<6>Adding 1044096k swap on /dev/sda3.  Priority:-1 extents:1 across:1044096k .
<6>device-mapper: uevent: version 1.0.3.
<6>device-mapper: ioctl: 4.14.0-ioctl (2008-04-23) initialised: dm-devel@redhat.com.
<6>loop: module loaded.
<6>fuse init (API version 7.11).
<6>ehea: eth0: Physical port up.
<6>ehea: External switch port is backup port.
<7>irq: irq 776 on host null mapped to virtual irq 264.
<7>irq: irq 777 on host null mapped to virtual irq 265.
<6>NET: Registered protocol family 10.
<6>lo: Disabled Privacy Extensions.
<7>eth0: no IPv6 routers present.
<1>Unable to handle kernel paging request for data at address 0xc0000000d0157260.
<1>Faulting instruction address: 0xc000000000038028........................

--------------080302040802060100050902
Content-Type: text/plain;
 name="libhugetlbfs.runlog"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libhugetlbfs.runlog"

/usr/bin/gcc
         VERSION
version string: 2.0
         CC32 obj32/elflink.o
         AS32 obj32/sys-elf32ppclinux.o
         CC32 obj32/elf32ppclinux.o
         CC32 obj32/hugeutils.o
         CC32 obj32/version.o
         CC32 obj32/init.o
         CC32 obj32/morecore.o
         CC32 obj32/debug.o
         CC32 obj32/alloc.o
         LD32 (shared) obj32/libhugetlbfs.so
         CC64 obj64/elflink.o
         AS64 obj64/sys-elf64ppc.o
         CC64 obj64/elf64ppc.o
         CC64 obj64/hugeutils.o
         CC64 obj64/version.o
         CC64 obj64/init.o
         CC64 obj64/morecore.o
         CC64 obj64/debug.o
         CC64 obj64/alloc.o
         LD64 (shared) obj64/libhugetlbfs.so
         AR32 obj32/libhugetlbfs.a
         AR64 obj64/libhugetlbfs.a
         CC32 obj32/gethugepagesize.o
         CC32 obj32/testutils.o
         LD32 (lib test) obj32/gethugepagesize
         CC32 obj32/test_root.o
         LD32 (lib test) obj32/test_root
         CC32 obj32/find_path.o
         LD32 (lib test) obj32/find_path
         CC32 obj32/unlinked_fd.o
         LD32 (lib test) obj32/unlinked_fd
         CC32 obj32/misalign.o
         LD32 (lib test) obj32/misalign
         CC32 obj32/readback.o
         LD32 (lib test) obj32/readback
         CC32 obj32/truncate.o
         LD32 (lib test) obj32/truncate
         CC32 obj32/shared.o
         LD32 (lib test) obj32/shared
         CC32 obj32/private.o
         LD32 (lib test) obj32/private
         CC32 obj32/fork-cow.o
         LD32 (lib test) obj32/fork-cow
         CC32 obj32/empty_mounts.o
         LD32 (lib test) obj32/empty_mounts
         CC32 obj32/large_mounts.o
         LD32 (lib test) obj32/large_mounts
         CC32 obj32/meminfo_nohuge.o
         LD32 (lib test) obj32/meminfo_nohuge
         CC32 obj32/ptrace-write-hugepage.o
         LD32 (lib test) obj32/ptrace-write-hugepage
         CC32 obj32/icache-hygiene.o
         LD32 (lib test) obj32/icache-hygiene
         CC32 obj32/slbpacaflush.o
         LD32 (lib test) obj32/slbpacaflush
         CC32 obj32/chunk-overcommit.o
         LD32 (lib test) obj32/chunk-overcommit
         CC32 obj32/mprotect.o
         LD32 (lib test) obj32/mprotect
         CC32 obj32/alloc-instantiate-race.o
         LD32 (lib test) obj32/alloc-instantiate-race
         CC32 obj32/mlock.o
         LD32 (lib test) obj32/mlock
         CC32 obj32/truncate_reserve_wraparound.o
         LD32 (lib test) obj32/truncate_reserve_wraparound
         CC32 obj32/truncate_sigbus_versus_oom.o
         LD32 (lib test) obj32/truncate_sigbus_versus_oom
         CC32 obj32/map_high_truncate_2.o
         LD32 (lib test) obj32/map_high_truncate_2
         CC32 obj32/truncate_above_4GB.o
         LD32 (lib test) obj32/truncate_above_4GB
         CC32 obj32/direct.o
         LD32 (lib test) obj32/direct
         CC32 obj32/misaligned_offset.o
         LD32 (lib test) obj32/misaligned_offset
         CC32 obj32/brk_near_huge.o
         LD32 (lib test) obj32/brk_near_huge
         CC32 obj32/task-size-overrun.o
         LD32 (lib test) obj32/task-size-overrun
         CC32 obj32/stack_grow_into_huge.o
         LD32 (lib test) obj32/stack_grow_into_huge
         CC32 obj32/counters.o
         LD32 (lib test) obj32/counters
         CC32 obj32/quota.o
         LD32 (lib test) obj32/quota
         CC32 obj32/heap-overflow.o
         LD32 (lib test) obj32/heap-overflow
         CC32 obj32/get_huge_pages.o
         LD32 (lib test) obj32/get_huge_pages
         CC32 obj32/malloc.o
         LD32 (nolib test) obj32/malloc
         CC32 obj32/malloc_manysmall.o
         LD32 (nolib test) obj32/malloc_manysmall
         CC32 obj32/dummy.o
         LD32 (nolib test) obj32/dummy
         CC32 obj32/heapshrink.o
         LD32 (nolib test) obj32/heapshrink
         CC32 obj32/mmap-gettest.o
         LD32 (lib test) obj32/mmap-gettest
         CC32 obj32/mmap-cow.o
         LD32 (lib test) obj32/mmap-cow
         CC32 obj32/shm-gettest.o
         LD32 (lib test) obj32/shm-gettest
         CC32 obj32/shm-getraw.o
         LD32 (lib test) obj32/shm-getraw
         CC32 obj32/shm-fork.o
         LD32 (lib test) obj32/shm-fork
         CC32 obj32/zero_filesize_segment.o
         LD32 (preload test) obj32/zero_filesize_segment
collect2: ld terminated with signal 11 [Segmentation fault]
         CC32 obj32/linkhuge.o
         LD32 (hugelink test) obj32/linkhuge
         CC32 obj32/linkhuge_nofd.o
         LD32 (hugelink test) obj32/linkhuge_nofd
         CC32 obj32/linkshare.o
         LD32 (hugelink test) obj32/linkshare
         LD32 (xB test) obj32/xB.linkhuge
         LD32 (xB test) obj32/xB.linkhuge_nofd
         LD32 (xB test) obj32/xB.linkshare
         LD32 (xBDT test) obj32/xBDT.linkhuge
         LD32 (xBDT test) obj32/xBDT.linkhuge_nofd
         LD32 (xBDT test) obj32/xBDT.linkshare
         CC32 obj32/linkhuge_rw.o
         LD32 (hugelink_rw test) obj32/linkhuge_rw
         CC64 obj64/gethugepagesize.o
         CC64 obj64/testutils.o
         LD64 (lib test) obj64/gethugepagesize
         CC64 obj64/test_root.o
         LD64 (lib test) obj64/test_root
         CC64 obj64/find_path.o
         LD64 (lib test) obj64/find_path
         CC64 obj64/unlinked_fd.o
         LD64 (lib test) obj64/unlinked_fd
         CC64 obj64/misalign.o
         LD64 (lib test) obj64/misalign
         CC64 obj64/readback.o
         LD64 (lib test) obj64/readback
         CC64 obj64/truncate.o
         LD64 (lib test) obj64/truncate
         CC64 obj64/shared.o
         LD64 (lib test) obj64/shared
         CC64 obj64/private.o
         LD64 (lib test) obj64/private
         CC64 obj64/fork-cow.o
         LD64 (lib test) obj64/fork-cow
         CC64 obj64/empty_mounts.o
         LD64 (lib test) obj64/empty_mounts
         CC64 obj64/large_mounts.o
         LD64 (lib test) obj64/large_mounts
         CC64 obj64/meminfo_nohuge.o
         LD64 (lib test) obj64/meminfo_nohuge
         CC64 obj64/ptrace-write-hugepage.o
         LD64 (lib test) obj64/ptrace-write-hugepage
         CC64 obj64/icache-hygiene.o
         LD64 (lib test) obj64/icache-hygiene
         CC64 obj64/slbpacaflush.o
         LD64 (lib test) obj64/slbpacaflush
         CC64 obj64/chunk-overcommit.o
         LD64 (lib test) obj64/chunk-overcommit
         CC64 obj64/mprotect.o
         LD64 (lib test) obj64/mprotect
         CC64 obj64/alloc-instantiate-race.o
         LD64 (lib test) obj64/alloc-instantiate-race
         CC64 obj64/mlock.o
         LD64 (lib test) obj64/mlock
         CC64 obj64/truncate_reserve_wraparound.o
         LD64 (lib test) obj64/truncate_reserve_wraparound
         CC64 obj64/truncate_sigbus_versus_oom.o
         LD64 (lib test) obj64/truncate_sigbus_versus_oom
         CC64 obj64/map_high_truncate_2.o
         LD64 (lib test) obj64/map_high_truncate_2
         CC64 obj64/truncate_above_4GB.o
         LD64 (lib test) obj64/truncate_above_4GB
         CC64 obj64/direct.o
         LD64 (lib test) obj64/direct
         CC64 obj64/misaligned_offset.o
         LD64 (lib test) obj64/misaligned_offset
         CC64 obj64/brk_near_huge.o
         LD64 (lib test) obj64/brk_near_huge
         CC64 obj64/task-size-overrun.o
         LD64 (lib test) obj64/task-size-overrun
         CC64 obj64/stack_grow_into_huge.o
         LD64 (lib test) obj64/stack_grow_into_huge
         CC64 obj64/counters.o
         LD64 (lib test) obj64/counters
         CC64 obj64/quota.o
         LD64 (lib test) obj64/quota
         CC64 obj64/heap-overflow.o
         LD64 (lib test) obj64/heap-overflow
         CC64 obj64/get_huge_pages.o
         LD64 (lib test) obj64/get_huge_pages
         CC64 obj64/malloc.o
         LD64 (nolib test) obj64/malloc
         CC64 obj64/malloc_manysmall.o
         LD64 (nolib test) obj64/malloc_manysmall
         CC64 obj64/dummy.o
         LD64 (nolib test) obj64/dummy
         CC64 obj64/heapshrink.o
         LD64 (nolib test) obj64/heapshrink
         CC64 obj64/mmap-gettest.o
         LD64 (lib test) obj64/mmap-gettest
         CC64 obj64/mmap-cow.o
         LD64 (lib test) obj64/mmap-cow
         CC64 obj64/shm-gettest.o
         LD64 (lib test) obj64/shm-gettest
         CC64 obj64/shm-getraw.o
         LD64 (lib test) obj64/shm-getraw
         CC64 obj64/shm-fork.o
         LD64 (lib test) obj64/shm-fork
         CC64 obj64/zero_filesize_segment.o
         LD64 (preload test) obj64/zero_filesize_segment
collect2: ld terminated with signal 11 [Segmentation fault]
         CC64 obj64/linkhuge.o
         LD64 (hugelink test) obj64/linkhuge
         CC64 obj64/linkhuge_nofd.o
         LD64 (hugelink test) obj64/linkhuge_nofd
         CC64 obj64/linkshare.o
         LD64 (hugelink test) obj64/linkshare
         LD64 (xB test) obj64/xB.linkhuge
         LD64 (xB test) obj64/xB.linkhuge_nofd
         LD64 (xB test) obj64/xB.linkshare
         LD64 (xBDT test) obj64/xBDT.linkhuge
         LD64 (xBDT test) obj64/xBDT.linkhuge_nofd
         LD64 (xBDT test) obj64/xBDT.linkshare
         CC64 obj64/linkhuge_rw.o
         LD64 (hugelink_rw test) obj64/linkhuge_rw
         CC64 obj64/straddle_4GB.o
         LD64 (lib test) obj64/straddle_4GB
         CC64 obj64/huge_at_4GB_normal_below.o
         LD64 (lib test) obj64/huge_at_4GB_normal_below
         CC64 obj64/huge_below_4GB_normal_above.o
         LD64 (lib test) obj64/huge_below_4GB_normal_above
         CC32 obj32/get_hugetlbfs_path.o
         LD32 (helper) obj32/get_hugetlbfs_path
         CC64 obj64/get_hugetlbfs_path.o
         LD64 (helper) obj64/get_hugetlbfs_path
         CC32 obj32/heapshrink-helper-pic.o
         LD32 (shared) obj32/libheapshrink.so
         CC64 obj64/heapshrink-helper-pic.o
         LD64 (shared) obj64/libheapshrink.so
         CC obj/hugectl
         CC obj/hugeedit
Benchmark started. Number of iterations: 1
Executing iteration 1 of 1
zero_filesize_segment (32):     Bad toolchain: can't build this testcase
zero_filesize_segment (64):     Bad toolchain: can't build this testcase
test_root (32): PASS
test_root (64): PASS
meminfo_nohuge (32):    PASS
meminfo_nohuge (64):    PASS
gethugepagesize (32):   PASS
gethugepagesize (64):   PASS
HUGETLB_VERBOSE=1 empty_mounts (32):    PASS
HUGETLB_VERBOSE=1 empty_mounts (64):    PASS
HUGETLB_VERBOSE=1 large_mounts (32):    PASS
HUGETLB_VERBOSE=1 large_mounts (64):    PASS
find_path (32): PASS
find_path (64): PASS
unlinked_fd (32):       PASS
unlinked_fd (64):       PASS
readback (32):  PASS
readback (64):  PASS
truncate (32):  PASS
truncate (64):  PASS
shared (32):    PASS
shared (64):    PASS
mprotect (32):  PASS
mprotect (64):  PASS
mlock (32):     Bad configuration: Locked memory ulimit set below huge page size
mlock (64):     Bad configuration: Locked memory ulimit set below huge page size
misalign (32):  PASS
misalign (64):  PASS
ptrace-write-hugepage (32):     PASS
ptrace-write-hugepage (64):     PASS
icache-hygiene (32):    PASS
icache-hygiene (64):    PASS
slbpacaflush (32):      PASS (inconclusive)
slbpacaflush (64):      PASS (inconclusive)
straddle_4GB (64):      PASS
huge_at_4GB_normal_below (64):  PASS
huge_below_4GB_normal_above (64):       PASS
map_high_truncate_2 (32):       PASS
map_high_truncate_2 (64):       PASS
misaligned_offset (32): PASS (inconclusive)
misaligned_offset (64): PASS (inconclusive)
truncate_above_4GB (32):        PASS
truncate_above_4GB (64):        PASS
brk_near_huge (32):     PASS
brk_near_huge (64):     PASS
task-size-overrun (32): PASS
task-size-overrun (64): PASS
stack_grow_into_huge (32):      PASS
stack_grow_into_huge (64):      PASS
private (32):   PASS
private (64):   PASS
fork-cow (32):  PASS
fork-cow (64):  PASS
direct (32):    PASS
direct (64):    PASS
malloc (32):    PASS
malloc (64):    PASS
LD_PRELOAD=libhugetlbfs.so HUGETLB_MORECORE=yes malloc (32):    PASS
LD_PRELOAD=libhugetlbfs.so HUGETLB_MORECORE=yes malloc (64):    PASS
malloc_manysmall (32):  PASS
malloc_manysmall (64):  PASS
LD_PRELOAD=libhugetlbfs.so HUGETLB_MORECORE=yes malloc_manysmall (32):  PASS
LD_PRELOAD=libhugetlbfs.so HUGETLB_MORECORE=yes malloc_manysmall (64):  PASS
heapshrink (32):        PASS
heapshrink (64):        PASS
LD_PRELOAD=libheapshrink.so heapshrink (32):    PASS
LD_PRELOAD=libheapshrink.so heapshrink (64):    PASS
LD_PRELOAD=libhugetlbfs.so HUGETLB_MORECORE=yes heapshrink (32):        PASS
LD_PRELOAD=libhugetlbfs.so HUGETLB_MORECORE=yes heapshrink (64):        PASS
LD_PRELOAD=libhugetlbfs.so libheapshrink.so HUGETLB_MORECORE=yes heapshrink (32):       PASS
LD_PRELOAD=libhugetlbfs.so libheapshrink.so HUGETLB_MORECORE=yes heapshrink (64):       PASS
LD_PRELOAD=libhugetlbfs.so HUGETLB_MORECORE=yes HUGETLB_MORECORE_SHRINK=yes heapshrink (32):    PASS
LD_PRELOAD=libhugetlbfs.so HUGETLB_MORECORE=yes HUGETLB_MORECORE_SHRINK=yes heapshrink (64):    PASS
LD_PRELOAD=libhugetlbfs.so libheapshrink.so HUGETLB_MORECORE=yes HUGETLB_MORECORE_SHRINK=yes heapshrink (32):   PASS (inconclusive)
LD_PRELOAD=libhugetlbfs.so libheapshrink.so HUGETLB_MORECORE=yes HUGETLB_MORECORE_SHRINK=yes heapshrink (64):   PASS (inconclusive)
HUGETLB_VERBOSE=1 HUGETLB_MORECORE=yes heap-overflow (32):      PASS
HUGETLB_VERBOSE=1 HUGETLB_MORECORE=yes heap-overflow (64):      PASS
HUGETLB_VERBOSE=0 linkhuge_nofd (32):   PASS
HUGETLB_VERBOSE=0 linkhuge_nofd (64):   PASS
LD_PRELOAD=libhugetlbfs.so HUGETLB_VERBOSE=0 linkhuge_nofd (32):        PASS
LD_PRELOAD=libhugetlbfs.so HUGETLB_VERBOSE=0 linkhuge_nofd (64):        PASS
HUGETLB_VERBOSE=0 xB.linkhuge_nofd (32):        obj32/xB.linkhuge_nofd: obj32/xB.linkhuge_nofd: cannot execute binary file
HUGETLB_VERBOSE=0 xB.linkhuge_nofd (64):        obj64/xB.linkhuge_nofd: obj64/xB.linkhuge_nofd: cannot execute binary file
HUGETLB_VERBOSE=0 xBDT.linkhuge_nofd (32):      obj32/xBDT.linkhuge_nofd: obj32/xBDT.linkhuge_nofd: cannot execute binary file
HUGETLB_VERBOSE=0 xBDT.linkhuge_nofd (64):      obj64/xBDT.linkhuge_nofd: obj64/xBDT.linkhuge_nofd: cannot execute binary file
HUGETLB_MINIMAL_COPY=no HUGETLB_VERBOSE=0 xB.linkhuge_nofd (32):        HUGETLB_MINIMAL_COPY=no HUGETLB_VERBOSE=0 xB.linkhuge_nofd (64):        obj32/xB.linkhuge_nofd: obj32/xB.linkhuge_nofd: cannot execute binary file
obj64/xB.linkhuge_nofd: obj64/xB.linkhuge_nofd: cannot execute binary file
HUGETLB_MINIMAL_COPY=no HUGETLB_VERBOSE=0 xBDT.linkhuge_nofd (32):      obj32/xBDT.linkhuge_nofd: obj32/xBDT.linkhuge_nofd: cannot execute binary file
HUGETLB_MINIMAL_COPY=no HUGETLB_VERBOSE=0 xBDT.linkhuge_nofd (64):      obj64/xBDT.linkhuge_nofd: obj64/xBDT.linkhuge_nofd: cannot execute binary file
HUGETLB_ELFMAP=no HUGETLB_VERBOSE=0 xB.linkhuge_nofd (32):      obj32/xB.linkhuge_nofd: obj32/xB.linkhuge_nofd: cannot execute binary file
HUGETLB_ELFMAP=no HUGETLB_VERBOSE=0 xB.linkhuge_nofd (64):      obj64/xB.linkhuge_nofd: obj64/xB.linkhuge_nofd: cannot execute binary file
HUGETLB_ELFMAP=no HUGETLB_VERBOSE=0 xBDT.linkhuge_nofd (32):    obj32/xBDT.linkhuge_nofd: obj32/xBDT.linkhuge_nofd: cannot execute binary file
HUGETLB_ELFMAP=no HUGETLB_VERBOSE=0 xBDT.linkhuge_nofd (64):    obj64/xBDT.linkhuge_nofd: obj64/xBDT.linkhuge_nofd: cannot execute binary file
linkhuge (32):  PASS
linkhuge (64):  PASS
LD_PRELOAD=libhugetlbfs.so linkhuge (32):       PASS
LD_PRELOAD=libhugetlbfs.so linkhuge (64):       PASS
xB.linkhuge (32):       obj32/xB.linkhuge: obj32/xB.linkhuge: cannot execute binary file
xB.linkhuge (64):       obj64/xB.linkhuge: obj64/xB.linkhuge: cannot execute binary file
xBDT.linkhuge (32):     obj32/xBDT.linkhuge: obj32/xBDT.linkhuge: cannot execute binary file
xBDT.linkhuge (64):     obj64/xBDT.linkhuge: obj64/xBDT.linkhuge: cannot execute binary file
HUGETLB_MINIMAL_COPY=no xB.linkhuge (32):       obj32/xB.linkhuge: obj32/xB.linkhuge: cannot execute binary file
HUGETLB_MINIMAL_COPY=no xB.linkhuge (64):       obj64/xB.linkhuge: obj64/xB.linkhuge: cannot execute binary file
HUGETLB_MINIMAL_COPY=no xBDT.linkhuge (32):     obj32/xBDT.linkhuge: obj32/xBDT.linkhuge: cannot execute binary file
HUGETLB_MINIMAL_COPY=no xBDT.linkhuge (64):     obj64/xBDT.linkhuge: obj64/xBDT.linkhuge: cannot execute binary file
HUGETLB_ELFMAP=no xB.linkhuge (32):     obj32/xB.linkhuge: obj32/xB.linkhuge: cannot execute binary file
HUGETLB_ELFMAP=no xB.linkhuge (64):     obj64/xB.linkhuge: obj64/xB.linkhuge: cannot execute binary file
HUGETLB_ELFMAP=no xBDT.linkhuge (32):   obj32/xBDT.linkhuge: obj32/xBDT.linkhuge: cannot execute binary file
HUGETLB_ELFMAP=no xBDT.linkhuge (64):   obj64/xBDT.linkhuge: obj64/xBDT.linkhuge: cannot execute binary file
HUGETLB_SHARE=1 xB.linkshare (32):      obj32/xB.linkshare: obj32/xB.linkshare: cannot execute binary file
HUGETLB_SHARE=1 xB.linkshare (64):      obj64/xB.linkshare: obj64/xB.linkshare: cannot execute binary file
HUGETLB_SHARE=1 xBDT.linkshare (32):    obj32/xBDT.linkshare: obj32/xBDT.linkshare: cannot execute binary file
HUGETLB_SHARE=1 xBDT.linkshare (64):    obj64/xBDT.linkshare: obj64/xBDT.linkshare: cannot execute binary file
HUGETLB_SHARE=1 xB.linkshare (32):      obj32/xB.linkshare: obj32/xB.linkshare: cannot execute binary file
HUGETLB_SHARE=1 xB.linkshare (64):      obj64/xB.linkshare: obj64/xB.linkshare: cannot execute binary file
HUGETLB_SHARE=1 xBDT.linkshare (32):    obj32/xBDT.linkshare: obj32/xBDT.linkshare: cannot execute binary file
HUGETLB_SHARE=1 xBDT.linkshare (64):    obj64/xBDT.linkshare: obj64/xBDT.linkshare: cannot execute binary file
HUGETLB_SHARE=1 xB.linkhuge (32):       obj32/xB.linkhuge: obj32/xB.linkhuge: cannot execute binary file
HUGETLB_SHARE=1 xB.linkhuge (64):       obj64/xB.linkhuge: obj64/xB.linkhuge: cannot execute binary file
HUGETLB_SHARE=1 xB.linkhuge (32):       obj32/xB.linkhuge: obj32/xB.linkhuge: cannot execute binary file
HUGETLB_SHARE=1 xB.linkhuge (64):       obj64/xB.linkhuge: obj64/xB.linkhuge: cannot execute binary file
HUGETLB_SHARE=1 xBDT.linkhuge (32):     obj32/xBDT.linkhuge: obj32/xBDT.linkhuge: cannot execute binary file
HUGETLB_SHARE=1 xBDT.linkhuge (64):     obj64/xBDT.linkhuge: obj64/xBDT.linkhuge: cannot execute binary file
HUGETLB_SHARE=1 xBDT.linkhuge (32):     obj32/xBDT.linkhuge: obj32/xBDT.linkhuge: cannot execute binary file
HUGETLB_SHARE=1 xBDT.linkhuge (64):     obj64/xBDT.linkhuge: obj64/xBDT.linkhuge: cannot execute binary file
linkhuge_rw (32):       PASS
linkhuge_rw (64):       PASS
HUGETLB_ELFMAP=R linkhuge_rw (32):      PASS
HUGETLB_ELFMAP=R linkhuge_rw (64):      PASS
HUGETLB_ELFMAP=W linkhuge_rw (32):      PASS
HUGETLB_ELFMAP=W linkhuge_rw (64):      PASS
HUGETLB_ELFMAP=RW linkhuge_rw (32):     PASS
HUGETLB_ELFMAP=RW linkhuge_rw (64):     PASS
HUGETLB_ELFMAP=no linkhuge_rw (32):     PASS
HUGETLB_ELFMAP=no linkhuge_rw (64):     PASS
HUGETLB_MINIMAL_COPY=no HUGETLB_ELFMAP=R linkhuge_rw (32):      PASS
HUGETLB_MINIMAL_COPY=no HUGETLB_ELFMAP=R linkhuge_rw (64):      PASS
HUGETLB_MINIMAL_COPY=no HUGETLB_ELFMAP=W linkhuge_rw (32):      PASS
HUGETLB_MINIMAL_COPY=no HUGETLB_ELFMAP=W linkhuge_rw (64):      PASS
HUGETLB_MINIMAL_COPY=no HUGETLB_ELFMAP=RW linkhuge_rw (32):     PASS
HUGETLB_MINIMAL_COPY=no HUGETLB_ELFMAP=RW linkhuge_rw (64):     PASS
HUGETLB_ELFMAP=R HUGETLB_SHARE=1 linkhuge_rw (32):      PASS
HUGETLB_ELFMAP=R HUGETLB_SHARE=1 linkhuge_rw (64):      PASS
HUGETLB_ELFMAP=R HUGETLB_SHARE=1 linkhuge_rw (32):      PASS
HUGETLB_ELFMAP=R HUGETLB_SHARE=1 linkhuge_rw (64):      PASS
HUGETLB_ELFMAP=W HUGETLB_SHARE=1 linkhuge_rw (32):      PASS
HUGETLB_ELFMAP=W HUGETLB_SHARE=1 linkhuge_rw (64):      PASS
HUGETLB_ELFMAP=W HUGETLB_SHARE=1 linkhuge_rw (32):      PASS
HUGETLB_ELFMAP=W HUGETLB_SHARE=1 linkhuge_rw (64):      PASS
HUGETLB_ELFMAP=RW HUGETLB_SHARE=1 linkhuge_rw (32):     PASS
HUGETLB_ELFMAP=RW HUGETLB_SHARE=1 linkhuge_rw (64):     PASS
HUGETLB_ELFMAP=RW HUGETLB_SHARE=1 linkhuge_rw (32):     PASS
HUGETLB_ELFMAP=RW HUGETLB_SHARE=1 linkhuge_rw (64):     PASS
chunk-overcommit (32):  PASS
chunk-overcommit (64):  PASS
alloc-instantiate-race shared (32):     PASS
alloc-instantiate-race shared (64):     PASS
alloc-instantiate-race private (32):    PASS
alloc-instantiate-race private (64):    PASS
truncate_reserve_wraparound (32):       PASS
truncate_reserve_wraparound (64):       PASS
truncate_sigbus_versus_oom (32):        PASS
truncate_sigbus_versus_oom (64):        PASS
get_huge_pages (32):    PASS
get_huge_pages (64):    PASS
quota (32):     PASS
quota (64):     PASS
counters (32):  PASS
counters (64):  PASS
mmap-gettest 10 20 (32):        PASS
mmap-gettest 10 20 (64):        PASS
mmap-cow 19 20 (32):    PASS
mmap-cow 19 20 (64):    PASS
set shmmax limit to 335544320
shm-fork 10 10 (32):    PASS
shm-fork 10 10 (64):    PASS
shm-fork 10 20 (32):    PASS
shm-fork 10 20 (64):



--------------080302040802060100050902--
