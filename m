Message-ID: <3D459176.CE30C05A@broadcom.com>
Date: Mon, 29 Jul 2002 12:03:18 -0700
From: "James Dougherty" <jfd@broadcom.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org, jfd@broadcom.com
Subject: Re: Problems with mount system call -- cannot mount procfs!
References: <3D458D46.D3511AAE@broadcom.com>
Content-Type: text/plain;
 charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Guys,

Here is the same trace of something going awry using 2.4.19-rc3 (latest as of last Friday)
from rsynch with MVista linux_2_4_devel:


 Booting image at 00100000 ...
   Image Name:   vmlinux.bin.gz
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    616969 Bytes = 602 kB = 0 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
arch: exit mpc8245_epic_init_ok ttyS00000000 iomem=f7f91500 port=f7f91500 irq=00000018 name=c012391c type=00000003
                                  Memory BAT mapping: BAT2=64Mb, BAT3=0Mb, residual: 0Mb
Linux version 2.4.19-rc3 (jfd@que) (gcc version 2.95.3 20010111 (prerelease/franzo/20010111)) #345 Mon Jul 29 11:47:09 PDT 2002
PPCBoot Environment: 0xc015fa38
IP PNP: 802.3 Ethernet Address=<0:0:10:18:10:10>
cpu0: MPC8245/KAHLUA-II : BMW Platform : 64MB RAM: BPLD Rev. 6e
NOTICE: mounting root file system via NFS
IP PNP: switch-2: eth0 IP 172.16.40.114/255.255.240.0 gateway 10.16.64.1 server 172.16.40.111
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line:
time_init: decrementer frequency = 16.501145 MHz
Calibrating delay loop... 175.71 BogoMIPS
Memory: 62920k available (1104k kernel code, 392k data, 88k init, 0k highmem)
Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)
register_filesystem
find_filesystem
init_rootfs ok:0
init_mount_tree
find_filesystem
do_kern_mount:rootfs
alloc_vfsmnt
alloc ok
get_sb_dev
get_sb_nodev
get_sb_nodev - ok
register_filesystem
find_filesystem
find_filesystem
do_kern_mount:bdev
alloc_vfsmnt
alloc ok
get_sb_dev
get_sb_nodev
get_sb_nodev - ok
Oops: Exception in kernel mode, sig: 4
NIP: C0040378 XER: 00000000 LR: C003F834 SP: C013A370 REGS: c013a2c0 TRAP: 0700    Not tainted
MSR: 00089032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c0138420[0] 'swapper' Last syscall: 0
last math 00000000 last altivec 00000000
GPR00: 3FFBFC8C C013A370 C0138420 C02B3200 00000000 00000000 C013A340 C0160000
GPR08: 00000552 C013AFC0 C01449C8 C013A290 22004022 62FAB95F 03FEB000 007FFF00
GPR16: 00000000 00000001 007FFF00 FFFFFFFF 003FF000 00000000 03DBDFD4 00000001
GPR24: 00000000 03FED2E4 00000000 00000000 00000000 C013C5AC 00000000 C02B3200
Call backtrace:
C003F7FC C003FA68 C003FCF4 C0155B04 C0155F10 C014E4EC 00003788
Kernel panic: Attempted to kill the idle task!
In idle task - not syncing
 <0>Rebooting in 180 seconds..

c0040374 <bd_read_super>:
c0040374:	94 21 ff f0 	stwu	r1,-16(r1)
c0040378:	7c 08 02 a6 	mflr	r0
c004037c:	bf c1 00 08 	stmw	r30,8(r1)
c0040380:	90 01 00 14 	stw	r0,20(r1)


c003f7b4 <get_sb_nodev>:
c003f7b4:	94 21 ff e0 	stwu	r1,-32(r1)
c003f7b8:	7c 08 02 a6 	mflr	r0
c003f7bc:	bf 81 00 10 	stmw	r28,16(r1)
c003f7c0:	90 01 00 24 	stw	r0,36(r1)
c003f7c4:	7c 7d 1b 78 	mr	r29,r3
c003f7c8:	3c 60 c0 12 	lis	r3,-16366
c003f7cc:	7c dc 33 78 	mr	r28,r6
c003f7d0:	7c 9e 23 78 	mr	r30,r4
c003f7d4:	38 63 93 74 	addi	r3,r3,-27788
c003f7d8:	4b fd 6a 09 	bl	c00161e0 <printk>
c003f7dc:	38 80 00 00 	li	r4,0
c003f7e0:	38 a0 00 00 	li	r5,0
c003f7e4:	7f a3 eb 78 	mr	r3,r29
c003f7e8:	4b ff fb b1 	bl	c003f398 <get_anon_super>
c003f7ec:	7c 7f 1b 78 	mr	r31,r3
c003f7f0:	3c 60 c0 12 	lis	r3,-16366
c003f7f4:	38 63 93 84 	addi	r3,r3,-27772
c003f7f8:	4b fd 69 e9 	bl	c00161e0 <printk>
c003f7fc:	20 1f fc 18 	subfic	r0,r31,-1000
c003f800:	7c 00 01 10 	subfe	r0,r0,r0
c003f804:	7c 00 00 d0 	neg	r0,r0
c003f808:	2c 00 00 00 	cmpwi	r0,0
c003f80c:	41 82 00 0c 	beq	c003f818 <get_sb_nodev+0x64>
c003f810:	7f e3 fb 78 	mr	r3,r31
c003f814:	48 00 00 74 	b	c003f888 <get_sb_nodev+0xd4>

