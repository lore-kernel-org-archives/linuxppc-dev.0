To: =?Windows-1252?Q?Garcia_J=E9r=E9mie?= <GARCIAJ@3il.fr>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Compiling assembler file with ppc_405-gcc 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 14 Jun 2004 12:15:06 BST."
             <85E6ED5B5EC32F439702305CC417E12D9E2A7D@email.3il.fr>
Date: Mon, 14 Jun 2004 12:24:12 +0200
Message-Id: <20040614102417.32EF6C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <85E6ED5B5EC32F439702305CC417E12D9E2A7D@email.3il.fr> you wrote:
>
>   --> I've included in this file:
>          #include <linux/config.h>
>          #include <asm/processor.h>
>          #include <asm/cache.h>
>          #include <asm-ppc/ppc_asm.h>
>          #include "ppcbslit.h"
>
>          [ppcbslit.h is a file which is supposed to contain a lot of
> #define
>           that I need in many files of my project. At the beggining of
> this
>           file, I have included:
>               #include <stdio.h>
>               #include <string.h>
>               #include <sys/types.h>
>               #include <sys/stat.h>
>               #include <fcntl.h>
>               #include <sys/ioctl.h>
>               #include <unistd.h>
>               #include <linux/ctype.h>                      ]

You should NOT include standard C header files in a assembler program!

assembler != C

> Results:
> ========
>    --> I don't know why but the #include of my assembler file are now
>        considered (a compilation option maybe... -x assembler??)

This is because your file now has a ".S" suffix instead  of  ".s"  as
before. Read the GCC manual about details!

>    --> But now there is the following problem ; I got hundreds of
> errors.
>        I report below a little part of them:
> /opt/hardhat/devkit/ppc/405/target/usr/include/stdio.h: Assembler
> messages:
> /opt/hardhat/devkit/ppc/405/target/usr/include/stdio.h:30: Error:
> Unrecognized opcode: `__begin_decls'
> /home/jgarcia/Desktop/kernel/ssc/StdLib/local/stddef.h:201: Error:
> Unrecognized opcode: `typedef'
> /opt/hardhat/devkit/ppc/405/target/usr/include/bits/stat.h:38: Error:
> Unrecognized opcode: `__dev_t'
> /home/jgarcia/Desktop/kernel/ssc/basic/services/include/ppcbslit.h:164:
> Error: Unrecognized opcode: `int'
> /opt/hardhat/devkit/ppc/405/target/usr/include/unistd.h:688: Error:
> Unrecognized opcode: `extern'

This is because you include C header files in assember code. You must
not do that.

>   --> I found a way to prevent those errors... I put all my #define that
> I need in my assembler file. But you'll understand that it's a very
> restrictive way of programming and I'd like to find a better solution
> cause I'm talkin' about a hundred of #define...so...

If you have the C includes in one of your private header  files,  you
can put a "#ifndef __ASSEMBLY__" / "#endif" around them.

Otherwise just clean up your code and don't use  C  headers  in  your
assembler file.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Landing: a controlled mid-air collision with a planet.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
