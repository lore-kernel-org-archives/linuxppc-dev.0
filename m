Return-Path: <acahalan@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.184])
	by ozlabs.org (Postfix) with ESMTP id 4DF5F679E2
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Aug 2006 13:47:23 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id c2so1593830nfe
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 20:47:22 -0700 (PDT)
Message-ID: <787b0d920608182047x7fd69defmace612dcc5b167df@mail.gmail.com>
Date: Fri, 18 Aug 2006 23:47:21 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: "=?ISO-8859-1?Q?Michel_D=E4nzer?=" <michel@tungstengraphics.com>
Subject: Re: [PATCH] no-execute -- please test
In-Reply-To: <1155572457.12664.143.camel@thor.lorrainebruecke.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <787b0d920608132020q4ad2b5c2y49e25ca7ecc33536@mail.gmail.com>
	<1155547172.12664.115.camel@thor.lorrainebruecke.local>
	<787b0d920608140908x391e926cs7c1023cb7ab5597f@mail.gmail.com>
	<1155572457.12664.143.camel@thor.lorrainebruecke.local>
Cc: linuxppc-dev@ozlabs.org, debian-powerpc <debian-powerpc@lists.debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 8/14/06, Michel D=E4nzer <michel@tungstengraphics.com> wrote:

> The diff between the log files doesn't show any explanation as to why it
> works in one case but doesn't in the other, maybe the difference really
> lies on the client side?

You're right. Somehow I hadn't spotted this in my syslog:

fuckup @ 1002f158 with trap 0x400 code 10000000 by x-session-manag