c003f998 <do_kern_mount>:
c003f998:	94 21 ff e0 	stwu	r1,-32(r1)
c003f99c:	7c 08 02 a6 	mflr	r0
c003f9a0:	bf 41 00 08 	stmw	r26,8(r1)
c003f9a4:	90 01 00 24 	stw	r0,36(r1)
c003f9a8:	7c bc 2b 78 	mr	r28,r5
c003f9ac:	7c 9b 23 78 	mr	r27,r4
c003f9b0:	7c da 33 78 	mr	r26,r6
c003f9b4:	4b ff f0 6d 	bl	c003ea20 <get_fs_type>
c003f9b8:	3b e0 ff f4 	li	r31,-12
c003f9bc:	7c 7d 1b 78 	mr	r29,r3
c003f9c0:	3c 60 c0 12 	lis	r3,-16366
c003f9c4:	38 63 93 a8 	addi	r3,r3,-27736
c003f9c8:	7f 84 e3 78 	mr	r4,r28
c003f9cc:	4b fd 68 15 	bl	c00161e0 <printk>
c003f9d0:	2c 1d 00 00 	cmpwi	r29,0
c003f9d4:	38 60 ff ed 	li	r3,-19
c003f9d8:	41 82 01 50 	beq	c003fb28 <do_kern_mount+0x190>
c003f9dc:	7f 83 e3 78 	mr	r3,r28
c003f9e0:	48 01 31 8d 	bl	c0052b6c <alloc_vfsmnt>
c003f9e4:	7c 7e 1b 79 	mr.	r30,r3
c003f9e8:	41 82 01 34 	beq	c003fb1c <do_kern_mount+0x184>
c003f9ec:	80 1d 00 04 	lwz	r0,4(r29)
c003f9f0:	70 09 00 01 	andi.	r9,r0,1
c003f9f4:	41 82 00 28 	beq	c003fa1c <do_kern_mount+0x84>
c003f9f8:	3c 60 c0 12 	lis	r3,-16366
c003f9fc:	38 63 93 bc 	addi	r3,r3,-27716
c003fa00:	4b fd 67 e1 	bl	c00161e0 <printk>
c003fa04:	7f 64 db 78 	mr	r4,r27
c003fa08:	7f 85 e3 78 	mr	r5,r28
c003fa0c:	7f 46 d3 78 	mr	r6,r26
c003fa10:	7f a3 eb 78 	mr	r3,r29
c003fa14:	4b ff fb 19 	bl	c003f52c <get_sb_bdev>
c003fa18:	48 00 00 50 	b	c003fa68 <do_kern_mount+0xd0>
c003fa1c:	70 09 00 08 	andi.	r9,r0,8
c003fa20:	41 82 00 28 	beq	c003fa48 <do_kern_mount+0xb0>
c003fa24:	3c 60 c0 12 	lis	r3,-16366
c003fa28:	38 63 93 98 	addi	r3,r3,-27752
c003fa2c:	4b fd 67 b5 	bl	c00161e0 <printk>
c003fa30:	7f 64 db 78 	mr	r4,r27
c003fa34:	7f 85 e3 78 	mr	r5,r28
c003fa38:	7f 46 d3 78 	mr	r6,r26
c003fa3c:	7f a3 eb 78 	mr	r3,r29
c003fa40:	4b ff fe 65 	bl	c003f8a4 <get_sb_single>
c003fa44:	48 00 00 24 	b	c003fa68 <do_kern_mount+0xd0>
c003fa48:	3c 60 c0 12 	lis	r3,-16366
c003fa4c:	38 63 93 68 	addi	r3,r3,-27800
c003fa50:	4b fd 67 91 	bl	c00161e0 <printk>
c003fa54:	7f 64 db 78 	mr	r4,r27
c003fa58:	7f 85 e3 78 	mr	r5,r28
c003fa5c:	7f 46 d3 78 	mr	r6,r26
c003fa60:	7f a3 eb 78 	mr	r3,r29
c003fa64:	4b ff fd 51 	bl	c003f7b4 <get_sb_nodev>
c003fa68:	7c 7f 1b 78 	mr	r31,r3

