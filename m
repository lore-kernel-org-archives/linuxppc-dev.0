Message-ID: <3B7D9126.D9F7C302@mvista.com>
Date: Fri, 17 Aug 2001 16:48:22 -0500
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: Mark Pilon <mark.pilon@minolta-qms.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: init fails w/ new build of gcc & glibc
References: <3B7D82D5.DD98A109@minolta-qms.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Mark Pilon wrote:
>
> Hi,
>
> I'm attempting to build gcc for powerPC as well as new binutils &
> glibc, -- all in an attempt to support a new 4xx chip w/ floating
> point.
>
> I'm using HHL 1.2 for the 405 & walnut as my base and am attempting
> to start using the new compiler and libraries:
>
> I've recompiled the kernel w/ the new compiler (albeit -msoft-float)
> and it boots fine;
>
> running w/ the hhl 1.2 libraries the whole system runs fine;
>
> supplying all of the libraries built under the new glibc causes the
> following when init is spawned:
>
> Kernel panic: Attempted to kill init!
> init: error while loading shared libraries: cannot open sh ared object file:
> cannot load shared object file: No such file or directory
>
> -- there is no comment as to what's missing ...
>
> I can spawn sash in place of 'init' and that runs (no surprise ...)
> -- I realize I've probably screwed up something pretty basic --
> I'm probably out of synch somewhere in the libraries but don't
> know how to debug this further.

A question... is the floating point standard PowerPC floating point?  or
is it "special" for your application?

If the answer is that it is standard floating point then you can use the
"7xx" or "82xx" tools for your project.  If you want to recompile then
you need to recompile the whole system from the compilers up to glibc
and all of the apps.  There are two ABIs, one for soft-floating point
and one for hard floating point.  They are not run-time compatable.

If the part is using non-standard PPC floating point then you will need
to run soft-floating point, or implement all of the instructions in both
binutils and gcc, and make corresponding changes to glibc.  (A lot of
work.)

--Mark

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
