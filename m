Date: Thu, 10 Oct 2002 16:33:38 -0500 (CDT)
From: Hollis Blanchard <hollis@austin.ibm.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: cross-compiler and stdarg.h
In-Reply-To: <6D4DC8B4AD16D6118E8200D0B76FE262023191B9@ONT06EXM01>
Message-ID: <Pine.LNX.4.44.0210101627210.9384-100000@sandstone.austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 10 Oct 2002, D'Abbraccio Joe-ljd015 wrote:
>
> When I build the kernel using the ELDK I get the following failure:
> >>>>>
> ppc_82xx-gcc -D__KERNEL__ -I/usr/opt/kernels/linuxppc_2_4_devel/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I/usr/opt/kernels/linuxppc_2_4_devel/arch/ppc -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring   -nostdinc -iwithprefix include -DKBUILD_BASENAME=sched  -fno-omit-frame-pointer -c -o sched.o sched.c
> In file included from /usr/opt/kernels/linuxppc_2_4_devel/include/linux/wait.h:13,
>                  from /usr/opt/kernels/linuxppc_2_4_devel/include/linux/fs.h:12,
>                  from /usr/opt/kernels/linuxppc_2_4_devel/include/linux/capability.h:17,
>                  from /usr/opt/kernels/linuxppc_2_4_devel/include/linux/binfmts.h:5,
>                  from /usr/opt/kernels/linuxppc_2_4_devel/include/linux/sched.h:9,
>                  from /usr/opt/kernels/linuxppc_2_4_devel/include/linux/mm.h:4,
>                  from sched.c:23:
> /usr/opt/kernels/linuxppc_2_4_devel/include/linux/kernel.h:10: stdarg.h: No such file or directory
> <<<<<
>
> Where is stdarg.h expected to come from if not from stdinc (i.e.
> -nostdinc).  I don't believe there is one in kernel distribution.

I just had this problem and I'm embarassed to say I'm not quite sure
what caused it. I was building on a ppc64 box, but when I switched from
the ppc32 "cross-compiler" to the native toolchain (which is ppc32) the
problem went away.

Your cross-compiler includes this file in
<prefix>/lib/gcc-lib/powerpc-linux/<version>/include/ .

-Hollis


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
