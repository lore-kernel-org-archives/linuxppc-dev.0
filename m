MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Subject: RE: Compiling assembler file with ppc_405-gcc 
Date: Fri, 11 Jun 2004 10:47:18 -0700
Message-ID: <E8E581FE5C58614B85A22AF2A495C64909E415@uschd00mx11usr.AVNET.COM>
From: "Kerl, John" <John.Kerl@Avnet.com>
To: "Kerl, John" <John.Kerl@Avnet.com>, "Wolfgang Denk" <wd@denx.de>,
	=?utf-8?B?R2FyY2lhIErDqXLDqW1pZQ==?= <GARCIAJ@3il.fr>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Resending as plain text:

> No Wolfgang, read it again: he is running ppc_4xx-gcc.  It's in a
> variable named $(AS), but he is running the C compiler.  It is
> reasonable to expect #include and #define statements to work --
> after all, the Linux build does this all the time!  As does the
> u-boot build:
>
> $ cd /opt/gx/u-boot
> $ make
> ...
> ppc_4xx-gcc -Wa,-gstabs -D__ASSEMBLY__ -g  -Os   -fPIC
> -ffixed-r14 -meabi
> -D__KERNEL__ -DTEXT_BASE=0xFFF80000 -I/opt/gx/u-boot/include
> -fno-builtin
> -ffreestanding -nostdinc -isystem
> /opt/eldk/usr/lib/gcc-lib/ppc-linux/2.95.4/include
> -pipe  -DCONFIG_PPC -D__powerpc__ -DCONFIG_4xx -ffixed-r2
> -ffixed-r29 -mstring
> -Wa,-m405 -mcpu=405 -msoft-float -DCONFIG_440=1 -c -o init.o
> /opt/gx/u-boot/board/avnet_440gx_eval/init.S
>
> The gentleman has a legitimate request.
>
>
>
>
> > -----Original Message-----
> > From: owner-linuxppc-embedded@lists.linuxppc.org
> > [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf
> > Of Wolfgang
> > Denk
> > Sent: Friday, June 11, 2004 9:26 AM
> > To: Garcia Jérémie
> > Cc: linuxppc-embedded@lists.linuxppc.org
> > Subject: Re: Compiling assembler file with ppc_405-gcc
> >
> >
> >
> > In message
> > <85E6ED5B5EC32F439702305CC417E12D9E2A78@email.3il.fr> you wrote:
> > >
> > > To compile this, I use the following lines in a makefile:
> > ...
> > > ppcsiafn.o:
> > >       $(AS) $(CFLAGS_AS) -c
> > $(SRC_PATH)/startup/init/ppcsiafn.s -o ppcsiafn.o
> > ...
> > > After a lot of tests, here are my conclusions: the
> > different "#include" are not considered by the compiler.
> > Indeed, I tried to introduce compilation errors in the
> > different ".h" files --> no difference in the result
> >
> > You don't call a compiler. You just run the assembler.  The
>  assember
> > does  nothing else but assemble your code. It does NOT
> include things
> > like running a preprocessore or so.
> >
> > > So I guess that but I don't know why : the character "#" is
> > understood as a comment (equivalent to /* ...*/).
> >
> > Maybe you want to check assembler syntax?
> >
> > > To conclude : is there a specific compil option to give to
> > gcc for it to understand the #include command?
> >
> > "gcc" does know how to run a preprocessor. But you're not
> > running  "gcc",
> > you're running "as" only.
> >
> > > I checked the different linux assembler file and the
> > #include is used. So why am I not able to use it?
> >
> > Because your build rule is inappropriate for what you want to do?
> >
> > Best regards,
> >
> > Wolfgang Denk
> >
> > --
> > Software Engineering:  Embedded and Realtime Systems,
> Embedded Linux
> > Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email:
> wd@denx.de
> > Generally speaking, there are other ways to accomplish
> whatever it is
> > that you think you need ...                               -
> Doug Gwyn
> >
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
