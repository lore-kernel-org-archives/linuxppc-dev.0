Date: Sun, 1 Oct 2000 22:44:27 +0200
From: Olaf Hering <olh@suse.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Patch: PCI resource fixup for atyfb (was: Re: xf 4.0.1 + ati driver with rage II/rage pro)
Message-ID: <20001001224427.A18368@suse.de>
References: <Pine.LNX.4.21.0009301652040.2538-100000@idd-01.imbc.gr> <Pine.LNX.4.10.10010011928450.9543-100000@opal.biophys.uni-duesseldorf.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.10.10010011928450.9543-100000@opal.biophys.uni-duesseldorf.de>; from schmitz@opal.biophys.uni-duesseldorf.de on Sun, Oct 01, 2000 at 07:59:55PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

while we are about to improve the atyfb, is it possible to fix the color
depth switching?
When I boot without a kernel arg I end up with 8 bit at console. I can't
increase the color depth afterwards with fbset, and mol crashes when it
tries to do that. When I specify atyfb:cmode:24 everythings works fine
and I can switch down to 8 and back to 24 and mol starts fine.

This trace may give a hint whats wrong here. Its the kernel with
Michaels ressource fix on a Wallstreet, mol should use 1024x768-60 with
24 bit. I did not try other Mach64 machines yet.


WARNING: This version of ksymoops is obsolete.
WARNING: The current version can be obtained from ftp://ftp.ocs.com.au/pub/ksymoops
Options used: -v /boot/vmlinux (specified)
              -o /lib/modules/2.2.16/ (default)
              -k /proc/ksyms (default)
              -l /proc/modules (default)
              -m /boot/System.map-2.2.16 (specified)
              -c 1 (default)

Warning: memstat symbol __insmod_memstat_O/lib/modules/2.2.16/misc/memstat.o_M39D30ACF_V131600 not found in /lib/modules/2.2.16/misc/memstat.o.  Ignoring /lib/modules/2.2.16/misc/memstat.o entry
Warning: memstat symbol __insmod_memstat_S.data_L316 not found in /lib/modules/2.2.16/misc/memstat.o.  Ignoring /lib/modules/2.2.16/misc/memstat.o entry
Warning: memstat symbol __insmod_memstat_S.rodata_L16 not found in /lib/modules/2.2.16/misc/memstat.o.  Ignoring /lib/modules/2.2.16/misc/memstat.o entry
Warning: memstat symbol __insmod_memstat_S.text_L1084 not found in /lib/modules/2.2.16/misc/memstat.o.  Ignoring /lib/modules/2.2.16/misc/memstat.o entry
Warning: dmasound symbol __insmod_dmasound_O/lib/modules/2.2.16/misc/dmasound.o_M39D30999_V131600 not found in /lib/modules/2.2.16/misc/dmasound.o.  Ignoring /lib/modules/2.2.16/misc/dmasound.o entry
Warning: dmasound symbol __insmod_dmasound_S.bss_L752 not found in /lib/modules/2.2.16/misc/dmasound.o.  Ignoring /lib/modules/2.2.16/misc/dmasound.o entry
Warning: dmasound symbol __insmod_dmasound_S.data_L1932 not found in /lib/modules/2.2.16/misc/dmasound.o.  Ignoring /lib/modules/2.2.16/misc/dmasound.o entry
Warning: dmasound symbol __insmod_dmasound_S.rodata_L1228 not found in /lib/modules/2.2.16/misc/dmasound.o.  Ignoring /lib/modules/2.2.16/misc/dmasound.o entry
Warning: dmasound symbol __insmod_dmasound_S.text_L23400 not found in /lib/modules/2.2.16/misc/dmasound.o.  Ignoring /lib/modules/2.2.16/misc/dmasound.o entry
Sep 30 23:07:41 plum kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000 (error 40000000)
Sep 30 23:07:41 plum kernel: NIP: C017EB44 XER: 00000000 LR: C018491C REGS: c4119bd0 TRAP: 0300
Sep 30 23:07:41 plum kernel: MSR: 00009032 [EEIRDRME]
Sep 30 23:07:41 plum kernel: TASK = c4118000[4326] 'mol' mm->pgd c26c0000 Last syscall: 4
Sep 30 23:07:41 plum kernel: last math c4118000
Sep 30 23:07:41 plum kernel: GPR00: 0000000C C4119C80 C4118000 C0613FE8 C029F928 CBEFEF00 0000001F 00130000
Sep 30 23:07:41 plum kernel: GPR08: 00000000 00000000 00000000 00000007 C029F928 01882AE0 C0290000 C3C12000
Sep 30 23:07:41 plum kernel: GPR16: C02A0000 C0210000 00000000 CBEFEF00 CBEFEF3E 00000000 00000000 00000000
Sep 30 23:07:41 plum kernel: GPR24: C4119D97 C029B1B0 00000000 FFFFFFFC 00000400 CBEFEF00 0000001F CBEFEF00
Sep 30 23:07:41 plum kernel: Call backtrace:
Sep 30 23:07:41 plum kernel: C029FFA0 C0613FE8 C017735C C00FF388 C00FFB30 C01073E8 C01099BC
Sep 30 23:07:41 plum kernel: C0104568 C0031588 C0003EC4 0160FDF0 014F52BC 014F4868 014F549C
Sep 30 23:07:41 plum kernel: 014E65C0 014E1824 01804CFC 01831938 0182DBA8 018208F4 01820B14
Sep 30 23:07:41 plum kernel: 0180CEC8 014BE85C 00000000
Sep 30 23:07:41 plum kernel: Kernel panic: kernel access of bad area pc c017eb44 lr c018491c address 0 tsk mol/4326
Sep 30 23:07:41 plum kernel: Unable to handle kernel NULL pointer dereference at virtual address 0000001c (error 40000000)
Sep 30 23:07:41 plum kernel: NIP: C017E95C XER: 00000000 LR: C0184874 REGS: c3e59cf0 TRAP: 0300
Sep 30 23:07:41 plum kernel: MSR: 00009032 [EEIRDRME]
Sep 30 23:07:41 plum kernel: TASK = c3e58000[305] 'gpm' mm->pgd c3db6000 Last syscall: 54
Sep 30 23:07:41 plum kernel: last math c4118000
Sep 30 23:07:41 plum kernel: GPR00: 00000650 C3E59DA0 C3E58000 C020FA14 C029F928 00007065 D00DF6E0 000006E0
Sep 30 23:07:41 plum kernel: GPR08: C029F928 0000001C 00000000 00000000 00000010 0182858C 00000000 01820000
Sep 30 23:07:41 plum kernel: GPR16: 01820D60 01820000 01820000 00000000 00009032 03E59E80 00000000 C0004154
Sep 30 23:07:41 plum kernel: GPR24: C3C12000 00000000 00000018 00000037 C0210000 00000003 00000000 00000400
Sep 30 23:07:41 plum kernel: Call backtrace:
Sep 30 23:07:41 plum kernel: C01054CC 01820D64 C0177238 C00FB30C C010153C C00FF9F8 C01065AC
Sep 30 23:07:41 plum kernel: C003DDAC C0003EC4 00000001 018031F0 0170785C 00000000
Sep 30 23:07:41 plum kernel: Kernel panic: kernel access of bad area pc c017e95c lr c0184874 address 1C tsk gpm/305
Warning, Code line not seen, dumping what data is available

