Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: Carlo Parravicini <c.parravicini@sehitaly.com>
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: ELDK 3.0 C++ Problem
Date: Thu, 20 May 2004 16:02:44 +0200
References: <20040519175636.8BA66C109F@atlas.denx.de>
In-Reply-To: <20040519175636.8BA66C109F@atlas.denx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200405201602.44480.c.parravicini@sehitaly.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Alle 19:56, mercoledì 19 maggio 2004, Wolfgang Denk ha scritto:
> In message <200405191757.48552.c.parravicini@sehitaly.com> you wrote:
> > have anybody problems using ELDK3.0 ppc_8xx-g++ cross-compiler(x86) on
> > 'new' function?
>
> What makes you think this is a problem with ELDK's C++ compiler?  Did
> you for example try to compile the same program with a native GCC 3.x
> C++ compiler on your PC?
Yes, I arrive to this point only because we have a problem in wxWindows:
We have a project where we build:
-- X (tiny) (cross compiled)
-- glib (compiled native)
-- gtk  (compiled native)
-- wxGTK (cross compiled)
-- minimal sample (wx-based)
for ppc system (ELDK 2.1) & x86 all works fine

On ELDK 3.0 (recompiling all as above) all works (X and gtk tests)  but not
wxGTK (also with wx samples) and because this is the only package build in
cpp this is why I was think to the cpp compiling.
In effect the test below is broken, written whit the [] runs.

So the question change: does anybody try to compile and use wxGTK with
ELDK3.0 ??
>
> > I try to run a stupid program like that on a linux 2.4.4 (previus ELDK
> > 2.1) & linux 2.4.24 (ELDK 3.0)
>
> I agree with your rating ;-)
Also me
>
> > //=================================================
> > #include <iostream>
> > #include <string.h>
> > int main (int argc, char **argv)
> > {
> >   int *p = new int (10000);
> >   memset ( p, 0, 10000);
> >   if (p == NULL)
> >    std::cout << "Allocation error\n";
> >   else
> >    std::cout << "OK.\n";
> >
> > return 0;
> > //=================================================
>
> This program cannot be compiled, there is a '}' missing.
>
> > ppc_8xx-g++ =Wall cpp.cpp -o cpp
>
> This was most definitely NOT the command line you used.
>
> > Both give me a segmentation fault on 'new' execution
>
> What makes you think so? I bet a case of beer that the 'new" returned
> just fine, and that your program segfaulted in memset() instead.

Lost the beer, the code is wrong but the segfaulted is in the "new"
(checked with a printf before the memset & also with gdb eh eh)

>
> Of course you didn't see this, as your test if p is NULL is much  too
> late,  and  obviously  you  didn't  bother to run the program under a
> debugger.
>
> > Any other have c++ compiling problems or have compiled c++ code
> > successfuly?
>
> There are no known C++ problems specific to the ELDK  (i.  e.  except
> those that apply to the native version of the same GCC as well).
>
> The problem is not with the ELDK.
>
> Best regards,
>
> Wolfgang Denk


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