That is the GNOME session manager.
The /proc/*/maps file contains this:

1002f000-101dc000 rwxp 1002f000 00:00 0          [heap]

Why the heck is the heap being executed?
If this is legit, how do I recognize it?
As far as I can tell, this is not the PLT area
and anyway the PLT is marked executable.

$ file /usr/bin/gnome-session
/usr/bin/gnome-session: ELF 32-bit MSB executable, PowerPC or cisco
4500, version 1 (SYSV), for GNU/Linux 2.4.1, dynamically linked (uses
shared libs), for GNU/Linux 2.4.1, stripped

------------------- some eu-readelf stuff -----------------------
ELF Header:
  Magic:   7f 45 4c 46 01 02 01 00 00 00 00 00 00 00 00 00
  Class:                             ELF32
  Data:                              2's complement, big endian
  Ident Version:                     1 (current)
  OS/ABI:                            UNIX - System V
  ABI Version:                       0
  Type:                              EXEC (Executable file)
  Machine:                           PowerPC
  Version:                           1 (current)
  Entry point address:               0x100077d0
  Start of program headers:          52 (bytes into file)
  Start of section headers:          124156 (bytes into file)
  Flags:
  Size of this header:               52 (bytes)
  Size of program header entries:    32 (bytes)
  Number of program headers entries: 7
  Size of section header entries:    40 (bytes)
  Number of section headers entries: 27
  Section header string table index: 26

Section Headers:
[Nr] Name                 Type         Addr     Off    Size   ES Flags Lk I=
nf Al
[ 0]                      NULL         00000000 000000 000000  0        0  =
 0  0
[ 1] .interp              PROGBITS     10000114 000114 00000d  0 A      0  =
 0  1
[ 2] .note.ABI-tag        NOTE         10000124 000124 000020  0 A      0  =
 0  4
[ 3] .hash                HASH         10000144 000144 0017ec  4 A      4  =
 0  4
[ 4] .dynsym              DYNSYM       10001930 001930 002160 16 A      5  =
 1  4
[ 5] .dynstr              STRTAB       10003a90 003a90 00251a  0 A      0  =
 0  1
[ 6] .gnu.version         GNU_versym   10005faa 005faa 00042c  2 A      4  =
 0  2
[ 7] .gnu.version_r       GNU_verneed  100063d8 0063d8 000070  0 A      5  =
 2  4
[ 8] .rela.dyn            RELA         10006448 006448 00003c 12 A      4  =
 0  4
[ 9] .rela.plt            RELA         10006484 006484 001320 12 A      4  =
24  4
[10] .init                PROGBITS     100077a4 0077a4 000028  0 AX     0  =
 0  4
[11] .text                PROGBITS     100077d0 0077d0 0132b0  0 AX     0  =
 0 16
[12] .fini                PROGBITS     1001aa80 01aa80 000020  0 AX     0  =
 0  4
[13] .rodata              PROGBITS     1001aaa0 01aaa0 003630  0 A      0  =
 0  8
[14] .eh_frame            PROGBITS     1001e0d0 01e0d0 000004  0 A      0  =
 0  4
[15] .ctors               PROGBITS     1002e0d4 01e0d4 000008  0 WA     0  =
 0  4
[16] .dtors               PROGBITS     1002e0dc 01e0dc 000008  0 WA     0  =
 0  4
[17] .jcr                 PROGBITS     1002e0e4 01e0e4 000004  0 WA     0  =
 0  4
[18] .got2                PROGBITS     1002e0e8 01e0e8 000010  0 WA     0  =
 0  1
[19] .dynamic             DYNAMIC      1002e0f8 01e0f8 000180  8 WA     5  =
 0  4
[20] .data                PROGBITS     1002e278 01e278 00018c  0 WA     0  =
 0  4
[21] .got                 PROGBITS     1002e404 01e404 000014  4 WAX    0  =
 0  4
[22] .sdata               PROGBITS     1002e418 01e418 000018  0 WA     0  =
 0  4
[23] .sbss                NOBITS       1002e430 01e430 000118  0 WA     0  =
 0  4
[24] .plt                 NOBITS       1002e548 01e430 001368  0 WAX    0  =
 0  4
[25] .bss                 NOBITS       1002f8b0 01e430 000078  0 WA     0  =
 0  4
[26] .shstrtab            STRTAB       00000000 01e430 0000ca  0        0  =
 0  1

Program Headers:
  Type           Offset   VirtAddr   PhysAddr   FileSiz  MemSiz   Flg Align
  PHDR           0x000034 0x10000034 0x10000034 0x0000e0 0x0000e0 R E 0x4
  INTERP         0x000114 0x10000114 0x10000114 0x00000d 0x00000d R   0x1
        [Requesting program interpreter: /lib/ld.so.1]
  LOAD           0x000000 0x10000000 0x10000000 0x01e0d4 0x01e0d4 R E 0x100=
00
  LOAD           0x01e0d4 0x1002e0d4 0x1002e0d4 0x00035c 0x001854 RWE 0x100=
00
  DYNAMIC        0x01e0f8 0x1002e0f8 0x1002e0f8 0x000180 0x000180 RW  0x4
  NOTE           0x000124 0x10000124 0x10000124 0x000020 0x000020 R   0x4
  GNU_STACK      0x000000 0x00000000 0x00000000 0x000000 0x000000 RW  0x4


 Section to Segment mapping:
  Segment Sections...
   00
   01      [RO: .interp]
   02      [RO: .interp .note.ABI-tag .hash .dynsym .dynstr
.gnu.version .gnu.version_r .rela.dyn .rela.plt .init .text .fini .
rodata .eh_frame]
   03      .ctors .dtors .jcr .got2 .dynamic .data .got .sdata .sbss .plt .=
bss
   04      .dynamic
   05      [RO: .note.ABI-tag]
   06

Dynamic segment contains 48 entries:
 Addr: 0x1002e0f8  Offset: 0x01e0f8  Link to section: [ 5] '.dynstr'
  Type              Value
  NEEDED            Shared library: [libgnome-desktop-2.so.2]
  NEEDED            Shared library: [libgnomeui-2.so.0]
  NEEDED            Shared library: [libstartup-notification-1.so.0]
  NEEDED            Shared library: [libSM.so.6]
  NEEDED            Shared library: [libICE.so.6]
  NEEDED            Shared library: [libgnome-2.so.0]
  NEEDED            Shared library: [libesd.so.0]
  NEEDED            Shared library: [libgtk-x11-2.0.so.0]
  NEEDED            Shared library: [libgdk-x11-2.0.so.0]
  NEEDED            Shared library: [libatk-1.0.so.0]
  NEEDED            Shared library: [libgdk_pixbuf-2.0.so.0]
  NEEDED            Shared library: [libXrandr.so.2]
  NEEDED            Shared library: [libpango-1.0.so.0]
  NEEDED            Shared library: [libX11.so.6]
  NEEDED            Shared library: [libbonobo-2.so.0]
  NEEDED            Shared library: [libgconf-2.so.4]
  NEEDED            Shared library: [libbonobo-activation.so.4]
  NEEDED            Shared library: [libORBit-2.so.0]
  NEEDED            Shared library: [libgobject-2.0.so.0]
  NEEDED            Shared library: [libpthread.so.0]
  NEEDED            Shared library: [libglib-2.0.so.0]
  NEEDED            Shared library: [libwrap.so.0]
  NEEDED            Shared library: [libc.so.6]
  NEEDED            Shared library: [libXau.so.6]
  INIT              0x100077a4
  FINI              0x1001aa80
  HASH              0x10000144
  STRTAB            0x10003a90
  SYMTAB            0x10001930
  STRSZ             9498 (bytes)
  SYMENT            16 (bytes)
  DEBUG
  PLTGOT            0x1002e548
  PLTRELSZ          4896 (bytes)
  PLTREL            RELA
  JMPREL            0x10006484
  RELA              0x10006448
  RELASZ            4956 (bytes)
  RELAENT           12 (bytes)
  VERNEED           0x100063d8
  VERNEEDNUM        2
  VERSYM            0x10005faa
  NULL
  NULL
  NULL
  NULL
  NULL
  NULL

Version needs section [ 7] '.gnu.version_r' contains 2 entries:
 Addr: 0x100063d8  Offset: 0x0063d8  Link to section: [ 5] '.dynstr'
  000000: Version: 1  File: libpthread.so.0  Cnt: 1
  0x0010: Name: GLIBC_2.0  Flags: none  Version: 3
  0x0020: Version: 1  File: libc.so.6  Cnt: 4
  0x0030: Name: GLIBC_2.3  Flags: none  Version: 6
  0x0040: Name: GLIBC_2.2  Flags: none  Version: 5
  0x0050: Name: GLIBC_2.1  Flags: none  Version: 4
  0x0060: Name: GLIBC_2.0  Flags: none  Version: 2

Note segment of 32 bytes at offset 0x124:
  Owner          Data size  Type
  GNU                   16  VERSION
    OS: Linux, ABI: 2.4.1
