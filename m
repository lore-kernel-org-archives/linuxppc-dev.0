Return-Path: <rdcorle@yahoo.com>
Received: from web56302.mail.re3.yahoo.com (web56302.mail.re3.yahoo.com
	[216.252.110.226]) by ozlabs.org (Postfix) with SMTP id 9585267DE3
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Oct 2006 00:51:40 +1000 (EST)
Message-ID: <20061026145139.18900.qmail@web56302.mail.re3.yahoo.com>
Date: Thu, 26 Oct 2006 07:51:39 -0700 (PDT)
From: robert corley <rdcorle@yahoo.com>
Subject: xapp902 with 2.6.17 -- uartlite IRQ  problems
To: "David H. Lynch Jr." <dhlii@dlasys.net>
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

(original msg below)=0A=0ADavid;=0A=0AThe RS232 interrupt is currently usin=
g IRQ #1.=0A=0AI did a couple of things to verify interrupt generation and =
servicing:=0A1.    Modified the uartlite isr to print a message every 128 i=
nterrupts (using the mod operator, etc.), and=0A2.    Modified the xilinx d=
esign to push three signals out the ports for examination via an o-scope:=
=0A    a.    the RS232 interrupt to the PIC,=0A    b.    the PIC interrupt =
to the PPC405, and=0A    c.    the RS232 xmit output=0A=0AOn startup, I see=
 a message from the uarlite ISR just once, as follows:=0A=0A---------------=
