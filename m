Date: Mon, 20 Oct 2003 11:09:13 +0200
From: Magnus Damm <damm@opensource.se>
To: "L. Puneeth Rao" <puneeth_l@roc.co.in>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Problem cross-compiling for MPC860T on x86 host
Message-Id: <20031020110913.30a1ac6d.damm@opensource.se>
In-Reply-To: <5.2.0.9.0.20031020095633.0271dec0@172.16.15.10>
References: <5.2.0.9.0.20031020095633.0271dec0@172.16.15.10>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Unless you've done some wierdo chroot-build, "-I/usr/src/linux/include"
probably points to include files for your build/host machine. You want
the includes for your cross target. The error you see is probably
because the ppc-compiler does not know how to compile x86 assembly.

/ magnus

On Mon, 20 Oct 2003 10:01:12 -0700
"L. Puneeth Rao" <puneeth_l@roc.co.in> wrote:

>
> Greetings All,
>          I have a MPC860T evaluation board, and i would like to load
> linux2.4 kernel. For this i have used a x86 system as host machine and
> followed the procedure prescribed in
> http://penguinppc.org/embedded/cross-compiling/. i have obtained 2.4.18
> kernel sources and applied the suggested patch ppc-patch-2.4.18 and
> additional tools used are gcc-core-3.3.1 and binutils-2.11.90.0.8.  Upon
> executing make zImage i found the following errors. it is only one type of
> error repeated over and over.
>          kindly suggest some way out. TIA
> with regards,
> Puneeth
>
>   make zImage
> powerpc-linux-gcc -D__KERNEL__ -I/usr/src/linux/include -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
> -fno-strict-aliasing -fno-common -D__powerpc__ -fsigned-char -msoft-float
> -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring
> -mcpu=860   -DKBUILD_BASENAME=main -c -o init/main.o init/main.c
> /usr/src/linux/include/asm/unistd.h: In function `do_linuxrc':
> /usr/src/linux/include/asm/unistd.h:413: error: asm-specifier for variable
> `__sc_4' conflicts with asm clobber list
> /usr/src/linux/include/asm/unistd.h:413: error: asm-specifier for variable
> `__sc_5' conflicts with asm clobber list
> /usr/src/linux/include/asm/unistd.h:412: error: asm-specifier for variable
> `__sc_4' conflicts with asm clobber list
> /usr/src/linux/include/asm/unistd.h:412: error: asm-specifier for variable
> `__sc_5' conflicts with asm clobber list
> /usr/src/linux/include/asm/unistd.h: In function `prepare_namespace':
> /usr/src/linux/include/asm/unistd.h:416: error: asm-specifier for variable
> `__sc_4' conflicts with asm clobber list
> /usr/src/linux/include/asm/unistd.h:416: error: asm-specifier for variable
> `__sc_5' conflicts with asm clobber list
> /usr/src/linux/include/asm/unistd.h: In function `init':
> /usr/src/linux/include/asm/unistd.h:413: error: asm-specifier for variable
> `__sc_4' conflicts with asm clobber list
> /usr/src/linux/include/asm/unistd.h:413: error: asm-specifier for variable
> `__sc_5' conflicts with asm clobber list
> /usr/src/linux/include/asm/unistd.h:412: error: asm-specifier for variable
> `__sc_4' conflicts with asm clobber list
> /usr/src/linux/include/asm/unistd.h:412: error: asm-specifier for variable
> `__sc_5' conflicts with asm clobber list
> /usr/src/linux/include/asm/unistd.h:412: error: asm-specifier for variable
> `__sc_4' conflicts with asm clobber list
> /usr/src/linux/include/asm/unistd.h:412: error: asm-specifier for variable
> `__sc_5' conflicts with asm clobber list
> /usr/src/linux/include/asm/unistd.h:412: error: asm-specifier for variable
> `__sc_4' conflicts with asm clobber list
> /usr/src/linux/include/asm/unistd.h:412: error: asm-specifier for variable
> `__sc_5' conflicts with asm clobber list
> /usr/src/linux/include/asm/unistd.h:412: error: asm-specifier for variable
> `__sc_4' conflicts with asm clobber list
> /usr/src/linux/include/asm/unistd.h:412: error: asm-specifier for variable
> `__sc_5' conflicts with asm clobber list
> /usr/src/linux/include/asm/unistd.h:412: error: asm-specifier for variable
> `__sc_4' conflicts with asm clobber list
> /usr/src/linux/include/asm/unistd.h:412: error: asm-specifier for variable
> `__sc_5' conflicts with asm clobber list
> /usr/src/linux/include/asm/unistd.h: In function `write':
> /usr/src/linux/include/asm/unistd.h:408: error: asm-specifier for variable
> `__sc_4' conflicts with asm clobber list
> /usr/src/linux/include/asm/unistd.h:408: error: asm-specifier for variable
> `__sc_5' conflicts with asm clobber list
> /usr/src/linux/include/asm/unistd.h: In function `read':
> /usr/src/linux/include/asm/unistd.h:409: error: asm-specifier for variable
> `__sc_4' conflicts with asm clobber list
> /usr/src/linux/include/asm/unistd.h:409: error: asm-specifier for variable
> `__sc_5' conflicts with asm clobber list
> /usr/src/linux/include/asm/unistd.h: In function `lseek':
> /usr/src/linux/include/asm/unistd.h:410: error: asm-specifier for variable
> `__sc_4' conflicts with asm clobber list
> /usr/src/linux/include/asm/unistd.h:410: error: asm-specifier for variable
> `__sc_5' conflicts with asm clobber list
> /usr/src/linux/include/asm/unistd.h: In function `execve':
> /usr/src/linux/include/asm/unistd.h:412: error: asm-specifier for variable
> `__sc_4' conflicts with asm clobber list
> /usr/src/linux/include/asm/unistd.h:412: error: asm-specifier for variable
> `__sc_5' conflicts with asm clobber list
> /usr/src/linux/include/asm/unistd.h: In function `open':
> /usr/src/linux/include/asm/unistd.h:413: error: asm-specifier for variable
> `__sc_4' conflicts with asm clobber list
> /usr/src/linux/include/asm/unistd.h:413: error: asm-specifier for variable
> `__sc_5' conflicts with asm clobber list
> /usr/src/linux/include/asm/unistd.h: In function `waitpid':
> /usr/src/linux/include/asm/unistd.h:416: error: asm-specifier for variable
> `__sc_4' conflicts with asm clobber list
> /usr/src/linux/include/asm/unistd.h:416: error: asm-specifier for variable
> `__sc_5' conflicts with asm clobber list
> /usr/src/linux/include/asm/unistd.h:416: confused by earlier errors,
> bailing out
> make: *** [init/main.o] Error 1
>
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
