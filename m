From: Boris.BUIRON@fr.thalesgroup.com
Message-ID: <8840D182F8BB7540B173D2B1FA0CA9AB719D87@argos.clb.tcfr.thales>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Pb with JFFS2 and kernel 2.4.18
Date: Thu, 26 Jun 2003 09:16:39 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I need help.

Context :
I use a kernel 2.4.18 from kernel.org adapted to our custom board. The board
is based on a MPC860T, has two 8-MBytes AMD29DL323 flash bank and I use a
cutsom boot. I have defined a JFFS2 partition on one bank which contains the
configuration files and a CRAMFS partition for our root file-system. I use
the ELDK-2.0.2 as a distribution.

Description :
>From time to time, on boot, the kernel crashes. The problem seems to be in
the physmap_write32() function. A simple test which consists in a succession
of creation and destruction of a file in my JFFS2 partition leads to the
same crash as well as a succession of mount/umount of the partition.
The phenomenon happens when I put a trace level of 0 in both MTD_DEBUG and
JFFS2_DEBUG. When I put a trace level of 2 in JFFS2_DEBUG (MTD_DEBUG
remaining at 0), the phenomenon seeems to "magically" disappear.
Here is a partial sample of the Oops I got :

Oops: kernel access of bad area, sig: 11
NIP: C00B07AC XER: 00000000 LR: C00AD87C SP: C06F7CF0 REGS: c06f7c40 TRAP:
0300    Not tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: C258D00C, DSISR: 82000000
TASK = c06f6000[1362] 'touch' Last syscall: 5
last math 00000000 last altivec 00000000
GPR00: 00000004 C06F7CF0 C06F6000 C01784E8 1985E002 0058000C C06F7D14
00000001
GPR08: 00000020 C200D000 004C0000 00000001 00100000 100210D4 00000000
00000000
GPR16: 00000000 00000000 00000000 C023BECC C06F7DB8 00000000 1985E002
C06F7CF8
GPR24: C06F7D08 C0190000 00000001 C023BE90 C023BECC 0058000C C01784E8
C0197990
Call backtrace:
00000010 C00AE0C8 C00B0F68 C0081C14 C0081EAC C007C4E8 C003E530
C003E738 C0030E1C C0031278 C000275C 10019264 10000E7C 100016F4
0FECED14 00000000
Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

Using the ksymoops utility :
ksymoops 2.4.4 on i686 2.4.20-8.  Options used
     -v ./vmlinux (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m ./System.map (specified)
     -t ppc_8xx- -a ppc_8xx-

Oops: kernel access of bad area, sig: 11
NIP: C00B07AC XER: 00000000 LR: C00AD87C SP: C06F7CF0 REGS: c06f7c40 TRAP:
0300    Not tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c06f6000[1362] 'touch' Last syscall: 5
last math 00000000 last altivec 00000000
GPR00: 00000004 C06F7CF0 C06F6000 C01784E8 1985E002 0058000C C06F7D14
00000001
GPR08: 00000020 C200D000 004C0000 00000001 00100000 100210D4 00000000
00000000
GPR16: 00000000 00000000 00000000 C023BECC C06F7DB8 00000000 1985E002
C06F7CF8
GPR24: C06F7D08 C0190000 00000001 C023BE90 C023BECC 0058000C C01784E8
C0197990
Call backtrace:
00000010 C00AE0C8 C00B0F68 C0081C14 C0081EAC C007C4E8 C003E530
C003E738 C0030E1C C0031278 C000275C 10019264 10000E7C 100016F4
0FECED14 00000000
Kernel panic: Aiee, killing interrupt handler!
Warning (Oops_read): Code line not seen, dumping what data is available

>>???; c00b07ac <physmap_write32+4/10>   <=====
Trace; 00000010 Before first symbol
Trace; c00ae0c8 <cfi_amdstd_write+424/be4>
Trace; c00b0f68 <part_write+ac/c0>
Trace; c0081c14 <mtd_fake_writev+68/cc>
Trace; c0081eac <jffs2_write_dnode+10c/224>
Trace; c007c4e8 <jffs2_create+148/444>
Trace; c003e530 <vfs_create+b0/10c>
Trace; c003e738 <open_namei+1ac/63c>
Trace; c0030e1c <filp_open+58/84>
Trace; c0031278 <sys_open+4c/fc>
Trace; c000275c <ret_from_syscall_1+0/b4>
Trace; 10019264 Before first symbol
Trace; 10000e7c Before first symbol
Trace; 100016f4 Before first symbol
Trace; 0feced14 Before first symbol
Trace; 00000000 Before first symbol


1 warning issued.  Results may not be reliable.

Furthermore, after the Oops, when I reset the board (short Power Off/Power
On), now the boot now the Init process claims not to be able to read the
flash :-(

Guess :
AFAIK, JFFS2 mechanism involves a garbage collector. Is there any misfortune
that I got a write cycle while the GC thread tryes to recover the files ?
Thus is there any kind of mutual exclusion to be planed in both mechanisms
in order to prvent this crash ?
Is it (I hope not) a hardware problem ?

Thanks in advance
Bests regards

Boris Buiron
Thales Communications France

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
