Date: Sat, 26 Feb 2000 20:20:56 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Brad Parker <brad@parker.boston.ma.us>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.3.47 imac build?
In-Reply-To: <200002261850.NAA09507@p2.parker.boston.ma.us>
Message-ID: <Pine.HPX.4.10.10002262011420.19933-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 26 Feb 2000, Brad Parker wrote:

>
>
> Anyone know how to cure the message:
>
> /usr/src/linux-2.3.47/include/linux/fs.h:769: warning: implicit declaration of function `abs'
>
> in the 2.3.47 build?
>
> abs is #defined in stdlib.h but I'm not sure that's used in the kernel builds.

Personnaly I have since long appended -Dabs=__builtin_abs to the compiler
flags parameter in arch/ppc/Makefile and removed it the ppc_ksyms.c and
the corresponding assembly code. There may be broken builtins in the
compiler (I did not try to remove the -fno-builtins) but the abs builtin
certainly works and is much better when inlined and scheduled by the
compiler. Calling a subroutine for such a simple function is ridiculous
and expensive especially from a module where you go through an indirect
jump in the procedure linkage table. Besides the compiler's implementation
is smarter and does not even require a conditional branch.

	Gabriel.



>
> (did I miss some patches?)
>
> -brad
>
>
>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
