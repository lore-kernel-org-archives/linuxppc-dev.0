Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <20000621080900.9868.qmail@web2103.mail.yahoo.com>
Date: Wed, 21 Jun 2000 01:09:00 -0700 (PDT)
From: Wentao Xu <xuwentao@yahoo.com>
Subject: About bad pte error
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am trying to port linux for IBM405GP to my board(
IBM PPC401, 24M memory, no
PCI), I map the kernel to 0xB0000000, and it seems ok
until a bad pte error
occurs during starting the
shell(execve("/sbin/sash",..))from ramdisk. After
that,sometime CPU entered machine check exception,
sometime print a long train
of messages. And the value following "bad pte" varies
from 0x2xxxxxxx to 0xf3xxxxxxx.
I dont know what causes bad pte error. Which friends
can tell me ? Thanks.

Xu Wentao
6/21

Here is the output during boot:
--------------------------------------------------------------------------------

Entry point at 0x250000 ...

-----  treeboot  VUFX  ftr.04.30.00.a  -----

imageSect_start   = 0x002578e4
imageSect_size    = 0x000b8ba8
initrdSect_start  = 0x0031048c
initrdSect_size   = 0x00200000
---  010  ---
Initial RAM disk loading at physaddr 0x00e00000
(2097152 bytes)
dst = 0x00000000, im = 0x002578e4, len = 0x000b8ba8
---  040  ---

first instructions of linux unpacked into RAM:
    0x7c7f1b78
    0x7c9e2378
    0x7cbd2b78
    0x7cdc3378
    0x7cfb3b78
    0x3b000000
    0x7c0002e4
    0x7c0004ac
    0x3c60b000
    0x3c630000

---  050  ---
----------  progress:  0x200 id mach(): done
Linux version 2.3.39 (xwt@stb_dev) (gcc version 2.95.2
19991024 (release)) #258
Wed Jun 21 15:43:17 CST 2000
walnut_setup_arch()
----------  progress:  0x3eab arch: exit
On node 0 totalpages: 00001800
zone(0): 6144 pages.
zone(1): 0 pages.
zone(2): 0 pages.
ERROR: ppc4xx_pic_init() detected wrong PVR_VER

-----  in walnut_calibrate_decr()

  bip:

    bi_s_version      1.3
    bi_r_version      1.13
    bi_memsize        0x1800000
    bi_enetaddr       123456-7890ab
    bi_pci_enetaddr   000002-f34f60
    bi_procfreq       0x2f34f60
    bi_plb_busfreq    0x4e800021
    bi_pci_busfreq    0x0


FTR_CPU_FREQ_HACK - walnut_calibrate_decr(), fixing up
frequencies

    bi_procfreq       0xbebc200
    bi_plb_busfreq    0x3ef1480
    bi_pci_busfreq    0x1f78a40

Calibrating delay loop... 8.19 BogoMIPS
Memory: 21000k available (548k kernel code, 508k data,
28k init) [b0000000,b1800
000]
Buffer-cache hash table entries: 1024 (order: 0, 4096
bytes)
Page-cache hash table entries: 8192 (order: 3, 32768
bytes)
POSIX conformance testing by UNIFIX
----------  progress:  0xffff
Linux NET4.0 for Linux 2.3
Based upon Swansea University Computer Society
NET3.039
Starting kswapd v1.6
usb.c: registered new driver hub
usb.c: registered new driver usb_mouse
usb.c: registered new driver keyboard
tty_init() -- calling rs_init()
Serial driver version 4.91 (1999-11-17) with no serial
options enabled
ttyS00 at 0x0000 (irq = 0) is a 16550A
tty_init() -- returned from rs_init()
pty: 256 Unix98 ptys configured
RAMDISK driver initialized: 16 RAM disks of 4096K size
1024 blocksize
loop: registered device at major 7
loop: enabling 8 loop devices
RAMDISK: ext2 filesystem found at block 0
RAMDISK: Loading 2048 blocks [1 disk] into ram disk...
done.
Freeing initrd memory: 0k freed
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 28k init
exec.c:291: bad pte 8069ead4.
do_wp_page: bogus page at address 7fffffb0 (nr 525982)
do_wp_page: bogus page at address 7fffffb0 (nr 525982)
......
--------------------------------------------------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
