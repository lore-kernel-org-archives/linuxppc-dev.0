Date: Mon, 23 Oct 2000 13:39:29 +0200 (MET DST)
From: Derek Homeier <supas100@astrophysik.uni-kiel.de>
To: linuxppc-dev@lists.linuxppc.org
cc: Michael Norton <mnorton@cisco.com>
Subject: Re: COPTS for Makefile LinuxPPC 2000
In-Reply-To: <200010210500.AAA23065@lists.linuxppc.org>
Message-ID: <Pine.SOL.3.95.1001023131438.18258B-100000@juliet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 20 Oct 2000 15:17:26 -0700 (PDT), Michael Norton <mnorton@cisco.com> wrote:
>
> I am trying to build the OpenGL Heretic game and there are compiler options in t
> he Makefile for m68k but not for the PPC.
>
> COPT.m68k = -m68020-60 -O2 -fomit-frame-pointer -D__BIG_ENDIAN__ -D__32BIT__ \
>         -DHAVE_ALLOCA_H
>
>
> was should this statement read if I am going to compile a PPC image on my G4?
>
Well, you probably should keep the defines, and possibly the "-fomit-frame-pointer"
as well, so leave everything after that unchanged. It's possible you need
"-fsigned-char" in addition. You obviously wouldn't want the "-m68020-60"
which turns on m68k-specific tuning. You might simply try "-O2" or "-O3" for a
first run. There also are some architecture-specific flags available on PPC,
such as"-mcpu=604", don't know if there is a flag for 750 or even 7400 yet.
You should look at the gcc info page for more details on the different
optimizations (under "Invoking GCC::"). Chances are you won't need
terribly agressive optimization if that game actually runs on a 68k :-).

HTH,
							Derek


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