------------=0A[   66.063011] ulite_startup: irq 1 allocated (int. counter =
=3D 0), resetting buffers...=0A[   68.111531] ulite_startup: enabling inter=
rupts...=0A=0ABusyBox v1.00-pre9 (2004.04.18-19-[   69.386364] Int. counter=
 =3D 0=0A#=0A---------------------------=0A=0ABut no more after that...=0A=
=0AOddly enough, there weren't any interrupt signals from the PIC or UARTLI=
TE at any time.=0A=0AI will modify the isr to dump the PIC and UARTLITE reg=
isters.  In addition, I will monitor =0Athe uartlite memory registers using=
 XMD and see what I find.=0A=0AWhere is the code that enables the interrupt=
s on the Xilinx PIC?=0A=0A-cy=0A=0A----- Original Message ----=0AFrom: Davi=
d H. Lynch Jr. <dhlii@dlasys.net>=0ATo: robert corley <rdcorle@yahoo.com>=
=0ASent: Thursday, October 26, 2006 1:15:13 AM=0ASubject: Re: xapp902 with =
2.6.17 -- uartlite & ramdisk problems=0A=0Arobert corley wrote:=0A> David e=
t al;=0A>=0A> In my seemingly neverending effort to get linux up on the ML4=
03, I went the route David B. did and worked with the xapp902 reference des=
ing.  I have met with a little success and appeal for some assistance...=0A=
>=0A> 1.    The uart is dog slow.  I suspect it has to do with interrupts  =
(note the console dump below).  I see this line:=0A>=0A>     [    2.637345]=
 uartlite.0: ttyUL0 at MMIO 0xa0000000 (irq =3D =0A>=0A>     and I think th=
at the interrupt isn't properly registered with the PIC.  What do you think=
?=0A>=0A> 2.    Can you look below and comment on the ram disk size?  I am =
not sure what this value should be.  My ramdisk=0A>     image is 4658942 by=
tes.  I recall reading somewhere that the value for the initrd ram disk sho=
uld be about 10k larger =0A>     than the ramdisk size to allow for decompr=
ession.  The # of pages and page size is throwing me off.  Comments?=0A>=0A=
> -corley=0A>   =0A    I do not want to profess to be expert on the David B=
./Peter version =0Aof the UartLite driver. But I would guess UartLite inter=
rupts are not =0Aworking at all. What IRQ are you using ?=0A    If it is IR=
Q 0 it is possible that it is being ignored =3D I had to =0Ajigger the code=
 a bit because IRQ 0 is frequently used by Linux as no =0Airq, and on Xilin=
x (an possibly many ppc's) it is valid.=0A    I made irq -1 the invalid irq=
 and if you set the irq to -1 I use the =0Atimer.=0A=0A    Adding timer dri=
ver I/O was fairly trivial - I am trying to put =0Atogether a patch for Dav=
id B./Peter's driver that does that.=0A    The timer stuff is trivial. The =
problem is that Peters =0Atransmit/receive assume that they are only called=
 when it is safe to =0Asend/receive - normal if driven by interrupts.=0A=0A=
    But the advantage to polled serial ports is they pretty much always =0A=
work. I currently have some minor interrupt issues on my driver (of =0Acour=
se Peter's fails in the same way on my system), but=0A    I do not have to =
sweat it because  I can just ignore uartlite =0Ainterrupts and things work =
fine.=0A=0A    Peter claims to be getting 1M xfers, that is probably not fe=
asible  =0Awith polled IO.=0A=0A=0A   =0A=0A=0A>=0A>=0A>=0A> =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   console dump  =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
> [    0.000000] Linux version 2.6.17.1 (rdcorle@athena) (gcc version 3.4.2=
) #2 Mon Oct 23 17:58:11 UTC 2006                          =0A> [    0.0000=
00] Xilinx ML403 Reference System (Virtex-4 FX)                            =
                              =0A> [    0.000000] Built 1 zonelists        =
                        =0A> [    0.000000] Kernel command line: console=3D=
ttyUL0 single ip=3Doff root=3D/dev/ram rw =0A> [    0.000000] Xilinx INTC #=
0 at 0xD1000FC0 mapped to 0xFDFFFFC0                                       =
                         =0A> [    0.000000] PID hash table entries: 512 (o=
rder: 9, 2048 bytes)                                                       =
          =0A> [    0.000151] Console: colour dummy device 80x25           =
                                      =0A> [    0.000560] Dentry cache hash=
 table entries: 8192                                                    =0A=
> [    0.001271] Inode-cache hash table entries: 4096 (order: 2, 16384 byte=
s)                                                                         =
  =0A> [    0.013924] Memory: 58572k available (1348k kernel code, 344k dat=
a, 80k init, 0k highmem)            =0A> [    0.200435] Mount-cache hash ta=
ble entries: 512                                                  =0A> [   =
 0.203108] checking if image is initramfs...it isn't (no cpio magic); looks=
 like an initrd              =0A> [    2.504612] Freeing initrd memory: 454=
9k freed                                                 =0A> [    2.508719=
] NET: Registered protocol family 16                                       =
          =0A> [    2.518260] NET: Registered protocol family 2            =
                                    =0A> [    2.583989] IP route cache hash=
 table entries: 51                                                  =0A> [ =
   2.584467] TCP established hash table entries: 2048 (order: 3, 32768 byte=
s)                                                                         =
      =0A> [    2.584936] TCP bind hash table entries: 1024 (order: 2, 2048=
0 bytes)                                                                   =
     =0A> [    2.585222] TCP: Hash tables configured (established 2048 bind=
 1024)                                                                     =
  =0A> [    2.585257] TCP reno registered                                  =
=0A> [    2.591657] io scheduler noop registered                           =
                =0A> [    2.591817] io scheduler anticipatory registered (d=
efault)                                                             =0A> [ =
   2.591912] io scheduler deadline registered                              =
                 =0A> [    2.592049] io scheduler cfq registered           =
                               =0A> [    2.637345] uartlite.0: ttyUL0 at MM=
IO 0xa0000000 (irq =3D                                                     =
     =0A> [   40.942337] RAMDISK driver initialized: 16 RAM disks of 4096K =
size 1024 block size    =0A> [   42.944862] eth%d: XTemac using sgDMA mode.=
                                              =0A> [   44.072738] eth%d: XT=
emac buffer_descriptor_space: phy: 0xbb8000, virt: 0xff1 00000, size: 0x500=
0                   =0A> [   46.424830] eth0: Xilinx TEMAC #0 at 0x60000000=
 mapped to 0xC5008000, irq=3D0                                             =
                                 =0A> [   48.289878] mice: PS/2 mouse devic=
e common for all mice                                                      =
    =0A> [   49.694042] TCP bic registered                                 =
=0A> [   50.524157] RAMDISK: Compressed image found at block 0             =
                                            =0A> [   52.672304] RAMDISK: in=
complete write (-28 !=3D 3276                                              =
     =0A> [   56.000551] VFS: Mounted root (ext2 filesystem).              =
                                     =0A> [   57.243671] Freeing unused ker=
nel memory: 80k init                                                     =
=0A> [   58.579050] attempt to access beyond end of device                 =
                                    =0A> [   59.867968] ram0: rw=3D0, want=
=3D10018, limit=3D8192                                                 =0A>=
 [   61.064912] Buffer I/O error on device ram0, logical block 5008        =
                                                          =0A> [   62.65314=
9] attempt to access beyond end of device                                  =
                   =0A> [   63.942154] ram0: rw=3D0, want=3D10020, limit=3D=
8192                                                 =0A> [   65.139082] Bu=
ffer I/O error on device ram0, logical block 5009                          =
                                        =0A> [   66.727305] attempt to acce=
ss beyond end of device                                                    =
 =0A> [   68.016306] ram0: rw=3D0, want=3D10022, limit=3D8192              =
                                   =0A> [   69.212688] BUG: soft lockup det=
ected on CPU#0!                                                  =0A> [   6=
9.212711] Call Trace:                          =0A> [   69.212733] [C024F78=
0] [C000906C] show_stack+0x48/0x194 (unreliable)                           =
                                            =0A> [   69.212808] [C024F7C0] =
[C0031874] softlockup_tick+0xb4/0xd0                                       =
                       =0A> [   69.212853] [C024F7E0] [C001DDE8] run_local_=
timers+0x18/0x28                                                           =
    =0A> [   69.212905] [C024F7F0] [C001DE70] update_process_times+0x78/0xb=
4                                                                   =0A> [ =
  69.212956] [C024F810] [C00045B4] timer_interrupt+0xd4/0x204              =
                                                 =0A> [   69.213000] [C024F=
850] [C000351C] ret_from_except+0x0/                                       =
                 =0A> [   69.213043] [C024F910] [C0015A9C] release_console_=
sem+0xe0/0x284                                                             =
      =0A> [   69.213105] [C024F950] [C0015DF4] vprintk+0x1b4/0x384        =
                                                =0A> [   69.213149] [C024F9=
F0] [C0016014] printk+0x50/0x60                                            =
         =0A> [   69.213189] [C024FA70] [C00B98DC] generic_make_request+0xc=
0/0x20c                                                                    =
=0A> [   69.213252] [C024FAB0] [C00B9AA8] submit_bio+0x80/0xd8             =
                                            =0A> [   69.213294] [C024FAF0] =
[C005602C] submit_bh+0x14c/0x1a0                                           =
               =0A> [   69.213342] [C024FB10] [C005854C] block_read_full_pa=
ge+0x310/0x328                                                             =
        =0A> [   69.213391] [C024FB80] [C007D4FC] do_mpage_readpage+0x38c/0=
x538                                                                  =0A> =
[   69.213437] [C024FC00] [C007D880] mpage_readpage+0x50/0x78              =
                                               =0A> [   69.213477] [C024FC5=
0] [C00B0120] ext2_readpage+0x1c/0x2c                                      =
                      =0A> [   69.213516] [C024FC60] [C0034824] read_cache_=
page+0xf8/0x208                                                            =
   =0A> [   69.213562] [C024FC90] [C00AD490] ext2_get_page+0x24/0x308      =
                                                       =0A> [   69.213623] =
[C024FCC0] [C00ADAE8] ext2_find_entry+0x7c/0x17c                 =0A> [   6=
9.213663] [C024FD10] [C00ADC78] ext2_inode_by_name+0x18/0x58=0A> [   69.213=
704] [C024FD30] [C00B191C] ext2_lookup+0x54/0xd8=0A> [   69.213744] [C024FD=
50] [C0062E4C] do_lookup+0x138/0x19c=0A> [   69.213793] [C024FD80] [C006391=
8] __link_path_walk+0x8f4/0x1014=0A> [   69.213837] [C024FDD0] [C00640C0] l=
ink_path_walk+0x88/0x150=0A> [   69.213879] [C024FE40] [C006432C] do_path_l=
ookup+0x1a4/0x2b8=0A> [   69.213924] [C024FE70] [C006452C] __path_lookup_in=
tent_open+0x58/0xb8=0A> [   69.213971] [C024FEA0] [C0064F14] open_namei+0x7=
0/0x6dc=0A> [   69.214015] [C024FEE0] [C00519E4] do_filp_open+0x30/0x78=0A>=
 [   69.214056] [C024FF50] [C0051E04] do_sys_open+0x70/0x10c=0A> [   69.214=
095] [C024FF80] [C0002618] init+0x274/0x2e0=0A> [   69.214137] [C024FFF0] [=
C00051FC] kernel_thread+0x44/0x60=0A> [  117.445261] Buffer I/O error on de=
vice ram0, logical block 5010=0A> [  119.033233] attempt to access beyond e=
nd of device=0A> [  120.322015] ram0: rw=3D0, want=3D10018, limit=3D8192=0A=
> [  121.518738] Buffer I/O error on device ram0, logical block 5008=0A> [ =
 123.106686] attempt to access beyond end of device=0A> [  124.395468] ram0=
: rw=3D0, want=3D10020, limit=3D8192=0A> [  125.592200] Buffer I/O error on=
 device ram0, logical block 5009=0A> [  127.180152] attempt to access beyon=
d end of device=0A> [  128.468929] ram0: rw=3D0, want=3D10022, limit=3D8192=
=0A> [  129.665650] Buffer I/O error on device ram0, logical block 5010=0A>=
 [  131.253675] attempt to access beyond end of device=0A> [  132.542475] r=
am0: rw=3D0, want=3D100=0A>=0A>=0A> _______________________________________=
________=0A> Linuxppc-embedded mailing list=0A> Linuxppc-embedded@ozlabs.or=
g=0A> https://ozlabs.org/mailman/listinfo/linuxppc-embedded=0A>   =0A=0A=0A=
-- =0ADave Lynch                               DLA Systems=0ASoftware Devel=
opment:                           Embedded Linux=0A717.627.3770            =
dhlii@dlasys.net       http://www.dlasys.net=0Afax: 1.253.369.9244         =
               Cell: 1.717.587.7774=0AOver 25 years' experience in platform=
s, languages, and technologies too numerous to list.=0A=0A"Any intelligent =
fool can make things bigger and more complex... It takes a touch of genius =
- and a lot of courage to move in the opposite direction."=0AAlbert Einstei=
n=0A=0A=0A=0A
