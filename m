Return-Path: <rdcorle@yahoo.com>
Received: from web56312.mail.re3.yahoo.com (web56312.mail.re3.yahoo.com
	[216.252.110.236]) by ozlabs.org (Postfix) with SMTP id A342967B70
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 Oct 2006 04:49:06 +1000 (EST)
Message-ID: <20061023184904.54961.qmail@web56312.mail.re3.yahoo.com>
Date: Mon, 23 Oct 2006 11:49:04 -0700 (PDT)
From: robert corley <rdcorle@yahoo.com>
Subject: xapp902 with 2.6.17 -- uartlite & ramdisk problems
To: David Bolcsfoldi <dbolcsfoldi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Cc: linux linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

David et al;=0A=0AIn my seemingly neverending effort to get linux up on the=
 ML403, I went the route David B. did and worked with the xapp902 reference=
 desing.  I have met with a little success and appeal for some assistance..=
.=0A=0A1.    The uart is dog slow.  I suspect it has to do with interrupts =
 (note the console dump below).  I see this line:=0A=0A    [    2.637345] u=
artlite.0: ttyUL0 at MMIO 0xa0000000 (irq =3D =0A=0A    and I think that th=
e interrupt isn't properly registered with the PIC.  What do you think?=0A=
=0A2.    Can you look below and comment on the ram disk size?  I am not sur=
e what this value should be.  My ramdisk=0A    image is 4658942 bytes.  I r=
ecall reading somewhere that the value for the initrd ram disk should be ab=
out 10k larger =0A    than the ramdisk size to allow for decompression.  Th=
e # of pages and page size is throwing me off.  Comments?=0A=0A-corley=0A=
=0A=0A=0A=0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
   console dump  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=0A[    0.000000] Linux version 2.6.17.1 (rdcorle@athe=
na) (gcc version 3.4.2) #2 Mon Oct 23 17:58:11 UTC 2006                    =
      =0A[    0.000000] Xilinx ML403 Reference System (Virtex-4 FX)        =
                                                  =0A[    0.000000] Built 1=
 zonelists                                =0A[    0.000000] Kernel command =
line: console=3DttyUL0 single ip=3Doff root=3D/dev/ram rw =0A[    0.000000]=
 Xilinx INTC #0 at 0xD1000FC0 mapped to 0xFDFFFFC0                         =
                                       =0A[    0.000000] PID hash table ent=
ries: 512 (order: 9, 2048 bytes)                                           =
                      =0A[    0.000151] Console: colour dummy device 80x25 =
                                                =0A[    0.000560] Dentry ca=
che hash table entries: 8192                                               =
     =0A[    0.001271] Inode-cache hash table entries: 4096 (order: 2, 1638=
4 bytes)                                                                   =
        =0A[    0.013924] Memory: 58572k available (1348k kernel code, 344k=
 data, 80k init, 0k highmem)            =0A[    0.200435] Mount-cache hash =
table entries: 512                                                  =0A[   =
 0.203108] checking if image is initramfs...it isn't (no cpio magic); looks=
 like an initrd              =0A[    2.504612] Freeing initrd memory: 4549k=
 freed                                                 =0A[    2.508719] NE=
T: Registered protocol family 16                                           =
      =0A[    2.518260] NET: Registered protocol family 2                  =
                              =0A[    2.583989] IP route cache hash table e=
ntries: 51                                                  =0A[    2.58446=
7] TCP established hash table entries: 2048 (order: 3, 32768 bytes)        =
                                                                       =0A[=
    2.584936] TCP bind hash table entries: 1024 (order: 2, 20480 bytes)    =
                                                                    =0A[   =
 2.585222] TCP: Hash tables configured (established 2048 bind 1024)        =
                                                               =0A[    2.58=
5257] TCP reno registered                                  =0A[    2.591657=
] io scheduler noop registered                                           =
=0A[    2.591817] io scheduler anticipatory registered (default)           =
                                                  =0A[    2.591912] io sche=
duler deadline registered                                               =0A=
[    2.592049] io scheduler cfq registered                                 =
         =0A[    2.637345] uartlite.0: ttyUL0 at MMIO 0xa0000000 (irq =3D  =
                                                        =0A[   40.942337] R=
AMDISK driver initialized: 16 RAM disks of 4096K size 1024 block size    =
=0A[   42.944862] eth%d: XTemac using sgDMA mode.                          =
                    =0A[   44.072738] eth%d: XTemac buffer_descriptor_space=
: phy: 0xbb8000, virt: 0xff1 00000, size: 0x5000                   =0A[   4=
6.424830] eth0: Xilinx TEMAC #0 at 0x60000000 mapped to 0xC5008000, irq=3D0=
                                                                           =
   =0A[   48.289878] mice: PS/2 mouse device common for all mice           =
                                               =0A[   49.694042] TCP bic re=
gistered                                 =0A[   50.524157] RAMDISK: Compres=
sed image found at block 0                                                 =
        =0A[   52.672304] RAMDISK: incomplete write (-28 !=3D 3276         =
                                          =0A[   56.000551] VFS: Mounted ro=
ot (ext2 filesystem).                                                   =0A=
[   57.243671] Freeing unused kernel memory: 80k init                      =
                               =0A[   58.579050] attempt to access beyond e=
nd of device                                                     =0A[   59.=
867968] ram0: rw=3D0, want=3D10018, limit=3D8192                           =
                      =0A[   61.064912] Buffer I/O error on device ram0, lo=
gical block 5008                                                           =
       =0A[   62.653149] attempt to access beyond end of device            =
                                         =0A[   63.942154] ram0: rw=3D0, wa=
nt=3D10020, limit=3D8192                                                 =
=0A[   65.139082] Buffer I/O error on device ram0, logical block 5009      =
                                                            =0A[   66.72730=
5] attempt to access beyond end of device                                  =
                   =0A[   68.016306] ram0: rw=3D0, want=3D10022, limit=3D81=
92                                                 =0A[   69.212688] BUG: s=
oft lockup detected on CPU#0!                                              =
    =0A[   69.212711] Call Trace:                          =0A[   69.212733=
] [C024F780] [C000906C] show_stack+0x48/0x194 (unreliable)                 =
                                                      =0A[   69.212808] [C0=
24F7C0] [C0031874] softlockup_tick+0xb4/0xd0                               =
                               =0A[   69.212853] [C024F7E0] [C001DDE8] run_=
local_timers+0x18/0x28                                                     =
          =0A[   69.212905] [C024F7F0] [C001DE70] update_process_times+0x78=
/0xb4                                                                   =0A=
[   69.212956] [C024F810] [C00045B4] timer_interrupt+0xd4/0x204            =
                                                   =0A[   69.213000] [C024F=
850] [C000351C] ret_from_except+0x0/                                       =
                 =0A[   69.213043] [C024F910] [C0015A9C] release_console_se=
m+0xe0/0x284                                                               =
    =0A[   69.213105] [C024F950] [C0015DF4] vprintk+0x1b4/0x384            =
                                            =0A[   69.213149] [C024F9F0] [C=
0016014] printk+0x50/0x60                                                  =
   =0A[   69.213189] [C024FA70] [C00B98DC] generic_make_request+0xc0/0x20c =
                                                                   =0A[   6=
9.213252] [C024FAB0] [C00B9AA8] submit_bio+0x80/0xd8                       =
                                  =0A[   69.213294] [C024FAF0] [C005602C] s=
ubmit_bh+0x14c/0x1a0                                                       =
   =0A[   69.213342] [C024FB10] [C005854C] block_read_full_page+0x310/0x328=
                                                                     =0A[  =
 69.213391] [C024FB80] [C007D4FC] do_mpage_readpage+0x38c/0x538            =
                                                      =0A[   69.213437] [C0=
24FC00] [C007D880] mpage_readpage+0x50/0x78                                =
                             =0A[   69.213477] [C024FC50] [C00B0120] ext2_r=
eadpage+0x1c/0x2c                                                          =
  =0A[   69.213516] [C024FC60] [C0034824] read_cache_page+0xf8/0x208       =
                                                        =0A[   69.213562] [=
C024FC90] [C00AD490] ext2_get_page+0x24/0x308                              =
                               =0A[   69.213623] [C024FCC0] [C00ADAE8] ext2=
_find_entry+0x7c/0x17c                 =0A[   69.213663] [C024FD10] [C00ADC=
78] ext2_inode_by_name+0x18/0x58=0A[   69.213704] [C024FD30] [C00B191C] ext=
2_lookup+0x54/0xd8=0A[   69.213744] [C024FD50] [C0062E4C] do_lookup+0x138/0=
x19c=0A[   69.213793] [C024FD80] [C0063918] __link_path_walk+0x8f4/0x1014=
=0A[   69.213837] [C024FDD0] [C00640C0] link_path_walk+0x88/0x150=0A[   69.=
213879] [C024FE40] [C006432C] do_path_lookup+0x1a4/0x2b8=0A[   69.213924] [=
C024FE70] [C006452C] __path_lookup_intent_open+0x58/0xb8=0A[   69.213971] [=
C024FEA0] [C0064F14] open_namei+0x70/0x6dc=0A[   69.214015] [C024FEE0] [C00=
519E4] do_filp_open+0x30/0x78=0A[   69.214056] [C024FF50] [C0051E04] do_sys=
_open+0x70/0x10c=0A[   69.214095] [C024FF80] [C0002618] init+0x274/0x2e0=0A=
[   69.214137] [C024FFF0] [C00051FC] kernel_thread+0x44/0x60=0A[  117.44526=
1] Buffer I/O error on device ram0, logical block 5010=0A[  119.033233] att=
empt to access beyond end of device=0A[  120.322015] ram0: rw=3D0, want=3D1=
0018, limit=3D8192=0A[  121.518738] Buffer I/O error on device ram0, logica=
l block 5008=0A[  123.106686] attempt to access beyond end of device=0A[  1=
24.395468] ram0: rw=3D0, want=3D10020, limit=3D8192=0A[  125.592200] Buffer=
 I/O error on device ram0, logical block 5009=0A[  127.180152] attempt to a=
ccess beyond end of device=0A[  128.468929] ram0: rw=3D0, want=3D10022, lim=
it=3D8192=0A[  129.665650] Buffer I/O error on device ram0, logical block 5=
010=0A[  131.253675] attempt to access beyond end of device=0A[  132.542475=
] ram0: rw=3D0, want=3D100=0A=0A
