Message-ID: <391531CD.E9097B47@pop.agri.ch>
Date: Sun, 07 May 2000 11:05:18 +0200
From: Andreas Tobler <toa@pop.agri.ch>
Reply-To: toa@pop.agri.ch
MIME-Version: 1.0
To: ian reinhart geiser <geiseri@msoe.edu>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Problems Compileing PVM
References: <Pine.LNX.4.10.10005061706360.6831-100000@sleepchamber.apt5.msoe.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


ian reinhart geiser wrote:
>
> Greetings,
>         I have a problem with compileing PVMd
>         on my LinuxPPC 1999 dist.
>
>         When i try to build anything liked off of the
>         PVM libs i get the following errors:
>
>         ../../lib/LINUXPPC/libpvm3.a(lpvmpack.o): In function
> `pvm_vpackf': lpvmpack.o(.text+0x53e8): undefined reference to
> `__va_arg_type_violation'
>         lpvmpack.o(.text+0x53e8): relocation truncated
> to fit: R_PPC_REL24 __va_arg_type_violation
>         lpvmpack.o(.text+0x54f4):
> undefined reference to `__va_arg_type_violation'
>         lpvmpack.o(.text+0x54f4): relocation truncated to fit: R_PPC_REL24
> __va_arg_type_violation
>
>         It looks like a linker error...
>         i have never had this error before on any
>         of my other systems(ARM, ALPHA and INTEL).
>
>         has anyone seen this?  or am i looking in the
>         wrong list?

Have a look in the function pvm_vpackf. I suppose there is something
like this:

va_arg(xyz,int) and in your case I suppose the int isn't int, it's
something else?!

e.g. when you have this va_arg(xyz,char), this would give the error
described above. You can only get the function as wanted when you do
(char)va_arg(xyz,int).

For further details search the dev-list.

Andreas

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
