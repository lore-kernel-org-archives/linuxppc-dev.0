Message-Id: <4.3.2.7.2.20000714132712.030c82c0@mail.munich.netsurf.de>
Date: Fri, 14 Jul 2000 13:30:34 +0200
To: ian geiser <geiseri@msoe.edu>
From: Franz Sirl <Franz.Sirl@munich.netsurf.de>
Subject: Re: What causes this error on LinuxPPC?
Cc: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <396E95F3.66DB2A25@msoe.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 06:24 14.07.00, ian geiser wrote:

>Greetings
>
>     I am trying to compile a program using gcc version 2.95.3 19991030
> (prerelease/franzo/20000622)
>
>     for some reason i get this error.  I do not get this error on my
> stock Linux Mandrake 7.1
>
>     box though.  Any ideas?
>
>gencode.o: In function `prcode':
>gencode.o(.text+0x8bf0): undefined reference to `__va_arg_type_violation'
>gencode.o(.text+0x8bf0): relocation truncated to fit: R_PPC_REL24
>__va_arg_type_violation
>collect2: ld returned 1 exit status

The source in gencode.c is buggy, change this illegal C line:

        char c = va_arg(ap,char);

to the correct one

        char c = (char) va_arg(ap,int);

and you should be fine.

Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
