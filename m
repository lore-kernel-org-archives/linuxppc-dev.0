From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
To: linuxppc-dev@lists.linuxppc.org,
        "Thomas C. Allison" <allison@dirac.nist.gov>,
        linuxppc-user@lists.linuxppc.org
Subject: Re: possible egcs c compiler bug
Date: Wed, 19 May 1999 23:26:37 +0200
Content-Type: text/plain
References: <199905192019.QAA00884@dirac.nist.gov>
MIME-Version: 1.0
Message-Id: <99051923331400.00882@ns1102.munich.netsurf.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Am Wed, 19 May 1999 schrieb Thomas C. Allison:
>I have found what *appears* to be a bug in the C compiler.  I have experienced
>this bug in R4 (regardless of the compiler/library installed) as well as in
>the latest (i.e. all the latest packages through 5/15/1999) pre-R5
>installation.  I include a short program below which illustrates the problem
>I am having.  The code compiles without error on my i386 machine
>running RHL 5.2.  The version of EGCS on the PC is 1.0.3 versus 1.1.2 on my
>PowerMac, so I don't know if this is a PPC problem or an EGCS problem.
>Any input is greatly appreciated.
>
>The code is as follows:
>
>test.c:
>
>     #include <stdio.h>
>     #include <stdarg.h>
>
>     static int myFunction(va_list inList)
>     {
>        va_list newList;
>        newList = inList;
>     }
>
>When I try to compile the code
>
>     % gcc -c test.c
>
>I get the following error message
>
>     test.c: In function `myFunction':
>     test.c:7: incompatible types in assignment
>
>Any ideas?

That is simply unportable code. va_list maybe of any underlying type, and is in
this case an array. If you want portable code, use:

     static int myFunction(va_list inList)
     {
        va_list newList;
        __va_copy(newList, inList);
     }

If you use varargs extensively in your application, I strongly recommend you to
use egcs-*1.1.2-12c or later on DRR1/preR5, which fixes some annoying bugs
in the ppc-linux varargs handling.

Franz.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
