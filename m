To: Carlo Parravicini <c.parravicini@sehitaly.com>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: ELDK 3.0 C++ Problem 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 19 May 2004 17:57:48 +0200."
             <200405191757.48552.c.parravicini@sehitaly.com>
Date: Wed, 19 May 2004 19:56:31 +0200
Message-Id: <20040519175636.8BA66C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <200405191757.48552.c.parravicini@sehitaly.com> you wrote:
>
> have anybody problems using ELDK3.0 ppc_8xx-g++ cross-compiler(x86) on 'new'
> function?

What makes you think this is a problem with ELDK's C++ compiler?  Did
you for example try to compile the same program with a native GCC 3.x
C++ compiler on your PC?

> I try to run a stupid program like that on a linux 2.4.4 (previus ELDK 2.1) &
> linux 2.4.24 (ELDK 3.0)

I agree with your rating ;-)

> //=================================================
> #include <iostream>
> #include <string.h>
> int main (int argc, char **argv)
> {
>   int *p = new int (10000);
>   memset ( p, 0, 10000);
>   if (p == NULL)
>    std::cout << "Allocation error\n";
>   else
>    std::cout << "OK.\n";
>
> return 0;
> //=================================================

This program cannot be compiled, there is a '}' missing.

> ppc_8xx-g++ =Wall cpp.cpp -o cpp

This was most definitely NOT the command line you used.

> Both give me a segmentation fault on 'new' execution

What makes you think so? I bet a case of beer that the 'new" returned
just fine, and that your program segfaulted in memset() instead.

Of course you didn't see this, as your test if p is NULL is much  too
late,  and  obviously  you  didn't  bother to run the program under a
debugger.

> Any other have c++ compiling problems or have compiled c++ code successfuly?

There are no known C++ problems specific to the ELDK  (i.  e.  except
those that apply to the native version of the same GCC as well).

The problem is not with the ELDK.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
                  Nail here --X-- for new monitor.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
