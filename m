Message-ID: <387094AD.8F3145F2@freenet.hut.fi>
Date: Mon, 03 Jan 2000 14:23:09 +0200
From: Kai Ruottu <karuottu@freenet.hut.fi>
Reply-To: karuottu@freenet.hut.fi
MIME-Version: 1.0
To: Brendan.Simon@ctam.com.au
CC: linux-embedded <linux-embedded@waste.org>,
        Cross-GCC <crossgcc@sourceware.cygnus.com>,
        linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: cross-compiling & debugging embedded-linux apps
References: <386C3615.E14AE6DD@ctam.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Brendan J Simon wrote:
> 
> I have a powerpc embedded system (MPC860, 4MB Flash, 16MB RAM, ethernet,
> rs232).  I have compiled the kernel and can boot it using a root
> filesystem via initrd or nfs.  The root filesystem is a minimal one that
> was on the linuxppc-embedded ftp site.  It basically has /bin/sh,
> /bin/ls and a few libraries in /lib.
> 
> I NEED to be able to compile apps from the sources.  I have managed to
> cross-compile ncurses and bash.  I can't get bash to run at all (even a
> statically compiled version).  I get segmentaion faults.  I'm currently
> using SASH which I have cross-compiled as a static binary.  I compiled a
> test app (bjs1.c) which outputs a string every second.  It is compiled
> as a static binary (bjs1-static) and a shared binary (bjs1-shared).  The
> static binary works but the shared one does not.  I assume it is some
> library problem but I can't figure out what.  The output of the sash
> session is below.
> 
> Stand-alone shell (version 1.0)
> > ./bjs1-static
> BJS1: Brendan was here
> BJS1: Brendan was here
> BJS1: Brendan was here
> pid 7: killed (signal 2)
> >
> > ./bjs1-shared
> pid 8: killed (signal 11)

 Some simple sanity checks for shared executables, before downloading them
into the target, follows...

1. Using 'strings' to see the 'hard-wired' name of the dynamic linker in
   the executable:

	E:\usr\local\samples>strings tst_ppc-linux.x | more
	/lib/ld.so.1	<------- !!!
	__gmon_start__
	libc.so.6
	strcpy
	printf
	stdout

2. Using 'objdump -p' to see the needed shared libs, version dependencies
   etc. :
-------------------- clip ---------------------
E:\usr\local\samples>objdump -p tst_ppc-linux.x

tst_ppc-linux-2.x:     file format elf32-powerpc

Program Header:
    PHDR off    0x0000000000000034 vaddr 0x0000000010000034 paddr 0x000000001000
0034 align 2**2
         filesz 0x00000000000000e0 memsz 0x00000000000000e0 flags r-x
  INTERP off    0x0000000000000114 vaddr 0x0000000010000114 paddr 0x000000001000
0114 align 2**0
         filesz 0x000000000000000d memsz 0x000000000000000d flags r--
    LOAD off    0x0000000000000000 vaddr 0x0000000010000000 paddr 0x000000001000
0000 align 2**16
         filesz 0x0000000000001860 memsz 0x0000000000001860 flags r-x
    LOAD off    0x0000000000001860 vaddr 0x0000000010011860 paddr 0x000000001001
1860 align 2**16
         filesz 0x000000000000012c memsz 0x00000000000001f0 flags rwx
 DYNAMIC off    0x00000000000018bc vaddr 0x00000000100118bc paddr 0x000000001001
18bc align 2**2
         filesz 0x00000000000000a8 memsz 0x00000000000000a8 flags rw-
    NOTE off    0x0000000000000130 vaddr 0x0000000010000130 paddr 0x000000001000
0130 align 2**4
         filesz 0x0000000000000020 memsz 0x0000000000000020 flags r--

