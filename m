Message-ID: <3AB7ED5B.7000800@brocade.com>
Date: Tue, 20 Mar 2001 15:52:59 -0800
From: Amit D Chaudhary <amitc@brocade.com>
MIME-Version: 1.0
To: nunninger@web.de
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: strange problem while booting
References: <3AB7E349.8AC5A1B0@enst.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I don't know your specific board or configuration, but here's what might
help.
It seems like the initrd is at another offset, while the kernel is
trying to get it from 0. What might go wrong, incorrect kernel being
used(for example, zImage instead of zImage.initrd) or incorrect .config
or image make settings.

Amit


Stefan Nunninger wrote:

> Hello everybody,
>
> Once more I've got a problem while trying to boot a montavista linux
> 2.2.14 on a custom board with a MPC860.
> I'm using BDM4GDB for debugging and running linux.
>
> Usually when booting linux it boots until it tries to load the
> ramdisk. There it stops for a reason I did not manage to figure out
> yet.
> The output of the kernel looks like this:
> --------------------------------------------------------
>  decomp : ZIMAGE_OFFSET: 0001C1F0
> INITRD_OFFSET: 00077DF3
> INITRD_SIZE: 0014D729
>  loaded at:     00100000 00100000
>  board data at: 001001E4 00100210
>  relocated to:  000F0100 000F012C
> ZIMAGE_OFFSET: 0001C1F0
> zimage_start : 0010C1F0
> zimage_size : 00032BA2
>  initrd_start : 00167DF3
>  initrd_end   : 002B551C
>  zimage at:     0010C1F0 0013ED92
>  initrd at:     00167DF3 002B551C
>  avail ram:     002B6000 01000000
>
> Linux/PPC load:
> Uncompressing Linux...
> Gunzip ...
>  Dest address   : 00000000
>  Dest length    : 00100000
>  Source address : 0010C1F0
> Now booting the kernel
> Linux version 2.2.14 (stefan@paris.enst.fr) (gcc version 2.95.2
> 19991030 (2.95.3
>  prerelease/franzo)) #617 Mon Mar 19 18:15:35 CET 2001
> Boot arguments: root=/dev/ram
> time_init: decrementer frequency = 120000000/60
> parse_options finished
> Calibrating delay loop... 31.85 BogoMIPS
> Memory: 14232k available (412k kernel code, 376k data, 24k init)
> [c0000000,c1000000]
> Dentry hash table entries: 2048 (order 2, 16k)
> Buffer cache hash table entries: 16384 (order 4, 64k)
> Page cache hash table entries: 4096 (order 2, 16k)
> POSIX conformance testing by UNIFIX
> do_basic_setup
> Linux NET4.0 for Linux 2.2
> Based upon Swansea University Computer Society NET3.039
> Starting kswapd v 1.5
> CPM UART driver version 0.03
> ttyS00 at 0x0280 is a SMC
> ttyS01 at 0x0380 is a SMC
> ttyS02 at 0x0100 is a SCC
> ttyS03 at 0x0200 is a SCC
> pty: 256 Unix98 ptys configured
> RAM disk driver initialized:  16 RAM disks of 4096K size
> loop: registered device at major 7
> RAMDISK: Couldn't find valid RAM disk image starting at 0.
> function: /fs/super.c::mount_root says
> Kernel panic: VFS: Unable to mount root fs on 01:00
> Rebooting in 180 seconds..
>
> While trying to debug this it appears that my board behaves in a
> strange way I can not really understand. After resetting the board
> (usually I turn of power for a second) and rebooting the kernel,
> there is not the same kernel output instead I see one of the
> following outputs:
> --------------------------------------------------------
>  decomp : ZIMAGE_OFFSET: 0001C1F0
> INITRD_OFFSET: 00077DE3
> INITRD_SIZE: 0014D729
>  loaded at:     00100000 0010002C
>  board data at: 001001E4 00100210
>  relocated to:  000F0100 000F012C
> ZIMAGE_OFFSET: 0001C1F0
> zimage_start : 0010C1F0
> zimage_size : 00032B94
>  initrd_start : 00167DE3
>  initrd_end   : 002B550C
>  zimage at:     0010C1F0 0013ED84
>  initrd at:     00167DE3 002B550C
>  avail ram:     002B6000 01000000
> Linux/PPC load:
> Uncompressing Linux...
> Gunzip ...
>  Dest address   : 00000000
>  Dest length    : 00100000
>  Source address : 0010C1F0
> Now booting the kernel
>
> - and nothing more.
> When debugging this I found that the kernel switches on virtual
> adresses and goes on until identify_machine. From there it branches
> to a c-function. However this is not identify_machine but any other
> function. As this makes no sense the kernel stops somewhere after.
>
> --------------------------------------------------------
>  decomp : ZIMAGE_OFFSET: 0001C1F0
> INITRD_OFFSET: 00077DF7
> INITRD_SIZE: 0014D729
>  loaded at:     00100000 00110004
>  board data at: 001001E4 00100210
>  relocated to:  000F0100 000F012C
> ZIMAGE_OFFSET: 0001C1F0
> zimage_start : 0010C1F0
> zimage_size : 00032BA5
>  initrd_start : 00167DF7
>  initrd_end   : 002B5520
>  zimage at:     0010C1F0 0013ED95
>  initrd at:     00167DF7 002B5520
>  avail ram:     002B6000 01000000
>
> Linux/PPC load:
> Uncompressing Linux...
> Gunzip ...
>  Dest address   : 00000000
>  Dest length    : 00100000
>  Source address : 0010C1F0
> Now booting the kernel
> Linux version 2.2.14 (stefan@paris.enst.fr) (gcc version 2.95.2
> 19991030 (21Boot arguments: root=/dev/ram
> time_init: decrementer frequency = 120000000/60
> parse_options finished
> Calibrating delay loop... 31.74 BogoMIPS
> Memory: 14232k available (412k kernel code, 376k data, 24k init)
> [c0000000,]Dentry hash table entries: 2048 (order 2, 16k)
> Buffer cache hash table entries: 16384 (order 4, 64k)
> Page cache hash table entries: 4096 (order 2, 16k)
> POSIX conformance testing by UNIFIX
> do_basic_setup
> Linux NET4.0 for Linux 2.2
> Based upon Swansea University Computer Society NET3.039
> Starting kswapd v 1.5
> CPM UART driver version 0.03
> ttyS00 at 0x0280 is a SMC
> ttyS01 at 0x0380 is a SMC
> ttyS02 at 0x0100 is a SCC
> ttyS03 at 0x0200 is a SCC
> pty: 256 Unix98 ptys configured
> RAM disk driver initialized:  16 RAM disks of 4096K size
> loop: registered device at major 7
> Machine check in kernel mode.
> Caused by (from msr): regs c0165ca0 Unknown values in msr
> NIP: 00000200 XER: 8000FF0A LR: C0019394 REGS: c0165ca0 TRAP: 0200
> MSR: 00009002 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 00
> TASK = c0164000[1] 'swapper' mm->pgd c0070000 Last syscall: 120
> last math 00000000
> GPR00: C0019394 C0165D50 C0164000 0006F885 C0165D68 C015D000
> 00000000 00000
> GPR08: C0076028 C015D000 00000000 000003F2 35000004 1111000D
> 1111000E 11110
> GPR16: 11110010 11110011 11110012 11110013 00009032 00165E10
> 00000000 C0002
> GPR24: C0009814 11110019 00000000 C015D000 C0164000 C00715E0
> 0006F885 C0071
> Call backtrace:
> 00000023 30303020
>
> this time I get a machine check exception. The backtrace does not
> really help as there is nothing at this addresses.
>
> yet another output looks like this:
> --------------------------------------------------------
>  decomp : ZIMAGE_OFFSET: 0001C1F0
> °²@..<L°...2N...<.N.ò¼...ÄòNN_.N_.._°..N..N...22L.2Å.B..I2..².I²¼0..²BL°_
> ... it goes on like this for quite a while
>
> and finally I see this:
> --------------------------------------------------------
>  Ä+Ä : ZIMAGE OFFSET: 0001C1F0
> INITRD OFFSET: 00077DF7
> INITRD SIZE: 0014D729
>  +Ä# #+:     00100000 00100080
>  Ä#_ #+# #+: 001001E4 00100210
>  _+Ä#+ +Ä:  000F0100 000F012C
> ZIMAGE OFFSET: 0001C1F0
>
>> +#± _+#_+ : 0010C1F0
>> +#± _> : 00032BA6
>
>  Å+_ _+#_+ : 00167DF7
>  Å+_ Å   : 002B5520
>  >+#± #+:     0010C1F0 0013ED96
>  Å+_ #+:     00167DF7 002B5520
>  #+#+ _#+:     002B6000 01000000
>
> LÅ+|/PPC +Ä#:
> UÅÄ+Ä___Å± LÅ+|...
> G+Å>Ä ...
>  D_+ #___   : 00000000
>  D_+ +Å±+    : 00100000
>  SÄ+_ #___ : 0010C1F0
>
> NÄ+ ÄÄ+Å± + +_Å+
> LÅ+| +__ÄÅ 2.2.14 (_+°#Å@Ä#__.Å_+.°_) (± +__ÄÅ 2.95.2 19991030
> (2.95.3 Ä__+1BÄÄ+ #_±++Å+_: _ÄÄ+=/+/_#+
> ++ Å+: _+Å+_ °_Ä+Å< = 120000000/60
> Ä#__ ÄÄ+ÄÅ_ °Å_
> C#+_#+Å± +#< +ÄÄÄ... 31.74 BÄ±ÄMIPS
> M+Ä_<: 14232+ #+#+#+ (412+ +_Å+ Ä, 376+ #+#, 24+ Å+)
> [0000000,1000000]
> DÅ+_< #_ +#+ Å+__: 2048 (Ä__ 2, 16+)
> B+°°_ # + Å++ Å+__: 16384 (Ä__ 4, 64+)
> B+°°_ # #_ +#+ Å+__: 16384 (Ä__ 4, 64+)
> P#± # #_ +#+ Å+__: 4096 (Ä__ 2, 16+)
> POSIX ÄÅ°Ä_+#Å +_+Å± < UNIFIX
> Ä #_ _++Ä
> LÅ+| NET4.0 °Ä_ LÅ+| 2.2
> B#_ +ÄÄÅ S+#Å_# UÅ+__+< CÄ+Ä++_ SÄ+< NET3.039
> S+#_+Å± +_+#Ä + 1.5
> CPM UART _+_ +__ÄÅ 0.03
> ++<S00 #+ 0|0280 _ # SMC
> ++<S01 #+ 0|0380 _ # SMC
> ++<S02 #+ 0|0100 _ # SCC
> ++<S03 #+ 0|0200 _ # SCC
> Ä+<: 256 UÅ|98 Ä+<_ ÄÅ°±+_
> RAM _+ _+_ Å+#+>:  16 RAM _+_ Ä° 4096K _>
> +ÄÄÄ: _±_+_ + #+ +#+Ä_ 7
>
> It appears that all upper case letters and numbers are correct. All
> other characters are changed. These changes are not random. When
> running the kernel several time the output is exactly the same.
>
> By chance I connected this board to another debugger (VisionClick)
> to see what happens there. Interestingly everything worked fine. It
> gets until trying to boot the ramdisk. Thus I conclude there is
> something wrong with my initialisation code in the bootloader. Some
> values which are set by VisionClick might not be set properly by my
> bootcode. Thus I tried to find any differences. All I could find was
> this
>
>
> REG      VisionClick   BDM4GDB
> SIPEND   00000000      02A80000
> MCR      0000003F      4080003F
> PLPRCR   00700000      00704000
> RSR      00000000      C0000000
> PBDAT    00001EC4      00001DC4
>
> I used the values of VisionClick to set up these register in
> BDM4GDB. It did not help in any way. Next I've copied all register
> values from VisionClick and set the values excactly like this in
> BDB4GDB. But still no improvement.
>
> The values which I normally initialize in my bootloader are as
> follows:
> DER = 0x2002000F
> DEC = 0x7FFFFFFF
> SYPCR = 0xffffff83
> ICTRL = 0x00000007
> ORx, BRx
> UPMAx
> MSTAT = 0x00000200
> MAMR = 0x07821330
> ICR = 0x0
> MSR = 0x1042
> IMMR = 0xFA200000
> SIUMCR = 0x00292900
> TBL = 0x0
> TBU = 0x0
> plprcr = 0x00700000
>
> Is there something missing here?
> Could anybody give me a hint what might be the reason for all this
> strange behaviour. What could solve the problem?
>
> I hope somebody has an idea as I spend now nearly two weeks on that
> without any result.
>
> Many thanks
> 	Stefan
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
