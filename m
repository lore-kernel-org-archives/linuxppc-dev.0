Message-ID: <3B7B3DDE.6603AFF@mvista.com>
Date: Wed, 15 Aug 2001 22:28:30 -0500
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: "Dr. Craig Hollabaugh" <craig@hollabaugh.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: cross compiling 8xx glibc on x86
References: <5.1.0.14.0.20010815184517.00ab30c0@spudcentral.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> ../sysdeps/powerpc/fclrexcpt.c:20: fenv_libc.h: No such file or directory

That error is due to glibc not being setup to run w/o floating point on
PowerPC.

> I fooled around a bit trying to pass the Ipath to gcc for fenv_libc.h. But didn't figure that out.

Look at the patch titled "hhl-powerpc-fpu.patch".  This will move the
files to where they need to be for it to work right.  It will also
remove the floating point loads/saves in the setjmp/longjmp call.

To find out the order of the patches that we apply, just look at the
%build section, they are layed out in the order in which they are
applied for our product.

> Has anyone cross compiled glibc2.2.3 successfully for the 8xx (no fpu)?

HHL 2.0 is based on glibc2.2.3pre1 (due to release schedules).  But we
do have glibc-2.2.3 release working in house, it was trivial since
2.2.3pre1 was already done.

> Did you use the GNU source or did you use the MontaVista source?

I use MontaVista's Source.. <grin>

> If you use the MontaVista source, which patches did you apply and in what order?
> What's your configure line?
> Once you got glibc compiled, how did you check the fpu operation? Printing pi or what?

The easiest way is to build bash and use the builtin (shell) printf
command and see if it prints out "nan" or the number.  If you get the
number it is working correctly.

One side note, you don't really need the no floating point patches, if
you are willing to live with the emulation overhead it works fine in the
kernel.

However, on the 8xx there is one thing that you can not "live w/o"
doing.  Specifically you must either "fix" or (easy way) delete the
sysdeps/powerpc/memset.S file.  This file is hard coded to 8 word wide
cache lines.. and the 8xx only has 4 words wide cache.

So...  if you can live w/ emulation, do that it's easier.....
but regardless you will need to delete the sysdeps/powerpc/memset.S
file.

--Mark

BTW the memset.S is being worked on in the PowerPC community to allow
for various cacheline optimizations from (4 words) 8xx, to (16 words)
Power3/4 series.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
