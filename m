Subject: Re: Problem cross-compiling for MPC860T on x86 host
From: "Matthew S. McClintock" <mattsm@arlut.utexas.edu>
To: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20031020110913.30a1ac6d.damm@opensource.se>
References: <5.2.0.9.0.20031020095633.0271dec0@172.16.15.10>
	 <20031020110913.30a1ac6d.damm@opensource.se>
Content-Type: text/plain
Message-Id: <1066750425.28407.9.camel@chuck.arlut.utexas.edu>
Mime-Version: 1.0
Date: Tue, 21 Oct 2003 10:33:46 -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I saw these warnings when I tried to use a compiler that was too new to
compile to kernel. For the that was gcc 3.3.1 compiling linux 2.4.19.
You may be seeing the same problem.

Matthew

On Mon, 2003-10-20 at 04:09, Magnus Damm wrote:
> Unless you've done some wierdo chroot-build, "-I/usr/src/linux/include"
> probably points to include files for your build/host machine. You want
> the includes for your cross target. The error you see is probably
> because the ppc-compiler does not know how to compile x86 assembly.
>
> / magnus
>
> On Mon, 20 Oct 2003 10:01:12 -0700
> "L. Puneeth Rao" <puneeth_l@roc.co.in> wrote:
>
> >
> > Greetings All,
> >          I have a MPC860T evaluation board, and i would like to load
> > linux2.4 kernel. For this i have used a x86 system as host machine and
> > followed the procedure prescribed in
> > http://penguinppc.org/embedded/cross-compiling/. i have obtained 2.4.18
> > kernel sources and applied the suggested patch ppc-patch-2.4.18 and
> > additional tools used are gcc-core-3.3.1 and binutils-2.11.90.0.8.  Upon
> > executing make zImage i found the following errors. it is only one type of
> > error repeated over and over.
> >          kindly suggest some way out. TIA
> > with regards,
> > Puneeth
> >
> >   make zImage
> > powerpc-linux-gcc -D__KERNEL__ -I/usr/src/linux/include -Wall
> > -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
> > -fno-strict-aliasing -fno-common -D__powerpc__ -fsigned-char -msoft-float
> > -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring
> > -mcpu=860   -DKBUILD_BASENAME=main -c -o init/main.o init/main.c
> > /usr/src/linux/include/asm/unistd.h: In function `do_linuxrc':
> > /usr/src/linux/include/asm/unistd.h:413: error: asm-specifier for variable
> > `__sc_4' conflicts with asm clobber list
> > /usr/src/linux/include/asm/unistd.h:413: error: asm-specifier for variable
> > `__sc_5' conflicts with asm clobber list
> > /usr/src/linux/include/asm/unistd.h:412: error: asm-specifier for variable
> > `__sc_4' conflicts with asm clobber list
> > /usr/src/linux/include/asm/unistd.h:412: error: asm-specifier for variable
> > `__sc_5' conflicts with asm clobber list
> > /usr/src/linux/include/asm/unistd.h: In function `prepare_namespace':
> > /usr/src/linux/include/asm/unistd.h:416: error: asm-specifier for variable
> > `__sc_4' conflicts with asm clobber list
> > /usr/src/linux/include/asm/unistd.h:416: error: asm-specifier for variable
> > `__sc_5' conflicts with asm clobber list
> > /usr/src/linux/include/asm/unistd.h: In function `init':
> > /usr/src/linux/include/asm/unistd.h:413: error: asm-specifier for variable
> > `__sc_4' conflicts with asm clobber list
> > /usr/src/linux/include/asm/unistd.h:413: error: asm-specifier for variable
> > `__sc_5' conflicts with asm clobber list
> > /usr/src/linux/include/asm/unistd.h:412: error: asm-specifier for variable
> > `__sc_4' conflicts with asm clobber list
> > /usr/src/linux/include/asm/unistd.h:412: error: asm-specifier for variable
> > `__sc_5' conflicts with asm clobber list
> > /usr/src/linux/include/asm/unistd.h:412: error: asm-specifier for variable
> > `__sc_4' conflicts with asm clobber list
> > /usr/src/linux/include/asm/unistd.h:412: error: asm-specifier for variable
> > `__sc_5' conflicts with asm clobber list
> > /usr/src/linux/include/asm/unistd.h:412: error: asm-specifier for variable
> > `__sc_4' conflicts with asm clobber list
> > /usr/src/linux/include/asm/unistd.h:412: error: asm-specifier for variable
> > `__sc_5' conflicts with asm clobber list
> > /usr/src/linux/include/asm/unistd.h:412: error: asm-specifier for variable
> > `__sc_4' conflicts with asm clobber list
> > /usr/src/linux/include/asm/unistd.h:412: error: asm-specifier for variable
> > `__sc_5' conflicts with asm clobber list
> > /usr/src/linux/include/asm/unistd.h:412: error: asm-specifier for variable
> > `__sc_4' conflicts with asm clobber list
> > /usr/src/linux/include/asm/unistd.h:412: error: asm-specifier for variable
> > `__sc_5' conflicts with asm clobber list
> > /usr/src/linux/include/asm/unistd.h: In function `write':
> > /usr/src/linux/include/asm/unistd.h:408: error: asm-specifier for variable
> > `__sc_4' conflicts with asm clobber list
> > /usr/src/linux/include/asm/unistd.h:408: error: asm-specifier for variable
> > `__sc_5' conflicts with asm clobber list
> > /usr/src/linux/include/asm/unistd.h: In function `read':
> > /usr/src/linux/include/asm/unistd.h:409: error: asm-specifier for variable
> > `__sc_4' conflicts with asm clobber list
> > /usr/src/linux/include/asm/unistd.h:409: error: asm-specifier for variable
> > `__sc_5' conflicts with asm clobber list
> > /usr/src/linux/include/asm/unistd.h: In function `lseek':
> > /usr/src/linux/include/asm/unistd.h:410: error: asm-specifier for variable
> > `__sc_4' conflicts with asm clobber list
> > /usr/src/linux/include/asm/unistd.h:410: error: asm-specifier for variable
> > `__sc_5' conflicts with asm clobber list
> > /usr/src/linux/include/asm/unistd.h: In function `execve':
> > /usr/src/linux/include/asm/unistd.h:412: error: asm-specifier for variable
> > `__sc_4' conflicts with asm clobber list
> > /usr/src/linux/include/asm/unistd.h:412: error: asm-specifier for variable
> > `__sc_5' conflicts with asm clobber list
> > /usr/src/linux/include/asm/unistd.h: In function `open':
> > /usr/src/linux/include/asm/unistd.h:413: error: asm-specifier for variable
> > `__sc_4' conflicts with asm clobber list
> > /usr/src/linux/include/asm/unistd.h:413: error: asm-specifier for variable
> > `__sc_5' conflicts with asm clobber list
> > /usr/src/linux/include/asm/unistd.h: In function `waitpid':
> > /usr/src/linux/include/asm/unistd.h:416: error: asm-specifier for variable
> > `__sc_4' conflicts with asm clobber list
> > /usr/src/linux/include/asm/unistd.h:416: error: asm-specifier for variable
> > `__sc_5' conflicts with asm clobber list
> > /usr/src/linux/include/asm/unistd.h:416: confused by earlier errors,
> > bailing out
> > make: *** [init/main.o] Error 1
> >
> >
> >
>
--
Matthew S. McClintock <mattsm@arlut.utexas.edu>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
