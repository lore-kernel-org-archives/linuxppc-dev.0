From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Date: Tue, 5 Dec 2000 18:51:11 +0100
Content-Type: text/plain;
  charset="US-ASCII"
Cc: linuxppc-dev@lists.linuxppc.org, max@trega.com
To: alex@cosmo.allay.net
References: <Pine.LNX.4.10.10012051230170.22364-100000@macachu.ex-pressnet.com>
In-Reply-To: <Pine.LNX.4.10.10012051230170.22364-100000@macachu.ex-pressnet.com>
Subject: Re: lots of questions (va_list, embedded perl, cvsd, introduction - sort of)
MIME-Version: 1.0
Message-Id: <00120518511100.12228@enzo.bigblue.local>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tuesday 05 December 2000 18:36, Alex Avriette wrote:
> And lo there was much discussion regarding:
> > > void
> > > log (const char *fmt, ...)
> >
> > This code looks OK. What environment? (gcc/glibc)
>
> from glibcbug:
>
> Host type: powerpc-redhat-linux-gnu
> System: Linux macachu 2.4.0-test11 #5 Sun Nov 26 13:51:22 EST 2000 ppc
> unknown
> Architecture: ppc
>
> Addons: crypt linuxthreads
> Build CFLAGS: -g -O2
> Build CC: gcc
> Compiler version: 2.95.2 19991024 (release/franzo)
> Kernel headers: 2.4.0-test11
> Symbol versioning: yes
> Build static: yes
> Build shared: yes
> Build pic-default: no
> Build profile: yes
> Build omitfp: no
> Build bounded: no
> Build static-nss: no
> Stdio: libio
>
> > > void vs_test ( const char *fmt, ...)
> >
> > This testcase is buggy (look at the printf!), if fixed it behaves as
> > expected. You would have seen that if you compiled with -W -Wall!
>
> whoops! (blush!) gotcha.
>
> > > void nested_test ( const char *fmt, ...)
> >
> > This testcase is bogus since you miss the required va_start/va_end pairs.
> > It misbehaves as expected.
>
> let me check with the bsd guy, but AIR, it runs without the two pairs. i
> could be wrong.

It may run on some platforms by accident, but this is simply illegal C code
if you want to process the same AP 2 times without an intervening
va_end()/va_start() pair.

> > I've tested this both with gcc-2.95.3 and a recent gcc-2.97 snapshot.
> > This looks a lot like your are still using egcs on PPC, don't do that,
> > use gcc-2.95.[23] as the current distributions do.
>
> all my experience writing c was in dos on borland c++, years ago. im
> actually not sure about egcs, except that i get the error in gdb. how can
> i be sure, and if i am, how can i switch?

rpm -q binutils egcs gcc glibc

You can get current stuff at
ftp://devel.linuxppc.org/users/fsirl/glibc-2.1/RPMS/ppc/

Franz.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
