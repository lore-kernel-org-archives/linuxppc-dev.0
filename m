Message-ID: <3DA6ABFF.FF441B87@imc-berlin.de>
Date: Fri, 11 Oct 2002 12:46:23 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: Hollis Blanchard <hollis@austin.ibm.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: cross-compiler and stdarg.h
References: <Pine.LNX.4.44.0210101627210.9384-100000@sandstone.austin.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hollis Blanchard wrote:
>
> On Thu, 10 Oct 2002, D'Abbraccio Joe-ljd015 wrote:
> >
> > When I build the kernel using the ELDK I get the following failure:
> > >>>>>
> > ppc_82xx-gcc -D__KERNEL__ -I/usr/opt/kernels/linuxppc_2_4_devel/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I/usr/opt/kernels/linuxppc_2_4_devel/arch/ppc -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring   -nostdinc -iwithprefix include -DKBUILD_BASENAME=sched  -fno-omit-frame-pointer -c -o sched.o sched.c
> > In file included from /usr/opt/kernels/linuxppc_2_4_devel/include/linux/wait.h:13,
> >                  from /usr/opt/kernels/linuxppc_2_4_devel/include/linux/fs.h:12,
> >                  from /usr/opt/kernels/linuxppc_2_4_devel/include/linux/capability.h:17,
> >                  from /usr/opt/kernels/linuxppc_2_4_devel/include/linux/binfmts.h:5,
> >                  from /usr/opt/kernels/linuxppc_2_4_devel/include/linux/sched.h:9,
> >                  from /usr/opt/kernels/linuxppc_2_4_devel/include/linux/mm.h:4,
> >                  from sched.c:23:
> > /usr/opt/kernels/linuxppc_2_4_devel/include/linux/kernel.h:10: stdarg.h: No such file or directory
> > <<<<<
> >
> > Where is stdarg.h expected to come from if not from stdinc (i.e.
> > -nostdinc).  I don't believe there is one in kernel distribution.
>
> I just had this problem and I'm embarassed to say I'm not quite sure
> what caused it. I was building on a ppc64 box, but when I switched from
> the ppc32 "cross-compiler" to the native toolchain (which is ppc32) the
> problem went away.
>
> Your cross-compiler includes this file in
> <prefix>/lib/gcc-lib/powerpc-linux/<version>/include/ .
>
> -Hollis

I had this problem too. A while ago. On 2002/09/13 I posted to this list but
with no success.

I found the problem in the main Makefile:

---------------
@@ -261,7 +262,7 @@
 # 'kbuild_2_4_nostdinc :=' or -I/usr/include for kernel code and you are not
UML
 # then your code is broken!  KAO.

-kbuild_2_4_nostdinc    := -nostdinc -iwithprefix include
+kbuild_2_4_nostdinc    := -nostdinc $(shell $(CC) -print-search-dirs | sed -ne
's/install: \(.*\)/-I \1include/gp')
 export kbuild_2_4_nostdinc

 export CPPFLAGS CFLAGS CFLAGS_KERNEL AFLAGS AFLAGS_KERNEL
---------------

I have no idea why... :o(

Cheers,

Steven

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