c003fcd4 <kern_mount>:
c003fcd4:	94 21 ff f0 	stwu	r1,-16(r1)
c003fcd8:	7c 08 02 a6 	mflr	r0
c003fcdc:	90 01 00 14 	stw	r0,20(r1)
c003fce0:	80 63 00 00 	lwz	r3,0(r3)
c003fce4:	38 80 00 00 	li	r4,0
c003fce8:	38 c0 00 00 	li	r6,0
c003fcec:	7c 65 1b 78 	mr	r5,r3
c003fcf0:	4b ff fc a9 	bl	c003f998 <do_kern_mount>
c003fcf4:	80 01 00 14 	lwz	r0,20(r1)
c003fcf8:	7c 08 03 a6 	mtlr	r0
c003fcfc:	38 21 00 10 	addi	r1,r1,16
c003fd00:	4e 80 00 20 	blr

c0155a6c <bdev_cache_init>:
c0155a6c:	94 21 ff f0 	stwu	r1,-16(r1)
c0155a70:	7c 08 02 a6 	mflr	r0
c0155a74:	90 01 00 14 	stw	r0,20(r1)
c0155a78:	38 00 00 40 	li	r0,64
c0155a7c:	7c 09 03 a6 	mtctr	r0
c0155a80:	3d 20 c0 17 	lis	r9,-16361
c0155a84:	39 29 08 28 	addi	r9,r9,2088
c0155a88:	91 29 00 00 	stw	r9,0(r9)
c0155a8c:	91 29 00 04 	stw	r9,4(r9)
c0155a90:	39 29 00 08 	addi	r9,r9,8
c0155a94:	42 00 ff f4 	bdnz	c0155a88 <bdev_cache_init+0x1c>
c0155a98:	3c 60 c0 12 	lis	r3,-16366
c0155a9c:	3c e0 c0 04 	lis	r7,-16380
c0155aa0:	38 63 94 30 	addi	r3,r3,-27600
c0155aa4:	38 e7 04 68 	addi	r7,r7,1128
c0155aa8:	38 80 00 34 	li	r4,52
c0155aac:	38 a0 00 00 	li	r5,0
c0155ab0:	38 c0 20 00 	li	r6,8192
c0155ab4:	39 00 00 00 	li	r8,0
c0155ab8:	4b ed a0 5d 	bl	c002fb14 <kmem_cache_create>
c0155abc:	2c 03 00 00 	cmpwi	r3,0
c0155ac0:	3d 20 c0 16 	lis	r9,-16362
c0155ac4:	90 69 42 e0 	stw	r3,17120(r9)
c0155ac8:	40 82 00 10 	bne	c0155ad8 <bdev_cache_init+0x6c>
c0155acc:	3c 60 c0 12 	lis	r3,-16366
c0155ad0:	38 63 94 3c 	addi	r3,r3,-27588
c0155ad4:	4b eb fd 71 	bl	c0015844 <panic>
c0155ad8:	3c 60 c0 14 	lis	r3,-16364
c0155adc:	38 63 c5 ac 	addi	r3,r3,-14932
c0155ae0:	4b ee 8b b1 	bl	c003e690 <register_filesystem>
c0155ae4:	2c 03 00 00 	cmpwi	r3,0
c0155ae8:	41 82 00 10 	beq	c0155af8 <bdev_cache_init+0x8c>
c0155aec:	3c 60 c0 12 	lis	r3,-16366
c0155af0:	38 63 94 60 	addi	r3,r3,-27552
c0155af4:	4b eb fd 51 	bl	c0015844 <panic>
c0155af8:	3c 60 c0 14 	lis	r3,-16364
c0155afc:	38 63 c5 ac 	addi	r3,r3,-14932
c0155b00:	4b ee a1 d5 	bl	c003fcd4 <kern_mount>
c0155b04:	20 03 fc 18 	subfic	r0,r3,-1000


