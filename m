Message-ID: <3872D1EA.DF497905@ctam.com.au>
Date: Wed, 05 Jan 2000 16:08:59 +1100
From: Brendan J Simon <Brendan.Simon@ctam.com.au>
Reply-To: Brendan.Simon@ctam.com.au
MIME-Version: 1.0
To: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
CC: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Linux ABI documents and powerpc supplements.
References: <38727B8B.2FBD0B8@ctam.com.au> <00010501374800.22517@enzo.bigblue.local>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Franz Sirl wrote:

> 0x10000000 + SIZEOF_HEADERS is the current recommended base address for
> Linux/PPC. It was changed sometime ago from 0x1800000 to better support running
> the binaries on AIX. On Linux we use /lib/ld.so.1, Linux overrules the SYSV ABI
> here. The size of the libraries if you are talking about the standard Linux/PPC
> ones is due to a bug in 'strip' which tends to corrupt the libraries.
>
> The most current documentation I know of is in
> <ftp://sourceware.cygnus.com/pub/binutils/ppc-docs/>

Thanks.  I just downloaded the "System V Application Binary Interface PowerPC Processor
Supplement".  It is dated September 1995 and is authored by Steve Zucker (SunSoft) and Kari Karhi
(IBM).  Chapter 3 (page 3-24) says that "a program base of 0x02000000 (32 MB) is recommended for
reasons given in chapter 5".  I take it that the Linux/PPC supplement would state that a base of
0x10000000+SIZEOF_HEADERS is recommneded.  Is there such a beast as a Linux/PPC supplement ?

I am having problems getting simple shared executalbes to work on my embedded powerpc system
(MPC860).  I am using an egcs-1.1.2 cross compiler and have cross-compiled linux-2.2.5 kernel,
glibc-2.1 and some simple test applications.  I have an app that outputs a string every second
using puts().  If I compile with "powerpc-linux-gcc -m860 -static" it works, but if I compile
with "powerpc-linux-gcc -m860 -shared" it doesn't work.  I am mount root via nfs and the nfs
daemon is in debug mode.  I can see the libraries being accessed and read but the app just
segfaults.  Here is the "powerpc-linux-objdump -p" of the test apps and the libraries.  Do they
look OK ?
Would the segfault occur when loading the shared libraries into memory or when trying to execute
code from memory ?
Do I need -fPIC or does -shared impy this ?

Thanks,
Brendan Simon.


bjs1-static:     file format elf32-powerpc

Program Header:
    LOAD off    0x00000000 vaddr 0x01800000 paddr 0x01800000 align 2**16
         filesz 0x00038910 memsz 0x00038910 flags r-x
    LOAD off    0x00038910 vaddr 0x01878910 paddr 0x01878910 align 2**16
         filesz 0x000015ac memsz 0x00002034 flags rw-
    NOTE off    0x000000a0 vaddr 0x018000a0 paddr 0x018000a0 align 2**4
         filesz 0x00000020 memsz 0x00000020 flags r--


bjs1-shared:     file format elf32-powerpc

Program Header:
    LOAD off    0x00000000 vaddr 0x00000000 paddr 0x00000000 align 2**16
         filesz 0x0000066c memsz 0x0000066c flags r-x
    LOAD off    0x00000670 vaddr 0x00040670 paddr 0x00040670 align 2**16
         filesz 0x000000d8 memsz 0x0000015c flags rwx
 DYNAMIC off    0x00000678 vaddr 0x00040678 paddr 0x00040678 align 2**2
         filesz 0x000000a0 memsz 0x000000a0 flags rw-

Dynamic Section:
  NEEDED      libc.so.6
  INIT        0x610
  FINI        0x634
  HASH        0x94
  STRTAB      0x310
  SYMTAB      0x150
  STRSZ       0xad
  SYMENT      0x10
  PLTGOT      0x40748
  PLTRELSZ    0x3c
  PLTREL      0x7
  JMPREL      0x48c
  RELA        0x420
  RELASZ      0xa8
  RELAENT     0xc
  TEXTREL     0x0
  VERNEED     0x400
  VERNEEDNUM  0x1
  VERSYM      0x3c8

Version References:
  required from libc.so.6:
    0x0d696910 0x00 02 GLIBC_2.0


lib/libc.so.6:     file format elf32-powerpc

Program Header:
    PHDR off    0x00000034 vaddr 0x00000034 paddr 0x00000034 align 2**2
         filesz 0x000000c0 memsz 0x000000c0 flags r-x
  INTERP off    0x000e8760 vaddr 0x00128760 paddr 0x00128760 align 2**2
         filesz 0x00000010 memsz 0x00000010 flags rw-
    LOAD off    0x00000000 vaddr 0x00000000 paddr 0x00000000 align 2**16
         filesz 0x000d9f1c memsz 0x000d9f1c flags r-x
    LOAD off    0x000d9f20 vaddr 0x00119f20 paddr 0x00119f20 align 2**16
         filesz 0x00012fa0 memsz 0x00016a48 flags rwx
 DYNAMIC off    0x000e8a30 vaddr 0x00128a30 paddr 0x00128a30 align 2**2
         filesz 0x000000b0 memsz 0x000000b0 flags rw-

Dynamic Section:
  NEEDED      ld.so.1
  SONAME      libc.so.6
  INIT        0x21738
  FINI        0xd9eb0
  HASH        0xf4
  STRTAB      0x9728
  SYMTAB      0x2be8
  STRSZ       0x79ba
  SYMENT      0x10
  PLTGOT      0x12cec0
  PLTRELSZ    0x14d0
  PLTREL      0x7
  JMPREL      0x1ff50
  RELA        0x11eec
  RELASZ      0xf714
  RELAENT     0xc
  VERDEF      0x11e60
  VERDEFNUM   0x3
  VERNEED     0x11ebc
  VERNEEDNUM  0x1
  VERSYM      0x110f6

Version definitions:
1 0x01 0x0865f4e6 libc.so.6
2 0x00 0x0d696910 GLIBC_2.0
3 0x00 0x0d696911 GLIBC_2.1
    GLIBC_2.0

Version References:
  required from ld.so.1:
    0x0d696911 0x00 05 GLIBC_2.1
    0x0d696910 0x00 04 GLIBC_2.0


lib/ld.so.1:     file format elf32-powerpc

Program Header:
    LOAD off    0x00000000 vaddr 0x00000000 paddr 0x00000000 align 2**16
         filesz 0x00013fb8 memsz 0x00013fb8 flags r-x
    LOAD off    0x00013fc0 vaddr 0x00053fc0 paddr 0x00053fc0 align 2**16
         filesz 0x00002bc8 memsz 0x000032c0 flags rwx
 DYNAMIC off    0x00016378 vaddr 0x00056378 paddr 0x00056378 align 2**2
         filesz 0x00000088 memsz 0x00000088 flags rw-

Dynamic Section:
  SONAME      ld.so.1
  HASH        0x94
  STRTAB      0xf28
  SYMTAB      0x528
  STRSZ       0xcc4
  SYMENT      0x10
  PLTGOT      0x56c2c
  PLTRELSZ    0x330
  PLTREL      0x7
  JMPREL      0x3170
  RELA        0x1d9c
  RELASZ      0x1704
  RELAENT     0xc
  VERDEF      0x1d40
  VERDEFNUM   0x3
  VERSYM      0x1c00

Version definitions:
1 0x01 0x0275a261 ld.so.1
2 0x00 0x0d696910 GLIBC_2.0
3 0x00 0x0d696911 GLIBC_2.1
    GLIBC_2.0


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
