Message-Id: <200003302040.PAA69395@p2.parker.boston.ma.us>
To: binutils@sourceware.cygnus.com, linuxppc-dev@lists.linuxppc.org
cc: dan@netx4.com, maxwell@parc.xerox.com, patrik@ucolick.org
Subject: gprof on powerpc fails if compiled with older gcc
Date: Thu, 30 Mar 2000 15:40:19 -0500
From: Brad Parker <brad@parker.boston.ma.us>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi

this is pretty scarey (for me) but perhaps someone who knows more about
gcc knows why...  I assume it's a known bug.

I could not get gprof to work on powerpc linux.  It would crash somewhere
in malloc.  Turns out the real crash is caused by a bug in gcc which
messes up a structure copy if the lvalue is a post incremented pointer...

(this must not be something people do much)

Hopefully this helps the other people who were trying to get gprof to
work on powerpc.  Just recompile binutils with gcc 2.95.2...

-brad

bad compiler:
gcc version egcs-2.91.66 19990314 (egcs-1.1.2 release)

working compile:
gcc version 2.95.2 19991024 (release)

code fragment: (gprof/symtab.c, line 126)

...
      else
	{
	  if (dst > tab->base && dst[-1].end_addr == 0)
	    {
	      dst[-1].end_addr = src->addr - 1;
	    }

	  /* retain sym only if it has a non-empty address range: */

	  if (!src->end_addr || src->addr <= src->end_addr)
	    {
#if 1
	      *dst++ = *src;   <-- works only in later gcc
#else
	      *dst = *src;     <-- works for both
	      dst++;
#endif
	      prev_addr = src->addr;
	    }
	}
    }
...


bad asm fragment:
.stabn 68,0,137,.LM43-symtab_finalize
.LM43:
	addi 9,31,16
	lwz 11,0(9)
	lwz 0,12(31)
	addi 11,11,216
	stw 11,0(9)
	mr 3,11			<-- woa.  this is after the ++
	mr 4,0
	li 5,216
	crxor 6,6,6
	bl memcpy
	mr 0,3
.stabn 68,0,142,.LM44-symtab_finalize


good asm fragment:
.stabn 68,0,137,.LM43-symtab_finalize
.LM43:
	addi 9,31,16
	lwz 11,0(9)
	lwz 10,12(31)
	mr 0,11			<-- save old ptr in r0
	li 8,216
	addi 11,11,216
	stw 11,0(9)
	mr 3,0			<-- use old ptr
	mr 4,10
	mr 5,8
	bl memcpy
	mr 0,3

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
