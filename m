Date: Sun, 30 Apr 2000 16:56:59 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Rolf Liu <rolfl@sc23.sc.mcel.mot.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: more about  Who ever encounter such an so strange problem about
 compiling ?
In-Reply-To: <018201bfb26b$2409f3a0$bf0102c8@dell191.sc.mcel.mot.com>
Message-ID: <Pine.LNX.4.10.10004301650550.28269-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >_8xx -fsigned-char -msoft-float  -pipe -fno-builtin -ffixed-r2 -Wno-uniniti
> a
> >lize
> >d -mmultiple -mstring -D__ASSEMBLY__ -c romsys/start.S -o romsys/start.o
> >
> >../usr/include/asm/fads.h: Assembler messages:
> >../usr/include/asm/fads.h:14: Error: Unrecognized opcode: `typedef'
> >../usr/include/asm/fads.h:15: Error: Unrecognized opcode: `unsigned'
> >../usr/include/asm/fads.h:16: Error: Unrecognized opcode: `unsigned'
> >../usr/include/asm/fads.h:17: Error: Unrecognized opcode: `unsigned'
> >../usr/include/asm/fads.h:18: Error: Unrecognized opcode: `unsigned'
> >../usr/include/asm/fads.h:19: Error: Unrecognized opcode: `unsigned'
> >../usr/include/asm/fads.h:20: Error: Rest of line ignored. First ignored
> >charac.
> >../usr/include/asm/fads.h:22: Error: Unrecognized opcode: `extern'
>
> the problem seems the as is trying to process the C source code ,how this
> can be true?
> I think the gcc will first call the c compiler to translate the C source
> code into assembly
> code .
> how this can be true ?

The header file you include isn't usually included by assembly code, only
by C code. The C compiler will first preprocess, but including fads.h in
your assembly file results in feeding the typedef and extern stuff
straight to as. These declatations are C code, so as is right to complain.

Include the C code in #ifndef __ASSEMBLY__ ... #endif (that's how other
headers that happen to get included from both assembly and C code handle
it).

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
