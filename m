Message-ID: <3872ECED.6E46EBF6@ctam.com.au>
Date: Wed, 05 Jan 2000 18:04:14 +1100
From: Brendan J Simon <Brendan.Simon@ctam.com.au>
Reply-To: Brendan.Simon@ctam.com.au
MIME-Version: 1.0
CC: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: dynamic binaries not working.
References: <38727B8B.2FBD0B8@ctam.com.au> <00010501374800.22517@enzo.bigblue.local> <3872D1EA.DF497905@ctam.com.au> <3872E8B5.F088FE57@fadata.bg>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Momchil 'Velco' Velikov wrote:

> Brendan J Simon wrote:
> > I am having problems getting simple shared executalbes to work on my embedded powerpc system
> > (MPC860).  I am using an egcs-1.1.2 cross compiler and have cross-compiled linux-2.2.5 kernel,
> > glibc-2.1 and some simple test applications.  I have an app that outputs a string every second
> > using puts().  If I compile with "powerpc-linux-gcc -m860 -static" it works, but if I compile
> > with "powerpc-linux-gcc -m860 -shared" it doesn't work.  I am mount root via nfs and the nfs
>
> -shared is used to *create* a shared library. You need -Bdynamic in
> order to force the executable to be linked against shared libraries.

I removed the -shared argument and the executable now looks a lot better interms of the vaddr and
program headers etc.  I used "powerpc-linux-gcc -Wall -mcpu=860 -fpic -o bjs1 bjs1.c".  I tried
with -fPIC, -fpic and without either.  The program still does not run however.  The output of
objdump -p  is below.
Does this look OK ?
Any suggestions for debugging the code or the shared libraries ?

Thanks,
Brendan Simon.



# powerpc-linux-objdump -p bjs1

bjs1:     file format elf32-powerpc

Program Header:
    PHDR off    0x00000034 vaddr 0x01800034 paddr 0x01800034 align 2**2
         filesz 0x000000e0 memsz 0x000000e0 flags r-x
  INTERP off    0x00000114 vaddr 0x01800114 paddr 0x01800114 align 2**0
         filesz 0x0000000d memsz 0x0000000d flags r--
    LOAD off    0x00000000 vaddr 0x01800000 paddr 0x01800000 align 2**16
         filesz 0x000004e4 memsz 0x000004e4 flags r-x
    LOAD off    0x000004e8 vaddr 0x018404e8 paddr 0x018404e8 align 2**16
         filesz 0x000000e4 memsz 0x00000168 flags rwx
 DYNAMIC off    0x00000508 vaddr 0x01840508 paddr 0x01840508 align 2**2
         filesz 0x000000a0 memsz 0x000000a0 flags rw-
    NOTE off    0x00000130 vaddr 0x01800130 paddr 0x01800130 align 2**4
         filesz 0x00000020 memsz 0x00000020 flags r--

Dynamic Section:
  NEEDED      libc.so.6
  INIT        0x180048c
  FINI        0x18004b0
  HASH        0x1800150
  STRTAB      0x1800204
  SYMTAB      0x1800184
  STRSZ       0x74
  SYMENT      0x10
  DEBUG       0x0
  PLTGOT      0x18405cc
  PLTRELSZ    0x3c
  PLTREL      0x7
  JMPREL      0x18002b4
  RELA        0x18002b4
  RELASZ      0x3c
  RELAENT     0xc
  VERNEED     0x1800294
  VERNEEDNUM  0x1
  VERSYM      0x1800282

Version References:
  required from libc.so.6:
    0x0d696910 0x00 02 GLIBC_2.0


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
