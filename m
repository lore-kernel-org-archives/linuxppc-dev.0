Date: Thu, 17 Feb 2000 12:05:51 -0600
Message-Id: <200002171805.MAA20716@kuttanna.somerset.sps.mot.com>
From: Edward Swarthout <swarthou@ibmoto.com>
To: sarrazip@machinasapiens.com.kev@primenet.com
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: message from Pierre Sarrazin on Wed, 16 Feb 2000 14:11:58 -0500
Subject: Re: Help w/ gdb - library stabs N_FUN relocation
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Feb 16,  2:11pm, Pierre Sarrazin wrote:
> (gdb) break 15
> Breakpoint 1 at 0x1800734: file prog.c, line 15.
> (gdb) run
> Starting program: /home/sarrazip/pgm/bug-gdb-dll/prog
>
> Breakpoint 1, main (argc=1, argv=0x7ffffbd4) at prog.c:15
> 15              (*function)();
> (gdb) step
> 0x161a61c in library_function () at libfoo.c:7
> 7       }
> (gdb) next
> This is library_function()
> --------------------------
> main (argc=1, argv=0x7ffffbd4) at prog.c:17
> 17              dlclose(handle);
> (gdb)

The problem is not the "step".
It is stopping at the correct address in library_function.
(if you do a "disassemble" after the step you see the correct function)

The problem is determining which line number in libfoo.c it is stopped at
It thinks it is at line 7, the end of the function, which causes
the "next" to exit the function and set the stop point back in main at
prog.c:17!

It looks like the N_FUN stabs entry for library_function is relative
to the N_SO stabs entry, not the beginning of the .so file.
This causes:
      (gdb) info line libfoo.c:5
      Line 5 of "libfoo.c" is at address 0x161a028 but contains no code.
to show line 5 as 0x5f8 too low.

gdb has a fix by setting (#define SOFUN_ADDRESS_MAYBE_MISSING) in
config/powerpc/tm-linux.h (which is also set in the linux x86 config).

But this does not fix it for objdump which uses bfd_find_nearest_line().
It has the same problem and causes it to put all the source after the
first function:

     objdump --stabs --source -d --line-numbers libfoo.so

     libfoo.so:     file format elf32-powerpc
     Contents of .stab section:
     Symnum n_type n_othr n_desc n_value  n_strx String
     -1     HdrSym 0      136    00000ec8 0
     0      SO     0      0      000005f8 9      /home/swarthou/prg/junk/
     1      SO     0      0      000005f8 0      libfoo.c
     ...
     129    FUN    0      4      00000000 3759   library_function:F(0,19)
     130    SLINE  0      4      00000000 942
     131    SLINE  0      5      00000028 942
     132    SLINE  0      6      00000034 942
     133    SLINE  0      7      00000040 942
     134    FUN    0      0      0000005c 942
     135    SO     0      0      00000658 942

     Disassembly of section .text:

     000004dc <__do_global_dtors_aux>:
     library_function():
     /home/swarthou/prg/junk/libfoo.c:7
     void library_function(void)
     {
	     printf("This is library_function()\n");
	     printf("--------------------------\n");
     }
      4dc:	94 21 ff e0 	stwu	r1,-32(r1)
      4e0:	7c 08 02 a6 	mflr	r0
      4e4:	93 a1 00 14 	stw	r29,20(r1)
     ...
     000005f8 <.Ltext0>:
      5f8:	00 04 81 dc
     000005fc <library_function>:
      5fc:	94 21 ff f0 	stwu	r1,-16(r1)
      600:	7c 08 02 a6 	mflr	r0
      604:	93 c1 00 08 	stw	r30,8(r1)
      608:	93 e1 00 0c 	stw	r31,12(r1)
      60c:	90 01 00 14 	stw	r0,20(r1)
      610:	7c 3f 0b 78 	mr	r31,r1
      614:	48 00 00 05 	bl	618 <library_function+0x1c>
      618:	7f c8 02 a6 	mflr	r30
      61c:	80 1e ff e0 	lwz	r0,-32(r30)
      620:	7f c0 f2 14 	add	r30,r0,r30
      624:	80 7e 80 00 	lwz	r3,-32768(r30)
     ...

Should this be fixed in binutils/bfd?

-Ed

Ed.Swarthout@Motorola.com
PowerPC Design Center
Motorola Austin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
