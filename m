Message-Id: <199906021206.OAA14059@denx.muc.de>
To: linuxppc-dev@lists.linuxppc.org
From: Wolfgang Denk <wd@denx.muc.de>
Subject: MPC8xx: wrong zimage_start
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Date: Wed, 02 Jun 1999 14:06:05 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I think I need some help... I'm trying to port Linux to a  "non-stan-
dard"   MPC860  board.  Obviously,  it  does  not  provide  the  same
environment as the EPPC-Bug on the MBX860 boards.

I'm running  into  problems  when  it  comes  to  decompressiong  and
starting  the  kernel;  here is what I see on the console (I've added
some debugging code):

    decompress_kernel: load_addr 00010000 num_words 0003F510 cksum 96CF6339 &residual 01FFFDD8 
    loaded at:     00010000 0010D440
    relocated to:  00100000 001FD440
    board data at: 01FFFDD8 01FFFE00
    relocated to:  00000100 00000128
    zimage at:     00017000 0006B2F3
    avail ram:     001FD440 00600000

    Linux/PPC load: console=tty0 console=ttyS0,115200n8

    gunzip: dst 0 dstlen 0x400000 zimage_start 00017000 zimage_size 000542F3 

    Uncompressing Linux... bad gzipped data
     00017000 : 3D29C000    A3E90000    7C0006AC    48000010 
     00017010 : A0093C82    541F043E    7C0006AC    3D20C000 
     00017020 : A0093CAC    5400043E    7C0006AC    2C800000 
     00017030 : 4186001C    31202010    5529043E    3D29C000 
     00017040 : B1690000    7C0006AC    4800000C    B1693C90 
     00017050 : 7C0006AC    3D20C000    A0093CAC    5400043E 
     00017060 : 7C0006AC    2C800000    4186001C    31202020 
     00017070 : 5529043E    3D29C000    B3E90000    7C0006AC 
     00017080 : 4800000C    B3E93CA0    7C0006AC    3D20C000 
     00017090 : A0093CAC    5400043E    7C0006AC    2C800000 
     000170A0 : 41860020    31202004    5529043E    3D29C000 
     000170B0 : 38000010    98090000    7C0006AC    48000010 
     000170C0 : 38000010    98093C84    7C0006AC    3D20C000 
     000170D0 : A0093CAC    5400043E    7C0006AC    2C800000 
     000170E0 : 41860020    31202005    5529043E    3D29C000 
     000170F0 : 38000010    98090000    7C0006AC    48000010 
    Searching [0x4000 - 0x1000000]...  
    at 004E7C00 : 1F8B0808  DC0D5337  0203766D  6C696E75 
    ......looks good...done.

I'm booting from flash memory; zImage is at 40700000, so I start with
a `go 40710000'; I have 32 MB RAM and created a faked "bd_info"
struct at the end of RAM. Everything seems to be fine, but the
compressed image is not where it is expected to be: objdump says

    -> objdump -h zvmlinux

    zvmlinux:     file format elf32-powerpc

    Sections:
    Idx Name          Size      VMA       LMA       File off  Algn
      0 .text         00004fa0  00100000  00100000  00010000  2**2
		      CONTENTS, ALLOC, LOAD, READONLY, CODE
      1 .rodata       00000618  00104fa0  00104fa0  00014fa0  2**2
		      CONTENTS, ALLOC, LOAD, READONLY, DATA
      2 .data         00000314  00106000  00106000  00016000  2**2
		      CONTENTS, ALLOC, LOAD, DATA
      3 .bss          0000bbbc  00107000  00107000  00017000  2**2
		      ALLOC
      4 image         0005421a  00000000  00000000  00017000  2**0
		      CONTENTS, READONLY

so the value of 00017000 for zimage_start looks good. I've added some
code to search for the real position in memory, and found it  to  sit
at 004E7C00 instead.

Hmmm... I guess that EPPC-Bug might be doing some magic things to the
ELF file which I am still missing.

Can anybody see what I'm doing wrong, or at least give me a few hints
where to look?

Thanks in advance,

Wolfgang

-- 
Phone: (+49)-8142-4596-87  Fax: -88  Home: -86  Email: wd@denx.muc.de
Any time things appear to be going better, you have overlooked  some-
thing.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