c0155e28 <vfs_caches_init>:
c0155e28:	94 21 ff f0 	stwu	r1,-16(r1)
c0155e2c:	7c 08 02 a6 	mflr	r0
c0155e30:	93 e1 00 0c 	stw	r31,12(r1)
c0155e34:	90 01 00 14 	stw	r0,20(r1)
c0155e38:	7c 7f 1b 78 	mr	r31,r3
c0155e3c:	3c 60 c0 12 	lis	r3,-16366
c0155e40:	3c e0 c0 05 	lis	r7,-16379
c0155e44:	38 63 9a b0 	addi	r3,r3,-25936
c0155e48:	38 e7 fd 34 	addi	r7,r7,-716
c0155e4c:	38 80 00 60 	li	r4,96
c0155e50:	38 a0 00 00 	li	r5,0
c0155e54:	38 c0 20 00 	li	r6,8192
c0155e58:	39 00 00 00 	li	r8,0
c0155e5c:	4b ed 9c b9 	bl	c002fb14 <kmem_cache_create>
c0155e60:	2c 03 00 00 	cmpwi	r3,0
c0155e64:	3d 20 c0 16 	lis	r9,-16362
c0155e68:	90 69 43 08 	stw	r3,17160(r9)
c0155e6c:	40 82 00 10 	bne	c0155e7c <vfs_caches_init+0x54>
c0155e70:	3c 60 c0 12 	lis	r3,-16366
c0155e74:	38 63 9a bc 	addi	r3,r3,-25924
c0155e78:	4b eb f9 cd 	bl	c0015844 <panic>
c0155e7c:	3c 60 c0 12 	lis	r3,-16366
c0155e80:	38 63 9a e4 	addi	r3,r3,-25884
c0155e84:	38 80 10 00 	li	r4,4096
c0155e88:	38 a0 00 00 	li	r5,0
c0155e8c:	38 c0 20 00 	li	r6,8192
c0155e90:	38 e0 00 00 	li	r7,0
c0155e94:	39 00 00 00 	li	r8,0
c0155e98:	4b ed 9c 7d 	bl	c002fb14 <kmem_cache_create>
c0155e9c:	2c 03 00 00 	cmpwi	r3,0
c0155ea0:	3d 20 c0 16 	lis	r9,-16362
c0155ea4:	90 69 42 fc 	stw	r3,17148(r9)
c0155ea8:	40 82 00 10 	bne	c0155eb8 <vfs_caches_init+0x90>
c0155eac:	3c 60 c0 12 	lis	r3,-16366
c0155eb0:	38 63 9a f0 	addi	r3,r3,-25872
c0155eb4:	4b eb f9 91 	bl	c0015844 <panic>
c0155eb8:	3c 60 c0 12 	lis	r3,-16366
c0155ebc:	38 63 9b 10 	addi	r3,r3,-25840
c0155ec0:	38 80 00 68 	li	r4,104
c0155ec4:	38 a0 00 00 	li	r5,0
c0155ec8:	38 c0 20 00 	li	r6,8192
c0155ecc:	38 e0 00 00 	li	r7,0
c0155ed0:	39 00 00 00 	li	r8,0
c0155ed4:	4b ed 9c 41 	bl	c002fb14 <kmem_cache_create>
c0155ed8:	2c 03 00 00 	cmpwi	r3,0
c0155edc:	3d 20 c0 16 	lis	r9,-16362
c0155ee0:	90 69 43 00 	stw	r3,17152(r9)
c0155ee4:	40 82 00 10 	bne	c0155ef4 <vfs_caches_init+0xcc>
c0155ee8:	3c 60 c0 12 	lis	r3,-16366
c0155eec:	38 63 9b 18 	addi	r3,r3,-25832
c0155ef0:	4b eb f9 55 	bl	c0015844 <panic>
c0155ef4:	7f e3 fb 78 	mr	r3,r31
c0155ef8:	4b ff fd f1 	bl	c0155ce8 <dcache_init>
c0155efc:	7f e3 fb 78 	mr	r3,r31
c0155f00:	48 00 00 29 	bl	c0155f28 <inode_init>
c0155f04:	7f e3 fb 78 	mr	r3,r31
c0155f08:	48 00 01 cd 	bl	c01560d4 <mnt_init>
c0155f0c:	4b ff fb 61 	bl	c0155a6c <bdev_cache_init>
c0155f10:	4b ff fc 2d 	bl	c0155b3c <cdev_cache_init>

