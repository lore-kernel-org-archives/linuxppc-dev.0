Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: ELDK 3.0 C++ Problem 
Date: Wed, 19 May 2004 16:38:41 -0500
Message-ID: <6F45E974A11B294383FD819C76719D8701984F@txex2ku01>
From: "Gosha, Michael (Michael)" <mgosha@agere.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Cc: "Carlo Parravicini" <c.parravicini@sehitaly.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The problem is with your statement, "new int (1000)". This should be
"new int [1000]". You are telling the compiler to initialize 1 integer
to 1000 instead of allocating 1000 integers. Replace the parens with
brackets and it should work.

Regards,

Michael Gosha

-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org
[mailto:owner-linuxppc-embedded@lists.linuxppc.org] On Behalf Of
Wolfgang Denk
Sent: Wednesday, May 19, 2004 12:57 PM
To: Carlo Parravicini
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ELDK 3.0 C++ Problem



In message <200405191757.48552.c.parravicini@sehitaly.com> you wrote:
>
> have anybody problems using ELDK3.0 ppc_8xx-g++ cross-compiler(x86) on

> 'new' function?

What makes you think this is a problem with ELDK's C++ compiler?  Did
you for example try to compile the same program with a native GCC 3.x
C++ compiler on your PC?

> I try to run a stupid program like that on a linux 2.4.4 (previus ELDK

> 2.1) & linux 2.4.24 (ELDK 3.0)

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

> Any other have c++ compiling problems or have compiled c++ code
> successfuly?

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