>>NIP: c017eb44 <fbcon_cfb32_putcs+40/26c>
Trace: c029ffa0 <fb_display+678/43ec>
Trace: c0613fe8 <_end+370290/1058c2fc>
Trace: c017735c <fbcon_putcs+fc/124>
Trace: c00ff388 <do_con_write+658/6a0>
Trace: c00ffb30 <con_write+18/3c>
Trace: c01073e8 <opost_block+230/244>
Trace: c01099bc <write_chan+180/2d8>
Trace: c0104568 <tty_write+214/2b0>
Trace: c0031588 <sys_write+124/164>
Trace: c0003ec4 <syscall_ret_1+0/b4>
Trace: 0160fdf0 Before first symbol
Trace: 014f52bc Before first symbol
Trace: 014f4868 Before first symbol
Trace: 014f549c Before first symbol
Trace: 014e65c0 Before first symbol
Trace: 014e1824 Before first symbol
Trace: 01804cfc Before first symbol
Trace: 01831938 Before first symbol
Trace: 0182dba8 Before first symbol
Trace: 018208f4 Before first symbol
Trace: 01820b14 Before first symbol
Trace: 0180cec8 Before first symbol
Trace: 014be85c Before first symbol
Trace: 00000000 Before first symbol
>>NIP: c017eb44 <fbcon_cfb32_putcs+40/26c>
>>NIP: c017e95c <fbcon_cfb32_putc+84/22c>
Trace: c01054cc <tty_open+204/3ac>
Trace: 01820d64 Before first symbol
Trace: c0177238 <fbcon_putc+e8/110>
Trace: c00fb30c <complement_pos+14c/160>
Trace: c010153c <set_selection+460/76c>
Trace: c00ff9f8 <tioclinux+e8/208>
Trace: c01065ac <tty_ioctl+434/520>
Trace: c003ddac <sys_ioctl+288/2ac>
Trace: c0003ec4 <syscall_ret_1+0/b4>
Trace: 00000001 Before first symbol
Trace: 018031f0 Before first symbol
Trace: 0170785c Before first symbol
Trace: 00000000 Before first symbol
>>NIP: c017e95c <fbcon_cfb32_putc+84/22c>


12 warnings issued.  Results may not be reliable.



Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