c014e3f8 <start_kernel>:
c014e3f8:	94 21 ff d0 	stwu	r1,-48(r1)
c014e3fc:	7c 08 02 a6 	mflr	r0
c014e400:	bf a1 00 24 	stmw	r29,36(r1)
c014e404:	90 01 00 34 	stw	r0,52(r1)
c014e408:	3d 20 c0 15 	lis	r9,-16363
c014e40c:	80 69 88 f4 	lwz	r3,-30476(r9)
c014e410:	4b ec 7d d1 	bl	c00161e0 <printk>
c014e414:	38 61 00 08 	addi	r3,r1,8
c014e418:	48 00 0f 6d 	bl	c014f384 <setup_arch>
c014e41c:	3c 60 c0 11 	lis	r3,-16367
c014e420:	3c 80 c0 16 	lis	r4,-16362
c014e424:	38 84 58 24 	addi	r4,r4,22564
c014e428:	38 63 40 84 	addi	r3,r3,16516
c014e42c:	4b ec 7d b5 	bl	c00161e0 <printk>
c014e430:	80 61 00 08 	lwz	r3,8(r1)
c014e434:	4b ff fe 2d 	bl	c014e260 <parse_options>
c014e438:	48 00 0b 11 	bl	c014ef48 <trap_init>
c014e43c:	48 00 0b 11 	bl	c014ef4c <init_IRQ>
c014e440:	48 00 58 99 	bl	c0153cd8 <sched_init>
c014e444:	48 00 5c b9 	bl	c01540fc <softirq_init>
c014e448:	48 00 0b 49 	bl	c014ef90 <time_init>
c014e44c:	48 00 8d fd 	bl	c0157248 <console_init>
c014e450:	48 00 5c 89 	bl	c01540d8 <init_modules>
c014e454:	3d 20 c0 16 	lis	r9,-16362
c014e458:	80 09 42 20 	lwz	r0,16928(r9)
c014e45c:	2c 00 00 00 	cmpwi	r0,0
c014e460:	41 82 00 44 	beq	c014e4a4 <start_kernel+0xac>
c014e464:	3d 20 c0 11 	lis	r9,-16367
c014e468:	3d 60 c0 00 	lis	r11,-16384
c014e46c:	39 6b 00 00 	addi	r11,r11,0
c014e470:	39 29 3f b8 	addi	r9,r9,16312
c014e474:	7d 2b 48 50 	subf	r9,r11,r9
c014e478:	7d 29 04 30 	srw	r9,r9,r0
c014e47c:	55 23 10 3a 	rlwinm	r3,r9,2,0,29
c014e480:	3d 60 c0 16 	lis	r11,-16362
c014e484:	3c a0 3f ff 	lis	r5,16383
c014e488:	91 2b 42 1c 	stw	r9,16924(r11)
c014e48c:	38 63 0f ff 	addi	r3,r3,4095
c014e490:	38 80 00 20 	li	r4,32
c014e494:	60 a5 ff ff 	ori	r5,r5,65535
c014e498:	48 00 6b 85 	bl	c015501c <__alloc_bootmem>
c014e49c:	3d 20 c0 16 	lis	r9,-16362
c014e4a0:	90 69 42 18 	stw	r3,16920(r9)
c014e4a4:	48 00 60 71 	bl	c0154514 <kmem_cache_init>
c014e4a8:	4b eb 98 29 	bl	c0007cd0 <__cli_end>
c014e4ac:	4b ff fc 25 	bl	c014e0d0 <calibrate_delay>
c014e4b0:	48 00 48 41 	bl	c0152cf0 <mem_init>
c014e4b4:	48 00 61 11 	bl	c01545c4 <kmem_cache_sizes_init>
c014e4b8:	3d 60 c0 16 	lis	r11,-16362
c014e4bc:	80 0b 42 64 	lwz	r0,16996(r11)
c014e4c0:	2c 00 00 00 	cmpwi	r0,0
c014e4c4:	40 82 00 10 	bne	c014e4d4 <start_kernel+0xdc>
c014e4c8:	3d 20 c0 16 	lis	r9,-16362
c014e4cc:	80 09 42 60 	lwz	r0,16992(r9)
c014e4d0:	90 0b 42 64 	stw	r0,16996(r11)
c014e4d4:	80 6b 42 64 	lwz	r3,16996(r11)
c014e4d8:	3f a0 c0 16 	lis	r29,-16362
c014e4dc:	48 00 58 a5 	bl	c0153d80 <fork_init>
c014e4e0:	48 00 58 c5 	bl	c0153da4 <proc_caches_init>
c014e4e4:	80 7d 42 60 	lwz	r3,16992(r29)
c014e4e8:	48 00 79 41 	bl	c0155e28 <vfs_caches_init>
c014e4ec:	80 7d 42 60 	lwz	r3,16992(r29)
c014e4f0:	48 00 73 d9 	bl	c01558c8 <buffer_init>



--
James F. Dougherty, III
Broadcom Corporation
jfd@broadcom.com
(408) 501-8273

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
