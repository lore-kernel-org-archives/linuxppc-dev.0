From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
To: rdn2@mutagenic.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: building gcc 2.95 on a powermac
Date: Sat, 31 Jul 1999 10:40:37 +0200
Content-Type: text/plain
References: <37A2A3E6.26E3D1F9@laki.mutagenic.org>
In-Reply-To: <37A2A3E6.26E3D1F9@laki.mutagenic.org>
MIME-Version: 1.0
Message-Id: <99073111050000.00494@ns1102.munich.netsurf.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Am Sam, 31 Jul 1999 schrieb rdn2@laki.mutagenic.org:
>I have been trying without success to build gcc 2.95 on my powerbase
>running Linuxppc 1999. The error I get always says that I cannot build
>exacutables. Also it looks like it is building for a rs6000 even though
>I tell it the host=linux-powerpc-unknown-gnu. Is there something I am
>doing wrong or is this a known problem? Does anyone have rpms built for
>this yet? Thanks for the help in advance..

<ftp://devel.linuxppc.org/users/fsirl/R5/RPMS/ppc/>

You'll need the binutils in there as well.

C nits:
- if you compile your kernel with gcc-2.95, add -fno-strict-aliasing to the
CFLAGS in arch/ppc/Makefile
- if you are compiling atyfb in your kernel, you have to use latest 2.2.10vger
- compiling XFree86 needs a patch for ATI and IMS (grab Tom Rini's latest 3.3.4
SRPM)
- compiling glibc-2.1 requires the latest CVS version of the
glibc-2-1-branch
- compiling emacs needs a patch

C++ nits:
- -fpermissive can be used as a compiler flag to turn some errors back into
warnings, but the bug is really in the source, fix it and/or report to the
author
- C++ has stricter syntax checking now to be compliant with ISO-C++, so if
gcc-2.95 flags an error where egcs-1.1 didn't, it's most likely the fault of
the source
- if you want to compile KDE, use KDE-1.1.2pre or later

FYI, I'm running gcc-2.95 compiled kernel, XFree86, qt-1.44, qt-2.0.1,
KDE-1.1.2pre on my local machine without problems.

Franz.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