Dynamic Section:
  NEEDED      libc.so.6
  NEEDED      ld.so.1
  INIT        0x100011f0
  FINI        0x10001214
  HASH        0x10000150
  STRTAB      0x1000027c
  SYMTAB      0x1000019c
  STRSZ       0xa4
  SYMENT      0x10
  DEBUG       0x0
  PLTGOT      0x10011990
  PLTRELSZ    0x78
  PLTREL      0x7
  JMPREL      0x10000368
  RELA        0x10000368
  RELASZ      0x84
  RELAENT     0xc
  VERNEED     0x10000348
  VERNEEDNUM  0x1
  VERSYM      0x1000032a

Version References:
  required from libc.so.6:
    0x0d696910 0x00 02 GLIBC_2.0

-------------------- clip ---------------------

 The previous executable probably searches the shared libs (libc.so.6 here) from the
default places, '/lib' and '/usr/lib' and the dynamic linker from the 'hard-wired'
place, given by '--dynamic-linker /lib/ld.so.1' in the GCC specs (LINK_SPEC).

 Using the '-rpath' one can add more directories to the run-time shared libs search
path, 'RPATH'.

  -rpath PATH                 Set runtime shared library search path
  -rpath-link PATH            Set link time shared library search path

 The '-rpath-link' (where to find the libs at link time) shouldn't be mixed with the
'-rpath' (where to find the libs at run time).

 Adding a '-Wl,-rpath,<something>' to the GCC compile&link command, the 'RPATH' row
will be added to the header of the previous executable :

-------------------- clip ---------------------
E:\usr\local\samples>gcc-ppc-linux -Wl,-rpath,/usr/mylib:/usr/yourlib -O -o tst_
ppc-linux-3.x tprintf.c

E:\usr\local\samples>objdump -p tst_ppc-linux-3.x

tst_ppc-linux-3.x:     file format elf32-powerpc

Program Header:
 <snip>

Dynamic Section:
  NEEDED      libc.so.6
  NEEDED      ld.so.1
  RPATH       /usr/mylib:/usr/yourlib
  INIT        0x10001208
  FINI        0x1000122c
 <snip>
-------------------- clip ---------------------

 Then the executable will search the shared libs also at '/usr/mylib' and
at '/usr/yourlib'...

> How does the kernel know where to look for libraries ?  I assume there
> are some default locations like /lib.  I haven't got an ld.so.conf setup
> nor do I have ldconfig.

 The previous simple tests, made in the cross-host, may help to reveal if
there is some basic fault or misunderstanding, e.g. the hard-wired dynamic-linker
name is now wrong in the executable.

 The 'ld.so.1' etc. components and their sanity can also be looked with the
'objdump -p' :

-------------------- clip ---------------------
E:\usr\local\ppc-linux-gnu\lib>objdump -p ld.so.1

ld.so.1:     file format elf32-powerpc

 <snip>

Dynamic Section:
  SONAME      ld.so.1
  HASH        0x94
  STRTAB      0x6e4
  SYMTAB      0x2b4
  STRSZ       0xcfa
  SYMENT      0x10
  PLTGOT      0x5661c
  PLTRELSZ    0x12c
  PLTREL      0x7
  JMPREL      0x292c
  RELA        0x1504
  RELASZ      0x1554
  RELAENT     0xc
  VERDEF      0x1484
  VERDEFNUM   0x4
  VERSYM      0x13fe

Version definitions:
1 0x01 0x0275a261 ld.so.1
2 0x00 0x0d696910 GLIBC_2.0
3 0x00 0x0d696911 GLIBC_2.1
        GLIBC_2.0
4 0x00 0x09691f71 GLIBC_2.1.1
        GLIBC_2.1

-------------------- clip ---------------------

 Don't ask me to interpret those version definitions, but I can guess that
if the one in the executable isn't listed in the 'ld.so.1', this means bad
troubles...

> It can't be that hard to get a simple 10 line program to execute as a
> shared binary.  It must be something really simple that I am missing.

 Perhaps the new 'readelf' utility in binutils can be used for sanity checks
of the same kind...

Cheers, Kai

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
