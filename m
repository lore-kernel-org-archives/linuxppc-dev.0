Message-ID: <388325CC.20EC244@eng.uct.ac.za>
Date: Mon, 17 Jan 2000 16:23:08 +0200
From: Grant Carter <gcarter@eng.uct.ac.za>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Dynamic Linking
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

I have been following the thread "Cross-compile Applications for 860 on
x86" and am running into similar problems. I have tried the solutions
that have been suggested but have had no success. Perhaps those
concerned have had private email conversations in which the solution has
been found, but since I cannot find one in the archives that helps me,
I'll post this question. Apologies for its length.

I am trying to get a hello world up and running using dynamically linked
libraries. The statically linked version works fine, so I presume that
the libraries are all fine. I am using linux-2.2.13 with no kernel
floating point support, but all the libraries and executables are
compiled with -msoft-float. I am using SASH-2.1 and it works fine. My
problem is that whenever I run something that I have compiled with the
dynamic linker, it exits on Signal 11.

I have made sure that LD_LIBRARY_PATH is set to /lib (it seems that I
had to do this even though all my libraries are in /lib as without it I
get a 

./hello: error in loading shared libraries: libc.so.6: cannot open
shared object file: No such file or directory

Doing a "strings" on the file shows that it is looking in /lib for
ld.so.1.)

---------------------------------
>powerpc-linux-strings hello
/lib/ld.so.1
__gmon_start__
libc.so.6
printf
_IO_stdin_used
__libc_start_main
GLIBC_2.0
}a[xN
Grant was here!
-----------------------------------

Anyhow, once the LD_LIBRARY_PATH has been set, the libraries are loaded
(or so it seems) Now everything that I run exits with Signal 11. I used
objdump -p on the main executable and saw that it required libc.so.6.
This exists in my /lib directory
-----------------------------------
>powerpc-linux-objdump -p hello

hello:     file format elf32-powerpc

<snip>

Dynamic Section:
  NEEDED      libc.so.6
  INIT        0x100003c8
  FINI        0x100003ec
  HASH        0x10000150
  STRTAB      0x100001c8
  SYMTAB      0x10000178
  STRSZ       0x42
  SYMENT      0x10
  DEBUG       0x0
  PLTGOT      0x100104f8
  PLTRELSZ    0x18
  PLTREL      0x7
  JMPREL      0x10000240
  RELA        0x10000240
  RELASZ      0x18
  RELAENT     0xc
  VERNEED     0x10000220
  VERNEEDNUM  0x1
  VERSYM      0x10000214

Version References:
  required from libc.so.6:
    0x0d696910 0x00 02 GLIBC_2.0
-----------------------------------

Doing the same thing on libc.so.6, I get the following:

-----------------------------------
>powerpc-linux-objdump -p libc.so.6 

libc.so.6:     file format elf32-powerpc

Program Header:
<snip> 

Dynamic Section:
  NEEDED      ld.so.1
  SONAME      libc.so.6
  INIT        0x21cb8
  FINI        0xe0fc8
  HASH        0xf4
  STRTAB      0x9d0c
  SYMTAB      0x2cdc
  STRSZ       0x7ca2
  SYMENT      0x10
  PLTGOT      0x103a9c
  PLTRELSZ    0x150c
  PLTREL      0x7
  JMPREL      0x204d8
  RELA        0x128c4
  RELASZ      0xf2dc
  RELAENT     0xc
  VERDEF      0x127e0
  VERDEFNUM   0x5
  VERNEED     0x12884
  VERNEEDNUM  0x1
  VERSYM      0x119da

Version definitions:
1 0x01 0x0865f4e6 libc.so.6
2 0x00 0x0d696910 GLIBC_2.0
3 0x00 0x0d696911 GLIBC_2.1
        GLIBC_2.0 
4 0x00 0x09691f71 GLIBC_2.1.1
        GLIBC_2.1 
5 0x00 0x09691f72 GLIBC_2.1.2
        GLIBC_2.1.1 

Version References:
  required from ld.so.1:
    0x09691f71 0x00 08 GLIBC_2.1.1
    0x0d696911 0x00 07 GLIBC_2.1
    0x0d696910 0x00 06 GLIBC_2.0
-----------------------------------

And now for ld.so.1

-----------------------------------
>powerpc-linux-objdump -p ld.so.1   

ld.so.1:     file format elf32-powerpc

Program Header:
<snip> 
Dynamic Section:
  SONAME      ld.so.1
  HASH        0x94
  STRTAB      0x838
  SYMTAB      0x2f8
  STRSZ       0xcfc
  SYMENT      0x10
  PLTGOT      0x25fd4
  PLTRELSZ    0x12c
  PLTREL      0x7
  JMPREL      0x2ab0
  RELA        0x167c
  RELASZ      0x1560
  RELAENT     0xc
  VERDEF      0x15fc
  VERDEFNUM   0x4
  VERSYM      0x1554

Version definitions:
1 0x01 0x0275a261 ld.so.1
2 0x00 0x0d696910 GLIBC_2.0
3 0x00 0x0d696911 GLIBC_2.1
        GLIBC_2.0 
4 0x00 0x09691f71 GLIBC_2.1.1
        GLIBC_2.1
-----------------------------------

So in summary, it seems that I have all of the required libraries
(ld.so.1 and libc.so.6) in the right place (/lib) as pointed to my
LD_LIBRARY_PATH and still I get a Signal 11 exit when trying to run it. 

Any ideas would be greatly appreciated.

Regards
Grant

-- 
Grant Carter                              gcarter@eng.uct.ac.za
Department of Electrical Engineering      University of Cape Town
Tel: +27 (0)21 650-3467                   Fax: +27 (0)21 650-3465
                     "Coffee not found - operator halted!"

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
