To: =?utf-8?Q?Garcia_J=C3=A9r=C3=A9mie?= <GARCIAJ@3il.fr>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Compiling assembler file with ppc_405-gcc 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 11 Jun 2004 17:28:25 BST."
             <85E6ED5B5EC32F439702305CC417E12D9E2A78@email.3il.fr>
Date: Fri, 11 Jun 2004 18:25:51 +0200
Message-Id: <20040611162556.18B71C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <85E6ED5B5EC32F439702305CC417E12D9E2A78@email.3il.fr> you wrote:
>
> To compile this, I use the following lines in a makefile:
...
> ppcsiafn.o:
>       $(AS) $(CFLAGS_AS) -c $(SRC_PATH)/startup/init/ppcsiafn.s -o ppcsiafn.o
...
> After a lot of tests, here are my conclusions: the different "#include" are not considered by the compiler. Indeed, I tried to introduce compilation errors in the different ".h" files --> no difference in the result

You don't call a compiler. You just run the assembler.  The  assember
does  nothing else but assemble your code. It does NOT include things
like running a preprocessore or so.

> So I guess that but I don't know why : the character "#" is understood as a comment (equivalent to /* ...*/).

Maybe you want to check assembler syntax?

> To conclude : is there a specific compil option to give to gcc for it to understand the #include command?

"gcc" does know how to run a preprocessor. But you're not running  "gcc",
you're running "as" only.

> I checked the different linux assembler file and the #include is used. So why am I not able to use it?

Because your build rule is inappropriate for what you want to do?

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Generally speaking, there are other ways to accomplish whatever it is
that you think you need ...                               - Doug Gwyn

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
